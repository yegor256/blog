---
layout: post
title: "Lazy Loading and Caching via Sticky Cactoos Primitives"
date: 2017-10-17
place: Odessa, Ukraine
tags: java
description: |
  Lazy loading is a popular technique in OOP, which is usually
  done through NULL references; Cactoos offers a better way,
  with the help of a few Java primitives.
keywords:
  - java cache
  - java lazy loading
  - java cache in memory
  - java cactoos
  - cactoos
image: /images/2017/10/reality.jpg
jb_picture:
  caption: Reality (2012) by Matteo Garrone
buffer:
  - "You obviously know what lazy loading is, right? And you no doubt know about caching. To my knowledge, there is no elegant way in Java to implement either of them"
  - "Unfortunately, lazy loading and NULL references always come together in classic examples. However there is a better way to implement it"
---

You obviously know what [lazy loading](https://en.wikipedia.org/wiki/Lazy_loading)
is, right? And you no doubt know about [caching](https://en.wikipedia.org/wiki/Cache_%28computing%29).
To my knowledge, there is no elegant way in Java to implement either of them. Here
is what I found out for myself with the help of Cactoos primitives.

<!--more-->

{% jb_picture_body %}

Let's say we need an object that will encrypt some text. Speaking in
a more object-oriented way, it will encapsulate the text and _become_ its
encrypted form. Here is how we will use it (let's create
[tests first]({% pst 2017/mar/2017-03-24-tdd-that-works %})):

```java
interface Encrypted {
  String asString() throws IOException;
}
Encrypted enc = new EncryptedX("Hello, world!");
System.out.println(enc.asString());
```

Now let's implement it, in a very primitive way, with one
[primary]({% pst 2015/may/2015-05-28-one-primary-constructor %})
constructor. The encryption mechanism
will just add `+1` to each byte in the incoming data, and will assume that
the encryption won't break anything (a very stupid
assumption, but for the sake of this example it will work):

```java
class Encrypted1 implements Encrypted {
  private final String text;
  Encrypted1(String txt) {
    this.text = txt;
  }
  @Override
  public String asString() {
    final byte[] in = this.text.getBytes();
    final byte[] out = new byte[in.length];
    for (int i = 0; i < in.length; ++i) {
      out[i] = (byte) (in[i] + 1);
    }
    return new String(out);
  }
}
```

Looks correct so far? I [tested it](https://github.com/yegor256/blog/tree/master/_samples/2017/10/sticky)
and it works. If the input is `"Hello, world!"`,
the output will be `"Ifmmp-!xpsme\""`.

Next, let's say that we want our class to accept an
[`InputStream`](https://docs.oracle.com/javase/8/docs/api/java/io/InputStream.html)
as well as a
[`String`](https://docs.oracle.com/javase/8/docs/api/java/lang/String.html).
We want to call it like this, for example:

```java
Encrypted enc = new Encrypted2(
  new FileInputStream("/tmp/hello.txt")
);
System.out.println(enc.toString());
```

Here is the most obvious implementation, with two
[primary]({% pst 2015/may/2015-05-28-one-primary-constructor %})
constructors (again, the implementation is primitive, but works):

```java
class Encrypted2 implements Encrypted {
  private final String text;
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
    this.text = new String(baos.toByteArray());
  }
  Encrypted2(String txt) {
    this.text = txt;
  }
  // asString() is exactly the same as in Encrypted1
}
```

Technically it works, but stream reading is right inside the constructor,
which is [bad practice]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}).
[Primary]({% pst 2015/may/2015-05-28-one-primary-constructor %})
constructors must not do anything but attribute assignments, while secondary
ones may only create new objects.

Let's try to refactor and introduce lazy loading:

```java
class Encrypted3 implements Encrypted {
  private String text;
  private final InputStream input;
  Encrypted3(InputStream stream) {
    this.text = null;
    this.input = stream;
  }
  Encrypted3(String txt) {
    this.text = txt;
    this.input = null;
  }
  @Override
  public String asString() throws IOException {
    if (this.text == null) {
      ByteArrayOutputStream baos =
        new ByteArrayOutputStream();
      while (true) {
        int one = input.read();
        if (one < 0) {
          break;
        }
        baos.write(one);
      }
      this.text = new String(baos.toByteArray());
    }
    final byte[] in = this.text.getBytes();
    final byte[] out = new byte[in.length];
    for (int i = 0; i < in.length; ++i) {
      out[i] = (byte) (in[i] + 1);
    }
    return new String(out);
  }
}
```

Works great, but looks ugly. The ugliest part is these two lines of course:

```java
this.text = null;
this.input = null;
```

They make the object
[mutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %})
and they're using [NULL]({% pst 2014/may/2014-05-13-why-null-is-bad %}). It's ugly,
trust me. Unfortunately, lazy loading and NULL references always come together in
[classic examples](https://stackoverflow.com/a/2192271/187141).
However there is a better way to implement it.
Let's refactor our class, this time using
[`Scalar`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/Scalar.html)
from
[Cactoos](http://www.cactoos.org):

```java
class Encrypted4 implements Encrypted {
  private final IoCheckedScalar<String> text;
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
        return new String(baos.toByteArray());
      }
    );
  }
  Encrypted4(String txt) {
    this(() -> txt);
  }
  Encrypted4(Scalar<String> source) {
    this.text = new IoCheckedScalar<>(source);
  }
  @Override
  public String asString() throws IOException {
    final byte[] in = this.text.value().getBytes();
    final byte[] out = new byte[in.length];
    for (int i = 0; i < in.length; ++i) {
      out[i] = (byte) (in[i] + 1);
    }
    return new String(out);
  }
```

Now it looks way better. First of all, there is only one primary constructor and
two secondary ones. Second, the object is
[immutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}).
Third, there is still a lot
of room for
[improvement]({% pst 2014/nov/2014-11-07-how-immutability-helps %}):
we can add more constructors which will accept
other sources of data, for example
[`File`](https://docs.oracle.com/javase/8/docs/api/java/io/File.html) or a byte array.

{% youtube 7WmsiV22IXM %}

In a nutshell, the attribute that is supposed to be loaded in a "lazy" way
is represented inside an object as a "function"
([lambda expression](https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html) in
Java&nbsp;8). Until we touch that attribute, it's not loaded. Once we need
to work with it, the function gets executed and we have the result.

There is one problem with this code though. It will read the input stream
every time we call `asString()`, which will obviously not work, since only
the first time will the stream have the data. On every subsequent call the stream
will simply be empty. Thus, we need to make sure that `this.text.value()`
executes the encapsulated `Scalar` only once. All later calls must return the
previously calculated value. So we need to _cache_ it. Here is how:

```java
class Encrypted5 implements Encrypted {
  private final IoCheckedScalar<String> text;
  // same as above in Encrypted4
  Encrypted5(Scalar<String> source) {
    this.text = new IoCheckedScalar<>(
      new StickyScalar<>(source)
    );
  }
  // same as above in Encrypted4
```

This [`StickyScalar`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/scalar/StickyScalar.html)
will make sure that only the first call to its method `value()`
will go through to the encapsulated `Scalar`. All other calls will receive
the result of the first call.

The last problem to solve is about concurrency. The code we have above is not
thread safe. If I create an instance of `Encrypted5` and pass it to two threads,
which call `asString()` simultaneously, the result will be unpredictable,
simply because
[`StickyScalar`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/scalar/StickyScalar.html)
is not thread-safe. There is another primitive to help us out though, called
[`SyncScalar`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/scalar/SyncScalar.html):

```java
class Encrypted5 implements Encrypted {
  private final IoCheckedScalar<String> text;
  // same as above in Encrypted4
  Encrypted5(Scalar<String> source) {
    this.text = new IoCheckedScalar<>(
      new SyncScalar<>(
        new StickyScalar<>(source)
      )
    );
  }
  // same as above in Encrypted4
```

Now we're safe and the design is elegant. It includes lazy loading and caching.

I'm using this approach in many projects now and it seems convenient,
clear, and object-oriented.
