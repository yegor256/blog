---
layout: post
title: "Redundant Variables Are Pure Evil"
date: 2015-08-04
tags: oop java
description:
  Redundant variables are making code dirty and difficult
  to understand, despite their initial good intention to
  make it clener.
keywords:
  - redundant variables
  - too many variables
  - variables in oop
  - variables in java
  - java variables
---

A redundant variable is the one that exists exclusively in order
to **explain** the value. I strongly believe that such a variable is pure
noise. Not just noise, but also evil, with a very negative effect
on code readability. When we introduce a redundant variable, we intend to make our code
cleaner and easier to read. In reality though, we make it more verbose
and difficult to understand. Without exceptions, any variable that is used only
once is redundant and must be replaced with a value.

<!--more-->

Here, variable `fileName` is redundant:

{% highlight java %}
String fileName = "test.txt";
print("Length is " + new File(name).length());
{% endhighlight %}

This code must look differently:

{% highlight java %}
print("Length is " + new File("test.txt").length());
{% endhighlight %}

The example is very primitive, but I'm sure you've seen these
redundant variables many times. We use them to "explain" the code &mdash;
it's not just a string literal `"test.txt"` any more, but a `fileName`.
The code looks easier to understand, right? Not really.

Let's see what is "readability" of code in the first place. I think this
quality can be measured by the amount of seconds I need to understand the
code I'm looking at. The longer this time frame, the lower the readability.
Ideally, I want to understand any piece of code in a **few seconds**. If I can't,
this is a failure of its **author**.

Remember, if I don't understand you, it's your fault.

An increasing length of code degrades readability. So the amount of variables I have
to keep in mind while reading it. The more names I have to remember,
the longer it takes to digest the code and come to a conclusion about
its purpose and effects. I think, **four** is the maximum amount
of variables I can comfortably hold in my head, without thinking
about quitting the job.

New variables make code longer, because they need extra lines to
be declared. And they make code more complex, because its reader
have to remember more names.

Thus, when you want to introduce a new variable to explain what your piece of code is
doing &mdash; stop and think. Your code is too complex and long in the first place!
Refactor it, using new objects or methods, but not variables. Make your
code shorter by moving pieces of it into new classes or just private methods.

Moreover, I think that in perfectly designed methods you won't
need **any** variables, aside from method arguments.
