---
layout: post
title: "What Do You Do With InterruptedException?"
date: 2015-10-17
place: Palo Alto, CA
tags: java
description:
  Checke InterruptedException in Java is a constant
  source of pain for many of us, here is my understanding
  of how it should be handled.
keywords:
  - InterruptedException
  - InterruptedException java
  - InterruptedException example
  - InterruptedException checked or unchecked
  - InterruptedException sleep
---

`InterruptedException` is a constant source of pain in Java, for
junior developers especially. But it should not be. It's a rather
simple and easy to understand idea. Let me try to describe and
simplify it.

<!--more-->

Let's start with this code:

{% highlight java %}
while (true) {
  // nothing
}
{% endhighlight %}

What does it do? Nothing, just spins the CPU endlessly. Can we terminate it?
Not in Java. It will stop only when the entire JVM stops, when you hit
`Ctrl-C`.
