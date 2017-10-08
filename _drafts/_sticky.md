---
layout: post
title: "Lazy Loading and Caching through Sticky Cactoos Primitives"
date: 2017-10-05
place: Odessa, Ukraine
tags: java
description: |
  Lazy loading is a popular technique in OOP, which usually is
  done through NULL references; Cactoos offers a better way,
  with the help of a few Java primitives.
keywords:
  - java cache
  - java lazy loading
  - java cache in memory
  - java cactoos
  - cactoos
image: /images/2017/02/...
jb_picture:
  caption:
---

You obviously know what [lazy loading](https://en.wikipedia.org/wiki/Lazy_loading)
is, right? And you also know what is [caching](https://en.wikipedia.org/wiki/Cache_%28computing%29).
To my knowledge, there is no elegant way in Java to implement them. Here
is what I found for myself with the help of Cactoos primitives.

<!--more-->

{% jb_picture_body %}

Let's say, we need an object that will encrypt the data. Speaking in
a more object-oriented way, it will encapsulate the data and become its
encrypted form. Here is how we will use it (let's create
[tests first]({% pst 2017/mar/2017-03-24-tdd-that-works %})):

{% highlight java %}
interface Encrypted {
  String asString() throws IOException;
}
Encrypted enc = new EncryptedX("Hello, world!");
System.out.println(enc.asString());
{% endhighlight %}

Now, let's implement it, in a very primitive way, with one
[primary]({% pst 2015/may/2015-05-28-one-primary-constructor %})
constructor. The encryption mechanism
will just add `+1` to each byte in the incoming data:

{% highlight java %}
class Encrypted1 implements Encrypted {
  private final byte[] data;
  Encrypted1(String txt) {
    this.data = txt.getBytes(StandardCharsets.UTF_8);
  }
  @Override
  public String asString() {
    final byte[] out = new byte[this.data.length];
    for (int i = 0; i < this.data.length; ++i) {
      out[i] = (byte) (this.data[i] + 1);
    }
    return new String(out, StandardCharsets.UTF_8);
  }
}
{% endhighlight %}

Looks correct so far? I [tested it]()
and it works. If the input is `"Hello, world!"`,
the output will be `"Ifmmp-!xpsme\""`.

Next, let's say we want our class to accept an `InputStream` aside
from `String`.
We want to call it like this, for example:

{% highlight java %}
Encrypted enc = new Encrypted(
  new FileInputStream("/tmp/hello.txt")
);
System.out.println(enc.toString());
{% endhighlight %}

Here is the most obvious implementation, with two primary constructors:

{% highlight java %}
class Encrypted2 implements Encrypted {
  private final byte[] data;
  Encrypted2(InputStream input) throws IOException {
    ByteArrayOutputStream baos =
      new ByteArrayOutputStream();
    while (true) {
      int one = input.read();
      if (one < 0) {
        break;
      }
      baos.write(one);
    }
    this.data = baos.toByteArray();
  }
  Encrypted2(String txt) {
    this.data = txt.getBytes(StandardCharsets.UTF_8);
  }
  // asString() is exactly the same as in Encrypted1
}
{% endhighlight %}

Technically it works, but stream reading is right inside the constructor,
which is a [bad practice]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}).
[Primary]({% pst 2015/may/2015-05-28-one-primary-constructor %})
constructors must not do anything else but attributes assignments, while secondary
ones may only create new objects.

Let's try to refactor and introduce lazy loading:

{% highlight java %}
class Encrypted3 {
  private byte[] data;
  private final InputStream input;
  Encrypted3(InputStream stream) {
    this.data = null;
    this.input = stream;
  }
  Encrypted3(String txt) {
    this.data = txt.getBytes(StandardCharsets.UTF_8);
    this.input = null;
  }
  @Override
  public String asString() throws IOException {
    if (this.data == null) {
      ByteArrayOutputStream baos =
        new ByteArrayOutputStream();
      while (true) {
        int one = input.read();
        if (one < 0) {
          break;
        }
        baos.write(one);
      }
      this.data = baos.toByteArray();
    }
    final byte[] out = new byte[this.data.length];
    for (int i = 0; i < this.data.length; ++i) {
      out[i] = (byte) (this.data[i] + 1);
    }
    return new String(out, StandardCharsets.UTF_8);
  }
}
{% endhighlight %}

Works great, but looks ugly. The ugliest part is these two lines, of course:

{% highlight java %}
this.data = null;
this.input = null;
{% endhighlight %}

It makes the object
[mutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %})
and it's [NULL]({% pst 2014/may/2014-05-13-why-null-is-bad %}). It's ugly,
trust me. Lazy loading and NULL references always come together in classic
examples, unfortunately. However, there is a better way to implement it.
Let's refactor our class, this time using
[`Scalar`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/Scalar.html)
from
[Cactoos](http://www.cactoos.org):

{% highlight java %}
class Encrypted4 implements Encrypted {
  private final IoCheckedScalar<byte[]> data;
  Encrypted4(InputStream stream) {
    this(
      () -> {
        ByteArrayOutputStream baos =
          new ByteArrayOutputStream();
        while (true) {
          int one = stream.read();
          if (one < 0) {
            break;
          }
          baos.write(one);
        }
        return baos.toByteArray();
      }
    );
  }
  Encrypted4(String txt) {
    this(() -> txt.getBytes(StandardCharsets.UTF_8));
  }
  Encrypted4(Scalar<byte[]> source) {
    this.data = new IoCheckedScalar<>(source);
  }
  @Override
  public String asString() throws IOException {
    final byte[] input = this.data.value();
    final byte[] out = new byte[input.length];
    for (int i = 0; i < input.length; ++i) {
      out[i] = (byte) (input[i] + 1);
    }
    return new String(out, StandardCharsets.UTF_8);
  }
{% endhighlight %}

Now it looks way better. First of all, there is only one primary constructor and
two secondary ones. Second, the object is immutable. Third, there is a lot
of room for improvement: we can add more constructors, which will accept
any other sources of data, for example `java.io.File` or a byte array.

In a nutshell, the attribute that is supposed to be loaded in a "lazy" way
is represented inside an object as a "function" (lambda expression in
Java&nbsp;8). Until we touch that attribute, it's not loaded. Once we need
to work with it, the function gets executed and we have the result.

There is one problem with this code though. It will read the input stream
every time we call `asString()`, which will obviously not work, since only
the first time the stream will have the data. On every next call the stream
will simply be empty. Thus, we need to make sure that `this.data.value()`
executes the encapsulated `Scalar` only once. All consecutive calls must return
previously calculated value. We need to __cache__ them. Here is how:

{% highlight java %}
class Encrypted5 implements Encrypted {
  private final IoCheckedScalar<byte[]> data;
  // same as above in Encrypted4
  Encrypted5(Scalar<byte[]> source) {
    this.data = new IoCheckedScalar<>(
      new StickyScalar<>(source)
    );
  }
  // same as above in Encrypted4
{% endhighlight %}

This [`StickyScalar`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/scalar/StickyScalar.html)
will make sure that only the first call to its method `value()`
will go through to the encapsulated `Scalar`. All other calls will receive
the result of the first call.

The last problem to solve is about concurrency. The code we have above is not
thread safe. If I create an instance of `Encrypted5` and pass it to two threads,
which will call `asString()` simultaneously, the result will be unpredictable,
simply because
[`StickyScalar`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/scalar/StickyScalar.html)
is not thread-safe. There is another primitive to help us, it's called
[`SyncScalar`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/scalar/SyncScalar.html):

{% highlight java %}
class Encrypted5 implements Encrypted {
  private final IoCheckedScalar<byte[]> data;
  // same as above in Encrypted4
  Encrypted5(Scalar<byte[]> source) {
    this.data = new IoCheckedScalar<>(
      new SyncScalar<>(
        new StickyScalar<>(source)
      )
    );
  }
  // same as above in Encrypted4
{% endhighlight %}

Now we're safe and the design is elegant. It includes lazy loading and caching.
