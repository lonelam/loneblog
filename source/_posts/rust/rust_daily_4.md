---
title: 一天学一个rust语法[4] enum与option
date: 2024-01-14 19:00:00
tags: [rust, beginner]
---

在 rust 中，enum 并不是单纯的值的别名，而是一种类型系统，enum 中定义的每一个项都可以去指定类型，而指定了类型以后这些项可以被当作类型来使用，典型的 case 如 IpAddr, 值得注意的是，无论这些项有没有添加类型，这些项本身都会有一个代表自己的枚举值的值存在，而不只是类型:

```rust
    enum IpAddr {
        V4(u8, u8, u8, u8),
        V6(String),
    }

    let home = IpAddr::V4(127, 0, 0, 1);

    let loopback = IpAddr::V6(String::from("::1"));

```

另外一个典型的 case 是 Message，`enum Message` 可以把不同的类型聚合成同一个类型，以为这一个类型去 impl 实现方法：

```rust
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}

    impl Message {
        fn call(&self) {
            // method body would be defined here
        }
    }

    let m = Message::Write(String::from("hello"));
    m.call();
```

更进一步地，Rust 利用这个语言特性去实现了 Option 类型，以解除对 null 的依赖，因此 Rust 里面是没有 null 的。

这有点像 TypeScript 中的 type 和 runtime 的关系，或者说 C++中的 metadata 和 runtime 的关系，类型系统减轻了运行时的负担，增加了程序的效率。

Option 定义如下，包含了两个类型 None 和 Some，这俩都是在全局空间可以直接用的，不需要 Option::None。

```rust
enum Option<T> {
    None,
    Some(T),
}
```

最终的效果就是试图使用 None 的值的时候，编译时就报错，这样运行时就显得安全了。

```rust
    let x: i8 = 5;
    let y: Option<i8> = Some(5);

    let sum = x + y;
```
