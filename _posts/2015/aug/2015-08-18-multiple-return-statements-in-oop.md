---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Why Many Return Statements Are a Bad Idea in OOP"
date: 2015-08-18
tags: oop java
place: Kyiv, Ukraine
description: |
  A properly designed method in object-oriented software
  must have a single return statement---and nothing
  but a return statement.
keywords:
  - single function exit point
  - one return only
  - one return statement
  - single exit point
  - single return in method
---

This [debate](http://programmers.stackexchange.com/questions/118703)
is very old, but I have something to say too. The question
is whether a method may have multiple `return` statements or always
just one. The answer may surprise you: In a pure object-oriented
world, a method _must_ have a _single_ `return` statement and _nothing_ else.
Yes, just a `return` statement and that's it. No other operators
or statements. Just `return`. All arguments in favor of multiple
`return` statements go against the very idea of object-oriented programming.

<!--more-->

This is a classical example:

```java
public int max(int a, int b) {
  if (a > b) {
    return a;
  }
  return b;
}
```

The code above has two `return` statements, and it is shorter than this one
with a single `return`:

```java
public int max(int a, int b) {
  int m;
  if (a > b) {
    m = a;
  } else {
    m = b;
  }
  return m;
}
```

More verbose, less readable, and slower, right? Right.

This is the code in a _pure_ object-oriented world:

```java
public int max(int a, int b) {
  return new If(
    new GreaterThan(a, b),
    a, b
  );
}
```

What do you think now? There are no statements or operators. No `if` and no `>`.
Instead, there are _objects_ of class `If` and `GreaterThan`.

This is a pure and clean object-oriented approach.

However, Java doesn't have that. Java (and many other pseudo OOP languages)
gives us operators like `if`, `else`, `switch`, `for`, `while`, etc. instead
of giving built-in classes, which would do the same. Because of that, we continue
to think in terms of procedures and keep talking about whether
two `return` statements are better than one.

If your code is truly object-oriented, you won't be able to have more than
one `return`. Moreover, you will have nothing except a `return` in each method.
Actually, you will have only two operators in the entire
software---`new` and `return`. That's it.

Until we're there, let's stick with just one `return` and at least try to look
like pure [OOP]({% pst 2016/aug/2016-08-15-what-is-wrong-object-oriented-programming %}).
