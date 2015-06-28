---
layout: post
title: "Catch Me If You... Can't Do Otherwise"
date: 2015-06-14
tags: oop
description:
  Catching an exception must be your last resort;
  a properly designed application would catch
  exceptions only in one place.
keywords:
  - exception catching
  - catch exception
  - when to catch exceptions
  - catch exception java
  - exceptions java
---

I don't know whether it's an anti-pattern or just a common and a very popular
mistake, but I see it everywhere and simply must write about it. I'm talking
about exception catching without re-throwing. I'm talking about something like
this Java code:

{% highlight java %}
try {
  stream.write(data);
} catch (IOException ex) {
  ex.printStackTrace();
}
{% endhighlight %}

<!--more-->

Pay attention, I don't have anything against this code:

{% highlight java %}
try {
  stream.write('X');
} catch (IOException ex) {
  throw new IllegalStateException(ex);
}
{% endhighlight %}

This is called _exception chaining_ and is a perfectly valid construct.

So, what is wrong about catching an exception and logging it? Let's try to
look at a bigger picture first. We're talking about object-oriented
programming &mdash; this means that we're dealing with objects. Here is
how an object (its class, to be exact) would look like:

{% highlight java %}
final class Wire {
  private final OutputStream stream;
  Wire(final OutputStream stm) {
    this.stream = stm;
  }
  public void send(final int data) {
    try {
      this.stream.write(x);
    } catch (IOException ex) {
      ex.printStackTrace();
    }
  }
}
{% endhighlight %}

Here is how I'm using this class:

{% highlight java %}
new Wire(stream).send(1);
{% endhighlight %}

Looks nice, right? I don't need to worry about that `IOException` when I'm
calling `send(1)`. It will be handled inside and, if it occurs, the stacktrace
will be logged... This is a totally wrong way of thinking and it's inherited
from languages without exceptions, like C.

Exceptions were invented in order to simplify our design by moving the entire
error-handling code away from the main logic. Moreover, not just moving it away, but
also concentrating it in one place &mdash; in the `main()` method, the entry
point of the entire app.

The main purpose of an exception is to collect as much information as possible
about the error and bubble it up to the highest level, where the user
is capable of doing something about it. Exception chaining is helping us even
further, allowing to extend that information on its way up. We basically
are putting our bubble (the exception) into a bigger bubble every time we
catch it and rethrow. When it hits the surface, there are many bubbles, staying
one inside another, like a russian doll. The original exception is the
smallest bubble.

When you catch an exception without re-throwing, you basically blows the bubble.
Everything that was inside it, all other bubbles with the information inside
them and the original bubble with the original exception are in your hands.
You don't let me see them. You use them somehow, but I don't know how. You're
doing something behind the scene, hiding potentially important information.

If you're hiding that from me, I won't promise my user that I will be honest
with him and will openly report the problem when it happens. I simply can't
trust your `send()` method any more and my user will not trust me.

But catching exceptions without re-throwing you're basically breaking the
chain of trust between objects.

My suggestion is to catch exceptions as little as possible and every time
you catch them &mdash; re-throw.

Unfortunately, the design of Java is against this principle, in many places.
For example, Java has checked and un-checked exceptions, while, in my opinion
there should be only checked ones (the ones that you must catch or declare
as throwable). Also, Java allows multiple exception types to be declared
as throwable in a single method &mdash; yet another mistake, must be stricly
one type. Also, there is a generic class `Exception` at the top of the hierarchy,
which is also wrong in my opinion. Besides that, some built-in classes don't
allow any checked exceptions to be thrown away, like `Runnable.run()`. There
are many other problems with exceptions Java.

But try to keep this principle in mind and your code will be cleaner &mdash;
`catch` only if you have no other choice.

ps. Here is how the class should look like:

{% highlight java %}
final class Wire {
  private final OutputStream stream;
  Wire(final OutputStream stm) {
    this.stream = stm;
  }
  public void send(final int data)
    throws IOException {
    this.stream.write(x);
  }
}
{% endhighlight %}

