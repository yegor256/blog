---
layout: post
title: "Objects Are about Messages vs Composition"
date: 2017-11-20
place: Moscow, Russia
tags: java
description: |
  ...
keywords:
  - alan kay oop
  - alan kay about oop
  - message oriented programming
  - messages oop
  - alan kay oop definition
image: /images/2017/02/...
jb_picture:
  caption:
---

Time to time someone is asking me what do I think about what
[Alan Kay](https://en.wikipedia.org/wiki/Alan_Kay), the father of OOP,
the designer of [Smalltalk](https://en.wikipedia.org/wiki/Smalltalk),
the first object-oriented language,
[said](http://lists.squeakfoundation.org/pipermail/squeak-dev/1998-October/017019.html)
in 1998 about OOP. He literally said that the very
term "object" was misleading and a more appropriate one would be "messaging."
Here is what I think.

<!--more-->

{% jb_picture_body %}

I believe that there are two orthogonal means of interaction between objects:
messaging and composition.

This is messaging:

{% highlight java %}
point.to(canvas);
{% endhighlight %}

This is composition:

{% highlight java %}
point.to(canvas);
{% endhighlight %}


I believe that the communication component of the OOP we are dealing with now is
more about composition than about messaging.

I think that the idea, which most probably stayed behind the Object, was
more about a microservice than an initially

Let me
[quote]()http://lists.squeakfoundation.org/pipermail/squeak-dev/1998-October/017019.html:

> The key in making great and growable systems is much more to design how
its modules communicate rather than what their internal properties
and behaviors should be.


