---
layout: post
title: "Abstract Objects"
date: 2020-12-01
place: Moscow, Russia
tags: oop eolang
description: |
  There are no classes in EO, but there are abstract
  objects, which are a more flexible instrument to prototype
  other objects.
keywords:
  - abstraction in oop
  - application in oop
  - eolang objects
  - eolang
  - eo design
image: /images/2020/12/the-irishman.jpg
jb_picture:
  caption: The Irishman (2019) by Martin Scorsese
translated:
  - Ukrainian: https://serge3ling.github.io/yegor256/202012-abstract-objects/
---

How do you create objects in your object-oriented language?
Let's take something classic, like C++, Java, or C#. First you define
a class, and then you make an instance of it. The first step is known
as [abstraction](https://en.wikipedia.org/wiki/Abstraction_%28computer_science%29),
and the second one as
[instantiation](https://en.wikipedia.org/wiki/Instance_%28computer_science%29#Object_oriented_programming).
A similar pair of operations
exist in functional programming: declaring a function is
abstraction,
while calling it with specific arguments is
[application](https://en.wikipedia.org/wiki/Apply).
The [question is]({% pst 2016/sep/2016-09-20-oop-without-classes %}):
why does OOP need classes _and_ objects,
while FP survives with just functions?

<!--more-->

{% jb_picture_body %}

This is an _abstract_ object in [EO](https://www.eolang.org):

{% highlight text %}
[id db] > book
  db.query > title
    "SELECT title FROM book WHERE id=?"
    id
{% endhighlight %}

The name of the object is `book`. It has three
[attributes]({% pst 2020/nov/2020-11-24-objects-without-methods %}): `id`, `db`, and `title`.
The first two are "free": they are not bound to any objects yet. The third
one `title` is bound already to a copy of the object `db.query`. The object
`book` is abstract because it has some free attributes---it's not specific
enough to refer to a specific entity in the real world.

The construct `db.query` takes an abstract object `query` from the object
bound to the attribute `db` and makes a copy of it, specifying two
arguments: the SQL string and the `id`. The process of copying an abstract
object is called "application," since it's very similar to applying
arguments to a function in FP.

The right way to use an abstract `book` is to make a copy of it, specifying
the arguments:

{% highlight text %}
book 42 mysql > b
{% endhighlight %}

Here, `42` is the `id`, `mysql` is the `db` and `b` is
a new object---a copy of the `book`. In 𝜑-calculus, which is foundational
to the EO programming language, this would be written as the following
formula:

{% highlight text %}
b ↤ book(42, mysql)
{% endhighlight %}

In order to get the `title` of `b` and name it `t`, we just do:

{% highlight text %}
b.title > t
{% endhighlight %}

We can also put it all together in one line:

{% highlight text %}
(book 42 mysql).title > t
{% endhighlight %}

It's possible to apply some arguments to an abstract object leaving
other attributes still free. For example, this would make
another abstract object, still requiring the `id` to be specified
in order to become a _closed_ object:

{% highlight text %}
book mysql:db > x
{% endhighlight %}

The suffix `:db` helps the compiler understand which free
attribute should be bound to the object `mysql`.
Later, `x` can be copied again and a closed object `b` will be created:

{% highlight text %}
x 42 > b
{% endhighlight %}

Even though the syntax of EO makes it possible to say `book.title`,
it will lead to a compile-time error: It's prohibited to touch
free attributes of an abstract object or attributes that depend
on other free attributes. However, let's say we add a new attribute `print` to the
`book`, in order to print it's `id` to the console we would do the following:

{% highlight text %}
[id db] > book
  stdout > print
    sprintf
      "The book ID is %d"
      id
  db.query > title
    "SELECT title FROM book WHERE id=?"
    id
{% endhighlight %}

The attribute `print` doesn't need the `db` attribute to be bound, since it
doesn't use it. It's possible to copy the `book` with just `id` and
then call `print` (assuming it's happening in an EO interactive console):

{% highlight text %}
$ book 42:id > x
x
$ x.print
The book ID is 42
{% endhighlight %}

By the way, do you know any other languages with abstract objects or
is EO the first one to introduce this design?
