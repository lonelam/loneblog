---
title: OnlineJudge判题核心基本思路
tags: [linux, OJ]
date: "2018-3-20"
---

如果不考虑沙盒、权限、虚拟化等问题，其实一共就三步：编译、运行、比对。

其中，比对只需要写一个循环即可，编译也较为简单，
编译选项暂定为g+++ -fno-asm -Wall -lm --static -std=c++11 -DONLINE_JUDGE -o Main Main.cpp

关键是运行。

hust 的judge中采取了如下手段：
### nice(19);
(限制进程优先级)
### 重定向
### ptrace
主要是为了监视EXIT信号
    long ptrace(enum __ptrace_request request, pid_t pid,
                   void *addr, void *data);
       PTRACE_TRACEME
              Indicate that this process is to be traced by its parent.  A
              process probably shouldn't make this request if its parent
              isn't expecting to trace it.  (pid, addr, and data are
              ignored.)

              The PTRACE_TRACEME request is used only by the tracee; the
              remaining requests are used only by the tracer.  In the
              following requests, pid specifies the thread ID of the tracee
              to be acted on.  For requests other than PTRACE_ATTACH,
              PTRACE_SEIZE, PTRACE_INTERRUPT, and PTRACE_KILL, the tracee
              must be stopped.
### wait4
用wait4来监视资源占用情况
但是wait4已经弃用了
所以我打算尝试用waitpid和getrusage来获取资源占用情况

### waitpid
``pid_t waitpid(pid_t pid, int *status, int options);``
等待子进程的“状态改变”，包括：

1. 进程结束
2. 子进程发出信号停止或继续运行。

### 如何获取时间
``waitpid``后``getruage``，然后取`ru_utime`和`ru_stime`两项，其中`ru_utime`表示user CPU time， `ru_stime`表示system CPU time

### 如何获取内存
最简单的方式是等待子进程结束之后使用`rusge`结构中的`max_rss`这一项。
但是据说这种方式有缺陷，暂时没发现有什么问题。
而hustoj采用了不同的方式，它在进程退出之前检测/proc/pid/status这一“文件”，
并找出VmPeak这一项读出结果。
从目前的实验来看，这两者有一定的出入，差距在10-20M之间，效果还有待研究