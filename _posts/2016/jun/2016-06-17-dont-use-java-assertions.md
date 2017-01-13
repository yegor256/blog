---
layout: post
title: "Don't Use Java Assertions"
date: 2016-06-17
place: Los Angeles, CA
tags: java
category: jcg
description: |
  Assertions are an outdated and flawed feature in Java
  (and some other languages) that I would not recommend you use.
keywords:
  - assertions or exceptions
  - assertion or exception
  - exceptions over assertions
  - throw exception not assertion
  - assertions java
jb_picture:
  src: /images/2016/06/natural-born-killers.jpg
  caption: Natural Born Killers (1994) by Oliver Stone
---

There are basically two ways to validate a situation in Java and complain
when something unexpected happens. It's either an exception
or an assertion. Technically, they are almost the same, but there are some
small differences. I believe that exceptions are the right way to go
in all situations and assertions should never be used. Here's why.

<!--more-->

{% jb_picture_body %}

Let's see what happens when an assertion is triggered. Say that this
is our code:

{% highlight java %}
public class Main {
  public static void main(String... args) {
    assert true == false : "There is a problem";
    System.out.println("Hello, world!");
  }
}
{% endhighlight %}

Save this code to `Main.java` and compile:

{% highlight bash %}
$ javac Main.java
{% endhighlight %}

Then run it:

{% highlight bash %}
$ java Main
Hello, world!
{% endhighlight %}

The assertion wasn't triggered. It was ignored. Now run it with an
`-enableassertions` flag:

{% highlight bash %}
$ java -enableassertions Main
Exception in thread "main" java.lang.AssertionError: There is a problem
  at Main.main(Main.java:3)
{% endhighlight %}

This is the first difference between exceptions and assertions. Exceptions
will always be thrown, while assertions are not enabled by default. They are
supposed to be turned on during testing and turned off in production.
The assertion caused the runtime exception
[`AssertionError`](https://docs.oracle.com/javase/7/docs/api/java/lang/AssertionError.html). But hold on; it's
not a [`RuntimeException`](https://docs.oracle.com/javase/7/docs/api/java/lang/RuntimeException.html). It extends
[`Error`](https://docs.oracle.com/javase/7/docs/api/java/lang/Error.html) class,
which extends [`Throwable`](https://docs.oracle.com/javase/7/docs/api/java/lang/Throwable.html).
This is the second difference. I don't know of any other differences.

I would recommend **not** to use assertions ... ever. Simply because I strongly
believe in the [Fail Fast]({% pst 2015/aug/2015-08-25-fail-fast %})
approach. I think bugs must be visible not only
during testing but also in production. Moreover, I believe making
bugs visible in production is very important if you want to achieve a high-quality product.

Thus, no assertions. They are simply a flawed and outdated feature in Java
(and some other languages).
