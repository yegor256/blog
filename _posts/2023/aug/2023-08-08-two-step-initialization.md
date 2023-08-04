---
layout: post
title: "Two-Step Initialization"
date: 2023-08-08
place: Moscow, Russia
tags: oop java
description: |
  ...
keywords:
  - init method
  - two-step construction
  - initialize method
  - two-step construction
  - two-stage construction
image: /images/2023/08/
jb_picture:
  caption: ...
---

In object-oriented programming, an object is immutable if its
state is not changed after 
[initialization](https://en.wikipedia.org/wiki/Initialization_%28programming%29). 
In Java, this means having `final` modifiers at all object's fields. 
Even though it [has been demonstrated]({% pst 2014/nov/2014-11-07-how-immutability-helps %}) 
that immutability [positively]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}) 
contributes to the quality of code, 
we keep using "[setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})", a lot.
However, there is yet another anti-pattern, which, in my opinion,
is even worse than "mutators"---it is the `init()` method that
is called on an object after the object is instantiated and initialized.

<!--more-->

{% jb_picture_body %}

This is how it usually happens (I found it in [Apache Kafka](https://github.com/apache/kafka/blob/e0b7499103df9222140cdbf7047494d92913987e/clients/src/main/java/org/apache/kafka/common/security/oauthbearer/internals/secured/RefreshingHttpsJwks.java)):

```java
class Foo {
  private final List<X> items;
  private boolean isInitialized;
  Foo() {
    items = new LinkedList<>();
    // initialize other fields
  }
  public void init() {
    try {
      // fill up "items" with data
    } finally {
      isInitialized = true;
    }
  }
}
```

It is expected that the object is used this way:

```java
var x = new Foo();
x.init();
```

There could be practical reasons for this _two-stage construction_, which, 
[according to Microsoft](https://learn.microsoft.com/en-us/cpp/mfc/one-stage-and-two-stage-construction-of-objects?view=msvc-170), 
is an "always safer" way to create objects. However, I believe that 
every one of such reasons is an indicator of a bad design and 
a motivation for refactoring.

## Resource Acquisition

Consider this class, which opens a stream in its constructor and then
closes it in the `close()` method:

```java
class Book implements Closeable {
  private InputStream in;
  public Book() throws IOException {
    in = new FileInputStream(new File("a.tex"));
    // a bit later:
    throw new IOException("oops!");
  }
  @Override
  public void close() throws IOException {
    this.in.close();
  }
}
```

There is also a runtime exception that may be raised in the constructor of 
the class. If the class is used this way, the stream will not be
closed and the resource [will be leaked](https://stackoverflow.com/a/29243066/187141):

```java
try (Book b = new Book()) {
  System.out.println("Hello, world!");
}
```

The `close()` will not be called by the 
[try-with-resources](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html) statement, 
because the object won't be constructed and its initialization won't be finished.
However, even though the initialization is not finished, the instance
of the `FileInputStream` will do its work: it will open the file and ... 
will keep it open.

Two-steps initialization might be a solution:

```java
class Book implements Closeable {
  private InputStream in;
  public Book() {
    // nothing
  }
  public void init() throws IOException {
    in = new FileInputStream(new File("a.tex"));
    // a bit later:
    throw new IOException("oops!");
  }
  @Override
  public void close() throws IOException {
    this.in.close();
  }
}
```

Now, the code may be used like this, which indeed is safer, because
the stream will always be closed:

```java
try (Book b = new Book()) {
  b.init(); // IOException raised here
  System.out.println("Hello, world!");
}
```

Even though this may be a good workaround, a better solution would
be to get rid of immutability of the `Book` and remove the `init()` method.
Thus, the initialization of the stream should be done
outside of the `Book` object and then provided to it as an argument
of the constructor (pay attention to the `final` modifier of the `in` field):

```java
class Book implements Closeable {
  private final InputStream in;
  public Book(InputStream in) {
    this.in = in;
  }
  @Override
  public void close() throws IOException {
    this.in.close();
  }
}
```

Then, this is how we can use it:

```java
try (InputStream i = new FileInputStream(new File("a.tex"))) {
  Book b = new Book(i);
}
```

Both the stream and the book will definitely be closed.

## Fragile Base Class

...