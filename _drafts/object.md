---
layout: post
title: "Who Is an Object?"
date: 2016-06-26
place: Palo Alto, CA
tags: oop
description: |
  The definition of an object is fundamental in
  the entire object-oriented programming paradigm, but
  is not defined correctly in most books
keywords:
  - object
  - object in oop
  - oop object
  - object definition in oop
  - what is object in oop
---

There are thousands of books about object-oriented programming and
hundreds of object-oriented languages. I believe, most (read "all") of them
give us an incorrect definition of an "object". That's why the entire
OOP world is so full of misconceptions and simply mistakes. Their
definition of an object were limited by the hardware architecture they
were working with. The definition is very primitive and mechanical.
I'd like to introduce a better one.

<!--more-->

What is an object? I've done a small research and this is what I've found:

  * "Objects may contain data, in the form of fields, often known as attributes;
    and code, in the form of procedures, often known as methods"
    &mdash; [Wikipedia](https://en.wikipedia.org/wiki/Object-oriented_programming) at the time of writing.

  * "An object stores its state in fields and exposes its behavior through"
    &mdash; [What Is an Object?](https://docs.oracle.com/javase/tutorial/java/concepts/object.html) by Oracle.

  * "Each object looks quite a bit like a little computer &mdash;
    it has a state, and it has operations that you can ask it to perform"
    &mdash; [Thinking in Java](http://amzn.to/1PBmQpm), 4th Ed., Bruce Eckel, p.16.

  * "A class is a collection of data fields that hold values
    and methods that operate on those values"
    &mdash; [Java in a Nutshell](http://amzn.to/28PEqSi), 6th Ed., Evans and Flanagan, p.98.

  * "An object is some memory that holds a value of some type"
    &mdash; [The C++ Programming Language](http://amzn.to/1XyGCtk), 4th Ed., Bjarne Stroustrup, p.40.

  * "An object consists of some private memory and a set of operations"
    &mdash; [Smalltalk-80](http://amzn.to/1UhYinp), Goldberg and Robson, p.6.

What is common for all these definitions is the word "contains" (or "holds",
"consists", "has", etc.) They all think that an objects is a _box with data_.
And this is exactly what I'm strongly against.

If we look at how C++ or Java are implemented, such a definition of an
object will sound _technically_ correct. Indeed, for each object Java Virtual
Machine allocates a few bytes in memory, in order to store object
attributes there. Thus, we can technically say, in that languages,
that an object is an in-memory box with data.

Right, but this is just a corner case!

Let's try to imagine another object-oriented language, which doesn't
store object attributes in memory. Confused? Bear with me for a minute.
Let's say, in that language we define an object:

{% highlight text %}
c {
  vin: v,
  engine: e
}
{% endhighlight %}

Here, `vin` and `engine` are attributes of object `c` (it's a car and let's
forget about classes for now to focus strictly on objects). Thus, there is
a simple object, which has two attributes. The first one is car's VIN and the
second one is its engine. The VIN is an object `v`, while the engine is `e`.
To make it easier to understand, this is how a similar object would
look in Java:

{% highlight java %}
char[] v = {'W','D','B','H',...'7','2','8','8'}; // 17 chars
Engine e = new Engine();
Car c = new Car(v, e);
{% endhighlight %}

I'm not entirely sure about JVM, but in C++ such an object will take
exactly 25 bytes in memory (assuming it's 64-bit x86 architecture). The
first 17 bytes will be taken by the array of chars and another 8 bytes
by a pointer to the block in memory with object `e`.
That's how C++ compiler understands objects and translates them to
the x86 architecture. In C++ objects are just data structures with
clearly defined allocation of data attributes.

In that example attributes `vin` and `engine` are not equal:
`vin` is "data", while `engine` is a "pointer" to another object.
I intentionally made it this way, in order to demonstrate that calling
an object a box with data is possible only with `vin`. Only when
the data are located right "inside" the object we can say that the
object is actually a box for the data. With `engine` it isn't
really true, since there is no data technically _inside_ the object. Instead, there is a
_pointer_ to another object. If our object would have only
`engine` attribute, it would take just 8 bytes in memory, with none of them
actually occupied by "data".

Now, let's get back to our new pseudo-language. Let's imagine it treats
objects very differently than C++ &mdash; it doesn't keep object attributes
in memory _at all_. It doesn't have pointers and it doesn't know anything about
x86 architecture. It just _knows_ somehow what attributes belong to an object.

Thus, in our languages objects are not boxes with data any more, neither
technically nor conceptually. They know where the data is, but they don't
contain the data. They _represent_ the data, other objects and entities.
Indeed, the object `c`, in our imaginary language, represents two other objects:
a VIN and an engine.

To summarize, we have to understand that even though a mechanical
definition of an object is correct in most programming languages at the
moment on the market, it is very incorrect conceptually. Because it
treats an object as a box with data, which are too visible to
the outside world. That visibility provokes us to think _procedurally_
and try to access that data as soon as possible.

{% badge /images/2015/04/book-object-thinking.jpg 96 http://amzn.to/266oJr4 %}

If we would think of an object as a **representative** of data, instead of
a container of them, we would not want to get ahold of data as soon as
possible. We will understand that the data is far away and we can't
just easily touch them. We should communicate with an object and how
exactly it communicates with the data &mdash; is not our concern.

I hope that in the nearest future new object-oriented languages will
show up, which won't store objects as in-memory data structures, even
technically.

By the way, here is the definition of an object from my favorite book
[Object Thinking](http://amzn.to/266oJr4) by David West, page 66:

> An object is the equivalent of the quanta from which the universe is constructed

What do you think? Is it close to the "representative" definition I just
proposed?
