---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Redundant Variables Are Pure Evil"
date: 2015-09-01
place: Kyiv, Ukraine
tags: oop java
description: |
  Despite good intentions, redundant variables actually
  make your code dirty and difficult to understand.
keywords:
  - redundant variables
  - too many variables
  - variables in oop
  - variables in java
  - java variables
image: /images/2015/09/y-tu-mama-tambien.jpg
jb_picture:
  caption: Y Tu Mamá También (2001) by Alfonso Cuarón
---

A redundant variable is one that exists exclusively
to _explain_ its value. I strongly believe that such a variable is
not only pure noise but also _evil_, with a very negative effect
on code readability. When we introduce a redundant variable, we intend to make our code
cleaner and easier to read. In reality, though, we make it more verbose
and difficult to understand. Without exception, any variable used only
once is redundant and must be replaced with a value.

<!--more-->

{% jb_picture_body %}

Here, variable `fileName` is redundant:

```java
String fileName = "test.txt";
print("Length is " + new File(fileName).length());
```

This code must look differently:

```java
print("Length is " + new File("test.txt").length());
```

This example is very primitive, but I'm sure you've seen these
redundant variables many times. We use them to "explain" the code---it's
not just a string literal `"test.txt"` anymore but a `fileName`.
The code looks easier to understand, right? Not really.

{% quote The more variable names I have to remember, the longer it takes to digest the code. %}

Let's dig into what "readability" of code is in the first place. I think this
quality can be measured by the number of seconds I need to understand the
code I'm looking at. The longer the timeframe, the lower the readability.
Ideally, I want to understand any piece of code in a _few seconds_. If I can't,
that's a failure of its _author_.

[Remember]({% pst 2015/jun/2015-06-29-simple-diagrams %}),
if I don't understand you, it's your fault.

An increasing length of code degrades readability. So the more variable
names I have to remember while reading through it, the longer
it takes to digest the code and come to a conclusion about
its purpose and effects. I think _four_ is the maximum number
of variables I can comfortably keep in my head without thinking
about quitting the job.

New variables make the code longer because they need extra lines to
be declared. And they make the code more complex because its reader
has to remember more names.

Thus, when you want to introduce a new variable to explain what your code is
doing, stop and think. Your code is too complex and long in the first place!
Refactor it using new objects or methods but not variables. Make your
code shorter by moving pieces of it into new classes or private methods.

Moreover, I think that in [perfectly designed methods]({% pst 2015/aug/2015-08-18-multiple-return-statements-in-oop %}),
you won't need _any_ variables aside from method arguments.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">More variables with longer self-explainable names make code... <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1074235467887980544?ref_src=twsrc%5Etfw">December 16, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

P.S. "Avoid temporary variables. The fewer temporary variables in a program,
the less chance there is that one will not be properly initialized,
or that one will be altered unexpectedly before it is
used."---_The Elements of Programming Style_, Brian Kernighan and Phillip James Plauger, 1974.

P.P.S. You may find [this study](https://ieeexplore.ieee.org/abstract/document/5332232)
by Raymond Buse et al. relevant: they found out that the biggest negative
impact on Java code readability has the number of identifiers used in the code.
