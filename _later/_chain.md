---
layout: post
title: "Object-Oriented Chain of Processors"
date: 2019-02-28
place: Moscow, Russia
tags: java oop
description: |
  ...
keywords:
  - java object-oriented
  - processing data
  - oop data processing
  - data processor oop
  - object oriented data processor
image: /images/2019/03/...
jb_picture:
  caption:
---

Imagine a situation: you have a table in a relational database, which contains a large
data set, like a few million records. You have to fetch them all and process,
one by one. Moreover some of them should be grouped with others. In the end
you want to get a file with some summary of the information from the database.
How would you do it in, say, Java? I guess, you would create a database "reader,"
a number of data "processors," and a file "writer." Well, that's how
[Spring Batch](https://spring.io/projects/spring-batch), and many other data
processing frameworks work. However, this is not really object-oriented enough.
How could we do it instead?

<!--more-->

{% jb_picture_body %}

I would use, guess what, ... decorators.
[Horizontal]({% pst 2015/oct/2015-10-01-vertical-horizontal-decorating %}) ones.
Let me show how.

First, I would create an interface for the source of data:

```java
interface Items<T> {
  Items<T> without(int max, );
  boolean isEmpty();
}
```

I would not use the `Iterator` simply because it is
[mutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}) and
it doesn't alow its methods
to throw checked `IOException`, and I'm a
[big fan]({% pst 2015/jul/2015-07-28-checked-vs-unchecked-exceptions %}) of those.
The `Items` interface is immutable and is supposed to be used like this,
in order to read the entire set of items:

```java
while (!items.empty()) {
  batch = items.batch(10);
  items = items.next();
}
```

The logic is similar to database "cursors."
The method `batch()` reads as much as it can, but not more than the
`max` specified. Then, if we want to move to the next batch, we call
`next()`. Before fetching items we have to check that the source
still has at least one of them there, that's why we call `isEmpty()`. It's a
pretty safe algorithm: even if `isEmpty()` returns `false` while the database
loses some items, method `batch()` will just return an empty collection
and our next call to `isEmpty()` will return `true`.

Then, I would create the "reader," but, of course, it would not be called
that way. I would call it by the name of the items it represents. For example,
we want to fetch the list of payments from the database. The name of the
class would be `Payments`:

```java
final class Payments implements Items<Payment> {
  private int latest; // the latest ID fetched
  Collection<Payment> batch(int max) {
    // SELECT * FROM payment WHERE id > %latest% LIMIT %max%
  }
  boolean isEmpty() {
    // SELECT * FROM payment WHERE id > %latest% LIMIT 1
  }
  Items<Payment> next() {
    return Payments();
  }
}
```














