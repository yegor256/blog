---
layout: post
title: "Composable Decorators vs. Imperative Utility Methods"
date: 2015-02-26
tags: oop
categories: jcg
description: |
  A decorator pattern, while being the best instrument to keep objects highly cohesive,
  solid, and loosely coupled, is unfortunately not very popular in traditional Java
  programming.
keywords:
  - composable decorators
  - decorator design pattern
  - decorator pattern java
  - decorator pattern example
  - decorator pattern real life example
image: /images/2015/02/russina-matroshka.jpg
---

The [decorator pattern](https://en.wikipedia.org/wiki/Decorator_pattern)
is my favorite among all other patterns I'm aware of. It is a very simple
and yet very powerful mechanism to make your code
[highly cohesive](https://en.wikipedia.org/wiki/Cohesion_%28computer_science%29) and
[loosely coupled](https://en.wikipedia.org/wiki/Coupling_%28computer_programming%29).
However, I believe decorators are not used often enough. They should
be everywhere, but they are not. The biggest advantage we get from decorators
is that they make our code _composable_. That's why the title of this
post is composable decorators. Unfortunately, instead of decorators, we often use imperative
utility methods, which make our code procedural rather than object-oriented.

<!--more-->

{% jb_picture_body %}

First, a practical example. Here is an interface for an object that is
supposed to read a text somewhere and return it:

```java
interface Text {
  String read();
}
```

Here is an implementation that reads the text from a file:

```java
final class TextInFile implements Text {
  private final File file;
  public TextInFile(final File src) {
    this.file = src;
  }
  @Override
  public String read() {
    return new String(
      Files.readAllBytes(this.file.toPath()), "UTF-8"
    );
  }
}
```

And now the decorator, which is another implementation of `Text` that
removes all unprintable characters from the text:

```java
final class PrintableText implements Text {
  private final Text origin;
  public PrintableText(final Text text) {
    this.origin = text;
  }
  @Override
  public String read() {
    return this.origin.read()
      .replaceAll("[^\p{Print}]", "");
  }
}
```

Here is how I'm using it:

```java
final Text text = new PrintableText(
  new TextInFile(new File("/tmp/a.txt"))
);
String content = text.read();
```

As you can see, the `PrintableText` doesn't read the text from the file. It doesn't
really care where the text is coming from. It _delegates_ text reading to
the encapsulated instance of `Text`. How this encapsulated object will
deal with the text and where it will get it doesn't concern `PrintableText`.

Let's [continue]({% pst 2016/apr/2016-04-19-object-must-not-be-configurable %})
and try to create an implementation of `Text`
that will capitalize all letters in the text:

```java
final class AllCapsText implements Text {
  private final Text origin;
  public AllCapsText(final Text text) {
    this.origin = text;
  }
  @Override
  public String read() {
    return this.origin.read().toUpperCase(Locale.ENGLISH);
  }
}
```

How about a `Text` that trims the input:

```java
final class TrimmedText implements Text {
  private final Text origin;
  public TrimmedText(final Text text) {
    this.origin = text;
  }
  @Override
  public String read() {
    return this.origin.read().trim();
  }
}
```

{% youtube D0dqC_3Bch8 %}

I can go on and on with these
[decorators]({% pst 2015/oct/2015-10-01-vertical-horizontal-decorating %}).
I can create many of them,
suitable for their own individual use cases. But let's see how they all
can play together. Let's say I want to read the text from the file,
capitalize it, trim it, and remove all unprintable characters. And I want
to be _declarative_. Here is what I do:

```java
final Text text = new AllCapsText(
  new TrimmedText(
    new PrintableText(
      new TextInFile(new File("/tmp/a.txt"))
    )
  )
);
String content = text.read();
```

First, I create an instance of `Text`, _composing_ multiple decorators into
a single object. I declaratively define the behavior of `text` without
actually executing anything. Until method `read()` is called, the file is not touched
and the processing of the text is not started. The object `text` is just
a composition of decorators, not an executable _procedure_. Check out this
article about declarative and imperative styles of programming:
[Utility Classes Have Nothing to Do With Functional Programming]({% pst 2015/feb/2015-02-20-utility-classes-vs-functional-programming %}).

This design is much more flexible and reusable than a more traditional one,
where the `Text` object is smart enough to perform all said operations. For
example, class [`String`](http://docs.oracle.com/javase/7/docs/api/java/lang/String.html)
from Java is a good example of a bad design. It has
more than 20 _utility methods_ that should have been provided as decorators instead: `trim()`, `toUpperCase()`, `substring()`, `split()`, and many others, for example.
When I want to trim my string, uppercase it, and then split it into pieces,
here is what my code will look like:

```java
final String txt = "hello, world!";
final String[] parts = txt.trim().toUpperCase().split(" ");
```

This is imperative and procedural programming. Composable decorators,
on the other hand, would make this code object-oriented and declarative. Something
like this would be great to have in Java instead (pseudo-code):

```java
final String[] parts = new String.Split(
  new String.UpperCased(
    new String.Trimmed("hello, world!")
  )
);
```

To conclude, I recommend you think twice every time you add
a new utility method to the interface/class. Try to avoid utility methods as much
as possible, and use decorators instead. An
[ideal interface]({% pst 2016/apr/2016-04-26-why-inputstream-design-is-wrong %}) should contain
only methods that you absolutely cannot remove. Everything else should be
done through composable decorators.
