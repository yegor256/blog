---
layout: post
title: "Reflection"
date: 2021-12-14
place: Moscow, Russia
tags: oop
description: |
  Reflection in object-oriented programming languages is 
  a powerful technique, but a very dangerous and harmful one.
keywords:
  - reflection
  - oop reflection
  - reflection is bad
  - what is reflection
  - why reflection
image: /images/2021/12/
jb_picture:
  caption:
---

[Reflective programming](https://en.wikipedia.org/wiki/Reflective_programming) (or reflection) is 
when your code changes itself on-fly. For example, a method of a class, when we call it,
among other things, adds a new method to the class 
(also known as [monkey patching](https://en.wikipedia.org/wiki/Monkey_patch)). 
Java, Python, PHP, JavaScript, you name it---they
all have this "powerful" feature. What's 
[wrong](https://softwareengineering.stackexchange.com/questions/193526) with it? 
Well, it's 
[slow](https://mattwarren.org/2016/12/14/Why-is-Reflection-slow/), 
[dangerous](https://owasp.org/www-community/vulnerabilities/Unsafe_use_of_Reflection),
hard to read and debug.
But all that is nothing comparing with the _coupling_ it introduces to the code.

<!--more-->

{% jb_picture_body %}

There are many situations when reflection can "help" you.
Let's go through all of them and see why the coupling they add to the code is
unnecessary and harmful.

## Type Checking and Casting

Here is the code (I took it from 
[this article]({% pst 2015/apr/2015-04-02-class-casting-is-anti-pattern %}) 
about casting):

{% highlight java %}
public int sizeOf(Iterable items) {
  int size = 0;
  if (items instanceof Collection) {
    size = ((Collection) items).size();
  } else {
    for (Object item : items) {
      ++size;
    }
  }
  return size;
}
{% endhighlight %}

I'm not sure everybody would agree that this is reflection, but I believe
it is: we check the structure of the class in runtime and then make 
a call to the method `size()` which doesn't exist in the `items`. It only
shows up when we, again in runtime, make a shortcut to it in the bytecode.

Why this is bad, aside from the fact that it's slow, more verbose
(that's why less readable), and introduces a new point of failure: the 
object `items` may not be 













