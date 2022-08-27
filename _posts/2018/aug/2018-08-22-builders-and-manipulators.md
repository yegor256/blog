---
layout: post
title: "Builders and Manipulators"
date: 2018-08-22
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
image: /images/2018/08/the-night-of.jpg
jb_picture:
  caption: The Night Of (2016) by Richard Price et al.
---

Here is a simple principle for naming methods in OOP,
which I'm trying to follow in my code:
it's a _verb_ if it _manipulates_, it's a _noun_ if it _builds_.
That's it. Nothing in between. Methods like
`saveFile()` or `getTitle()` don't fit and must be renamed and refactored.
Moreover, methods that "manipulate" must always return `void`,
for example `print()` or `save()`. Let me explain.

<!--more-->

{% jb_picture_body %}

First, I have to say that this idea is very similar to the one
suggested by [Bertrand Meyer](https://en.wikipedia.org/wiki/Bertrand_Meyer) in his book
[Object Oriented Software Construction](https://amzn.to/2MWEuJP),
where he proposes we divide an object's methods into two sharply
separated categories: queries and commands.

The idea behind this principle is rather philosophical. Let's start
with builders, which are supposed to create or find an object and then return
it. Suppose I have a store of books and I ask it to give me a book
by name:

```java
interface Bookshelf {
  Book find(String title);
}
```

It's obviously a "builder" (or a "query" in Meyer's terms). I ask for
a book and it's given to me. The problem, though, is with the name of the method.
It's called "find," which implies that I know how the book will be dealt with. It will
be found.

However, this is not how we should treat our objects. We must not tell them
how to do the job we want them to do. Instead, we must let _them_ decide
whether the book will be found, constructed, or maybe taken from a memory cache.
When we query, we have to say what result we are looking for and let
the object make the decision about the way this result is going to be built.
A much more appropriate name for this method would be `book()`:

```java
interface Bookshelf {
  Book book(String title);
}
```

The rule of thumb is: a builder is always a noun. If the method returns
something, it has to be a noun. Preferably its name should explain what
the method returns. If it's a book, name it `book()`. If it's a file, call
the method `file()`, etc. Here are a few good builder examples:

```java
interface Foo {
  float speed(Actor actor);
  Money salary(User user);
  File database();
  Date deadline(Project project, User user);
}
```

Here, on the contrary, are a few examples of badly named builders:

```java
interface Foo {
  float calculateSpeed(Actor actor);
  Money getSalary(User user);
  File openDatabase();
  Date readDeadline(Project project, User user);
}
```

There is no place for a verb in a builder's name!

It's not only about the name, by the way. A builder, since its name doesn't
contain a verb, should not do any modifications to the encapsulated entities.
It may only create or find something and return it. Just like a
[pure function](https://en.wikipedia.org/wiki/Pure_function), it must not have any
side-effects.

Next, there are "manipulators" (or "commands" in Meyer's terms). They do some
work for us, modifying the entities, which the object encapsulates. They are
the opposite to builders, because they actually make changes to the world
abstracted by the object.
For example, we ask the `Bookshelf` to add a new book to itself:

```java
interface Bookshelf {
  void add(Book book);
}
```

The method adds the book to the storage. How exactly the storage will be
modified, we don't know. But we know that since the name of the method
is a verb, there will be modifications.

Also, manipulators must not return anything. It's always `void` that we see
as the type of their response. This is needed mostly in order to separate the imperative
part of the code from the declarative part. We either receive objects
or tell them what to do. We must not mix those activities in one method.

The purpose of these rules is to make the code simpler. If you follow
them, and all your builders only return objects and your manipulators
only modify the world, the entire design will become easier to
understand. Methods will be smaller and their names shorter.

{% youtube oXj9UWm1134 %}

Of course, very often you will have a hard time finding those names. From time to time
you will want to return something from a manipulator or make your builder
make some changes, say to the cache. Try to resist this temptation and stay
with the principle: a method is either a builder or a manipulator, nothing in
the middle. The examples above are rather primitive, the code in real life
is much more complicated. But that's what the principle is going to help
us with---making the code simpler.

I'm also aware of the [noun/verb](http://steve-yegge.blogspot.com/2006/03/execution-in-kingdom-of-nouns.html)
principle, which suggests always naming classes as nouns and their methods
as verbs. I believe it's a wrong idea, since it doesn't differentiate
builders from manipulators and encourages us to always think in terms
of imperative instructions. I believe that OOP must be much more about declarative
composition of objects, even if we have to sometimes get them from other objects
instead of instantiating them via constructors. That's why we do need builders
in most situations and we also have to see an obvious difference between them and the other
methods, manipulators.

You can find a more detailed discussion of this problem
in [Elegant Objects](http://goo.gl/W2WVMk), Volume 1, Section 2.4.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">How would you name a method of a class Document that reads and returns its content? <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1033605343274840064?ref_src=twsrc%5Etfw">August 26, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
