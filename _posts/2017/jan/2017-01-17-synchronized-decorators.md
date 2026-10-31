---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Synchronized Decorators to Replace Thread-Safe Classes"
date: 2017-01-17
place: Odessa, Ukraine
tags: java oop
description: |
  Don't make your classes thread-safe; instead,
  create thread-safe decorators to make
  thread safety configurable.
keywords:
  - thread safety
  - synchronized java
  - synchronized in java
  - how to make class thread-safe
  - thread-safe java
image: /images/2017/01/aladdin.jpg
jb_picture:
  caption: Aladdin (1992) by Ron Clements and John Musker
buffer:
  - "All classes must be thread-safe, right? Not really. I think none of them have to be thread-safe"
  - "Remember, there is a performance concern involved; we don't often have multiple threads..."
  - "The right approach is to have two classes. One that is not thread-safe and a synchronized decorator"
---

You know what thread safety is, right? If not, there is a simple example
below. All classes must be thread-safe, right? Not really. Some of them
have to be thread-safe? Wrong again. I think none of them have to
be thread-safe, while all of them have to provide synchronized decorators.

<!--more-->

{% jb_picture_body %}

Let's start with an example (it's
[mutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}), by the way):

```java
class Position {
  private int number = 0;
  @Override
  public void increment() {
    int before = this.number;
    int after = before + 1;
    this.number = after;
  }
}
```

What do you think---is it [thread-safe](https://en.wikipedia.org/wiki/Thread_safety)?
This term refers to whether
an object of this class will operate without mistakes when used by multiple
threads at the same time. Let's say we have two threads working with
the same object, `position`, and calling its method `increment()` at
exactly the same moment in time.

We expect the `number` integer to be equal to 2 when both threads
finish up, because each of them will increment it once, right?
However, most likely this won't happen.

{% youtube rC17YwowURQ %}

Let's see what will happen. In both threads, `before`
will equal `0` when they start. Then `after` will be set to `1`. Then, both threads
will do `this.number = 1` and we will end up with `1` in `number` instead
of the expected `2`. See the problem? Classes with such a flaw in their
design are **not thread-safe**.

The simplest and most obvious solution is to make our method
[`synchronized`](https://docs.oracle.com/javase/tutorial/essential/concurrency/syncmeth.html).
That will guarantee that no matter how many threads call it
at the same time, they will all go sequentially, not in parallel: one
thread after another. Of course, it will take longer, but it will prevent
that mistake from happening:

```java
class Position {
  private int number = 0;
  @Override
  public synchronized void increment() {
    int before = this.number;
    int after = before + 1;
    this.number = after;
  }
}
```

A class that guarantees it won't break no matter how many threads
are working with it is called **thread-safe**.

Now the question is: Do we have to make all classes
thread-safe or only some of them? It would seem to be better to have all
classes error-free, right? Why would anyone want an object
that may break at some point? Well, not exactly. Remember, there is
a performance concern involved; we don't often have multiple
threads, and we always want our objects to run as fast as possible.
A between-threads synchronization mechanism will definitely slow us down.

I think the right approach is to have two classes. The first one
is not thread-safe, while the other one is a **synchronized decorator**,
which would look like this:

```java
class SyncPosition implements Position {
  private final Position origin;
  SyncPosition(Position pos) {
    this.origin = pos;
  }
  @Override
  public synchronized void increment() {
    this.origin.increment();
  }
}
```

Now, when we need our `position` object to be thread-safe, we decorate
it with `SyncPosition`:

```java
Position position = new SyncPosition(
  new SimplePosition()
);
```

When we need a plain simple position, without any thread safety, we do this:

```java
Position position = new SimplePosition();
```

Making class functionality both rich _and_ thread-safe is, in my opinion,
a violation of that famous
[single responsibility principle](https://en.wikipedia.org/wiki/Single_responsibility_principle).

By the way, this problem is very close to the one of
[defensive programming]({% pst 2016/jan/2016-01-26-defensive-programming %})
and validators.
