---
layout: post
title: "Decoratoring Envelopes"
date: 2016-12-30
place: Lviv, Ukraine
tags: java oop
description: |
  Composing a big object is a rather verbose
  process in Java; would be great to have an
  ability to do it shorter.
keywords:
  - decorators
  - constructor in oop
  - primary constructor oop
  - oop constructor
  - object oriented programming
---

<del>Sometimes</del> Very often I need a class that implements an
interface by making an instance of another class. Sounds weird? Let me show
an example. There are many classes of that kind in Takes Framework,
they all are named like `*Wrap`. It's a convenient design concept, which
unfortunately looks rather verbose in Java. Would be great to have something
shorter, for example, in [EO](http://www.eolang.org).

<!--more-->

Take a look at
[`RsHtml`](https://github.com/yegor256/takes/blob/1.1/src/main/java/org/takes/rs/RsHtml.java)
from [Takes Framework](http://www.takes.org). Its design looks
like this (a simplified version with only one primary constructor):

{% highlight java %}
class RsHtml extends RsWrap {
  RsHtml(final String text) {
    super(
      new RsWithType(
        new RsWithStatus(text, 200),
        "text/html"
      )
    );
  }
}
{% endhighlight %}

Now, let's take a look at that
[`RsWrap`](https://github.com/yegor256/takes/blob/1.1/src/main/java/org/takes/rs/RsWrap.java)
it extends:

{% highlight java %}
public class RsWrap implements Response {
  private final Response origin;
  public RsWrap(final Response res) {
    this.origin = res;
  }
  @Override
  public final Iterable<String> head() {
    return this.origin.head();
  }
  @Override
  public final InputStream body() {
    return this.origin.body();
  }
}
{% endhighlight %}

As you see, this "decorator" doesn't do anything except "just decorating".
It encapsulates another `Response` and passes through all method calls.

If it's not clear yet, I'll explain the purpose of `RsHtml`. Let's
say you have a text and you want to create a `Response`:

{% highlight java %}
String text = // you have it already
Response response = new RsWithType(
  new RsWithStatus(text, HttpURLConnection.HTTP_OK),
  "text/html"
);
{% endhighlight %}

Instead of doing this composition of decorators over and over
again in many places you use `RsHtml`:

{% highlight java %}
String text = // you have it already
Response response = new RsHtml(text);
{% endhighlight %}

It is very convenient, but that `RsWrap` is very verbose. Too many
lines, which are not doing anything special, just forwarding all method
calls to the encapsulated `Response`.

How about we introduce a new concept&mdash;"decorators" with a new
keyword `decorates`:

{% highlight java %}
class RsHtml decorates Response {
  RsHtml(final String text) {
    this(
      new RsWithType(
        new RsWithStatus(text, 200),
        "text/html"
      )
    )
  }
}
{% endhighlight %}

Then, in order to create an object, we just call:

{% highlight java %}
Response response = new RsHtml(text);
{% endhighlight %}

We don't have any new methods in that decorators, just constructors.
The only purpose of these guys is to create other objects and encapsulate
them. They are not really full-purpose objects. They only help us
create other objects.

That's why I would call them "decorating envelopes."

This idea may look very similar to the
[Factory](https://en.wikipedia.org/wiki/Factory_%28object-oriented_programming%29) design pattern,
but it doesn't have static methods, which we are trying to avoid
in object-oriented programming.
