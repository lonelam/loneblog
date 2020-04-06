---
title: C#语言的编程习惯[deprecated]
date: 2018-8-31
tags: [coding style, csharp, chinglish]
---
# I'm trying to practice my english skills, if you are willing to help me with terminology and grammar, please contact me by email or wechat or qq, great rewards await.
As I have learned lots of knowledges in work, writting cleanner C# codes are still challengeable for me.
The book "effective C#"(referd as "The book" in context) is expected to be the saver for me. 
# item1 Prefer Implicitly Typed Local Variables
According to the book, implicit type "var" is introduced to support anonymous types in C#.
In most cases, for example `var foo = new MyType();` almost every one could recognize foo's type at glance, but some cases behave in opposite manner.
if you write something like 
```cs
var f = GetMagicNumber();
var total = 100 * f / 6;
Console.WriteLine($"Declared Type: {total.GetType().Name}, Value: {total}");
```

the output could be ambiguous.
So such situation should be avoid on whatever.

## msdn gives some examples and we can do more in practice
```cs
// Example #1: var is optional because
// the select clause specifies a string
string[] words = { "apple", "strawberry", "grape", "peach", "banana" };
var wordQuery = from word in words
                where word[0] == 'g'
                select word;

// Because each element in the sequence is a string, 
// not an anonymous type, var is optional here also.
foreach (string s in wordQuery)
{
    Console.WriteLine(s);
}

// Example #2: var is required when
// the select clause specifies an anonymous type
var custQuery = from cust in customers
                where cust.City == "Phoenix"
                select new { cust.Name, cust.Phone };

// var must be used because each item 
// in the sequence is an anonymous type
foreach (var item in custQuery)
{
    Console.WriteLine("Name={0}, Phone={1}", item.Name, item.Phone);
}
```

For the 1st example, it could be more efficient to let the compiler select a `IQueryable<string>` interface, and for the 2nd example, the anonymous type could be assigned as variables without type cast.

## Type relationship in linq query operations
The following illustration shows a LINQ to Objects query operation that performs no transformations on the data. The source contains a sequence of strings and the query output is also a sequence of strings.
![](https://docs.microsoft.com/zh-cn/dotnet/csharp/programming-guide/concepts/linq/media/linq_flow3.png)

Relation of data types in a LINQ query

The type argument of the data source determines the type of the range variable.

The type of the object that is selected determines the type of the query variable. Here name is a string. Therefore, the query variable is an IEnumerable<string>.

The query variable is iterated over in the foreach statement. Because the query variable is a sequence of strings, the iteration variable is also a string.

# Prefer `readonly` to `const`

C# has two types of const variable, one in compile-time, other one is runtime. They behave quite different.

for example,

```cs
//compile-time constant
public const int Millennium = 2000;
//Runtime constant
public static readonly int ThisYear = 2004;
```

the compile-time is just a declaration and the number 2000 will replace all Millennium token appeared.

thus, const declaration shouldn't be used to userdefined type or the type you prefer it to be a reference.

and const is used to define those variables must be resolved.