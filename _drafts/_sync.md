---
layout: post
title: "Synchronized Decorators to Replace Thread-Safe Classes"
date: 2016-12-30
place: Dnipro, Ukraine
tags: java oop
description: |
  Don't make your classes thread-safe, instead
  create thread-safe decorators, to make
  thread-safety configurable.
keywords:
  - thread-safety
  - synchronized java
  - synchronized in java
  - how to make class thread-safe
  - thread-safe java
---

You know what thread-safety is, right? If not, there is a simple example
below. All classes must be thread-safe, right? Not really. Some of them
have to thread-safe? Again wrong. I think that none of them have to
be thread-safe, while all of them have to provide synchronized decorators.

<!--more-->

Let's start with an example (it's
[mutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}), by the way):

{% highlight java %}
class Position {
  private int number = 0;
  @Override
  public void increment() {
    int before = this.number;
    int after = before + 1;
    this.number = after;
  }
}
{% endhighlight %}

What do you think&mdash;is it [thread-safe](https://en.wikipedia.org/wiki/Thread_safety)?
This term means whether
an object of this class will work without mistakes when being used by multiple
threads at the same time. Let's say, we have two threads working with
the same object `position` and calling its method `increment()` at
exactly the same moment of time.

We expect that `number` integer to be equal to 2 when both threads
finish up, since each of them will increment it once, right?
However, most likely this won't happen.

Let's see what will happen. In both threads, when they start, `before`
will be equal to `0`. Then `after` will be set to `1`. Then, both threads
will do `this.number = 1` and we will end up with `1` in `number`, instead
of the expected `2`. See the problem? Classes with such a flaw in their
design are called **not thread-safe**.

The most obvious and simple solution is to make our method
[`synchronized`](https://docs.oracle.com/javase/tutorial/essential/concurrency/syncmeth.html).
That will guarantee that no matter how many threads are calling it
at the same time, they all will go sequentially, not parallel: one
thread after another. Of course, it will take longer, but will prevent
that mistake from happening:

{% highlight java %}
class Position {
  private int number = 0;
  @Override
  public synchronized void increment() {
    int before = this.number;
    int after = before + 1;
    this.number = after;
  }
}
{% endhighlight %}

A class that guarantees that it won't break no matter how many threads
are working with it is called **thread-safe**.

And now the question is: do we have to make all classes
thread-safe or only some of them? It seems that it's better to have all
classes error-free, right? Why would anyone want an object
that may break at some point? Well, not exactly. Remember, there is
a performance concern involved: very often we just don't have multiple
threads and want out objects to be as fast as possible.
Between-threads synchronization mechanism will definitely slow us down.

I think that the right approach is to two have two classes. The first one
is not thread-safe, while the other one is a **synchronized decorator**,
which would look like this:

{% highlight java %}
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
{% endhighlight %}

Now, when we need our `position` object to be thread-safe, we decorate
it with `SyncPosition`:

{% highlight java %}
Position position = new SyncPosition(
  new SimplePosition()
);
{% endhighlight %}

When we need a plain simple position, without any thread-safety, we do:

{% highlight java %}
Position position = new SimplePosition();
{% endhighlight %}

Making classes both functionality rich _and_ thread-safety is, in my opinion,
a violation of that famous
[single responsibility principle](https://en.wikipedia.org/wiki/Single_responsibility_principle).

By the way, this problem is very close to the one of
[defensive programming]({% pst 2016/jan/2016-01-26-defensive-programming %})
and validators.
