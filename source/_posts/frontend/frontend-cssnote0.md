---
title: 打卡中...
date: 2020-04-11 23:04:46
tags: [frontend, css, note]
---

# 找了一波资料
当我真正下决心去学的时候，才发现前端的学习路径简单枯燥到可怕：看[MDN](https://wiki.developer.mozilla.org/en-US/docs/Web)就完事了。
所以从现在开始每日打卡吧~

<!-- more -->

# 进度
## react
  - [x] [INSTALLATION](https://reactjs.org/docs/getting-started.html)
    - [x] Getting Started
    - [x] Add React to a Website
    - [x] Create a New React App
  - [x] [MAIN CONCEPTS](https://reactjs.org/docs/hello-world.html)
    - [x] Hello World
    - [x] Introducing JSX
    - [x] Rendering Elements
    - [x] Components and Props
    - [x] State and Lifecycle
    - [x] Handling Events
    - [x] Conditional Rendering
    - [x] Lists and Keys
    - [x] Forms
    - [x] Lifting State Up
    - [x] Composition vs Inheritance
    - [x] Thinking In React

## web fundamentals
  - [ ] CSS layout
    - [x] [basics](https://wiki.developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Introduction)
    - [x] [normal flow](https://wiki.developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Normal_Flow)
    - [ ] [flexbox](https://wiki.developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Flexbox)

  - [ ] Javascript高级程序设计
  - [ ] Javascript权威指南
  - [ ] CSS揭秘


# 一点想法
## react
跟angular复杂的概念和模板语法比起来，react真的简单到哭，看完了上面这密密麻麻一摞，我需要记住的只有两点。
首先React的state必须由setState方法设置，以触发变更检测，其次setState可能是异步，可以使用一个纯函数来防止同一个state被多次覆写。
其他不过是介绍了一些语法糖，和异想天开的用法，都是为了快速搞出一个react组件树服务的。

## css层叠
之前不知道css层叠的优先级这么复杂，并且似乎随着时间的流转，这优先级还有一些差异，另一方面，看css层叠的时候发现中文文档和英文文档差异实在是太大，甚至存在技术性错误。尝试修改，发现这居然是个wiki社区——我的修改不需要审核就可以进入wiki。这就让我对mdn英文wiki的质量也开始担忧起来。但是目前来看英文文档的更新还是比较保守的。
https://wiki.developer.mozilla.org/en-US/docs/Web/CSS/Specificity
关于css层叠规则，主要是元素名称>class>id, https://specifishity.com/ 的这张图就很可以啦:![specifishity](https://specifishity.com/specifishity.png)
