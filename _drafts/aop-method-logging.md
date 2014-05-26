---
layout: post
title: "Java Method Logging with AOP and Annotations"
date: 2014-05-25
tags: aop java logging
description:
  ...
keywords:
  - aop java logging
  - log every method java
  - method logging java
  - every method logging java
  - aspect oriented programming java
  - aop annotations
  - aop logging annotations
  - aspectj logging
  - aspectj weaving annotations
---

Sometimes I want to log (through [slf4j](http://www.slf4j.org)
and [log4j](http://logging.apache.org/log4j/2.x/))
every execution of a method, seeing
what arguments it was receiving, what was it returning and how much
time every execution was taking. This is how I'm doing it, with help of
[AspectJ](http://eclipse.org/aspectj/),
[jcabi-aspects](http://aspects.jcabi.com), and
Java 6 annotations:

{% highlight java %}
public class Foo {
  @Loggable
  public int power(int x, int p) {
    return Math.pow(x, p);
  }
}
{% endhighlight %}

This is what I see in log4j output:

{% highlight text %}
[INFO] 12:34:08 com.example.Foo #doSomething(2, 5): 32 in 12μs
[INFO] 12:35:23 com.example.Foo #doSomething(3, 3): 27 in 4μs
{% endhighlight %}

Now, I'll explain how it works.

## Annotation with Runtime Retention

Annotations is a technique introduced in Java 6. It is a meta-programming
instrument that doesn't change the way code works, but gives marks to its certain
elements (methods, classes or variables). Yes, annotations are just markers
attached to our code that can be seen and read.

Some annotations are designed to be seen at compile time only &mdash;
they don't exist in `.class` files after compilation. Others remain
visible after compilation and can be accessed in runtime.

For example,
[`@Override`](http://docs.oracle.com/javase/7/docs/api/java/lang/Override.html)
is of the first type (its retention type is [`SOURCE`](http://docs.oracle.com/javase/7/docs/api/java/lang/annotation/RetentionPolicy.html#SOURCE)),
while
[`@Test`](http://junit.sourceforge.net/javadoc/org/junit/Test.html) from JUnit is
of the second type (retention type is [`RUNTIME`](http://docs.oracle.com/javase/7/docs/api/java/lang/annotation/RetentionPolicy.html#RUNTIME)).

[`@Loggable`](http://aspects.jcabi.com/apidocs-0.15.1/com/jcabi/aspects/Loggable.html)
from [jcabi-aspects](http://aspects.jcabi.com)
is an annotation of the second type. It stays with the bytecode in `.class`
file after compilation.

That's all we have at the first step,
after attaching [`@Loggable`]() annotation
to method `power()` and compiling the class. The sources are compiled but they
don't send anything to slf4j so far. Method `power()` just contains a marker
saying "please, log my execution".

## Aspect Oriented Programming (AOP)

AOP is useful technique that enables adding executable blocks to
the source code without explicit changing of it. In our example,
we don't want to log method execution inside our class. Instead,
we want some other class to intercept every call to method `power()`,
measure its execution time, and send this information to slf4j.

## Aspect Weaving

When files are compiled, we ask AspectJ

## @Around Aspect and Joint Points


