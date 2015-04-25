---
layout: post
title: "How To Implement an Adapter Iterator"
date: 2015-04-27
tags: java
description:
  In my experience, very few people understand how to implement
  an interator in Java, this article should give a simple
  and practical example
keywords:
  - java iterator
  - iterator in java example
  - iterator in java
  - java iterator example
  - implement java iterator
---

[Iterator](http://docs.oracle.com/javase/7/docs/api/java/util/Iterator.html)
is one of fundamental Java interfaces, introduced in Java 1.2. It is supposed
to be very simple. However, in my experience, many Java developers don't understand
how to implement a custom one, which should iterate a stream of data
coming from some other source. In other words, an **adapter** of
another source of data, in form of an iterator. Hope this example will help.

<!--more-->

Let's say we have an object of this class:

{% highlight java %}
final class Data {
  byte[] read();
}
{% endhighlight %}

When we call `read()`, it returns a new array of bytes, which were retrieved
from somewhere. If there is nothing to retrieve, the array will be empty. Now,
we want to create an _adapter_:

{% highlight java %}
final class FluentData implements Iterator<Byte> {
  boolean hasNext() { /* ... */ }
  Byte next() { /* ... */ }
  void remove()  { /* ... */ }
}
{% endhighlight %}

Here is how it should look (it is not thread-safe!):

{% highlight java %}
final class FluentData implements Iterator<Byte> {
  private final Data data;
  private final Queue<Byte> buffer = new LinkedList<>();
  public DataIterator(final Data dat) {
    this.data = dat;
  }
  public boolean hasNext() {
    if (this.buffer.isEmpty()) {
      for (final byte item : this.data.read()) {
        this.buffer.add(item);
      }
    }
    return !this.buffer.isEmpty();
  }
  public Byte next() {
    if (!this.hasNext()) {
      throw new NoSuchElementException("nothing left");
    }
    return this.buffer.poll();
  }
  public void remove() {
    throw new UnsupportedOperationException("it is read-only");
  }
}
{% endhighlight %}

There is no way to make it thread-safe, because iterating process
is outside of scope of the iterator. Even if we declare our methods
as `synchronized`, this won't guarantee that two threads won't conflict
when they both call `hasNext()` and `next()`. So, don't bother, just
document the iterator as not thread-safe and let its users
synchronize one level higher, when necessary.
