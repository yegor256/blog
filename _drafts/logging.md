---
layout: post
title: "A Few Reasons Against Logging in Unit Tests"
date: 2021-08-03
place: Moscow, Russia
tags: oop java
description: |
  ...
keywords:
  - logging tests
  - logging in unit tests
  - unit testing
  - logging testing
  - testing and logging
image: /images/2021/08/
jb_picture:
  caption:
---

Logging is an inevitable part of debugging. Well, at least in modern
high-level programming languages and architectures. It wasn't thirty 
years ago in Assembly, but it is now. Sometimes we trace variables, 
but rarely. More often we just print them to console. Moreover, we don't
just print them using `println` or whatever it is we have for console
printing, but send messages to a logging framework, which deals with 
the console or any other logging destinations, like files.

<!--more-->

{% jb_picture_body %}

How about this:

{% highlight java %}
...
{% endhighlight %}

