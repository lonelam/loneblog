---
title: SC Mobile SG on Xiaomi 13 Ultra（ishtar）隐藏root完整经验
date: 2026-08-17
tags: [android, vibe]
---

# SC Mobile SG on Xiaomi 13 Ultra（ishtar）完整经验

目标：在 **Xiaomi 13 Ultra + HyperOS Android 14 + KernelSU Next** 上，让渣打新加坡 **SC Mobile SG** 能正常打开并进入登录页，同时尽量保留 USB 调试。

本文记录最终能用的栈、错误码含义、以及一路试错里真正有用的结论。不要把 LSPosed 模块注入银行 app 进程。

---

## 1. 环境

| 项 | 值 |
|----|----|
| 设备 | Xiaomi 13 Ultra（`ishtar`） |
| ROM | HyperOS `OS1.0.17.0.UMACNXM`，Android 14 |
| 分区槽 | A/B，当时在 `_b` |
| 内核 | WildKernels GKI `5.15.123-android13-Wild`（内置 KSU + SUSFS v2.2.0），刷在 `boot` |
| `init_boot` | 保持官方（不用 LKM） |
| Root | KernelSU Next（ksud 3.3.0），**不是 Magisk** |
| 银行 app | `air.app.scb.breeze.android.main.sg.prod` v9.27.0 |

安全组件：app 内混淆包名 `stsei` = **LexisNexis ThreatMetrix**。  
检测跑在 isolated 服务 `stsei.C`，进程名类似：

```text
air.app.scb.breeze.android.main.sg.prod:icbtsrxclv:stsei.C
```

LSPosed **不能注入 isolated 进程**（日志会写 `skip injecting ... because it's isolated`）。主进程 Java 过了不等于 native isolated 过了。

---

## 2. 对外错误码 ↔ 内部异常

native 返回值前 2 个字符按十六进制解析，主进程 `stsei.at.b()` 再映射成异常类。崩溃关键字里经常有 `"isRoot":false`——那只说明 **Java 层 root 检查过了**，不代表设备对 ThreatMetrix 是干净的。

| 用户看到的码 | 内部异常 | 含义 | 触发条件（本机验证） |
|--------------|----------|------|----------------------|
| **#1004** | `stsei.R: 1c` | USB 调试 / 开发者选项 | `adb_enabled`、`development_settings_enabled`，以及 native 读 `sys.usb.*` / `init.svc.adbd` |
| **#1002** | `stsei.z: 16` | Hooking framework | LSPosed **注入了 SC Mobile 主进程**（例如 DuckUSB 勾了银行 app） |
| **#1001** | `stsei.f: 00` | 设备不安全（官方也写成 root / not secured） | isolated 扫到可疑 app、Zygisk maps、未藏的 `su`、证书/attest 等 |

检测是分层的：过了前一层才会暴露下一层。所以早期一直是 `#1004`，装上 LSPosed 并注入 app 后变成 `#1002`，拿掉注入并关开发者选项后变成 `#1001`。

---

## 3. 最终能进登录页的栈

### 3.1 内核 / Root

- WildKernels GKI + SUSFS 2.2.0
- KernelSU Next
- SUSFS：`uname` spoof 成官方串；`/system/bin/su` 加入 `sus_path`
- `/proc/version` 里仍可能带 `-Wild`（procfs 上 `open_redirect` 无效），对这次登录页不是阻断项

### 3.2 Zygisk / LSPosed

- **ZygiskNext** 1.4.5
- **LSPosed** 2.1.1 (7790)（从 1.9.3_mod 升上来后 Manager 要装配套 APK）
- **Enforce Denylist 必须关掉**，否则 LSPosed Manager 显示 `Not Installed`（daemon 其实在跑，只是 Manager 没被注入）
- 若既要 denylist 拦银行 app、又要开 Manager：KernelSU 里给 **LSPosed Manager** 关掉「卸载模块」

### 3.3 LSPosed 模块作用域（关键）

| 模块 | 作用域 | 说明 |
|------|--------|------|
| **Hide My Applist** | **仅系统框架 `system`** | 骗 PackageManager；isolated 只能走 PMS |
| **HideDevMode** | **仅系统框架** | 在 `SettingsProvider` / `Transport.call` **短路**返回 0，不进银行进程 |
| **DuckUSB** | **空（不要勾 SC）** | 勾 SC 能过 #1004，但立刻 #1002 |
| **AdbHide** | 关掉 | 只在 `call()` 之后改 Bundle，LSPosed 2.x binder 经常传不回去；也盖不住 `query()` |

**任何模块都不要把 SC Mobile 加进作用域。** 注入主进程 = `#1002`。

### 3.4 USB 调试（#1004 的两层）

只 hook Settings 不够。`libfacedevice.so` / classes5 还会读属性：

- `sys.usb.state`
- `sys.usb.config`
- `persist.sys.usb.config`
- `init.svc.adbd`

做法：`resetprop -n`（`--skip-svc`，只改属性 mmap，不通知 init），让 app 看到 `mtp` / `stopped`，adbd 继续跑。

开机脚本：`/data/adb/service.d/hide_usb_debug.sh`

```sh
resetprop -n sys.usb.state mtp
resetprop -n sys.usb.config mtp
resetprop -n persist.sys.usb.config mtp
resetprop -n init.svc.adbd stopped
```

关掉开发者选项总开关也能进登录页（那时属性本身就是干净的），但那是「真关」，不是 spoof。

### 3.5 证书 / 应用隐藏（#1001）

登录页是在下面两项一起改完后出现的（未做单变量对照，两样都留着更稳）：

1. TrickyStore `target.txt` 增加：
   ```text
   air.app.scb.breeze.android.main.sg.prod
   air.app.scb.breeze.android.main.sg.prod!
   ```
2. `pm disable-user` 掉检测器类应用，例如：
   - `icu.nullptr.nativetest`
   - `github.tornaco.android.thanos`
   - Play Integrity 检测器（SPIC 等）
   - 需要开 LSPosed 时再 `pm enable org.lsposed.manager`

HMA 对 SC 用白名单模板（当时只放行 QQ）可以藏 PM 可见应用；**挡不住** isolated 直接扫 `/data/app`。所以检测器 app 仍建议禁用，不能只靠 HMA。

### 3.6 其它

- 禁用小米投屏/镜像 `com.xiaomi.mirror`（当时有活跃 `TYPE_SCREEN_CAPTURE`，会干扰）
- Play Integrity `MEETS_DEVICE_INTEGRITY` 是最初目标之一，**进登录页并不依赖它已通过**；PIF-NEXT + TrickyStore 仍建议留着给 GMS

---

## 4. 绝对不要做的事

1. **不要把 SC Mobile 勾进任何 LSPosed 模块**（DuckUSB / HMA app 作用域 / 其它 Xposed 模块都不行）。
2. **不要用 Frida / 对银行进程下断**。
3. **不要为了骗 USB 而在银行进程里 hook**——那是 #1004 和 #1002 的死锁：注入才能骗 Settings，注入就会被认成 hook 框架。
4. 不要对 isolated 进程抱希望：LSPosed 进不去；SUSFS 2.2.0 也没有 `umount_for_zygote_iso_service`（需要更老的 SUSFS）。

正确分层：

```text
银行 app 进程     → 保持干净，无 Xposed
system_server     → HMA + HideDevMode
属性区            → resetprop -n 骗 sys.usb.* / adbd
内核 SUSFS        → 藏 su / maps / uname
TrickyStore       → 证书链
```

---

## 5. 试错时间线（为什么绕了这么远）

1. **只搞 Play Integrity / boot 解锁标志**  
   崩的是 `stsei`，不是 Play Integrity verdict。日志 `"isRoot":false`。

2. **resetprop `persist.sys.usb.config=mtp` 但 Settings 仍是 1**  
   仍 `#1004`。当时主因是 `settings global adb_enabled`。

3. **真关 USB 调试**  
   `#1004` 消失，证明官方 #1004 就是 USB 调试。

4. **ZygiskNext + LSPosed + DuckUSB 勾 SC**  
   Settings 骗过，出现 `#1002`。官方说明是 hooking framework。

5. **SC 移出 DuckUSB 作用域 + 关开发者选项总开关**  
   `#1002` 消失，出现 `#1001`。

6. **藏 `/system/bin/su`、Zygisk denylist、uname spoof**  
   `#1001` 仍在。isolated 里还能看到 `libzygisk.so` 等。

7. **TrickyStore 把 SC 加入 target + disable 检测器 app**  
   进登录页。HMA 之前其实已经在 system 上启用，但对 filesystem 扫描不够。

8. **想开着 USB 用银行**  
   DuckUSB 勾 SC → 又回到 #1002。  
   AdbHide 挂 system → Settings 的 `adb_enabled` 对 SC 没骗到（LSPosed 2.x + 只 hook `call()`）。  
   HideDevMode 短路 SettingsProvider → 仍 #1004，因为 native 读属性。  
   `resetprop -n` 骗 `sys.usb.*` + `init.svc.adbd` → **开发者选项开着也能进登录页**。

---

## 6. 日常用法

开银行 app 时：

- SC Mobile **不要**在任何 LSPosed 作用域里
- HideDevMode / HMA 只挂系统框架
- USB 可以插着；开机后 `hide_usb_debug.sh` 会把属性骗成 mtp/stopped
- 若脚本没跑、又开着 USB 调试 → 回到 `#1004`
- 若某次误把 SC 勾进模块 → 立刻 `#1002`，拿掉作用域并强停 app

LSPosed Manager 打不开 / 显示未安装：

- 看 `pidof lspd`，在的话是 denylist 卸了 Manager
- `znctl enforce-denylist disabled`，强停后再开 Manager
- Manager APK 必须和模块版本一致（2.1.1 不能混用 1.9.3_mod 签名）

---

## 7. 关键路径

```text
/data/adb/service.d/hide_usb_debug.sh
/data/adb/tricky_store/target.txt
/data/adb/lspd/config/modules_config.db
/data/adb/susfs4ksu/sus_path.txt          # 含 /system/bin/su
/data/user/0/com.tsng.hidemyapplist/files/config.json
```

相关包名：

```text
air.app.scb.breeze.android.main.sg.prod    # SC Mobile SG
com.tsng.hidemyapplist
com.dongdev.hidedevmode
com.strawing.duckusb                       # 留着但不要勾 SC
com.adbhide                                # 不要用
org.lsposed.manager
```

---

## 8. 未完全解决 / 已知限制

- Play Integrity DEVICE 未作为进登录页的前置条件验证。
- isolated 进程 maps 里的 Zygisk/LSPosed so，SUSFS 2.2.0 藏不干净；本次靠「不注入 + 禁用检测器 + TrickyStore」过了 `#1001`。
- HMA 骗不了直接扫 `/data/app` 的 native。
- 若 ThreatMetrix 以后改去读 `/sys/class/android_usb` 或 gadget sysfs，当前属性 spoof 会再失效，那时只能关开发者选项总开关。

---

## 9. 一句话总结

**不要 hook 银行进程。**  
Settings 在 `system_server` 骗，USB 状态用 `resetprop -n` 骗，应用列表用 HMA（system）+ 禁用检测器，证书用 TrickyStore。LSPosed 只给系统用，不给 SC Mobile 用。
