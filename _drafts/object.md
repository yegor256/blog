---
layout: post
title: "Four Virtues of a Good Object"
date: 2014-11-05
tags: oop quality
description:
  Who is that properly designed object in an object-oriented world? What
  name, behavior, habits, interfaces, and friends does he have? Let's
  look at it from a different perspective.
keywords:
  - object in java
  - object oriented programming
  - object oriented methodology
  - object oriented principles
  - object oriented programming concepts
---

Martin Fowler [says](http://martinfowler.com/bliki/InversionOfControl.html):

> A library is essentially a set of functions that you can call,
these days usually organized into classes

Functions organized into classes? What kind of programming is that?
Object-oriented? Martin, classes are **not** organizers of functions!
Unfortunately, you're not alone, since it is a very common
misconception of a class and an object in object-oriented programming.

So, what is a "proper" object? Which one is not a proper one?
What is the difference? Even though it is a very polemic subject, it is very important.
Unless we undertand what an object is, how can we write object-oriented software?
Well, thanks to Java, Ruby and others &mdash; we can, but how good will it be?
Unfortunately, this is not an exact science. There are many opinions.
Here is my list of qualities of a good object.

<!--more-->

Before we start talking about objects, let's define what a *class* is. It
is a place where objects are being born (aka *instantiated*). The main responsibility
of a class is to *construct* new objects on demand and *destruct* them when
they are not used any more. A class knows how its children should look
and how they should behave. In other words, it knows what *contracts* they should obey.

Sometimes I hear classes being called "object templates"
(for example, [wikipedia says so](https://en.wikipedia.org/wiki/Class_%28computer_programming%29)).
This definition is not correct because it places classes into a passive position. This definition
assumes that someone will get a template and build an object using it.
This may be true, technically speaking, but conceptually it's wrong. There
is nobody else should be involved &mdash; there are only a class and its children. An
object asks a class to create another object and the class constructs it, that's it.
Ruby expresses this concept much better than Java or C++:

{% highlight java %}
photo = File.new('/tmp/photo.png')
{% endhighlight %}

The object `photo` is constructed by the class `File` (`new` is an entry point to the class).
Once constructed, the object is acting on its own. It shouldn't know who constructed it
and how many more brothers and sisters it has in the class. Yes, I mean
that [reflection](https://en.wikipedia.org/wiki/Reflection_%28computer_programming%29)
is a terrible idea, but about it in one of the next posts :)
Now, let's talk about objects and their best and worst sides.

## It Exists In Real Life

First of all, an object is a **living organism**. Moreover, an object
should be [antropomorphized](https://en.wikipedia.org/wiki/Anthropomorphism), i.e.
treated like a human being (or a pet, if you like them more). By this
I basically mean that an object is not a *data structure* or a collection
of functions. Instead, it is an independent entity with its own life cycle,
its own behavior and its own habits.

An employee, a department, an HTTP request, a table in MySQL,
a line in a file, or a file itself are proper objects. Because they exist in
real-life, even when our software is turned off. To be more precise, an object is a
*representative* of a real-life creature. It is a *proxy* of that
real-life creature in front of all other objects. Without
such a creature &mdash; there is, obviously, no object.

{% highlight java %}
photo = File.new('/tmp/photo.png')
puts photo.width()
{% endhighlight %}

In this example I'm asking `File` to construct a new object `photo`, which will
be a representative of a real file on disc. You may say that a file
is also something virtual and exists only when the computer is turned on.
I would agree and refine the definition of "real life" &mdash; it is
everything that exists aside from the scope of the program the object
lives in. The disc file is outside of scope of our program, that's why
it perfectly correct to create its representative inside the program.

A controller, a parser, a filter, a validator, a service locator,
a singleton, or a factory are **not** good objects
(yes, most of GoF patterns are anti-patterns!).
They don't exist apart from your software, in real life. They
are invented just to tie other objects together. They are artificial
and fake creatures. They don't represent anyone. Seriously, an XML parser
&mdash; who does it represent? Noboby.

Some of them may become good if they change their names,
others can never excuse their existence. For example, that XML parser can be
renamed to "parseable XML" and start to represent an XML document,
that exists outside of our scope. Always ask yourself, what is
the real-life entity behind your object. If you can't find an answer,
start thinking about refactoring.

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
entity should stay the same through the entire life of the object. In other
words, an should should never betray those who it represents. It should
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
may change its state and force him to betray the URL. In other words,
`setURL()` would be a terrible mistake in class `Status`.

## It Is Alive

An object must expose some functionality, through non-static methods.
Objects without methods are not good objects.

## no public static methods

## He Is Named After Who He Is Not What He Does

The name of an object should tell us **what this object is**, not what
it does. For example, these names tell us what their owners are:
an apple, a file, a series of HTTP requests, a socket, an XML document, a list of users, a regular
expression, an integer, or a PostgreSQL table. A properly named is always
possible to draw as a small picture. Even a socket can be drawn.

In the opposite, this is an example of names that tell us what their owners do:
a file reader, a text parser, an URL validator, a XML printer,
a service locator, a singleton, or an script runner. Can you draw
any of them? No, you can't. These names are not suitable for good objects.
They are terrible names that lead to terrible design.

In general, avoid names that end with "-er" &mdash; most of them are bad.

"What is the alternative of a FileReader?" &mdash; I hear you asking. What would
be a better name? Let's see. We already have `File`, which is a representative
of a real-world file on disc. This representative is not powerful enough for us,
because it doesn't know how to read the content of the file. We want to create
a more powerful one, which will have that ability. How would we call him?
Remember, the name should say what it is, not what it does. What it is? It
is a file that has data. Not just a file, like `File`, but a more sophisticated
one, with data. So, how about `FileWithData` or simply `DataFile`?

The same logic should be applicable to all other names.
Always think about **what it is**, instead of what it does.

## Interfaces

A good object always work by a contract. He works for someone. He is ready
to be hired and obey a contract. He wants to be hired

## Either final or abstract

## Hall of Fame

Android SDK `Activity`
