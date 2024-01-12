---
title: 一天学一个rust语法[1] ownership
date: 2024-01-13
tags: [rust, beginner]
---

根据 rust book，ownership 是 rust 用来管理内存空间的生命周期的机制。

类似 C++的 RAII，rust 会在一个结构体的生命周期结束时释放内存，并调用 [drop 函数](https://doc.rust-lang.org/std/ops/trait.Drop.html)。

同时，String 类型的赋值会导致 ownership 转移，类似于 C++的 move, 在 rust 中这是默认的。

例如下面这段会抛异常：

```rust
    let s1 = String::from("hello");
    let s2 = s1;

    println!("{}, world!", s1);
```

但是下面这段不会：

```rust
    let x = 5;
    let y = x;

    println!("x = {}, y = {}", x, y);
```

这是由于部分类型实现了 Copy trait，而 String 实现了 Drop trait, 这俩是互斥的。

正因为这样的特性，当传参时，如果 String 被直接传入，那这个 String 相当于已经 move 了，不能再被试用.

因此如果只使用默认的传参方式，`calculate_length`函数会被写成这样：

```rust
fn main() {
    let s1 = String::from("hello");

    let (s2, len) = calculate_length(s1);

    println!("The length of '{}' is {}.", s2, len);
}

fn calculate_length(s: String) -> (String, usize) {
    let length = s.len(); // len() returns the length of a String

    (s, length)
}
```

这显然不太方便，因此后面介绍了 reference，也就是写成下面这样，这里标注引用的语法和 C++是反的，同时这里看起来是类似 C++的引用，但是因为没有更复杂的语法，所以实际上可以认为是传指针了。

```rust
fn main() {
    let s1 = String::from("hello");

    let len = calculate_length(&s1);

    println!("The length of '{}' is {}.", s1, len);
}

fn calculate_length(s: &String) -> usize {
    s.len()
}
```

上面这个行为在 rust 中被称作 borrowing。
为了安全，reference 默认也是不可变的，调用 String 的方法例如下面这个是会报错的：

```rust
fn main() {
    let s = String::from("hello");

    change(&s);
}

fn change(some_string: &String) {
    some_string.push_str(", world");
}
```

```bash
$ cargo run
   Compiling ownership v0.1.0 (file:///projects/ownership)
error[E0596]: cannot borrow `*some_string` as mutable, as it is behind a `&` reference
 --> src/main.rs:8:5
  |
7 | fn change(some_string: &String) {
  |                        ------- help: consider changing this to be a mutable reference: `&mut String`
8 |     some_string.push_str(", world");
  |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ `some_string` is a `&` reference, so the data it refers to cannot be borrowed as mutable

For more information about this error, try `rustc --explain E0596`.
error: could not compile `ownership` due to previous error
```

所以又要传引用又要改的话，这里会有更复杂的语法

```rust
fn main() {
    let mut s = String::from("hello");

    change(&mut s);
}

fn change(some_string: &mut String) {
    some_string.push_str(", world");
}
```

这种方式实际上有更复杂的约束条件：同一个变量不能被 mutable borrow 两次, 这样的话 Rust 就从语法层面限制了 data race.

不仅 mutable borrow 不能被重复 borrow， 如果之前被 immutalbe borrow, 那么这个变量也无法被 mutable borrow 了。

错误示范如下：

```rust
    let mut s = String::from("hello");

    let r1 = &s; // no problem
    let r2 = &s; // no problem
    let r3 = &mut s; // BIG PROBLEM

    println!("{}, {}, and {}", r1, r2, r3);
```

不仅如此，reference 还有个特性，就是不允许跑出变量自身的作用域，例如下面这么用就不行：

```rust
fn main() {
    let reference_to_nothing = dangle();
}

fn dangle() -> &String {
    let s = String::from("hello");

    &s
}
```

# 读后感

这应该就是 Rust 最核心的机制了，不考虑 unsafe 的情况，这种 ownership 的设计保证了内存安全。每块内存只能被一个值拥有，可以通过引用去 borrow，而内存一旦被借用，就不能再去改它，只有借用结束了才能再改它。
