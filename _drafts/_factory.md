---
layout: post
title: "Constructors or Static Factory Methods?"
date: 2017-11-01
place: Odessa, Ukraine
tags: testing
description: |
  ...
keywords:
  - constructors
  - factory methods
  - factory method
  - constructor or factory
  - factories vs constructiors
image: /images/2017/02/...
jb_picture:
  caption:
---

I believe Joshua Bloch said it first in his very good book
["Effective Java"](): static factory methods are a more preferred
way to instantiate objects comparing with constructors. I disagree.
Not only because I belive that static methods are pure evil, but
mostly because in this particular case they pretend to be good
and make us think that they we have to love them.

<!--more-->

{% jb_picture_body %}

This is a class with a primary and two secondary constructors:

{% highlight java %}
class Color {
  private final int hex;
  Color(String rgb) {
    this(Integer.parseInt(rgb, 16));
  }
  Color(int red, int green, int blue) {
    this(red << 16 + green << 8 + blue);
  }
  Color(int h) {
    this.hex = h;
  }
}
{% endhighlight %}

This is a similar class with three static factory methods:

{% highlight java %}
class Color {
  private final int hex;
  static Color makeFromRGB(String rgb) {
    return new Color(Integer.parseInt(rgb, 16));
  }
  static Color makeFromPalette(int red,
    int green, int blue) {
    return new Color(red << 16 + green << 8 + blue);
  }
  static Color makeFromHex(int h) {
    return new Color(h);
  }
  private Color(int h) {
    return new Color(h);
  }
}
{% endhighlight %}

Which one do you like better?

According to Joshua Bloch, there are three basic advantages
of using static factory methods instead of constructors (there
are actually four, but the forth one is not applicable to Java anymore):

  * They have names.
  * They can cache.
  * They can subtype.

I believe that all four make perfect sense ... if the design is bad. They are
good excuses for workarounds. Let's go one by one.

## They Have Names

This is how you make a
[red tomato](http://www.rapidtables.com/web/color/red-color.htm)
color object with a constructor:

{% highlight java %}
Color tomato = new Color(255, 99, 71);
{% endhighlight %}

This is how you do it with a static factory method:

{% highlight java %}
Color tomato = Color.makeFromPalette(255, 99, 71);
{% endhighlight %}

It seems that `makeFromPalette()` is sematically richer than just `new Color()`,
right? Well, yes. Who knows what that three numbers mean if we just pass
them to the constructor. But the word "palette" helps us figure everthing
out immediately.

tbd...

## They Can Cache

Let's say I need a red tomato color in multiple places of the application:

{% highlight java %}
Color tomato = new Color(255, 99, 71);
// ... sometime later
Color red = new Color(255, 99, 71);
{% endhighlight %}

Two objects will be created, which is obviously inefficient, since they are
identical. Would be better to keep the first instance somewhere in memory
and return it when the second call arrives. Static factory method makes
it possible to solve this very problem:

{% highlight java %}
Color tomato = Color.makeFromPalette(255, 99, 71);
// ... sometime later
Color red = Color.makeFromPalette(255, 99, 71);
{% endhighlight %}

Then, somewhere inside `Color` we keep a private static `Map` with all
objects already instantiated:

{% highlight java %}
class Color {
  private static final Map<Integer, Color> CACHE =
    new HashMap<>();
  private final int hex;
  static Color makeFromPalette(int red,
    int green, int blue) {
    final int hex = red << 16 + green << 8 + blue;
    return Color.CACHE.computerIfAbsent(
      hex, h -> new Color(h)
    );
  }
  private Color(int h) {
    return new Color(h);
  }
}
{% endhighlight %}

tbd...

## They Can Subtype

Let's say, our class `Color` has a method
