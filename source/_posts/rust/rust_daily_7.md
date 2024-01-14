---
title: 一天学一个rust语法[7] Result
date: 2024-01-15 07:00:00
tags: [rust, beginner]
---

Rust 中处理异常的一种方式是 Result 作为函数的返回值，和 panic 相对的，Result 通常意味着希望你处理异常并恢复运行。

Result 的定义如下：

```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

看起来有点像 go 的函数返回值，但是不同的是因为是 enum，所以 Ok 和 Err 是二选一的，而且这俩都是泛型，可以进行类型推断。

Err 比较复杂时，可以被 match 处理，例如 match 枚举值，但是这应该不是一个好的写法，看着晕晕的。而且这意味着你得知道 Result 里的 E 泛型到底实现了哪个 Error，看起来这里是返回了一个 std::io::Error, 谁知道其他地方会返回啥呢。

```rust
use std::fs::File;
use std::io::ErrorKind;

fn main() {
    let greeting_file_result = File::open("hello.txt");

    let greeting_file = match greeting_file_result {
        Ok(file) => file,
        Err(error) => match error.kind() {
            ErrorKind::NotFound => match File::create("hello.txt") {
                Ok(fc) => fc,
                Err(e) => panic!("Problem creating the file: {:?}", e),
            },
            other_error => {
                panic!("Problem opening the file: {:?}", other_error);
            }
        },
    };
}
```

和 Option 一样，std 也给 Result 实现了一大堆方法，比较典型的是 unwrap 和 expect，这样当遇到 Err 的时候就直接 panic 了。

例如上面这段代码还可以这么写：这里似乎用了一个 lambda 语法，就是不知道这个写法要到哪里才会介绍。另外，注意 File::create 实际上是有返回值的，最后没有用分号，把这个作为新的返回值给到 greeting_file 了，不知道 rust 为什么要用这么隐晦的方式来写返回值，可能这就是对 IDE 的信任把。

```rust
use std::fs::File;
use std::io::ErrorKind;

fn main() {
    let greeting_file = File::open("hello.txt").unwrap_or_else(|error| {
        if error.kind() == ErrorKind::NotFound {
            File::create("hello.txt").unwrap_or_else(|error| {
                panic!("Problem creating the file: {:?}", error);
            })
        } else {
            panic!("Problem opening the file: {:?}", error);
        }
    });
}
```

另一个重要的语法糖就是 Error 的传播，适用于一连串操作，多次返回 Error 的情况，这在进行 IO 或是一步操作时非常常见：

```rust
use std::fs::File;
use std::io::{self, Read};

fn read_username_from_file() -> Result<String, io::Error> {
    let username_file_result = File::open("hello.txt");

    let mut username_file = match username_file_result {
        Ok(file) => file,
        Err(e) => return Err(e),
    };

    let mut username = String::new();

    match username_file.read_to_string(&mut username) {
        Ok(_) => Ok(username),
        Err(e) => Err(e),
    }
}

```

这种常见的操作可以用 `?` operator 进行简化：

```rust
use std::fs::File;
use std::io::{self, Read};

fn read_username_from_file() -> Result<String, io::Error> {
    let mut username_file = File::open("hello.txt")?;
    let mut username = String::new();
    username_file.read_to_string(&mut username)?;
    Ok(username)
}
```

对上面这个操作进行进一步简化以后就是我们常见的 optional chaining：

```rust
use std::fs::File;
use std::io::{self, Read};

fn read_username_from_file() -> Result<String, io::Error> {
    let mut username = String::new();

    File::open("hello.txt")?.read_to_string(&mut username)?;

    Ok(username)
}

```

而`?` 操作符并没有那么简单，它还可以被用于返回 Option 类型的函数：

```rust
fn last_char_of_first_line(text: &str) -> Option<char> {
    text.lines().next()?.chars().last()
}

```

上面这个 next()返回了 Option 类型，但仍然可以使用?操作符来获取 Option 中的值, 这里如果`?`操作符终端，None 会被提前返回，而不是继续执行后续的语句，因此`?`只能被用在最后一个 expression 或是 return 语句里面。

`?`到底是啥意思取决于当前函数的返回值，而返回值必须被手动指定而不能被推导出来，所以`?`的行为是明确的。
不过拷贝代码的时候需要考虑到同一段代码实际上再不同的函数里 有不同的含义。
