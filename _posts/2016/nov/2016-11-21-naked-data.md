---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Encapsulation Covers Up Naked&nbsp;Data"
date: 2016-11-21
tags: oop java
place: Moscow, Russia
description: |
  Encapsulation is what makes OOP objects solid,
  cohesive, and trustworthy; publicly accessible data
  is what breaks encapsulation.
keywords:
  - encapsulation
  - encapsulation data
  - encapsulation trusted objects
  - encapsulation meaning
  - encapsulation violation
image: /images/2016/11/borat.jpg
jb_picture:
  caption: "Borat: Cultural Learnings of America for Make Benefit Glorious Nation of Kazakhstan (2006) by Larry Charles"
---

[Encapsulation](https://en.wikipedia.org/wiki/Encapsulation_%28computer_programming%29)
is the core principle of object-oriented programming
that makes objects solid, cohesive, trustworthy, etc. But
what exactly is encapsulation? Does it only protect against access
to private attributes from outside an object? I think it's much more.
Encapsulation leads to the absence of _naked_ data on all levels and in all forms.

<!--more-->

{% jb_picture_body %}

This is what naked data is (C code):

```C
int t;
t = 85;
printf("The temperature is %d F", t);
```

Here `t` is the data, which is publicly accessible by the code around it.
Anyone can modify it or read it.

Why is that bad? For one reason: tight and hidden coupling.

The code around `t` inevitably makes a lot of assumptions about the data. For
example, both lines after `int t` decided that the temperature is in Fahrenheit.
At the moment of writing, this may be true, but this assumption couples the
code with the data. If tomorrow we change `t` to Celsius, the code won't know
about this change. That's why I call this coupling _hidden_.

{% youtube Nm274dGikFc %}

If we change the type of `t` from `int` to, say, `double`, the `printf`
line won't print anything after the decimal point. Again, the coupling is
there, but it's hidden. Later on, we simply won't be able to find all the places in our
code where we made these or other assumptions about `t`.

This will seriously affect maintainability.

And this is not a solution, as you can imagine (Java now):

```java
class Temperature {
  private int t;
  public int getT() { return this.t; }
  public void setT(int t) { this.t = t; }
}
```

It looks like an object, but the data is still naked. Anyone can retrieve
`t` from the object and decide whether it's Fahrenheit or Celsius, whether
it has digits after the dot or not, etc. This is not encapsulation yet!

The only way to encapsulate `t` is to make sure nobody can touch
it either directly or by retrieving it from an object. How do we do that?
Just stop exposing data and start exposing functionality. Here is how,
for example:

```java
class Temperature {
  private int t;
  public String toString() {
    return String.format("%d F", this.t);
  }
}
```

We don't allow anyone to retrieve `t` anymore. All they can do is
convert temperature to text. If and when we decide to change `t` to Celsius,
we will do it just once and in one place: in the class `Temperature`.

{% quote Any data elements that escape objects are naked and lead to maintainability problems. %}

If we need other functions in the future, like math operations or conversion
to Celsius, we add more methods to class `Temperature`. But we never
let anyone touch or know about `t`.

This idea is close to
"[printers instead of getters]({% pst 2016/apr/2016-04-05-printers-instead-of-getters %}),"
which we discussed earlier, though from a much wider perspective.
Here I'm saying that any data elements that escape objects are _naked_
and lead to maintainability problems.

The question is how we can work entirely without naked data, right? Eventually
we have to let objects exchange data, don't we? Yes, that's true. But not entirely.
I'll explain that in
[my next post]({% pst 2016/dec/2016-12-20-can-objects-be-friends %}).

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Has this Java class done enough to encapsulate the price? <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a><br><br>class Book {<br>  private int price;<br>  public int getPrice() {<br>    return this.price;<br>  }<br>}</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1104652461430706177?ref_src=twsrc%5Etfw">March 10, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
