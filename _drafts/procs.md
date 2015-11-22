---
layout: post
title: "Procedures, Functions, Methods, and Temporal Coupling"
date: 2015-11-25
place: Kyiv, Ukraine
tags: java oop
description:
  ...
keywords:
  - procedures vs functions
  - oop procedures
  - procedures in oop
  - temporal coupling
  - methods vs functions
---

There is no much of a difference between them, right? Procedures,
methods, functions &mdash; just a piece of code that accepts some
arguments and performs something for us. Basically, a set of
instructions for the CPU, with a name and a list of parameters. Right.
This is a procedure. Functions and methods are something else, something
very different. But, theory aside, I want to show a practical example
of refactoring, which makes procedural code more object-oriented and
removes temporal coupling.

<!--more-->

Here is the code (just taken from this pull request code review):

{% highlight java %}
if (!file.exists()) {
  throw new IllegalArgumentException(
    "File doesn't exist"
  );
}
{% endhighlight %}
