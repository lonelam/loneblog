---
title: 一天学一个rust语法[5] match & if let
date: 2024-01-14 23:00:00
tags: [rust, beginner]
---

match 是针对 enum 类型进行判断的语法，关键字后面的表达式表示的是 **值** , 下面的分支被称为 **arm** , **arm** 由 pattern 和 code 组成，pattern 中可以声明变量来接收 enum 类型内部的值，code 如果是 expression 则有可能被作为函数的返回值. 同时`other`或是`_`被用作表示匹配所有值的占位符

```rust
    let dice_roll = 9;
    match dice_roll {
        3 => add_fancy_hat(),
        7 => remove_fancy_hat(),
        _ => (),
    }

    fn add_fancy_hat() {}
    fn remove_fancy_hat() {}

```

```rust
#[derive(Debug)] // so we can inspect the state in a minute
enum UsState {
    Alabama,
    Alaska,
    // --snip--
}

enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter(UsState),
}

fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => 1,
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter(state) => {
            println!("State quarter from {:?}!", state);
            25
        }
    }
}
```

另一种表示 enum 类型处理的方式是`if let` 这种方式更自由，并且不需要遍历枚举值的所有可能性，这会在很多时候方便一些。
例如针对上面的哪个 Coin 类型，可以用 if let 处理如下：

```rust
let mut count = 0;
if let Coin::Quarter(state) = coin {
    println!("State quarter from {:?}!", state);
} else {
    count += 1;
}

```
