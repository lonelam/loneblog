---
title: 果然搞点网站什么的才是最爽的事情！
tags: [atom, hexo, blog, markdown]
date: 2016-12-31
---


写这篇也是主要为了熟悉一下markdown的语法啦！
===========

<p>搞了hexo以后，因为hexo的post文件要用markdown写嘛，然后就来了解markdown了~~~</p>
随便找了点[资料](http://www.aaronsw.com/)，一个[点击量很高的github页面](https://github.com/younghz/Markdown)对创始人的介绍：

>它由Aaron Swartz和John Gruber共同设计，Aaron Swartz就是那位于去年（2013年1月11日）自杀,有着开挂一般人生经历的程序员。维基百科对他的介绍是：软件工程师、作家、政治组织者、互联网活动家、维基百科人。

果然是开挂般的人生啊~~然后被封号了~~，想到我自己，恐怕，这些都只能放进幻想里面了吧。
<!--more-->

问群神了一下markdown，然后就给推荐了[https://stackedit.io/editor]
这种online editor。
这个似乎并不是特别给力，还要各种注册什么的，然后群神又说VSCode上面也可以写。
然而之前在VSCode上写cpp的体验实在是让我对VSCode已经丧失了各种信心，之前在知乎上有看到过ATOM的介绍，当时感觉不错，于是入坑ATOM。
- 在ATOM下配置markdown Preview 的一些可能的坑
> 似乎Markdown Preview Plus 和原装的Markdown Preview有一定的冲突可能，尤其是存在其他相关的Packages的情况下，所以最好是装上Markdown Preview Plus之后就把原生的Markdown Preview给disable了，然后装Markdown-scroll-sync 和 language-markdown这两个包

- 如何关闭ATOM下的拼写检查？

> 然而随便打了点文字，就发现ATOM上满满的都是点点，原因的话，似乎和系统的字典内容有关系~~
> 据[Atom飞行手册](https://wizardforcel.gitbooks.io/atom-flight-manual-zh-cn/content/2.12-Writing-in-Atom.html)，这是因为ATOM的spell-check自动调用了系统的字典。
> 至于解决方案，--packages-  spellcheck- toggle
> 然后红色点点就消失啦！！
> 这样只能够关闭一次，如果要完全解决
> 两种方案：
>- 安装Package：language-markdown
>- 也可以禁用spell-check这个Package

- ATOM 的Preview下的显示效果和hexo渲染成的网页完全不一致？

> 这个。。。只好待解决了。这个Markdown Preview 插件明显是可以定制的。。
> [一点参考](https://atom.io/packages/markdown-preview)
> 当然网页的渲染也是可以定制的啦， 这个比较简单，教程不要太多

- ATOM Markdown Preveiw 数学公式 $mathjax$ 需要搞上点插件
> Settings View: Install Packages and Themes
> :markdown-preview plus
