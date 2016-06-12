---
layout: post
title: "If-Then-Else Is a Code Smell"
date: 2016-06-12
place: Tallinn, Estonia
tags: oop
description: |
  Forking is a perfect mechanism to control execution
  flow in a procedure, which has almost
  no right to exist in OOP.
keywords:
  - if then else
  - if forking
  - if then else oop
  - oop forking
  - if forking
---

In most cases (maybe even in all of them) If-Then-Else can and must
be replaced by a decorator or simply another object.
I've been planning to write about it for almost a year, but only today found
a real case in my own code, which perfectly
illustrates the problem. So, it's time to demonstrate it and explain.

<!--more-->

Take a look at this class
[`DyTalk`](https://github.com/yegor256/rultor/blob/1.61.9/src/main/java/com/rultor/dynamo/DyTalk.java)
from
[yegor256/rultor](https://github.com/yegor256/rultor)
and its method
[`modify()`](https://github.com/yegor256/rultor/blob/1.61.9/src/main/java/com/rultor/dynamo/DyTalk.java#L127-L169).
In a nutshell, it prevents from saving any data to the DynamoDB if there were no
modifications of the XML document. It's a valid case and it has to be
validated, but the way it's implemented is simply wrong. This is
how it works (an over simplified example):

{% highlight java %}
class DyTalk {
  void modify(Collection<Directive> dirs) {
    if (!dirs.isEmpty()) {
      // apply the modification
      // and save the new XML document
      // to the DynamoDB table
    }
  }
}
{% endhighlight %}

What's wrong, you wonder? This If-Then-Else forking functionality doesn't really belong
to this object &mdash; that's what's wrong. Modifying the XML document
and saving it to the database is _its functionality_, while
not saving anything if the modification instructions set is empty is not
(very similar to the [defensive programming]({% pst 2016/jan/2016-01-26-defensive-programming %})).

...

Every time there is If-Then-Else in your code &mdash; it's a code smell,
begging for refactoring. Break your object to smaller ones.

