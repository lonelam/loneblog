---
title: 移动光猫改桥接并用openwrt拨号（路由器Netgear R8000为例）
date: 2023-03-25
tags: [router, netgear]
---

# 光猫配置

参考这篇[移动光猫之桥接教程](https://zhuanlan.zhihu.com/p/398555628)
用超级管理员账号登录
用户名 CMCCAdmin
超级密码 aDm8H%MdA

## 我的配置

### 解决 openwrt 与 ip 地址冲突

### 光猫侧

打开网络-宽带设置-Internet 连接，可以看到已经有 3 个连接配置，分别是

```
TR069_R_VID_4034
INTERNET_R_VID_4031
IPTV_R_VID_4033
```

对应 3 个不同的 VLAN，连接网络需要用到的只有第二个 vlan 为 4031 的标着 internet 的连接。
注意这个 VLAN 可能有不同，记住这个 vlan 号，后面新建的连接还需要用到。
关闭原先的 pppoe 拨号连接 INTERNET_R_VID_4031，只需要在连接里把勾去掉并保存即可！不需要删除，如果后续出现问题，回到这一步把 INTERNET_R_VID_4031 重新打开就行了。
**接下来新建一个完全一样的 PPPoe 连接**，这是为了确认 pppoe 拨号的账号密码，以免后续登录不上。
**杭州地区**的移动宽带，

> 宽带默认密码是 123456 或者宽带账号的后 6 位，以前老账号也有身份证后 6 位，后 8 位，联系电话前 8 位。
> 如果都不是，拨打 10086 或者问宽带装机小哥~
> 确认完成后，将刚才的那个新的可用的 PPPoe 连接改为桥接，其他选项不动：
> ![cmcc-settings](cmcc-settings.png)

### 路由器侧

**先修改 LAN 口 ip 地址**由于 LAN 口 ip 地址
这里将原先的 WAN 口 PPPoe 处输入宽带账号密码
![openWrt side settings](openwrt-pppoe-settings.png)

# Netgear R8000 刷 Openwrt

本来是配置好了 openwrt 的，结果这次一不小心改错了配置，刷成砖了，又找不到靠谱的救砖教程，只好淘宝找了一个专业救砖师傅帮我远程搞，然后发现其实有个很好的工具可以救砖：https://github.com/jclehner/nmrpflash，具体流程见另一篇。
**恢复原厂 ROM 之后**按照官方指导上的刷：https://openwrt.org/toh/netgear/r8000
把 chk 文件上传，并等一会儿：https://downloads.openwrt.org/releases/22.03.3/targets/bcm53xx/generic/openwrt-22.03.3-bcm53xx-generic-netgear_r8000-squashfs.chk
我是等了一会儿以后毫无反应，并**直接重启**了路由器，然后就直接进入了 OpenWrt 系统，看起来中间可能报错了或者写入停止了，但不影响使用。

# Wifi 配置问题

初始配置看起来只有 1 个可连接 wifi，2.4G 的直接需要手动开启另外两个。
第一步先给 wifi 配置密码

# 将 overlay 分区改到 U 盘

直接参考 OpenWrt 官方的文档[ExtRoot Configureation](https://openwrt.org/docs/guide-user/additional-software/extroot_configuration)执行命令，可以完美扩展/overlay 分区到 64G 的 U 盘上面，彻底解决空间不够用的问题。

# 关于 ipv6 配置

NAS 等服务需要获取独立 ipv6 地址，并开放端口到公网。其中 ipv6 的网段是动态分配给 NAS 等主机的，前缀可能会发生变化，因此需要以 ipv6 网段的形式来配置 Openwrt firewall 的规则：具体在 ip destination 处填写`::a1b2:c3d4:0/::ffff:ffff:0`即可，这里找了好久也没找到中文资料，简单描述一下规则：

> `/`前面的是 ipv6 地址，`/`后的是掩码。ipv6 地址一共 128 位，分为 8 组 16 位的 16 进制表示，`:`分隔的字符。其中，双`:`是一种简写，表示该位置所有位都是 0，一般只出现一次。掩码也是一样的表示方式。
> 掩码也可以用数字简写，例如`/32`相当于`/ffff:ffff::`，在 openwrt 中，掩码还可以用负数例如`/-64`这样的格式表示，相当于`/::ffff:ffff:ffff:ffff`
> 之所以需要把掩码放在中间，是因为这 32 位在 ipv6 地址的分配中，无论前缀怎么变，这 32 位都不会变。具体原因可能是由于 SLAAC 协议中，ipv6 地址的后 64 位通过 EUI-64 的方法生成，相当于 MAC 地址扩展后会对应到唯一的 ipv6 子网。

配置下面这个规则即可暴露 NAS 的 ipv6 地址和高位端口到外网
![expose-nas-ipv6](expose-nas-ipv6.png)

# 配置科学上网

目前最好用的插件是 OpenClash，上传 ClashX 的配置文件到 OpenClash 即可直接使用。
其中需要注意第一次启动之前，因为是在大内网环境，需要在 Overwrite Settings-General Settings-Github Address Modify 选项中，把 Github 地址修改为
https://testingcf.jsdelivr.net/
，否则 github 地址污染，会导致 openclash 检查版本或者下载 clash 内核等步骤报错:

```
2022-11-07 10:12:13【/tmp/clash_last_version】下载失败：【how to fix it, please visit the web page mentioned above.】
2022-11-07 10:12:13【/tmp/clash_last_version】下载失败：【establish a secure connection to it. To learn more about this situation and】
2022-11-07 10:12:13【/tmp/clash_last_version】下载失败：【curl failed to verify the legitimacy of the server and therefore could not】
2022-11-07 10:12:13【/tmp/clash_last_version】下载失败：【】
2022-11-07 10:12:13【/tmp/clash_last_version】下载失败：【More details here: https://curl.se/docs/sslcerts.html】
2022-11-07 10:12:13【/tmp/clash_last_version】下载失败：【curl: (60) Cert verify failed: BADCERT_CN_MISMATCH】
2022-11-07 10:10:57【/tmp/openclash_last_version】下载失败：【how to fix it, please visit the web page mentioned above.】
2022-11-07 10:10:57【/tmp/openclash_last_version】下载失败：【establish a secure connection to it. To learn more about this situation and】
2022-11-07 10:10:57【/tmp/openclash_last_version】下载失败：【curl failed to verify the legitimacy of the server and therefore could not】
2022-11-07 10:10:57【/tmp/openclash_last_version】下载失败：【】
2022-11-07 10:10:57【/tmp/openclash_last_version】下载失败：【More details here: https://curl.se/docs/sslcerts.html】
2022-11-07 10:10:57【/tmp/openclash_last_version】下载失败：【curl: (60) Cert verify failed: BADCERT_CN_MISMATCH】
2022-11-07 09:26:43【/tmp/clash_last_version】下载失败：【how to fix it, please visit the web page mentioned above.】
2022-11-07 09:26:43【/tmp/clash_last_version】下载失败：【establish a secure connection to it. To learn more about this situation and】
2022-11-07 09:26:43【/tmp/clash_last_version】下载失败：【curl failed to verify the legitimacy of the server and therefore could not】
2022-11-07 09:26:43【/tmp/clash_last_version】下载失败：【】
2022-11-07 09:26:43【/tmp/clash_last_version】下载失败：【More details here: https://curl.se/docs/sslcerts.html】
2022-11-07 09:26:43【/tmp/clash_last_version】下载失败：【curl: (60) Cert verify failed: BADCERT_CN_MISMATCH】
```

参见[GitHub Issue](https://github.com/vernesong/OpenClash/issues/2791)
