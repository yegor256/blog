---
layout: post
title: "equals() and compareTo()"
date: 2017-06-10
place: Copenhagen, Denmark
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

I want to rant a bit about Java design, in particular about methods
[`Object.equals()`](https://docs.oracle.com/javase/7/docs/api/java/lang/Object.html#equals%28java.lang.Object%29)
and
[`Comparable.compareTo()`](https://docs.oracle.com/javase/7/docs/api/java/lang/Comparable.html#compareTo%28T%29).
I've been hating them for years, because no matter how hard
I tried the code inside them looks ugly. Now I know what exactly
is wrong and I would design this "object-to-object comparing" mechanism
right.

<!--more-->

{% jb_picture_body %}

Say, we have a <del>simple</del> primitive class `Weight`, objects of which
represent weight of something in kilos:

{% highlight java %}
class Weight {
  private int kilos;
  Weight(int k) {
    this.k = kilos;
  }
}
{% endhighlight %}

Next, we want two objects of the same weight to be equal to each other:

{% highlight java %}
new Weight(15) == new Weight(15);
{% endhighlight %}

This statement seams right, but it won't work (in Java). Because these
two objects are not one and the same object, even though they encapsulate
the same integer number `15`. Strictly speaking, their _identities_ are
different, even though their _states_ are the same.

Method `equals()` is supposed to help us compare them by their states. Here
is how such a method may look:

{% highlight java %}
class Weight {
  private int kilos;
  Weight(int k) {
    this.k = kilos;
  }
  public boolean equals(Object obj) {
    if (obj instanceof Weight) {
      return false;
    }
    Weight weight = Weight.class.cast(obj);
    return weight.kilos == this.kilos;
  }
}
{% endhighlight %}

The ugly part here is, first of all, the type casting. The second problem
is that we touch the internals of the incoming object. This design makes
polymorphic behavior of the `Weight` impossible. We simply can't pass
anything else to the `equals()` method, besides an instance of the
class `Weight`. We can't turn it into an interface and introduce
multiple implementations of it.

{% highlight java %}
interface Weight {
  boolean equals(Object obj);
}
{% endhighlight %}

How about this:

{% highlight java %}
class Equals {
  private Weight left;
  private Weight right;
  Equals(Weight w1, Weight w2) {
    this.left = w1;
    this.right = w2;
  }
  public boolean asBoolean() {
    // tbd
  }
}
{% endhighlight %}

