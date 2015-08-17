---
layout: post
title: "PowerMock is evil"
date: 2015-05-24
tags: oop java
place: Kiev, Ukraine
description:
  A properly designed method in object-oriented software
  must have a single return statement; moreover, nothing
  besides a return statement.
keywords:
  - single function exit point
  - one return only
  - one return statement
  - single exit point
  - single return in method
---

This debate is very old, but I have something to say too. The question
is whether a method may have multiple `return` statements or always
one? The answer may surprise you &mdash; in a pure object-oriented
world a method must have a single return statement and nothing else.
Yes, just a `return` statement and that's it. No other operators
or statements. Just `return`. All arguments in favor of multiple
`return`-s are just aginst the very idea of object-oriented design.

<!--more-->

This is a classical example:

{% highlight java %}
public int max(int a, int b) {
  if (a > b) {
    return a;
  }
  return b;
}
{% endhighlight %}

Indeed, this code has two `return` statements and it is shorter than this one,
with a single `return`:

{% highlight java %}
public int max(int a, int b) {
  int m;
  if (a > b) {
    m = a;
  } else {
    m = b;
  }
  return m;
}
{% endhighlight %}

More verbose, less readable, and slower, right. Right.

This is the code in a **pure** object-oriented world:

{% highlight java %}
public int max(int a, int b) {
  return new If(
    new GreaterThan(a, b),
    a, b
  );
}
{% endhighlight %}

What do you think now? There are no statements or operators. No `if` and no `>`.
Instead, there are **objects** of class `If` and `GreaterThan`.

This is pure and clean object-oriented approach.

However, Java doesn't have that. Java (and many other pseudo OOP languages)
give us operators `if`, `else`, `switch`, `for`, `while`, etc. Instead
of giving built-in classes, which would do the same. Because of that we continue
to think in terms of procedures and keep talking about whether
two `return` statements are better than a single one.

If your code is truely object-oriented, you won't be able to have more than
one `return`. Moreover, you will have nothing except a `return` in each method.
Actually, you will have only two operators in the entire
software &mdash; `new` and `return`. That's it.

Until we're there, let's stay with one `return`, at least to try to look
like pure OOP.
