---
layout: post
title: "𝜑 in EOLANG"
date: 2021-01-12
place: Moscow, Russia
tags: oop
description: |
  ...
keywords:
  - oop
  - object-oriented programming
  - oop research
  - oop research topics
  - oop research subjects
image: /images/2021/01/
jb_picture:
  caption:
---

There is a built-in mechanism of object decorating in EOLANG,
which I'll try to explain in this short blog post. It does look
simple to me, but I'm not sure how fast you can get it, especially
if your background is in Java, C++, or, say, JavaScript, which are also
object-oriented language.

<!--more-->

{% jb_picture_body %}

Each object in EOLANG is simply a map of other
objects and their names. Let's say, there is an object `book`:

{% highlight text %}
[id] > book
  "Object Thinking" > title
  "David West" > author
{% endhighlight %}







