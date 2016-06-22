---
layout: post
title: "How Immutable Is a Gearbox?"
date: 2016-06-20
place: Palo Alto, CA
tags: oop
description: |
  Very often we misunderstand immutability in OOP
  and expect immutable objects to be constant; this
  is not right.
keywords:
  - immutability
  - immutability java
  - immutable list
  - immutable object
  - immutable object java
---

Is it possible to change an immutable object?

<!--more-->

Let's start from an example:

{% highlight java %}
class Gearbox {
  Gearbox switchTo(int gear) {
    // return a new gearbox that
    // is switched to the required gear
  }
  int gear() {
    // return current gear
  }
}
{% endhighlight %}

And now take a look

{% highlight java %}
class Gearbox {
  void switchTo(int gear) {
    // switch it to the required gear
  }
  int gear() {
    // return current gear
  }
}
{% endhighlight %}

