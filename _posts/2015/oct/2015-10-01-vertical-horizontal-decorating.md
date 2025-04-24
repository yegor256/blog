---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Vertical and Horizontal Decorating"
date: 2015-10-01
place: Moscow, Russia
categories: jcg
tags: java oop
description: |
  Decorators are used to extend object functionality
  without changing their interfaces, and there are two
  approaches: horizontal and vertical.
keywords:
  - composable decorators
  - decorator pattern
  - decorator pattern java
  - decorator java
  - encapsulation
book: elegant-objects-1 3.2.6
image: /images/2015/10/the-apartment.jpg
jb_picture:
  caption: The Apartment (1960) by Billy Wilder
buffer:
  - "A decorator pattern is one of the best ways to add features to an object without changing its interface"
  - "Which one is better and when?"
  - "I always tend to start with vertical decorating since it's easier to implement..."
  - "I migrate to horizontal decorating when the number of decorators starts to grow..."
---

A [decorator pattern](https://en.wikipedia.org/wiki/Decorator_pattern)
is one of the best ways to add features to an object
without changing its interface. I use
[composable decorators]({% pst 2015/feb/2015-02-26-composable-decorators %})
quite often and always question myself as to how to design them right
when the list of features must be configurable.
I'm not sure I have the right answer, but here is
some food for thought.

<!--more-->

{% jb_picture_body %}

Let's say I have a list of numbers:

```java
interface Numbers {
  Iterable<Integer> iterate();
}
```

Now I want to create a list that will only have odd, unique, positive, and sorted numbers.
The first approach is **vertical** (I just made this name up):

```java
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
```

The second approach is **horizontal** (again, a name I made up):

```java
Numbers numbers = new Modified(
  new ArrayNumbers(
    new Integer[] {
      -1, 78, 4, -34, 98, 4,
    }
  ),
  new Diff[] {
    new Positive(),
    new Odds(),
    new Unique(),
    new Sorted(),
  }
);
```

See the difference? The first approach decorates `ArrayNumbers` "vertically,"
adding functionality through the composable decorators `Positive`, `Odds`,
`Unique`, and `Sorted`.

The second approach introduces the new interface `Diff`, which implements
the core functionality of iterating numbers through instances of
`Positive`, `Odds`, `Unique`, and `Sorted`:

```java
interface Diff {
  Iterable<Integer> apply(Iterable<Integer> origin);
}
```

For the user of `numbers`, both approaches are the same. The difference is
only in the design. Which one is better and when? It seems that
vertical decorating is easier to implement and is more suitable for
smaller objects that expose just a few methods.

As for my experience, I always tend to start with vertical decorating since it's
easier to implement but eventually migrate to a horizontal one when the
number of decorators starts to grow.
