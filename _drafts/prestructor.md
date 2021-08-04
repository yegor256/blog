---
layout: post
title: "Prestructors"
date: 2021-08-03
place: Moscow, Russia
tags: oop java
description: |
  Prestructor is a private static method or a standalone
  class that is used in constructors of other objects
  to pre-process their arguments.
keywords:
  - oop design pattern
  - constructor
  - static method ctor
  - oop
  - oop ctor
image: /images/2021/08/
jb_picture:
  caption:
---

Making constructors pre-process the arguments before 
encapsulating them seems to be 
[bad practice]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}). 
However, very often it's necessary to do exactly that: perform some manipulations
with the objects provided as arguments and only then assign
them to the attributes of the constructed object. For this purpose
I suggest using prestructors, which could be methods or standalone
objects.

<!--more-->

{% jb_picture_body %}

Say, this is your code:

{% highlight java %}
import java.util.List;
import java.util.Collections;
class Books {
  private final List<String> titles;
  Books(List<String> list) {
    this.titles = Collections.unmodifiableList(list);
  }
}
{% endhighlight %}

The only constructor expects a list of titles, which is being
encapsulated as `this.titles` for some future use. It's also protected against
any accidental modifications, through the JDK decorator at
[`unmodifiableList`](https://docs.oracle.com/javase/8/docs/api/java/util/Collections.html#unmodifiableList-java.util.List-).
So far, so good. Now, we want to make our class a bit smarter 
and let it accept not only the `List` but an array of strings:

{% highlight java %}
class Books {
  private List<String> titles;
  Books(List<String> list) {
    this.titles = Collections.unmodifiableList(list);
  }
  Books(String... array) {
    final List<String> list = new ArrayList<>(array.length);
    for (final String title : array) {
      list.add(title);
    }
    this.titles = list;
  }
}
{% endhighlight %}

What's wrong with this code? Those of you who have read my earlier 
[blog posts about OOP](/tag/oop.html) most definitely know the answer. First, 
there are two primary constructors, which is another 
[bad practice]({% pst 2015/may/2015-05-28-one-primary-constructor %}). 
Second, there is code in the second constructor, which is also a 
[bad idea]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}).

Here is how I usually refactor this code, to solve both mentioned problems:

{% highlight java %}
class Books {
  private List<String> titles;
  Books(List<String> list) {
    this.titles = Collections.unmodifiableList(list);
  }
  Books(String... array) {
    this(Books.toList(array));
  }
  private static List<String> toList(String... array) {
    final List<String> list = new ArrayList<>(array.length);
    for (final String title : array) {
      list.add(title);
    }
    return list;
  }
}
{% endhighlight %}

I call this new static method `toList()` a _prestructor_: it is used
only at the moment of object construction and only from the
secondary constructor.

An even better way to design it would be to make a new class `ToList`,
which would do exactly the same, but in a more declarative and lazy way:

{% highlight java %}
class Books {
  private List<String> titles;
  Books(List<String> list) {
    this.titles = Collections.unmodifiableList(list);
  }
  Books(String... array) {
    this(new ToList(array));
  }
}
class ToList<T> implements List<T> {
  private final String[] array;
  ToList(String... items) {
    this.array = items;
  }
  // All required methods of the List interface
}
{% endhighlight %}

[`ListOf`](https://www.javadoc.io/static/org.cactoos/cactoos/0.50/org/cactoos/list/ListOf.html)
from [Cactoos](https://www.cactoos.org) is a perfect example 
of such a prestructor.
