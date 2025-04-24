---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Is Two-Step Initialization a Solution or a Symptom?"
date: 2023-08-08
place: Moscow, Russia
tags: oop java
description: |
  Sometimes you might be tempted to use a two-stage construction
  for your object. However, I suggest reevaluating your design
  principles if you feel such an inclination.
keywords:
  - init method
  - two-step construction
  - initialize method
  - two-step construction
  - two-stage construction
image: /images/2023/08/nirvana.jpg
jb_picture:
  caption: Нирвана (2008) by Igor Voloshin
---

At times, it might appear practical to execute additional initialization steps
for an object after its constructor has completed. However, I'm of the belief that
such requirements signal underlying design flaws, such as object mutability,
base class fragility, violation of layering, and unfocused abstraction.
A constructor should be good enough for all scenarios. If it's not, refactor the object.

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

There might be practical justifications for this _two-stage construction_,
which, [as per Microsoft](https://learn.microsoft.com/en-us/cpp/mfc/one-stage-and-two-stage-construction-of-objects?view=msvc-170),
is touted as an "always safer" approach to object creation. Yet, I'm convinced
that each of these reasons signifies a flawed design and should
serve as a catalyst for refactoring.

## Resource Leakage

Consider an [auto-closeable](https://docs.oracle.com/javase/8/docs/api/java/lang/AutoCloseable.html) Java class
that opens a stream in its constructor and then
reasonably expects it to be closed in the `close()` method:

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

However, if the runtime exception is raised in the constructor, the stream will not be
closed and the resource [will be leaked](https://stackoverflow.com/a/29243066/187141):

```java
try (Book b = new Book()) {
  System.out.println("Hello, world!");
}
```

The `close()` will not be called by the
[try-with-resources](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html) statement,
as the object will not be fully constructed and its initialization won't be completed.
However, even if the initialization isn't finalized, the instance
of `FileInputStream` will do part of its work: it will open the file.
It will never close it though.

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

Now, the code can be used in the following manner, which is indeed safer
because the stream will always be closed:

```java
try (Book b = new Book()) {
  b.init(); // IOException raised here
  System.out.println("Hello, world!");
}
```

Even though this may be a good workaround, it is only a cover for
the design flaw: mutability of the attribute. A better solution would
be to get rid of [mutability]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %})
of the `Book` and remove the `init()` method.

Thus, the [initialization](https://en.wikipedia.org/wiki/Initialization_%28programming%29) of the stream should be done
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

Now, both the stream and the book will definitely be closed.

The root cause of the issue here stems from the [mutability]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %})
of the `in` attribute,
which creates potential for resource leakage. If we were to agree upfront that
every object must be immutable, this problem wouldn't arise in the first place.
We wouldn't need a workaround like two-step initialization, because we wouldn't
encounter a class where an attribute might remain
[uninitialized]({% pst 2014/may/2014-05-13-why-null-is-bad %}). It seems that
this example serves as [yet another]({% pst 2014/nov/2014-11-07-how-immutability-helps %})
testament to the benefits of object immutability.

## Fragile Base Class

Consider this parent class, with an immutable attribute `title`:

```java
class Product {
  private final String title;
  Product(String t) {
    this.title = t;
    this.print();
  }
  void print() {
    System.out.printf("Title: %s\n", this.title);
  }
}
```

Now, let's extend it (again, the `author` attribute is immutable):

```java
class Book extends Product {
  private final String author;
  Book(String t, String a) {
    super(t);
    this.author = a;
  }
  @Override void print() {
    super.print();
    System.out.printf("Author: %s\n", this.author);
  }
}
```

What do you think will be printed after we do the following?

```java
new Book("Object Thinking", "David West");
```

This is what:

```java
Title: Object Thinking
Author: null
```

Why does the `author` print as `null` when we provided the `"David West"`
string in the constructor? The reason is that `super()`, the constructor
of the parent class, was invoked before `this.author` was initialized.
The constructor of the `Product` class called its own
[virtual](https://en.wikipedia.org/wiki/Virtual_function) method `print()`,
which the derived class `Book` had overridden. This issue can be more
generically referred to as the "[fragile base class](https://en.wikipedia.org/wiki/Fragile_base_class)"
problem: the base class calls its own method, expecting it to operate as defined,
but this method is unexpectedly replaced by a different implementation in the derived class,
leading to unintended and incorrect behavior. Such potential for method
replacement is what renders the base class fragile.

Using two-phase construction could address this issue by keeping
attribute initialization in the constructor while relocating the
"printing" functionality to a new `init()` method.
However, this approach merely masks the underlying design flaw:
the class's inherent fragility.

A more comprehensive solution is twofold. Firstly, maintain constructors code-free, as
[suggested earlier]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}).
Secondly, opt for [composition over inheritance](https://en.wikipedia.org/wiki/Composition_over_inheritance),
as has also been [previously recommended]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %})."
This is how:

```java
final class Product {
  private final String title;
  Product(String t) {
    this.title = t;
  }
  void print() {
    System.out.printf("Title: %s\n", this.title);
  }
}
final class Book {
  private final Product product;
  private final String author;
  Book(String t, String a) {
    this.product = new Product(t);
    this.author = a;
  }
  void print() {
    this.product.print();
    System.out.printf("Author: %s\n", this.author);
  }
}
```

Now, both classes are marked as `final`, making it technically impossible
to override any of their methods. Instead of extending `Product`, the `Book`
class encapsulates an instance of it. The `print()` method in the `Book`
class oversees the printing functionality, delegating part of this responsibility to
`product.print()`. Such a design becomes the only viable option if we mutually
agree from the outset that all constructors should remain
[code-free]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}) and that
implementation inheritance is [off-limits]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %}).

## Defaults and Configs

If you've coded in Java for a sufficient amount of time,
you'll undoubtedly find this design approach quite familiar:

```java
class Database {
  private String host;
  private int port;
  private String login;
  private String password;
  Database() {
    this.host = "localhost";
    this.port = 5432;
    this.login = "pgsql";
    this.password = "";
  }
  void init(Config cfg) {
    this.host = cfg.getHost();
    this.port = cfg.getPort();
    this.login = cfg.getLogin();
    this.password = cfg.getPassword();
  }
}
```

Here, the constructor assigns default values to four object attributes, while the
`init()` method subsequently updates them based on the values from the "configuration"
[DTO]({% pst 2016/jul/2016-07-06-data-transfer-object %}).
This method of object initialization may seem more appealing than a series of
[setter]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})
calls, as it ensures all necessary attributes are assigned simultaneously,
with none overlooked. Such assurance isn't guaranteed with isolated
[setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}).
Furthermore, the DTO can be auto-populated from an XML or JSON file, which, when
passed to the `init()` method, further streamlines the code:

```java
var db = new Database(); // first initialization step
var cfg = loadFromXML("db-config.xml");
db.init(cfg); // second initialization step
```

However, this merely masks the underlying design flaw: the class is too expansive.
It's not about the lines of code, but rather the multitude of external elements
it tries to abstract: the Internet address, the TCP port, the login string, the password,
and likely more in the future. While the `Config` DTO currently suffices
due to its modest size, it seems to pave the way for future expansion,
tempting programmers to augment it as they see fit. As the size of `Config` increases,
so will the number of attributes in `Database`. It's probable that they will
soon fall out of sync. Over time, it may become challenging to discern
if constructing the `Database` object readies it for operation, or if a preliminary
`init()` call is required. Further, will just invoking `init()` be sufficient to utilize the object fully?

If we had initially agreed that our objects should not encapsulate more than
three attributes, as [suggested earlier]({% pst 2014/dec/2014-12-15-how-much-your-objects-encapsulate %}),
we would have refactored this class. The `init()` method would be removed, and all
necessary parameters would be passed through its
[primary or secondary]({% pst 2015/may/2015-05-28-one-primary-constructor %}) constructors.
Keeping all attributes immutable would be helpful too.

It seems that even the [Builder design pattern](https://en.wikipedia.org/wiki/Builder_pattern)
would be a better solution than the `init()` method in this particular case.

## Violation of Layering

Consider the following two Java classes, which depend on each other:

```java
class Book {
  private final Order order;
  private final String language;
  Book(Order o) {
    this.order = o;
    this.language = o.language();
  }
}
class Order {
  private final Book book;
  private final int total;
  Order(Book b) {
    this.book = b;
    this.total = book.price() + 10;
  }
}
```

Clearly, instantiating either the `Book` or the `Order` is impossible,
as each requires the other to be instantiated first.
Two-phase construction accompanied by
[attributes mutability]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %})
and
[setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})
may look like a solution:

```java
class Book {
  private Order order;
  private String language;
  void setOrder(Order o) { this.order = o; }
  void init() {
    this.language = this.order.language();
  }
}
class Order {
  private Book book;
  private int total;
  void setBook(Book b) { this.book = b; }
  void init() {
    this.total = book.price() + 10;
  }
}
```

Now, it's possible to instantiate them:

```java
order = new Order();
book = new Book();
order.setBook(book);
book.setOrder(order);
order.init();
book.init();
```

However, this design exhibits a significant flaw: both the `order` and `book` objects
remain in an incomplete state until their respective `init()` methods are invoked.
As the code takes shape, its original author understands the correct sequence of
method calls: the constructor first, followed by the setter, and only then
the `init()` method. However, in the future, as others modify the code, this
[temporal coupling]({% pst 2015/dec/2015-12-08-temporal-coupling-between-method-calls %})
between method calls could be easily missed. An inadvertent call to
`init()` prior to the setter could result in runtime errors that are difficult to diagnose.

The underlying issue here stems from a violation of the layering principle present
in the design of both `Book` and `Order`: they are mutually dependent.
If I recall correctly, Martin Fowler postulated that "a layer can only access layers beneath it."
In the context of our book-and-order design, there's no clear distinction of
these layers: it's indeterminable which is foundational to the other.
The difficulties in instantiation are just manifestations of this issue,
and two-step initialization serves more as a band-aid rather than an actual solution.

I'm at a loss for how to enhance this code directly. It's likely that the entire architecture
needs a thorough reassessment, with the introduction of more adequate abstractions
in place of `Book` and `Order`.

<hr/>

It appears that two-step initialization doesn't truly solve problems;
rather, it merely masks them for a time. While you can have `init()` methods in your objects,
they look like flags with "I failed to design this class properly!" written on them.
