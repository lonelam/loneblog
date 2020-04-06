---
title: google面试题
date: 2018-8-31
tags: [interview, google]
---

Google面试居然走到了2nd onsite，不可思议…已经是梦一样的体验了啊，回顾一下自己面的几道题给好友一起参考下……由于实习报告还没写完，简单题先不写解法了。

# 视频面
中文面，面试官很nice，这轮面试因为我自己的问题，电脑面到一半没电了，思路说完了代码还没来得及动，面试官说可以第二天早上继续面，这时候我以为我的Google面试之旅就此结束了，没想到面试官还是给了我一次机会，感动。题目很简单，我给了O(nm)的解法，我觉得这已经是最优了。

一个nxm的grid，若干房间有黄金，部分房间没有，且这些房间的黄金数量不等，房间之间四联通，每次能走一格，但是只能一次拿走全部黄金并且不允许走到没有黄金的房间里，且有黄金的房间没有环！求一条路径，拿走最多的黄金。


# 1st onsite#1
这一面是英文技术面，也是一道图。可以看得出来面试官对我的英语已经绝望了，尤其是说到各种terminology我觉得面试官能猜到我说了啥已经很不容易，毕竟我把无向图都说成了，不过我最后还是写了代码。解法O(石子数+n+m)，我觉得还有优化空间但是面试官似乎没有让我优化的意图。

Given an nxm grid, some positions are occupied by a stone.

Define operation as eliminate stone with another stone exist on the same row or same column.

you could only do operation on the grid step by step, and calculate the most amount of elimination operation you could do.

# 1st onsite#2
中文面，这一面几乎炸了，上来先让我写一个数据结构，要求给一个数组，实现Set, Get, SetAll三种方法，并且三者全都要O(1)，方法是弄个标记。非常无脑地写了，然后面试官问我如果这个数据结构需要用很久会不会出错，我说如果tag到了INT_MAX就对数组的每个元素都赋一次真实值并且把tag继续置0.

第二道题我觉得就有点复杂，但是应该还是属于middle的难度，毕竟算法上不存在难点。

给定二维平面上若干个虫洞，一个虫洞包含两个点，可以从虫洞的一端进去然后另一端出来，给你一个点，然后运动方向一定是x轴正方向，求这个点是否会进入一个循环当中。
其实就是找循环，但是我没理解题意，给想复杂了，直到时间用完了也没写出来，感觉得到了面试官一些不太好的评价，我觉得很可惜。

# 2nd onsite
（一年以后update）嗯，挂了以后就没心思写这些了，果然自己心态还是不行。今后努力！