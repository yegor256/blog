---
layout: post
title: "Constructors or Static Factory Methods?"
date: 2017-11-01
place: Odessa, Ukraine
tags: testing
description: |
  Static factory methods are supposed to be a convenient
  replacement of object constructors; however, I disagree
  with this idea and explain why.
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

See, Joshua, no static methods, no static attributes.

## They Can Subtype

Let's say, our class `Color` has a method `lighter()`, which is supposed
to shift the color to the next available lighter one:

{% highlight java %}
class Color {
  protected final int hex;
  Color(int h) {
    this.hex = h;
  }
  public Color lighter() {
    return new Color(hex + 0x111);
  }
}
{% endhighlight %}

However, sometimes it's more desirable to pick the next lighter color
through a set of available
[Pantone](https://en.wikipedia.org/wiki/Pantone) colors:

{% highlight java %}
class PantoneColor extends Color {
  private final PantoneName pantone;
  PantoneColor(String name) {
    this(new PantoneName(name));
  }
  PantoneColor(PantoneName name) {
    this.pantone = name;
  }
  @Override
  public Color lighter() {
    return new PantoneColor(this.pantone.up());
  }
}
{% endhighlight %}

Then, we create a static factory method, which will make the decision
which `Color` implementation is the most suitable for us:

{% highlight java %}
class Color {
  private final String code;
  static Color make(int h) {
    if (h == 0xBF1932) {
      return new PantoneColor("19-1664 TPX");
    }
    return new RGBColor(h);
  }
}
{% endhighlight %}

If the [true red](https://www.pantone.com/color-finder/19-1664-TPX) color
is requested, we return an instance of `PantoneColor`. In all other cases it's
just a standard `RGBColor`. The decision is made by the static factory
method. This is how we will call it:

{% highlight java %}
Color color = Color.make(0xBF1932);
{% endhighlight %}

It would not be possible to do the same "forking" with a constructor, since
it can only return the class it is declared in. A static method has all the
necessary freedom to return any subtype of `Color`.

True.

However, in an object-oriented world we can and must do it all differently.
First, we would make `Color` an interface:

{% highlight java %}
interface Color {
  Color lighter();
}
{% endhighlight %}

Next, we would move this decision making process to its own class `Colors`, just
like we did in the previous example:

{% highlight java %}
class Colors {
  Color make(int h) {
    if (h == 0xBF1932) {
      return new PantoneColor("19-1664-TPX");
    }
    return new RGBColor(h);
  }
}
{% endhighlight %}

And would use an instance of class `Colors` instead of a static faсtory
method inside `Color`:

{% highlight java %}
colors.make(0xBF1932);
{% endhighlight %}

However, this still is not really an object-oriented way of thinking, because
we're taking the decision making away from the object it belongs to. Either
through a static factory method `make()` or a new class `Colors`&mdash;doesn't
really matter how&mdash;we tear our objects into pieces. The first
piece is the one that is the object and the second one is the decision
making algorithm that stays somewhere else.

A much more object-oriented design would be to put that logic into the
object of class `PantoneColor`, which would be decorating
the original `RGBColor`:

{% highlight java %}
class PantoneColor {
  private final Color origin;
  PantoneColor(Color color) {
    this.origin = color;
  }
  @Override
  public Color lighter() {
    final Color next;
    if (this.origin.hex() == 0xBF1932) {
      next = new RGBColor(0xD12631);
    } else {
      next = this.origin.lighter();
    }
    return new PantoneColor(next);
  }
)
{% endhighlight %}

Then, we make an instance of `RGBColor` and decorate it with `PantoneColor`:

{% highlight java %}
Color truered = new PantoneColor(
  new RGBColor(0xBF1932)
);
{% endhighlight %}

Then, we ask it to return a lighter color and it returns the one from
the Pantone palette, not the one that is just lighter in RGB coordinates:

{% highlight java %}
Color lighter = color.lighter(); // 0xD12631
{% endhighlight %}

Of course, the example is rather primitive and needs further improvement
if we really want it to be applicable to all Pantone colors, but I hope
you got the idea. The logic must stay inside the class, not somewhere outside
of it in static factory methods or even in some other supplementary classes.
I mean the logic that belongs to the class, of course. If it's something
related to the management of class instances, there could be containers
and storages, like in the previous example above.

To summarize, I would strongly recommend to never use static methods, especially
when they are going to replace object constructors. Giving birth to an
object through its constructor is the most "sacred" moment in any object-oriented
software, don't miss the beauty of it.

