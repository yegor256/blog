---
layout: post
title: "Objects Without Methods"
date: 2020-11-17
place: Moscow, Russia
tags: oop
description: |
  There are no methods in EO programming language, while
  objects have attributes, which are other objects, created
  together with the parent object.
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

What do you think an object is in OOP? No matter what language you are
programming with, you will most probably agree with Bruce Eckel,
the author of [Effective Java](https://amzn.to/35xigKf), who said that "each object has a state
and operations that you can ask it to perform," or
Benjamin Evans, the author of [Java in a Nutshell](https://amzn.to/35uKVPU), who claimed that it is
"a collection of data fields that hold values and methods that operate on those values."
However, hold on... What if I told you that an object may have no "operations"
and still be a perfect "equivalent of the quanta from which the universe
is constructed," as David West suggested in his great book
[Object Thinking](https://amzn.to/3kuXHlL)?

<!--more-->

{% jb_picture_body %}

In [EO](https://www.eolang.org),
our experimental programming language, we made an attempt to re-define
OOP and its objects. There are two types of _things_ in EO: atoms and objects.
An atom is the lowest level language primitive, which can't be expressed by
other atoms. For example, an arithmetic addition of two other objects is an atom
(stay with me, this is EO syntax, you will get used to it):

{% highlight text %}
add 5 y > x
{% endhighlight %}

In a more traditional Java-like [infix notation](https://en.wikipedia.org/wiki/Infix_notation)
this code would look like this:

{% highlight text %}
x = add(5, y)
{% endhighlight %}

The atom is `add` and its two specific
arguments are `5` and `y`. This statement creates a new atom, using
the existing one and specifying its arguments. The name of the new atom being
created is `x`. Once we ask this newly created atom to do anything,
it gets what's in `y`, adds `5`, and starts behaving
like a summary of them. Until then, it stays quiet.
EO is a declarative language.

Atoms are provided by the EO runtime. For example,
`add`, `sub`, `mul`,  and `div` are for arithmetic operations;
`if` and `for` are for forking and iterating;
`less`, `and`, `eq`, `or` are for logical operations, and so on.
Atoms may resemble low-level functions with arguments.
However, they don't calculate results immediately, but only when needed.
Saying `add(5, file)` won't lead to reading the content
of the file and adding 5 to it immediately. Only when the
created atom is dealt with will the file reading happen.

Next, on top of these atoms, objects can be created by a programmer.
For example, this is an object that represents a circle:

{% highlight text %}
[r] > circle
  mul 2 3.14 r > perimeter
  mul 3.14 r r > area
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
The other two are `perimeter` and `area`. They are "bounded," since their
atoms are already defined: `mul` in both cases. To get the area of the
circle `c` we do this:

{% highlight text %}
c.area > a
{% endhighlight %}

It looks like a method call, but it's not. We don't call a method, we just
take an `area` object from the object `c`. It's not created for us
at the moment we do `c.area`! It has already been there sitting and waiting
for us to take it. It was created right when the object `c` was built.

This is the difference between methods in Java and attributes in EO.
In Java, every method is a procedure to be executed as soon as it's
called. This method calling (or message sending, according to
[early OOP adepts]({% pst 2017/dec/2017-12-12-alan-kay-was-wrong %}))
mechanism was inherited from C functions,
which itself we inherited from ALGOL procedures, I believe.
EO does it differently. There is no method calling. It just takes attributes out
of objects and gives them to other objects, until control is
passed to them and it gets down to the level of atoms.

In the example above, the object `s` is not a calculated number.
It's an atom `mul` that encapsulates `3.14`, `30`, and `30` (the radius). The
result of the calculation is not yet known. If we don't do anything
with `a`, the CPU will never do the calculation. However, if we decide
to, say, print the number to the console, the calculation will happen:

{% highlight text %}
stdout
  sprintf
    "Radius is %d, Area is %d"
    r
    a
{% endhighlight %}

Here, the atom `sprintf` constructs the string, which encapsulates
three attributes: the text, `r`, and `s`. By the way,
it's possible to use either vertical or horizonal notation
for constructing objects. The code above may be written like this:

{% highlight text %}
stdout (sprintf "Radius is %d, Area is %d" r s)
{% endhighlight %}

The atom `stdout` encapsulates the string constructed by `sprintf`
and stays quiet. It doesn't print anything! Only when someone
at some point tries to "touch" this object, taking one of
its attributes out, the atom `stdout` will drop the line to the
console.

There are no attributes in `stdout`, `sprintf`, `mul`, and most
other atoms, except one: [𝜑](https://en.wikipedia.org/wiki/Phi).
Any object or atom has this specific attribute, also known as
the "body" of an object. Once someone attempts to touch `stdout.𝜑`,
the console will see the string.

Thus, we have objects, but we don't have methods.
There are only attributes representing other objects.

