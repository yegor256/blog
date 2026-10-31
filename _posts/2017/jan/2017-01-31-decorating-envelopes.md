---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Decorating Envelopes"
date: 2017-01-31
place: Lviv, Ukraine
tags: java oop
description: |
  Composing a large object is a rather verbose
  process in Java; it would be great to have the
  ability to do it more succinctly.
keywords:
  - decorators
  - constructor in oop
  - primary constructor oop
  - oop constructor
  - object oriented programming
image: /images/2017/01/north-by-northwest.jpg
jb_picture:
  caption: North by Northwest (1959) by Alfred Hitchcock
---

~~Sometimes~~ Very often I need a
[class]({% pst 2016/sep/2016-09-20-oop-without-classes %}) that implements an
interface by making an instance of another class. Sound weird? Let me show
you an example. There are many classes of that kind in the
[Takes Framework](https://www.takes.org),
and they all are named like `*Wrap`. It's a convenient design concept that,
unfortunately, looks rather verbose in Java. It would be great to have something
shorter, like in [EO](https://www.eolang.org) for example.

<!--more-->

{% jb_picture_body %}

Take a look at
[`RsHtml`](https://github.com/yegor256/takes/blob/1.1/src/main/java/org/takes/rs/RsHtml.java)
from [Takes Framework](https://www.takes.org). Its design looks
like this (a simplified version with only one primary constructor):

```java
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
```

Now, let's take a look at that
[`RsWrap`](https://github.com/yegor256/takes/blob/1.1/src/main/java/org/takes/rs/RsWrap.java)
it extends:

```java
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
```

As you see, this "decorator" doesn't do anything except "just decorating."
It encapsulates another `Response` and passes through all method calls.

If it's not clear yet, I'll explain the purpose of `RsHtml`. Let's
say you have text and you want to create a `Response`:

```java
String text = // you have it already
Response response = new RsWithType(
  new RsWithStatus(text, HttpURLConnection.HTTP_OK),
  "text/html"
);
```

Instead of doing this
[composition of decorators]({% pst 2015/feb/2015-02-26-composable-decorators %})
over and over again in many places, you use `RsHtml`:

```java
String text = // you have it already
Response response = new RsHtml(text);
```

It is very convenient, but that `RsWrap` is very verbose. There are too many
lines that don't do anything special; they just forward all method
calls to the encapsulated `Response`.

How about we introduce a new concept, "decorators," with a new
keyword, `decorates`:

```java
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
```

Then, in order to create an object, we just call:

```java
Response response = new RsHtml(text);
```

{% youtube Wcy53ZSF78o %}

We don't have any new methods in the decorators, just constructors.
The only purpose for these guys is to create other objects and encapsulate
them. They are not really full-purpose objects. They only help us
create other objects.

That's why I would call them "decorating envelopes."

This idea may look very similar to the
[Factory](https://en.wikipedia.org/wiki/Factory_%28object-oriented_programming%29) design pattern,
but it doesn't have
[static methods]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}),
which we are trying to avoid in
[object-oriented programming]({% pst 2016/aug/2016-08-15-what-is-wrong-object-oriented-programming %}).
