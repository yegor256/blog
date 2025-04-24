---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Paired Brackets"
date: 2014-10-23
tags: java
description: |
  Paired Brackets notation makes your object-oriented
  code look beautiful and disciplined, no matter
  how deep the nesting level.
keywords:
  - indentation notation
  - indentation in java
  - indentation in php
  - indentation in ruby
  - indentation in c++
social:
  - reddit: https://www.reddit.com/r/programming/comments/2k2wdo/paired_brackets_notation/
---

Here is a notation rule I'm using in Java code:
**a bracket should either start/end
a line or be paired on the same line**.

The notation applies universally to any programming language (incl.
Java, Ruby, Python, C++, PHP, etc.) where brackets are used
for method/function calls.

Here is how your code will look, if you follow
this "Paired Brackets" notation:

```java
new Foo( // ends the line
  Math.max(10, 40), // open/close at the same line
  String.format(
    "hello, %s",
    new Name(
      Arrays.asList(
        "Jeff",
        "Lebowski"
      )
    )
  ) // starts the line
);
```

<!--more-->

Obviously, the line with a closing bracket should start at the same
indentation level as the line with its opening pair.

This is how your IDE will render the code if you
follow this notation (IntelliJ IDEA):

{% figure /images/2014/10/intellij-idea-indentation.png 529 %}

Sublime Text will also appreciate it:

{% figure /images/2014/10/sublime-text-indentation.png 584 %}

As you see, those light vertical lines at the left side
of the code help you to navigate, if you follow the notation.

Those multiple closing brackets may look strange to you
at the beginning---but give yourself some time and you will
get used to them.

## Fluent

This is how I would recommend formatting
[fluent]({% pst 2018/mar/2018-03-13-fluent-interfaces %}) method calls
(this is Java in [NetBeans](https://netbeans.org/)):

{% figure /images/2014/10/netbeans-fluent-indentation.png 637 %}

## Arrays

Here is how you format an array in "Paired Brackets" notation
(this is Ruby in [RubyMine](https://www.jetbrains.com/ruby/)):

{% figure /images/2014/10/rubymine-array-indentation.png 568 %}

As you see, the same principle applies to square and curled brackets.

## JSON

The same principle is applicable to
[JSON]({% pst 2015/nov/2015-11-16-json-vs-xml %}) formatting. This is
a small JSON document in [Coda 2](http://panic.com/coda/):

{% figure /images/2014/10/coda-json-indentation.png 406 %}

## JavaScript

JavaScript should also follow the same principle. This is
how your `.js` code would look in [Atom](https://atom.io/):

{% figure /images/2014/10/atom-javascript-indentation.png 520 %}

## Python

Finally, here is Python in [PyCharm](https://www.jetbrains.com/pycharm/):

{% figure /images/2014/10/pycharm-python-indentation.png 852 %}
