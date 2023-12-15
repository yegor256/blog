---
layout: post
title: "Object-Oriented Declarative Input/Output in Cactoos"
date: 2017-06-22
place: Dnipro, Ukraine
tags: java oop pets
description: |
  Instead of calling static procedures we may want
  to use objects, the way they are supposed to be used;
  that's why Cactoos.
keywords:
  - IO java
  - read/write java
  - object-oriented input/output
  - cactoos
  - input/output cactoos
---

{% badge /images/books/elegant-objects/cactus.svg 92 https://www.cactoos.org %}

[Cactoos](https://www.cactoos.org) is a library of object-oriented
Java primitives
[we](https://github.com/yegor256/cactoos#contributors)
started to work on just a few weeks ago. The intent was to
propose a clean and more declarative alternative to
[JDK](https://en.wikipedia.org/wiki/Java_Development_Kit),
[Guava](https://github.com/google/guava),
[Apache Commons](https://commons.apache.org/),
and others. Instead of calling static
[procedures]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %})
we want to use [objects]({% pst 2016/jul/2016-07-14-who-is-object %}),
the way they are supposed to be used. Let's see how input/output works in a _pure_
[object-oriented]({% pst 2016/aug/2016-08-15-what-is-wrong-object-oriented-programming %})
fashion.

<!--more-->

{% jb_picture_body %}

**Disclaimer**: The version I'm using at the time of writing is
[0.9](https://github.com/yegor256/cactoos/releases/tag/0.9). Later versions
may have different names of classes and a totally different design.

Let's say you want to read a file. This is how you would do it with the static method
[`readAllBytes()`](https://docs.oracle.com/javase/7/docs/api/java/nio/file/Files.html#readAllBytes%28java.nio.file.Path%29) from the
[utility class]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %})
[`Files`](https://docs.oracle.com/javase/7/docs/api/java/nio/file/Files.html)
in JDK7:

```java
byte[] content = Files.readAllBytes(
  new File("/tmp/photo.jpg").toPath()
);
```

This code is very imperative---it reads the file content right here and now,
placing it into the array.

This is how you do it with [Cactoos](https://github.com/yegor256/cactoos):

```java
Bytes source = new InputAsBytes(
  new FileAsInput(
    new File("/tmp/photo.jpg")
  )
);
```

Pay attention---there are no method calls yet. Just three constructors
of three classes that compose a bigger object. The object `source` is of type
[`Bytes`](http://static.javadoc.io/org.cactoos/cactoos/0.9/org/cactoos/Bytes.html)
and represents the content of the file. To get that content
out of it we call its method `asBytes()`:

```java
bytes[] content = source.asBytes();
```

This is the moment when the file system is touched. This approach, as you
can see, is absolutely declarative and thanks to that possesses all the
benefits of object orientation.

Here is another example. Say you want to write some text into a file. Here
is how you do it in Cactoos. First you need the
[`Input`](http://static.javadoc.io/org.cactoos/cactoos/0.9/org/cactoos/Input.html):

```java
Input input = new BytesAsInput(
  new TextAsBytes(
    new StringAsText(
      "Hello, world!"
    )
  )
);
```

Then you need the [`Output`](http://static.javadoc.io/org.cactoos/cactoos/0.9/org/cactoos/Output.html):

```java
Output output = new FileAsOutput(
  new File("/tmp/hello.txt")
);
```

Now, we want to copy the input to the output. There is no "copy" operation
in _pure_ OOP. Moreover, there must be no operations at all. Just objects. We
have a class named
[`TeeInput`](http://static.javadoc.io/org.cactoos/cactoos/0.9/org/cactoos/io/TeeInput.html),
which is an `Input` that copies everything
you read from it to the
[`Output`](http://static.javadoc.io/org.cactoos/cactoos/0.9/org/cactoos/Output.html),
similar to what
[`TeeInputStream`](https://commons.apache.org/proper/commons-io/javadocs/api-1.4/org/apache/commons/io/input/TeeInputStream.html)
from [Apache Commons](https://commons.apache.org/) does, but encapsulated. So we don't copy, we create an
[`Input`](http://static.javadoc.io/org.cactoos/cactoos/0.9/org/cactoos/Input.html)
that will copy if you _touch_ it:

```java
Input tee = new TeeInput(input, output);
```

Now, we have to "touch" it. And we have to touch every single byte of it,
in order to make sure they all are copied. If we just `read()` the first
byte, only one byte will be copied to the file. The best way to touch them
all is to calculate the size of the `tee` object, going byte by byte. We
have an object for it, called
[`LengthOfInput`](http://static.javadoc.io/org.cactoos/cactoos/0.9/org/cactoos/io/LengthOfInput.html).
It encapsulates an
[`Input`](http://static.javadoc.io/org.cactoos/cactoos/0.9/org/cactoos/Input.html)
and behaves like its length in bytes:

```java
Scalar<Long> length = new LengthOfInput(tee);
```

Then we take the value out of it and the file writing operation takes place:

```java
long len = length.value();
```

Thus, the entire operation of writing the string to the file will
look like this:

```java
new LengthOfInput(
  new TeeInput(
    new BytesAsInput(
      new TextAsBytes(
        new StringAsText(
          "Hello, world!"
        )
      )
    ),
    new FileAsOutput(
      new File("/tmp/hello.txt")
    )
  )
).value(); // happens here
```

This is its procedural alternative from
[JDK7](https://docs.oracle.com/javase/7/docs/api/java/nio/file/Files.html#write%28java.nio.file.Path,%20byte[],%20java.nio.file.OpenOption...%29):

```java
Files.write(
  new File("/tmp/hello.txt").toPath(),
  "Hello, world!".getBytes()
);
```

"Why is object-oriented better, even though it's longer?" I hear you ask.
Because it perfectly **decouples** concepts, while the procedural one keeps
them together.

Let's say, you are designing a class that is supposed
to encrypt some text and save it to a file. Here is how you would
design it the procedural way (not a real encryption, of course):

```java
class Encoder {
  private final File target;
  Encoder(final File file) {
    this.target = file;
  }
  void encode(String text) {
    Files.write(
      this.target,
      text.replaceAll("[a-z]", "*")
    );
  }
}
```

Works fine, but what will happen when you decide to extend it to also write to
an [`OutputStream`](https://docs.oracle.com/javase/7/docs/api/java/io/OutputStream.html)?
How will you modify this class? How ugly will it look after that?
That's because the design is not object-oriented.

This is how you would do the same design, in an object-oriented way,
with [Cactoos](https://www.cactoos.org):

```java
class Encoder {
  private final Output target;
  Encoder(final File file) {
    this(new FileAsOutput(file));
  }
  Encoder(final Output output) {
    this.target = output;
  }
  void encode(String text) {
    new LengthOfInput(
      new TeeInput(
        new BytesAsInput(
          new TextAsBytes(
            new StringAsText(
              text.replaceAll("[a-z]", "*")
            )
          )
        ),
        this.target
      )
    ).value();
  }
}
```

What do we do with this design if we want
[`OutputStream`](https://docs.oracle.com/javase/7/docs/api/java/io/OutputStream.html)
to be accepted? We just add one
[secondary]({% pst 2015/may/2015-05-28-one-primary-constructor %}) constructor:

```java
class Encoder {
  Encoder(final OutputStream stream) {
    this(new OutputStreamAsOutput(stream));
  }
}
```

Done. That's how easy and elegant it is.

That's because concepts are perfectly separated and functionality
is encapsulated. In the procedural example the behavior of the object is
located outside of it, in the method `encode()`. The file itself doesn't know
how to write, some outside procedure
[`Files.write()`](https://docs.oracle.com/javase/7/docs/api/java/nio/file/Files.html#write%28java.nio.file.Path,%20byte[],%20java.nio.file.OpenOption...%29)
knows that instead.

To the contrary, in the object-oriented design the
[`FileAsOutput`](http://static.javadoc.io/org.cactoos/cactoos/0.9/org/cactoos/io/FileAsOutput.html)
knows how to write, and nobody else does.
The file writing functionality is encapsulated and this makes it
possible to decorate the objects in any possible way, creating
reusable and replaceable composite objects.

Do you see the beauty of OOP now?
