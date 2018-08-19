---
layout: post
title: "Builders and Manipulators"
date: 2018-08-21
tags: oop java
place: Palo Alto, CA
description: |
  Giving good names to methods in object-oriented programming
  is a tough job, which can be done right if you follow this
  simple principle.
book: elegant-objects-1 2.4
keywords:
  - good name for a method
  - java method name
  - method name in oop
  - method naming best practices
  - method naming
---

Here is a simple principle of giving names to methods in OOP,
which I'm trying follow in my code:
it's a _verb_ if it _manipulates_, it's a _noun_ if it _builds_.
That's it. Nothing in between. Methods like
`saveFile()` or `getTitle()` don't fit and must be renamed and refactored.
Moreover, methods that "manipulate" must always return `void`,
for example `print()` or `save()`. Let me explain.

<!--more-->

First, I have to say that this idea is very similar to the one
suggested by [Bertrand Meyer](https://en.wikipedia.org/wiki/Bertrand_Meyer) in his book
[Object Oriented Software Construction](https://amzn.to/2MWEuJP),
where he proposes to divide object's methods into two sharply
separated categories: queries and commands.

The idea behind this principle is rather philosophical. Let's start
with builders, which are supposed to create or find an object and return
it. Say, it's a storage of books and I ask it to give me a book
by the name:

{% highlight java %}
interface Bookshelf {
  Book find(String title);
}
{% endhighlight %}

It's obviously a "builder" (or a "query" in Meyer's terms). I'm asking for
a book and it comes back to me. The problem is with the name of the method.
It is "find," which implies that I know how the book will be created. It will
be found.

However, this is not how we should treat our objects. We must not tell them
how to do the job we want them to do. Instead, we must let _them_ decide
whether the book will be found, constructed, or maybe taken from a memory cache.
When we query, we have to say what is the result we are looking for and let
them make the decision about the way this result is going to be built.
A much more appropriate name for this method would be `book()`:

{% highlight java %}
interface Bookshelf {
  Book book(String title);
}
{% endhighlight %}

The rule of thumb is: a builder is always a noun. If the method returns
something, it has to be a noun. Preferably its name has to explain what
the method returns. If it's a book, name it `book()`. If it's a file, call
the method `file()`, etc. A few good builder examples:

{% highlight java %}
interface Foo {
  float speed(Actor actor);
  Money salary(User user);
  File database();
  Date deadline(Project project, User user);
}
{% endhighlight %}

Here, on the contrary, a few examples of badly named builders:

{% highlight java %}
interface Foo {
  float calculateSpeed(Actor actor);
  Money getSalary(User user);
  File openDatabase();
  Date readDeadline(Project project, User user);
}
{% endhighlight %}

There is no place for a verb in a builder's name!

It's not only about the name, by the way. A builder, since its name doesn't
contain a verb, should not do any modifications to the encapsulated entities.
It may only create or find something and return it. It can't have any
side-effects, just like a [pure function](https://en.wikipedia.org/wiki/Pure_function).

Next, there are "manipulators" (or "commands" in Meyer's terms). They do some
work for us, modifying the entities, which the object encapsulates. They are
the opposite to builders, because they actually make changes to the world
abstracted by the object.
For example, we ask the `Bookshelf` to add a new book to it:

{% highlight java %}
interface Bookshelf {
  void add(Book book);
}
{% endhighlight %}

The method adds the book to the storage. How exactly the storage will be
modified, we don't know. But we know that since the name of the method
is a verb, there will be modifications.

Also, manipulators must not return anything. It's always `void` as a type
of their response. This is needed mostly in order to separate the imperative
part of the code from its declarative one. We either collect the objects
or tell them what to do. We must not do mix those activities in one method.

The purpose of these rules is to make the code simpler. If you follow
them and all your builders will only return objects and manipulators
will only modify the world, the entire design will become easier to
understand. Methods will be smaller and their names shorter.

Of course, very often you will have hard time finding those names. Time to time
you will want to return something from your manipulator or make your builder
do some changes to, say, the cache. Try to resist the temptation and stay
with the principle: a method is either a builder or manipulator, nothing in
the middle. The example above are rather primitive, the code in real life
is much more complicated. But that's what the principle is going to help
us with---make the code simpler.

I'm also aware of the [noun/verb](http://steve-yegge.blogspot.com/2006/03/execution-in-kingdom-of-nouns.html)
principle, which suggests to always name classes as nouns and their methods
as verbs. I believe, it's a wrong idea, since it doesn't segregate
builders from manipulators and encourages us to always think in terms
of imperative instructions. I believe that OOP must be much more about declarative
composition of objects, even if we have to get them from the other objects
instead of instantiating via constructors. That's why we do need builders
in most situations and we have to see an obvious between them and other
methods (manipulators).

A more detailed discussion of this problem you can find
in [Elegant Objects](http://goo.gl/W2WVMk), Volume 1, Section 2.4.

