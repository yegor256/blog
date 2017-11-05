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
["Effective Java"](http://amzn.to/2zgpiRI): static factory methods are a more preferred
way to instantiate objects comparing with constructors. I disagree.
Not only because I belive that static methods are pure evil, but
mostly because in this particular case they pretend to be good
and make us think that we have to love them.

<!--more-->

{% jb_picture_body %}

Let's analyze the reasoning and see why it's wrong, from
an object-oriented point of view.

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
are actually four, but the forth one is not applicable to Java
[anymore](https://docs.oracle.com/javase/7/docs/technotes/guides/language/type-inference-generic-instance-creation.html)):

  * They have names.
  * They can cache.
  * They can subtype.

I believe that all three make perfect sense ... if the design is wrong.
They are good excuses for workarounds.
Let's go one by one.

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

True.

However, the right solution would be to use polymorphism and encapsulation,
to decompose the problem into a few semantically rich classes:

{% highlight java %}
interface Color {
}
class HexColor implements Color {
  private final int hex;
  HexColor(int h) {
    this.hex = h;
  }
}
class RGBColor implements Color {
  private final Color origin;
  RGBColor(int red, int green, int blue) {
    this.origing = new HexColor(
      red << 16 + green << 8 + blue
    );
  }
}
{% endhighlight %}

Now, we use the right constructor of the right class:

{% highlight java %}
Color tomato = new RGBColor(255, 99, 71);
{% endhighlight %}

See, Joshua?

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

Then, somewhere inside the `Color` we keep a private static `Map` with all
objects already instantiated:

{% highlight java %}
class Color {
  private static final Map<Integer, Color> CACHE =
    new HashMap<>();
  private final int hex;
  static Color makeFromPalette(int red,
    int green, int blue) {
    final int hex = red << 16 + green << 8 + blue;
    return Color.CACHE.computeIfAbsent(
      hex, h -> new Color(h)
    );
  }
  private Color(int h) {
    return new Color(h);
  }
}
{% endhighlight %}

It is very effective performance wise. With such a small object like our
`Color` the problem may not be so obvious, but when objects are bigger, their
instantiation and garbage collection may waste a lot of time.

True.

However, there is an object-oriented way to solve this problem. We just
introduce a new class `Palette`, which becomes a storage of colors:

{% highlight java %}
class Palette {
  private final Map<Integer, Color> colors =
    new HashMap<>();
  Color take(int red, int green, int blue) {
    final int hex = red << 16 + green << 8 + blue;
    return this.computerIfAbsent(
      hex, h -> new Color(h)
    );
  }
}
{% endhighlight %}

Now, we make an instance of `Palette` once and ask it to return a color
to us every time we need it:

{% highlight java %}
Color tomato = palette.take(255, 99, 71);
// Later we will get the same instance:
Color red = palette.take(255, 99, 71);
{% endhighlight %}

See, Joshua? I'm sure you knew it too.

## They Can Subtype

Let's say, our class `Color` has a method
