---
layout: post
title: "Don't Use Java Assertions, Only Exceptions"
date: 2016-06-20
place: Los Angeles, CA
tags: java
description: |
  ...
keywords:
  - ...
  - ...
  - ...
  - ...
  - ...
---

There are basically two ways to validate the situation in Java and complain
when something is happening that is not expected. It's either an exception
or an assertion. Technically they are almost the same, but there are some
small differences. I believe that exceptions are the right way to go
in all situations and assertions should not be used ever. Here is why.

<!--more-->

Let's see what happens when an assertion is triggered. Let's say, this
is our code:

{% highlight java %}
public class Main {
  public static void main(String... args) {
    assert true == false : "there is a problem";
    System.out.println("hello, world!");
  }
}
{% endhighlight %}

Save this code to `Main.java` and compile:

{% highlight bash %}
$ javac Main.java
{% endhighlight %}

Then, run it:

{% highlight bash %}
$ java Main
hello, world!
{% endhighlight %}

The assertion wasn't triggered. It was ignored. Now, run it with
`-enableassertions` flag:

{% highlight bash %}
$ java -enableassertions Main
Exception in thread "main" java.lang.AssertionError: there is a problem
  at Main.main(Main.java:3)
{% endhighlight %}

This is the first difference between exceptions and assertions. Exceptions
will always be thrown, while assertions are not enabled by default. They are
supposed to be turned on during testing and turned off in production.
The assertion caused a runtime exception `AssertionError`. But, hold on, it's
not a `RuntimeException`. It extends `Error` class, which extends `Throwable`.
This is the second difference. I don't know any other differences.

I would recommend **not** to use assertions ever. Simply because I strongly
believe in [Fail Fast]({% pst 2015/aug/2015-08-25-fail-fast %})
approach. I think that bugs must be visible not only
during testing but also in production. Moreover, I believe that making
bugs visible in production is very important if you want to achieve high
quality.

Thus, no assertions. They are simply a wrong and outdated feature in Java
(and some other languages).

