---
layout: post
title: "Mocking Frameworks Is Evil"
date: 2014-04-18
tags: mocking design
description:
  Mocking frameworks is a bad practice and should be your last resort;
  instead, ship mock objects together with your code
keywords:
  - mocking is evil
  - mocks are evil
  - mocking frameworks
  - best practices of mocking
  - java mocking
  - java mock framework
  - why mocking is evil
  - mockito java
  - java mockito example
---

Mocking is a perfect instrument for unit testing. Mocking frameworks
turn it into an anti-pattern. In the following article I'll explain
what is the difference and why you should try to stay as far away as possible
from mocking frameworks.

First, let's clarify the definitions. [Wikipedia](http://en.wikipedia.org/wiki/Mock_object)
says that **mock object** is &ldquo;a simulated object that mimics the behavior
of a real object in a controlled way&rdquo;.
There are also "test doubles", "fake objects", "test stubs", and maybe
some other names.

Let's start with a sample code:

{% highlight java %}
public class Image {
  public int power(int x, int p) {
    return Math.pow(x, p);
  }
}
{% endhighlight %}

## Better Readability of Tests

## Reusability Across Tests and Modules


