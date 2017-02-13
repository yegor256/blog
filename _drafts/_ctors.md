---
layout: post
title: "Converters in Constructors"
date: 2017-01-10
place: Dnipro, Ukraine
tags: oop java
description: |
  How is it possible to deal with different types of
  constructor arguments if we can't have code
  in constructors? Here is my take.s
keywords:
  - constructor oop
  - OOP constructors
  - arguments of constructors
  - OOP arguments of constructors
  - code-free constructors
image: ...
jb_picture:
  caption: ...
---

Some time ago I
[suggested]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %})
that we must not have any code in constructors.
Since then, the question I keep getting is how
can we deal with different types of incoming objects, when we
have to convert them before encapsulating. Say, we encapsulate a `String`,
but an `Integer` is provided. We have to call `Integer.toString()` right
inside the constructor, correct? Not really.

<!--more-->

{% jb_picture_body %}

Here is an example:

{% highlight java %}
class Foo {
  private final String name;
  Foo(Integer n) { // secondary ctor
    this(Integer.toString(n));
  }
  Foo(String n) { // primary ctor
    this.name = n;
  }
}
{% endhighlight %}

There are two constructors: the first one is secondary, the second one
is primary. The first one



