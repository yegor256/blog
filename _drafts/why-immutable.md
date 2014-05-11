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

Moverover, I think that *all* classes should be immutable in an ideal
object-oriented world. Unfortunately, sometimes, it is technically not
possible due to limitations of, say, JVM. However, we should aim for the
best :) Maybe in the future there will be an OO language without mutable
objects at all.

Anyway, let me show the arguments in favor of immutability.

## Avoiding Temporal Coupling

Here is an example of temporal coupling:

{% highlight java linenos=table %}
Weight weight = new Weight(45);
// this line and the next one are coupled
weight.add(5);
weight.multiply(2);
System.out.println("Weight is: " + weight); // 100
{% endhighlight %}

The code works as it is. However, everybody has to remember that
the third and the forth lines should stay in this specific order. In this
primitive example this may be not a big problem, but in more complex
scenarios some additional lines may easily get in between.

This is the right design:

{% highlight java %}
Weight weight = new Weight(45).add(5).multiply(2);
System.out.println("Weight is: " + weight); // 100
{% endhighlight %}

## Thread Safety

You can avoid millions of problems in multi-thread execution
by using immutable objects.

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
