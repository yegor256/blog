---
layout: post
title: "Class Casting is a Discriminating Anti-Pattern"
date: 2015-03-20
tags: oop
description:
  Type casting and instanceof operator in particular is a
  terrible anti-pattern that diminishes the entire idea
  of object-oriented programming.
keywords:
  - class casting
  - class casting in java
  - instanceof
  - type casting in java
  - class casting is evil
---

Type casting is a very useful technique when there is no time
or desire to think and design objects properly. Type casting (or
class casting) helps us to work with provided objects differently,
based on the class they belong to or the interface they implement. Class
casting helps us to **discriminate** that poor objects and **segregate**
them by their race, gender and religion. Can this be a good practice?

<!--more-->

This is a very typical example of type casting (Google Guava is full
of that, for example `Iterables.size()`):

{% highlight java %}
public final class Foo {
  public int sizeOf(Iterable items) {
    int size = 0;
    if (items instanceof Collection) {
      size = Collection.class.cast(items).size();
    } else {
      for (Object item : items) {
        ++size;
      }
    }
    return size;
  }
}
{% endhighlight %}

This method `sizeOf()` is calculating the size of an iterable. However, it
is smart enough to understand that if `items` is also an instance of `Collection`,
there is no need to actually iterate them. It would be much faster to
cast it to `Collection` and then call method `size()` on it. Looks logical.
What's wrong about this approach? I see two practical problems.

First, there is a **hidden coupling** between `sizeOf()` and `Collection`. This
coupling is not visible to the clients of `sizeOf()`. They don't know that
method `sizeOf()` relies on interface `Collection`. If tomorrow we decide
to change it, `sizeOf()` won't work. And we'll be very surprised, since
its signature says nothing about this dependency. This won't happen with
`Collection`, obviously, since it is part of Java SDK, but with custom
classes this may and will happen.

The second problem is an inevitably **growing complexity** of method `sizeOf()`. The
more special types it has to treat differently, the more complex it will become.
This if/then forking is inevitable, since it has to check all possible
types and give them special treatments. This complexity is a result
of a violation of single responsibility principle. The method is not
only calculating the size of `Iterable`, but is also doing type
casting and forking, based on casting.

What is the alternative? There are a few, but the most obvious
is method overloading (not available is semi-OOP languages, like Ruby or PHP):

{% highlight java %}
public final class Foo {
  public int sizeOf(Iterable items) {
    int size = 0;
    for (Object item : items) {
      ++size;
    }
    return size;
  }
  public int sizeOf(Collection items) {
    return items.size();
  }
}
{% endhighlight %}

Isn't it more elegant?

Phylosophically speaking, type casting is a discrimination towards the object
that comes into the method. The object complies to the contract, announced in the
method signature. It does implement `Iterable` interface, which
[is a contract]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}).
It expects an equal treatment with all other objects that come into
the same method. But the method discriminates objects by their types.
The method is basically asking the object about its... race. Black
objects go right while white objects go left. That's what this `instanceof`
is doing. This is what discrimination is about.

By using `instanceof` the method is segregating incoming objects by their
belonging to a certain group. In this case, there are two groups &mdash; collections
and everybody else. If you are a collection, you get a special treatment.
Even though you abide the `Iterable` contract, we still treat some objects
specially. Because they belong to an "elite" group, called `Collection`.

You may say that `Collection` is just another contract that an object may
comply to. That's true, but in this case there should be another door where
those who work by that contract should enter. You announced that
`sizeOf()` accepts everybody who works by `Iterable` contract. I am an object
and I do what the contract says. I come into the method and I expect
an equal treatment with everybody else who come into the same method.
But, apparently, inside the method, I realize that some objects have
some privileges. Isn't it a discrimination?

To conclude, I would consider `instanceof` and class casting
an anti-pattern and a code smell. Once you see a necessity to use them,
start thinking about refactoring.
