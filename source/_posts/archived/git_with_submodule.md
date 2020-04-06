---
title: Git submodule —— 一点经验
date: 2018-8-9
tags: [git, work]
---

今天一天都在各种调整git的噩梦中度过，终于感觉自己对git的branch, submodule, commit 这些操作有所了解了，都是些Google很难搜到的东西，先整理一下orz。

官方教程： <https://git-scm.com/book/en/v2/Git-Tools-Submodules>
# git中submodule的维护
工作的项目维护了一个很复杂的submodule树，不小心的话很容易就搞崩。记录几个重点。

## git如何配置submodule
git提供了一个名为`.gitmodules`的配置文件来帮助你配置submodule，这个文件的一般格式如下：显然，path是子模块的相对位置，url是仓库地址。


```
[submodule "rack"]
      path = rack
      url = git://github.com/chneukirchen/rack.git
```


## submodule的仓库的建立
初始化这些submodule有若干种方式：
### 直接clone --recursive
`git clone /path/to/your/repo --recursive`

如果你才刚开始或者想要放弃所有本地的修改，再来一次永远是最简单的方式。

### 利用git submodule 建立子模块
`git submodule` 这条命令可以帮你完成很多事，如果你不加任何后缀，它至少会帮你列出所有子模块：

```
$ git submodule
-3cb76a4301dcc76d453c69c86c2c8a889bafac34 subproject/tutor-wpf-common
```



当你编辑了`.gitmodules`文件或者只建立了父级仓库，或是进行了一些别的骚操作导致你需要自己建立一次子模块：

`git submodule update --init`

或是更骚的：
`git submodule update --init --recursive`

这条命令帮助你建立了子模块的仓库， **并且还会帮你checkout到父级仓库所在的分支上** 

```
$ git submodule update --init
Submodule 'subproject/tutor-wpf-common' (ssh://gerrit.zhenguanyu.com:29418/tutor-wpf-common) registered for path 'subproject/tutor-wpf-common'
Cloning into 'D:/tutor-wpf-student/subproject/tutor-wpf-common'...
Total 32915 (delta 0), reused 32909 (delta 0)
Submodule path 'subproject/tutor-wpf-common': checked out '3cb76a4301dcc76d453c69c86c2c8a889bafac34'
```

值得注意的是，子模块的.git目录不在 `path/to/child/.git`，而是在 `.git/modules/path/to/child`

## submodule的管理

`3cb76a4301dcc76d453c69c86c2c8a889bafac34` <= 这串神秘数字显然是某个commit-id，你也许想到了，如果一个项目要依赖于某个子模块，那让这个子模块天天在master上更新不是个好主意，也许哪天更新了接口或是修复了`feature`呢？

所以，对于父级仓库来说，`submodule`是以整个repo为单位来进行管理的！而记录这个repo，对父仓库来说，只需要记录下它们的commit-id！对于大工程来说，这个commit-id是维护每个repo之间的依赖的关键！

这时候，你的子模块很可能会是这样的：
```
$ git branch
* (HEAD detached at 3cb76a43)
  master
```

因为一般项目开发人手都不够，很难保证依赖是最新的。

如果你觉得子模块实在是太旧了，直接切换到你想要到的分支上。

```
$ git checkout master
Previous HEAD position was 3cb76a43 MOD: move virtual call from constructor, and resigter jsobject async
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
```

然后你的主仓库会变成这样：

```
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   subproject/tutor-wpf-common (new commits)

no changes added to commit (use "git add" and/or "git commit -a")
```

这时候就可以非常开心的`git add .`接`git commit -a`啦!

# 等等，这次push被老板reject了！！！
嗯，做完这一堆操作之后，你很可能发现你的代码没有通过code review，虽然你在本地磕磕绊绊干掉了build报的所有error，多出来几个warning，但是老板还是非常贴心地给你查出了100000个coding style error！嗯，为了吃饭没法坚持信仰了呢...QAQ。
更麻烦的是，老板告诉你，不要随便更新依赖库！
虽然你发现组里其他人的代码一样不忍直视，但是老板毕竟要舔好，幸亏你入职以前看了几篇《10分钟学会git》，又根据错误提示自己琢磨了下，打出了`git reset HEAD^`，然后胡乱用了几下code formatter准备交差。。。嗯。。。老板还说不能更新依赖。。。
难道是……

~~`git checkout -- subproject/tutor-wpf-common`~~

但是不知道为什么，似乎这不起作用啊！！！
赶紧切到submodule的repo。。。然而……刚才的branch已经不见啦！！！
这时候你只能通过父级仓库的命令去checkout到当前记录的那个commit！

`git submodule update`


# 关于gerrit
在gerrit上，你需要一个Change-Id，虽然可以通过 `git commit --amend` 在不更改Change-Id的情况下修改上一个commit，但是由于几乎没有一个git-gui能够非常完美地支持rebase，先Reset复制一下Change-Id，也许是比使用rebase更好的一种方式。

```
Change 243062 - Not Code-Review

ADD: add Services and interfaces for design view.

Change-Id: I952418a42a507d276f203f01976f710c04b5783a
```



