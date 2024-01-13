---
title: 一天学一个rust语法[2] slices
date: 2024-01-13 02:00:00
tags: [rust, beginner]
---

slices 语法允许使用切片获取 array 的一部分，例如

```rust
    let s = String::from("hello world");

    let hello = &s[0..5];
    let world = &s[6..11];
```

这里 hello 和 world 相当于是 borrow 了 s，只是 borrow 了一部分，盲猜 rust 应该没有能力实现把一个 array 搞出两个 mut borrow. 实际也几乎没有必要。

```rust
fn first_word(s: &String) -> &str {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }

    &s[..]
}
```

除了 String 可以切片, 数组 array 也可以切片.

```rust
let a = [1, 2, 3, 4, 5];

let slice = &a[1..3];

assert_eq!(slice, &[2, 3]);
```

很自然的语法，然后我猜这个切片语法应该和 C++的操作符一样能被重载
