---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "One More Recipe Against NULL"
date: 2018-05-22
place: Moscow, Russia
tags: oop
description: |
  Returning NULL when a method can't calculate the result
  is widely considered a bad practice; there are
  a number of alternatives.
keywords:
  - oop null
  - null in oop
  - return null
  - null is evil
  - null is bad
image: /images/2018/05/snatch.jpg
jb_picture:
  caption: Snatch (2000) by Guy Ritchie
---

You know what NULL is, right? It's
[evil](https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare).
In OOP, your method can return NULL,
it can accept NULL as an argument, your object can encapsulate it as an attribute,
or you can assign it to a variable.
All four scenarios are bad for the maintainability of your code---there
are no doubts about that.
The question is what to do instead. Let's discuss the "return it" part and
I will suggest one more "best practice" on top of what
[was discussed]({% pst 2014/may/2014-05-13-why-null-is-bad %}) a few years ago.

<!--more-->

{% jb_picture_body %}

Look at this code:

```java
Integer max(List<Integer> items) {
  // Calculate the maximum of all
  // items and return it.
}
```

What should this method do if the list is empty?
Java's [`Collections.max()`](https://docs.oracle.com/javase/8/docs/api/java/util/Collections.html#max-java.util.Collection-)
throws an exception.
Ruby's [`Enumerable.max()`](https://ruby-doc.org/core-2.5.1/Enumerable.html#method-i-max)
returns `nil`.
PHP's [`max()`](http://php.net/manual/en/function.max.php)
returns `FALSE`.
Python's [`max()`](https://docs.python.org/3/library/functions.html#max)
raises an exception.
C#'s [`Enumerable.Max()`](https://msdn.microsoft.com/en-us/library/bb335614(v=vs.110).aspx)
also throws an exception.
JavaScript's [`Math.max()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/max)
returns `NaN`.

Which is the right way, huh? An exception, NULL, false or NaN?

An exception, if you ask me.

But there is yet another approach, which is better than an exception. This one:

```java
Integer max(List<Integer> items, Integer def) {
  // Calculate the maximum of all
  // items and return it. Returns 'def' if the
  // list is empty.
}
```

The "default" object will be returned if the list is empty. This feature
is implemented in Python's [`max()`](https://docs.python.org/3/library/functions.html#max) function:
it's possible to pass both a list and a default element to return in case the list
is empty. If the default element is not provided, the exception will be raised.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Say, you are designing a method findUserByName(), which has to find a user in the database. What would you return if nothing is found? <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a></p>--- Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/990459955818979329?ref_src=twsrc%5Etfw">April 29, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
