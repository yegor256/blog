---
layout: post
title: "Vertical and Horizontal Decorating"
date: 2015-09-11
tags: java oop
description:
  Decorators are used to extend object functionality
  without changing their interfaces; there are two
  approaches &mdash; horizontal and vertical.
keywords:
  - composable decorators
  - decorator pattern
  - decorator pattern java
  - decorator java
  - encapsulation
---

[Decorator pattern](http://en.wikipedia.org/wiki/Decorator_pattern)
is one of the best ways to add features to an object
without changing its interface. I'm using
[composable decorators]({% pst 2015/feb/2015-02-26-composable-decorators %})
very often and always question myself how to design them right,
when the list of features must be configurable.
I'm not sure I have the right answer, but there is
some food for thought.

<!--more-->

Let's say I have a list of numbers:

{% highlight java %}
interface Numbers {
  Iterable<Integer> iterate();
}
{% endhighlight %}

Now I want to create a list that will have only odd, unique, positive and sorted numbers.
The first approach is **vertical** (I just made this name up):

{% highlight java %}
Numbers numbers = new Sorted(
  new Unique(
    new Odds(
      new Positive(
        new ArrayNumbers(
          new Integer[] {
            -1, 78, 4, -34, 98, 4,
          }
        )
      )
    )
  )
);
{% endhighlight %}

The second approach is **horizontal** (again, a name I made up):

{% highlight java %}
Numbers numbers = new Modified(
  new ArrayNumbers(
    new Integer[] {
      -1, 78, 4, -34, 98, 4,
    }
  ),
  new Modifier[] {
    new Positive(),
    new Odds(),
    new Unique(),
    new Sorted(),
  }
);
{% endhighlight %}

See the difference? The first approach decorates `ArrayNumbers` "vertically",
adding functionality through composable decorators `Positive`, `Odds`,
`Unique`, and `Sorted`.

The second approach introduces a new interface `Modifier`, which implements
just the functionality of iterating numbers, through instances
`Positive`, `Odds`, `Unique`, and `Sorted`:

{% highlight java %}
interface Mofifier {
  Iterable<Integer> modify(Iterable<Integer> origin);
}
{% endhighlight %}

For the user of `numbers` both approaches are the same. The difference is
only in design. Which one is better and when? It seems that
vertical decorating is easier to implement and is more suitable for
smaller objects, which expose just a few methods.

In my experience, I always tend to start with vertical decorating, since it's
easier to implement, but eventually migrate to a horizontal one, when the
amount of decorators starts to grow.
