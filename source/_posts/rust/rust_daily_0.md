---
title: 一天学一个rust语法[0] 光速入门
date: 2024-01-12
tags: [rust, beginner]
---

rust 相比 c++来说脚手架强了太多，因此只需要记住几条命令就可以开始入门。

```bash
# 编译单文件
rustc main.rs

# 初始化项目
cargo init

# 把项目跑起来
cargo run

```

对有各种语言基础的 rust 初学者来说基础的编程语法应该不是问题，因此 Rust book 给了一个非常简短的章节来介绍常见的语法概念，[Common Programming Concepts](https://doc.rust-lang.org/book/ch03-00-common-programming-concepts.html)

简短摘要如下 5 个部分：

- 3.1. Variables and Mutability
- 3.2. Data Types
- 3.3. Functions
- 3.4. Comments
- 3.5. Control Flow

每个部分读后感如下：

# 3.1. Variables and Mutability

rust 里变量有强类型，但可以被推导. 和绝大多数语言一样, 大括号是变量的作用域. 和其他语言不同的是，rust 默认变量不可变，需要加关键字 mut。

```rust
fn main() {
    let x = 5;

    let x = x + 1;

    {
        let x = x * 2;
        println!("The value of x in the inner scope is: {x}");
    }

    println!("The value of x is: {x}");
}
```

另外变量也可以被覆盖，覆盖了以后变量会是一个不同的地址，因此尽管 rust 中常有覆盖的操作，但真正使用时可能需要注意一下实际用了什么时候分配的内存：

```rust

fn main() {
    let x = 4;
    println!("the first x location is {:p}", &x);
    let x = 5;
    println!("the second x location is {:p}", &x);
    for i in 0..10 {
        if x != 5 {
            // 永远不会输出, 因为 x 的值不会被改变
            println!("the x value is {} and not equal to 5", x);
        }
        let x = i;
    }
}

```

# 3.2 Data Types

除了 C 基础类型以外，Rust 还额外支持 tuple 和 array.
比较神奇的是 tuple 用需要用`x.0`的方式去取值，而 array 和其他语言一样是用`x[0]`的方式去取值.

```rust
fn main() {
    let x: (i32, f64, u8) = (500, 6.4, 1);

    let five_hundred = x.0;

    let six_point_four = x.1;

    let one = x.2;

    let a: [i32; 5] = [1, 2, 3, 4, 5];

    let two = a[1];
}

```

# 3.3. Functions

返回值的类型在签名最后面，最后一个 expression 表示返回值。
注意这里有一个特殊的点是 expression 是没有分号;的，加分号会把 expression 变成 statement，而函数的返回值必须是 expression

```rust
fn main() {
    let x = plus_one(5);

    println!("The value of x is: {x}");
}

fn plus_one(x: i32) -> i32 {
    x + 1
}

```

# 3.4. Comments

```rust
// 真正的勇士从不写注释
```

# 3.5. Control Flow

和大部分语言一样，循环有很多种写法，rust 比较有特色的是 loop 作为关键字的循环，但是我不打算现在学，因为 for 和 while 已经够用了。for 循环只有 for...in 的用法,没有手写下标的用法, while 应该是唯一可以自定义退出条件的循环.

break 跳出循环

```rust
fn main() {
    let a = [10, 20, 30, 40, 50];

    for element in a {
        println!("the value is: {element}");
    }
}

fn main() {
    for number in (1..4).rev() {
        println!("{number}!");
    }
    println!("LIFTOFF!!!");
}

```

while 用法如下：

```rust
fn main() {
    let a = [10, 20, 30, 40, 50];
    let mut index = 0;

    while index < 5 {
        println!("the value is: {}", a[index]);

        index += 1;
    }
}
```
