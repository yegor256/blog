---
layout: post
title: "Why Objects Have to Be Immutable"
date: 2014-05-19
tags: quality immutability
description:
  The article gives arguments about why classes/objects
  in object-oriented programming have to be immutable,
  i.e. never change their encapsulated state
keywords:
  - object design
  - why immutable
  - immutability of objects
  - agruments for immutable objects
  - why immutable objects are better
  - immutability in oop
  - oop immutable objects
  - immutable classes
  - immutable class
  - immutable object
  - best practices immutable
---

In object-oriented programming, an object is immutable when it doesn't
change its state during the whole lifetime. A good example of an immutable
object is [`String`](http://docs.oracle.com/javase/7/docs/api/java/lang/String.html)
in Java. Once it is created we can't change its state. We
can ask it to create new objects, but its own state will never change.

However, there are not so many immutable classes in JDK. Take, for example,
class [`Date`](http://docs.oracle.com/javase/7/docs/api/java/util/Date.html).
It can change its state through method `setTime()`, at any moment during its lifetime.

I don't know why JDK designers decided to make these two very similar classes
differently. However, I believe that the design of a mutable `Date` has
a lot of flaws, while the immutable `String` is more in spirit
of object-oriented paradigm.

Moverover, I think that *all* classes should immutable in a proper
object-oriented world. Unfortunately, sometimes it is technically not
possible due to limitations of, say, JVM.

Let me show the arguments in favor of immutability.

## Avoiding Temporal Coupling

An example of temporal coupling:

{% highlight java linenos=table %}
Order order = orders.find(345);
order.discount(0.15); // this line and the next one are coupled
order.save();
{% endhighlight %}

This is the right design:

{% highlight java linenos=table %}
Order order = orders.find(345);
order.discount(0.15).save(); // no more coupling
{% endhighlight %}

## Thread Safety

You can avoid millions of problems in multi-threading by using immutable objects.

## No Side Effects

This is how they may happen:

{% highlight java linenos=table %}
Order order = orders.find(345);
bank.process(order);
order.save();
{% endhighlight %}

While method `process(Order)` is defined in `Bank` class as the following:

{% highlight java linenos=table %}
public class Bank {
  public void process(final Order order) {
    order.discount(0.15);
    // do some other processing
  }
}
{% endhighlight %}

Object `order` will be changed in method `process(Order)`, however these changes
are side effects for the client that doesn't expect it to be changed during
processing.
