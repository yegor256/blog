---
layout: post
title: "How Does Inversion of Control Really Work?"
date: 2017-05-10
place: Odessa, Ukraine
tags: oop
description: |
  IoC is a very popular concept, which for most programmers
  looks overcomplicated or very much coupled with
  dependency injection containers; it's not.
keywords:
  - IoC
  - inversion of control
  - dependency injection
  - IoC OOP
  - dependency control
image: /images/2017/05/le-conseguenze-dellamore.jpg
jb_picture:
  caption: Le conseguenze dell'amore (2004) by Paolo Sorrentino
---

[IoC](https://en.wikipedia.org/wiki/Inversion_of_control)
seems to have become the cornerstone concept of many frameworks
and object-oriented designs since it was described by
[Martin Fowler](https://martinfowler.com/bliki/InversionOfControl.html),
[Robert Martin](https://web.archive.org/web/20041221102842/https://www.objectmentor.com/resources/articles/dip.pdf)
and
[others](https://www.laputan.org/drc/drc.html)
ten years ago. Despite its popularity IoC is
misunderstood and overcomplicated all too often.

<!--more-->

{% jb_picture_body %}

Look at this code:

```java
print(book.title());
```

It is very straight forward: we retrieve the title from the book and
simply give it to the `print()` procedure, or whatever else it might be. _We_ are in charge,
the _control_ is in our hands.

In contrast to this, here is the _inversion_:

```java
print(book);
```

We give the entire book to the procedure `print()` and
it calls `title()` when it feels like it. That is, we _delegate_ control.

This is pretty much everything you need to know about IoC.

{% quote The main point of IoC: we must not deal with data, but instead only with object composition. %}

Does it have anything to do with
[dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) containers?
Well, of course, we _could_ put the book into a container, inject the entire
container into `print()`, let it retrieve the book from the container and
then call `title()`. But that's not what IoC is really about---it's merely
one of its
[perverted]({% pst 2014/oct/2014-10-03-di-containers-are-evil %}) usage scenarios.

The main point of IoC is exactly the same as I was proposing
in my previous posts about [naked data]({% pst 2016/nov/2016-11-21-naked-data %})
and [object friends]({% pst 2016/dec/2016-12-20-can-objects-be-friends %}):
we must _not_ deal with _data_, but instead only with
[object composition](https://en.wikipedia.org/wiki/Object_composition). In the
given example the design would be even better if we got rid of the
`print()` procedure altogether and replaced it with an object:

```java
new PrintedBook(book);
```

That would be pure [object composition](https://en.wikipedia.org/wiki/Object_composition).

There is not much more to say on this subject; I hope I have cleared it up for you---it
is just as simple as that.
