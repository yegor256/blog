---
layout: post
title: "Object-Oriented Declarative Input/Output in Cactoos"
date: 2017-06-10
place: Dnipro, Ukraine
tags: java oop
description: |
  ...
keywords:
  - IO java
  - read/write java
  - object-oriented input/output
  - cactoos
  - input/output cactoos
image: /images/2017/06/?
jb_picture:
  caption: xxx
---

[Cactoos](http://www.cactoos.org) is a library of object-oriented
Java primitives I created just a few weeks ago. The intent was to
propose a more declarative and clean alternative to
JDK, Guava, Apache Commons, and others. Instead of calling static
procedures we may want to use objects, the way they are supposed to
be used. Let's see how input/output works, in a _pure_
object-oriented fashion.

<!--more-->

{% jb_picture_body %}

Let's say I want to read a file. This is how I would do it with the static
method `readAllBytes()` from the
[utility class]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %})
`Files` in JDK7:

{% highlight java %}
byte[] content = Files.readAllBytes(
  new File("/tmp/photo.jpg").toPath()
);
{% endhighlight %}

This code is very imperative&mdash;it reads the file content right here and now,
placing it into the array.

This is how I do it with [Cactoos](https://github.com/yegor256/cactoos):

{% highlight java %}
Bytes content = new InputAsBytes(
  new PathAsInput(
    new File("/tmp/photo.jpg")
  )
);
{% endhighlight %}

