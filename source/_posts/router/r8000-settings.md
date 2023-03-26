---
title: 移动光猫改桥接并用openwrt拨号（路由器Netgear R8000为例）
date: 2023-03-25
tags: [router, netgear]
---
# 光猫配置
参考这篇[移动光猫之桥接教程](https://zhuanlan.zhihu.com/p/398555628)
用超级管理员账号登录
用户名CMCCAdmin
超级密码aDm8H%MdA
## 我的配置
### 解决openwrt与ip地址冲突
### 光猫侧
打开网络-宽带设置-Internet连接，可以看到已经有3个连接配置，分别是
```
TR069_R_VID_4034
INTERNET_R_VID_4031
IPTV_R_VID_4033
```
对应3个不同的VLAN，连接网络需要用到的只有第二个vlan为4031的标着internet的连接。
注意这个VLAN可能有不同，记住这个vlan号，后面新建的连接还需要用到。
关闭原先的pppoe拨号连接INTERNET_R_VID_4031，只需要在连接里把勾去掉并保存即可！不需要删除，如果后续出现问题，回到这一步把INTERNET_R_VID_4031重新打开就行了。
**接下来新建一个完全一样的PPPoe连接**，这是为了确认pppoe拨号的账号密码，以免后续登录不上。
**杭州地区**的移动宽带，
>宽带默认密码是123456或者宽带账号的后6位，以前老账号也有身份证后6位，后8位，联系电话前8位。
如果都不是，拨打10086或者问宽带装机小哥~
确认完成后，将刚才的那个新的可用的PPPoe连接改为桥接，其他选项不动：
![cmcc-settings](cmcc-settings.png)

### 路由器侧
**先修改LAN口ip地址**由于LAN口ip地址
这里将原先的WAN口PPPoe处输入宽带账号密码
![openWrt side settings](openwrt-pppoe-settings.png)

# Netgear R8000刷Openwrt
本来是配置好了openwrt的，结果这次一不小心改错了配置，刷成砖了，又找不到靠谱的救砖教程，只好淘宝找了一个专业救砖师傅帮我远程搞，然后发现其实有个很好的工具可以救砖：https://github.com/jclehner/nmrpflash，具体流程见另一篇。
**恢复原厂ROM之后**按照官方指导上的刷：https://openwrt.org/toh/netgear/r8000
把chk文件上传，并等一会儿：https://downloads.openwrt.org/releases/22.03.3/targets/bcm53xx/generic/openwrt-22.03.3-bcm53xx-generic-netgear_r8000-squashfs.chk	
我是等了一会儿以后毫无反应，并**直接重启**了路由器，然后就直接进入了OpenWrt系统，看起来中间可能报错了或者写入停止了，但不影响使用。
# Wifi配置问题
初始配置看起来只有1个可连接wifi，2.4G的直接需要手动开启另外两个。
第一步先给wifi配置密码
# 将overlay分区改到U盘
直接参考OpenWrt官方的文档[ExtRoot Configureation](https://openwrt.org/docs/guide-user/additional-software/extroot_configuration)执行命令，可以完美扩展/overlay分区到64G的U盘上面，彻底解决空间不够用的问题。

# 关于ipv6配置
NAS等服务需要获取独立ipv6地址，并开放端口到公网。其中ipv6的网段是动态分配给NAS等主机的，前缀可能会发生变化，因此需要以ipv6网段的形式来配置Openwrt firewall的规则：具体在ip destination处填写`::a1b2:c3d4:0/::ffff:ffff:0`即可，这里找了好久也没找到中文资料，简单描述一下规则：
>`/`前面的是ipv6地址，`/`后的是掩码。ipv6地址一共128位，分为8组16位的16进制表示，`:`分隔的字符。其中，双`:`是一种简写，表示该位置所有位都是0，一般只出现一次。掩码也是一样的表示方式。
>掩码也可以用数字简写，例如`/32`相当于`/ffff:ffff::`，在openwrt中，掩码还可以用负数例如`/-64`这样的格式表示，相当于`/::ffff:ffff:ffff:ffff`
>之所以需要把掩码放在中间，是因为这32位在ipv6地址的分配中，无论前缀怎么变，这32位都不会变。具体原因可能是由于SLAAC协议中，ipv6地址的后64位通过EUI-64的方法生成，相当于MAC地址扩展后会对应到唯一的ipv6子网。

配置下面这个规则即可暴露NAS的ipv6地址和高位端口到外网
![expose-nas-ipv6](expose-nas-ipv6.png)

# 配置科学上网
目前最好用的插件是OpenClash，上传ClashX的配置文件到OpenClash即可直接使用。
其中需要注意第一次启动之前，因为是在大内网环境，需要在Overwrite Settings-General Settings-Github Address Modify选项中，把Github地址修改为https://testingcf.jsdelivr.net/，否则github地址污染，会导致openclash检查版本或者下载clash内核等步骤报错:
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

