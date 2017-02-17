---
layout: post
title: "Gradients of Immutability"
date: 2016-09-07
place: Palo Alto, CA
tags: oop
description: |
  There are a few levels and forms of immutability in
  object-oriented programming, all of which
  can be used when they seem appropriate.
keywords:
  - immutability
  - immutability java
  - immutable list
  - immutable object
  - immutable object java
youtube:
  - PVvLQGnyDrQ
related:
  - 2014/jun/2014-06-09-objects-should-be-immutable
  - 2014/dec/2014-12-09-immutable-object-state-and-behavior
  - 2014/dec/2014-12-22-immutable-objects-not-dumb
image: https://cf.jare.io/?u=http://www.yegor256.com/images/2016/09/twelve-monkeys.jpg
jb_picture:
  caption: Twelve Monkeys (1995) by Terry Gilliam
---

Good objects are immutable, but not necessarily constants.
I tried to explain it [here]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}),
[here]({% pst 2014/dec/2014-12-09-immutable-object-state-and-behavior %}), and
[here]({% pst 2014/dec/2014-12-22-immutable-objects-not-dumb %}),
but now it's time to make another attempt. Actually, the more I think about it,
the more I realize that immutability is not black or white&mdash;there
are a few more gradients; let's take a look.

<!--more-->

{% jb_picture_body %}

As we agreed [here]({% pst 2016/jul/2016-07-14-who-is-object %}),
an object is a **representative** of someone else
(some entity or entities, other object(s), data, memory, files, etc.).
Let's examine a number of objects that look exactly the same
to us but **represent** different things, then analyze how
immutable they are and why.

## Constant

This is **constant**; it doesn't allow any modifications
to the encapsulated entity and always returns the same text
(I've skipped constructors for the sake of brevity):

{% highlight java %}
class Book {
  private final String ttl;
  Book rename(String title) {
    return new Book(title);
  }
  String title() {
    return this.ttl;
  }
}
{% endhighlight %}

This is what we usually have in mind when talking about immutable
objects. Such a class is very close to a
[pure function](https://en.wikipedia.org/wiki/Pure_function),
which means that no matter how many times we instantiate it with
the same initial values, the result of `title()` will be the same.

## Not a Constant

Check out this one:

{% highlight java %}
class Book {
  private final String ttl;
  Book rename(String title) {
    return new Book(title);
  }
  String title() {
    return String.format(
      "%s (as of %tR)", this.ttl, new Date()
    );
  }
}
{% endhighlight %}

The object is still immutable, but it is not a pure
function anymore because of the method `title()`&mdash;it returns different values if we call it
multiple times with at least a one-minute interval. The object
is immutable; it's just not a constant anymore.

## Represented Mutability

How about this one:

{% highlight java %}
class Book {
  private final Path path;
  Book rename(String title) {
    Files.write(
      this.path,
      title.getBytes(),
      StandardOpenOption.CREATE
    );
    return this;
  }
  String title() {
    return new String(
      Files.readAllBytes(this.path)
    );
  }
}
{% endhighlight %}

This _immutable_ object keeps the book title in a file. It's not a constant,
because its method `title()` may return different values on every
second call. Moreover, the represented entity (the file) is not a constant.
We can't say whether it's mutable or immutable, as we don't know how `Files.write()`
is implemented. But we know for sure that it's not a constant, because it
accepts change requests.

## Encapsulated Mutability

An immutable object may not only represent but even
encapsulate a mutable one. Just like in the
previous example, a mutable file was encapsulated. Even though it
was represented by the immutable class `Path`, the real file on disk
was mutable. We can do the same, but in memory:

{% highlight java %}
class Book {
  private final StringBuffer buffer;
  Book rename(String title) {
    this.buffer.setLength(0);
    this.buffer.append(title);
    return this;
  }
  String title() {
    return this.buffer.toString();
  }
}
{% endhighlight %}

The object is still _immutable_. Is it
[thread-safe]({% pst 2017/jan/2017-01-17-synchronized-decorators %})? No. Is it a constant?
No. Is it immutable? Yes. Confused? You bet.

<hr/>

My point is that immutability is not _binary_; there are many
forms of it. The most simple one is, of course, a
constant. Constants are almost the same as pure functions in functional
programming. But object-oriented programming allows us to take
a few steps forward and give immutable objects more permissions
and flexibility. In OOP, we may have many more forms of immutability.

What is common among all these examples is that our objects are
**loyal** to the entities they encapsulate. There are no
[setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})
that could change them. All encapsulated objects are `final`.

This is the only quality that differentiates mutable objects from
immutable ones. The latter are always loyal to the entities they
encapsulate and represent. For all the rest ... it depends.
