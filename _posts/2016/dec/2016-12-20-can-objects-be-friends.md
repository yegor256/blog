---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Can Objects Be Friends?"
date: 2016-12-20
tags: oop java
place: Moscow, Russia
description: |
  Can you have encapsulation with only objects and no naked data?
  The question boils down to how objects can interact without data.
  They can be friends!
keywords:
  - encapsulation
  - encapsulation friends
  - encapsulation trusted objects
  - encapsulation meaning
  - encapsulation violation
image: /images/2016/12/raging-bull.jpg
jb_picture:
  caption: Raging Bull (1980) by Martin Scorsese
---

As [discussed before]({% pst 2016/nov/2016-11-21-naked-data %}),
proper encapsulation leads to a complete absence
of "naked data." However, the question remains: How can objects
interact if they can't exchange data? Eventually we have to expose
some data in order to let other objects use it, right? Yes, that's true.
However, I guess I have a solution that keeps encapsulation in place
while allowing objects to interact.

<!--more-->

{% jb_picture_body %}

Say that this is our object:

```java
class Temperature {
  private int t;
  public String toString() {
    return String.format("%d C", this.t);
  }
}
```

It represents a temperature. The only behavior it exposes is printing
the temperature in Celsius. We don't want to expose `t`, because
that will lead to the "[naked data]({% pst 2016/nov/2016-11-21-naked-data %})"
problem. We want to keep `t` secret, and that's a good desire.

Now, we want to have the ability to print temperature in Fahrenheit. The most
obvious approach would be to introduce another method, `toFahrenheitString()`,
or add a Boolean [flag]({% pst 2016/apr/2016-04-19-object-must-not-be-configurable %})
to the object, which will change the behavior
of method `toString()`, right? Either one of these solutions is better than adding
a method `getT()`, but neither one is perfect.

What if we create this decorator:

```java
class TempFahrenheit implements Temperature {
  private TempCelsius origin;
  public String toString() {
    return String.format(
      "%d F", this.origin.t * 1.8 + 32
    );
  }
}
```

It should work just great:

```java
Temperature t = new TempFahrenheit(
  new TempCelsius(35)
);
```

The only problem is that it won't compile in Java, because class
`TempFahrenheit` is not allowed to access private `t` in class `TempCelsius`.
And if we make `t` public, everybody will be able to read it directly, and we'll have
that "naked data" problem---a severe violation of encapsulation.

However, if we allow that access _only_ to one class, everything will be fine.
Something like this (won't work in Java; it's just a concept):

```java
class TempCelsius {
  trust TempFahrenheit; // here!
  private int t;
  public String toString() {
    return String.format("%d C", this.t);
  }
}
```

Since this `trust` keyword is placed into the class that allows access,
we won't have the "naked data" problem---we will always know exactly which
objects posses knowledge about `t`. When we change
something about `t`, we know exactly where to update the code.

What do you think?

P.S. After discussing this idea below in comments I
[started](https://www.yegor256.com/2016/12/20/can-objects-be-friends.html#comment-3068629632) to think
that we don't need that `trust` keyword at all. Instead, we should just
give all decorators access to all private attributes of an object.
