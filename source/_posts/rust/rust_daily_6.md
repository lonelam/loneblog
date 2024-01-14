---
title: 一天学一个rust语法[6] packages, crate, module
date: 2024-01-15 01:00:00
tags: [rust, beginner]
---

Rust 的包管理器叫作 cargo，cargo 提供各种 cli 命令。例如`cargo new my-project`，一个 cargo 项目有自己唯一的 cargo.toml 文件，但是可能包含多个 crate。
从 rust 自身考虑编译的角度，可编译的最小单元叫作 crate，它可能是 binary crate 或者 library crate，其中 binary crate 意味着它可以被直接运行, 特征是有 main 函数入口。

为了把代码暴露给 crate 外部使用，除了 enum 以外的所有结构和命名空间，都必须标注 pub 才会被导出。
例如想要导出一个子模块，除了要加上`pub mod submod;`以外，还需要写清楚导出的方法才行： `pub use submod::subfunc;`

module 有两种形式，一种是写一个文件，另一种是在文件内部声明`mod xxx {}` 这样大括号内部会被认为是一个模块。
