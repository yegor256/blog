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

Works like this:

{% highlight java %}
class Temp implements Closeable {
  private final Path p;
  public Temp() {
    this.p = Files.createTempFile("", "");
  }
  @Override
  public void close() {
    Files.delete(this.f);
  }
  public Path path() {
    return this.f;
  }
}
{% endhighlight %}

Now we use it like this:

{% highlight java %}
try (Temp t = new Temp()) {
  Files.write(t.path(), "Hello!".getBytes());
}
{% endhighlight %}

The only problem is that does the temporary file is being created inside
the constructor, which is a
[code smell]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}).
Here is what I'm doing in order to avoid that:

{% highlight java %}
class Temp implements Closeable {
  private final AtomicReference<Path> p =
    new AtomicReference<>;
  @Override
  public void close() {
    Path path = this.p.get();
    if (path != null) {
      Files.delete(path);
    }
  }
  public Path init() {
    if (this.p.get() == null) {
      this.p.set(Files.createTempFile("", ""));
    }
    return this.p.get();
  }
}
{% endhighlight %}

And then:
{% highlight java %}
try (Temp t = new Temp().open()) {
  Files.write(t.path(), "Hello!".getBytes());
}
{% endhighlight %}
