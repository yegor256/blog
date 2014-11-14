---
layout: post
title: "Four Virtues of a Good Object"
date: 2014-11-05
tags: oop quality
description:
  What is a properly designed object in an object-oriented world? What
  name should it have and what are the typical mistakes made in
  class designs?
keywords:
  - object design
  - what is an object
  - object oriented class
  - good object name
  - good name for an object
  - object name in OOP
  - how to choose a good name for an object
  - good name for a class
  - good class name
  - class name
  - good name of a class
  - good class name
  - name of class in java
  - java class name
---

Martin Fowler [says](http://martinfowler.com/bliki/InversionOfControl.html):

> A library is essentially a set of functions that you can call,
these days usually organized into classes

Functions organized into classes? What kind of programming is that?
Object-oriented? Martin, classes are **not** organizers of functions!
Unfortunately, you're not alone, since it is a very common
misconception of a class and an object in OOP.

So, what is a "proper" object? What is not a proper one?
What is the difference? Even though it is a very polemic subject, it is very important.
Unless we undertand what an object is, how can
we write object-oriented software?
Well, thanks to Java, Ruby and others &mdash; we can, but how good will it be?
Unfortunately, this is not an exact science. There are many opinions.
Here is my **four qualities** of a good object.

<!--more-->

Before we start talking about objects, let's define what a *class* is. It
is a place where objects are being born (aka *instantiated*). The main responsibility
of a class is to *construct* new objects on demand and *destruct* them when
they are not used any more. A class knows how its children should look
and how they should behave. In other words, it knows what *contracts* they should obey.

Sometimes I hear classes being called "object templates". This definition is
not correct because it places classes into a passive position. This definition
assumes that someone will get a template and build an object using it.
This may be true, technically speaking, but conceptually it's wrong. There
is nobody else involved &mdash; just a class and its children. An
object asks a class to create another object and the class constructs it, that's it.
Ruby expresses this concept much better than Java or C++:

{% highlight java %}
photo = File.new('/tmp/photo.png')
{% endhighlight %}

The object `photo` is constructed by the class `File`. Once constructed,
the object is acting on its own. It shouldn't know who constructed it
and how many more brothers and sisters it has in the class. Yes, I mean
that [reflection](https://en.wikipedia.org/wiki/Reflection_%28computer_programming%29)
is a terrible idea, but about it in one of the next posts :)
Now, let's talk about objects and their best and worst sides.

## It Exists In Real Life

Yes, an object is a living organism. Moreover, an object
should be [antropomorphized](https://en.wikipedia.org/wiki/Anthropomorphism), i.e.
treated like a human being (or a pet, if you like them more). By this
I basically mean that an object is not a data structure of a collection
of functions. Instead, it is an independent entity with its own life cycle,
its own behavior and its own habits.

An employee, a department, an HTTP request, a table in MySQL,
a line in a file, or a file itself are proper objects. Because they exist in
real-life, even when our software is turned off. To be more precise, an object is a
*representative* of a real-life creature. It is a *proxy* of that
real-life creature in front of all other objects. Without
such a creature &mdash; there is no object.

{% highlight java %}
photo = File.new('/tmp/photo.png')
puts photo.width()
{% endhighlight %}

In this example I'm asking `File` to construct a new object, which will
be a representative of a real file on disc. You may say that a file
is also something virtual and exists only when the computer is turned on.
I would agree and refine the definition of "real life" &mdash; it is
everything that stays aside from the scope of the program the object
lives in.

A controller, a parser, a filter, a validator, a service locator,
a singleton, or a factory are **not** good objects
(yes, most of GoF patterns are anti-patterns!).
They don't exist apart from your software, in real life. Some of them
may become good if they change their names, others can never excuse their
existence.

## It Is Unique

A good object should always encapsulate something, in order
to be unique. If there is nothing to encapsulate, an object may
have identical clones, which, I believe, is bad. Here is an example
of a bad object, which may have clones:

{% highlight java %}
class Status {
  private URL page = new URL("http://www.google.com");
  public int read() throws IOException {
    return HttpURLConnection.class.cast(
      this.page.openConnection()
    ).getResponseCode();
  }
}
{% endhighlight %}

I can create a few instances of class `Status` and all of them will be
equal to each other:

{% highlight java %}
first = new Status();
second = new Status();
assert first.equals(second);
{% endhighlight %}

Obviously, utility classes, which have only static methods,
can't instantiate good objects. More generally, utility classes
don't have any of the merits mentioned in this article and can't
even be called "classes". They are simply terrible abusers of an object paradigm
and exist in modern object-oriented languages only because their
inventors enabled static methods.

## It Is Immutable

A good object should never change its encapsulated state
(see also [Objects Should Be Immutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %})).
Remember, an object is a representative of a real-life entity, and this
entity should say the same through the entire life of the object. In other
words, an should should never betray those who he represents. It should
never change owners :)

It doesn't mean that all object methods always return the same.
Instead, a good immutable object is very dynamic
but never changes its internal state, for example:

{% highlight java %}
class Status {
  private URL page;
  public Status(URL url) {
    this.page = url;
  }
  public int read() throws IOException {
    return HttpURLConnection.class.cast(
      this.page.openConnection()
    ).getResponseCode();
  }
}
{% endhighlight %}

Even though method `read()` may return different values, the
object is immutable. It points to a certain web page and will
never point anywhere else, will never change its encapsulated state, will
never betray the URL it represents.
Of course, a good object doesn't have
[setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}), which
may change its state and force him to betray the URL.

## It Is Alive

An object must expose some functionality, through non-static methods.
Objects without methods are not good objects.

## no public static methods

## Name says What it Is not What it Does

## Interfaces

## Either final or abstract

## Hall of Fame

Android SDK `Activity`
