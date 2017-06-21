---
layout: post
title: "RAII"
date: 2017-05-02
place: Riga, Latvia
tags: oop
description: |
  ...
keywords:
  - RAII
  - resource acquisition is initialization
  - RAII in OOP
  - RAII in Java
  - RAII in C++
image: /images/2015/03/?
jb_picture:
  caption: xxx
---

Resource Acquisition Is Initialization (RAII) is a design
idea introduced in C++.

<!--more-->

{% jb_picture_body %}

Here is how we can implement it in Java for a "resource," which
is a temporary file, using [Cactoos](http://www.cactoos.org):

{% highlight java %}
class Temp implements Closeable {
  private final Scalar<Path> pth = new StickyScalar<>(
    () -> Files.createTempFile("", "")
  );
  @Override
  public void close() {
    Files.delete(this.path());
  }
  public Path path() {
    return this.pth.asValue();
  }
}
{% endhighlight %}

Now we use it like this:

{% highlight java %}
try (Temp temp = new Temp()) {
  Files.write(t.path(), "Hello!".getBytes());
}
{% endhighlight %}

That's it.
