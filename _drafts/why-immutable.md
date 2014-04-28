---
layout: post
title: "Why Objects Have to Be Immutable"
date: 2014-04-29
tags: quality immutability
description:
  The article gives arguments about why classes
  in object-oriented programming have to be immutable,
  i.e. never change their encapsulated state
keywords:
  - object design
  - null pointer
  - why null is bad
  - null is bad
  - best practices null
  - null worst practices
---

Every object should be immutable for the following reasons:

 - to avoid temporal coupling
 - to avoid multi-threading collisions
 - to avoid side effects

## Temporal Coupling

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

## Multi-Threading

You can avoid millions of problems in multi-threading by using immutable objects.

## Side Effects

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
