---
layout: post
title: "What is an Object?"
date: 2014-04-29
tags: oop quality
description:
  What is a properly designed class in an object-oriented world? What
  name should it have and what are the typical mistakes made in
  class designs?
keywords:
  - object design
  - what is an object
  - object oriented class
  - good object name
  - good name for an object
  - object name in OOP
  - how to choose a good name for an object
  - good name for a class
  - good class name
  - class name
  - good name of a class
  - good class name
  - name of class in java
  - java class name
---

At the time of writing, [wikipedia](http://en.wikipedia.org/wiki/Object_%28computer_science%29) says that:

> Objects in "object-oriented programming" are essentially
data structures together with their associated processing routines

This is a **wrong** definition, that leads to big misunderstandings.
Most of us really think that objects are data structures with attached
routines, or micro COBOL programs being called "objects" since it's cool.

In my opinion, an object is something that satisfies these four criteria:

 - it is an abstraction of a real-life thing
 - it encapsulates knowledge
 - it never changes its encapsulated knowledge ([why immutable?](https://github.com/yegor256/d29/wiki/Why-immutable%3F))
 - it can do something on request

An employee, a department, an HTTP request, a table in MySQL,
a line in a file, or a file are objects. Because they exist in
real-life even when our software doesn't.

A controller, a parser, a service locator,
a singleton, or a factory are **not** objects
(yes, most of GoF patterns are anti-patterns!).
They don't exist apart from your software in real life.

This is a class in Java that specifies a proper object:

{% highlight java linenos=table %}
public class File {
  private String name;
  public File(String path) {
    this.name = path;
  }
  // methods
}
{% endhighlight %}

An object of class `File` encapsulates knowledge, which
is the name of the file on disc in `this.name`.

The principle is that your object should always encapsulate
something, otherwise it's not an object.

An object must expose some functionality, through non-static methods.
Objects without methods are not objects.
