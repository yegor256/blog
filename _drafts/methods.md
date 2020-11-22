---
layout: post
title: "Objects Without Methods"
date: 2020-11-17
place: Moscow, Russia
tags: oop
description: |
  ...
keywords:
  - methods in oop
  - object oriented programming
  - oop and eo
  - eolang
  - eo design
image: /images/2020/11/
jb_picture:
  caption: ...
---

What do you think an object is, in OOP? No matter what language you are
programming with, you will most probably agree with Bruce Eckel,
the author of [Effective Java](https://amzn.to/35xigKf), who said that "each object has a state
and operations that you can ask it to perform," or
Benjamin Evans, the author of [Java in a Nutshell](https://amzn.to/35uKVPU), who claimed that it is
"a collection of data fields that hold values and methods that operate on those values."
However, hold on... What if I tell you that an object may have no "operations"
and still be a perfect "equivalent of the quanta from which the universe
is constructed," as David West suggested in his great book
[Object Thinking](https://amzn.to/3kuXHlL)?

<!--more-->

{% jb_picture_body %}

In [EO](https://www.eolang.org),
our experimental programming language, we made an attempt to re-define
OOP and its objects. There are two types of _things_ in EO: atoms and objects.
Atom is a lowest level language primitive, which can't be expressed by
other atoms. For example, an object that represents an arithmetic
addition of other two objects, is an atom:

{% highlight text %}
add 5 y > x
{% endhighlight %}

In a more traditional Java-like infix notation
this code would look like this:

{% highlight text %}
x = add(5, y)
{% endhighlight %}

The atom is `add` and its two specific
arguments are `5` and `y`. The name of a new atom being
created is `x`. Once we ask this newly created atom to do anything,
it gets what's in `y`, add `5` and start behaving
like a summary of them. Until then, it stays quiet.

Atoms are provided by EO runtime. For example,
`add`, `sub`, `mul`,  and `div` for arithmetic operations;
`if` and `for` for forking and iterating;
`less`, `and`, `eq`, `or` for logical operations, and so on.
For a while you can understand atoms as low-level
functions with arguments. But they don't calculate
the result immediately, but only when the result is needed.
Saying `add(5, file)` won't lead to reading the content
of the file and adding 5 to it immediately. Only when the
created atom is dealt with, the file reading will happen.

Next, on top of these atoms objects can be created, by a programmer.
For example, this is an object that represents a circle:

{% highlight text %}
[r] > circle
  mul 2 3.14 r > length
  mul 3.14 r r > square
{% endhighlight %}

The first line creates an "abstract" object named `circle`. It is abstract,
because one of its attributes `r` is "free". It's not specified
in this object and that's why the object can't be used as is, it has
to be copied with `r` specified. For example, this is the circle `c`
with the radius 30:

{% highlight text %}
circle 30 > c
{% endhighlight %}

The object `circle` has three attributes. The first one is `r`, which is free.
The other two are `length` and `square`. They are "bounded," since their
atoms already defined: `mul` in both cases. To get the square of the
circle `c` we do this:

{% highlight text %}
c.square > s
{% endhighlight %}

It looks like a method call, but it's not. We don't call a method, we just
take an `square` object from the object `c`. It's not created for us
at the moment we do `c.square`! It has already been there sitting and waiting
for us to take it. It was created right when the object `c` was built.

This is the difference between methods in Java and attributes in EO.
In Java, every method is a procedure to be executed right once it's
called. This method calling (or message sending, according to early OOP adepts)
mechanism was inherited from C functions,
which itself we inherited from ALGOL procedures, I believe.
EO does it differently. No method calling. Just taking attributes out
of objects and giving them to other objects, until control is
given to the the entire co

In the example above, the object `s` is not a calculated number.
It's an atom `mul` that encapsulates `3.14`, `30`, and `30` (the radius). The
result of the calculation is not yet known. If we don't do anythin
with `s`, the CPU will never do the calculation. However, if we decide
to, say, print the number to the console, the caculation will happen:

{% highlight text %}
stdout
  sprintf
    "The square of circle with radius %d is %d"
    r
    s
{% endhighlight %}

Here, the atom `sprintf` constructs the string, encapsulating
three attributes: the text, `r`, and `s`. By the way,
it's possible to use either vertical or horizonal notation
for constructing objects. The code above may be written like this:

{% highlight text %}
stdout (sprintf "Radius is %d, square is %d" r s)
{% endhighlight %}

