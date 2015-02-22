---
layout: post
title: "Composable Decorators vs. Imperative Utility Methods"
date: 2015-02-28
tags: oop
description:
  Decorator pattern, while the best instrument to keep objects highly cohesive,
  solid and losely coupled, unfortunately is not very popular in traditional Java
  programming.
keywords:
  - composable decorators
  - decorator design pattern
  - decorator pattern java
  - decorator pattern example
  - decorator pattern real life example
---

[Decorator pattern](http://en.wikipedia.org/wiki/Decorator_pattern)
is my favorite one among all other patterns I'm aware of. It is very simple
and yet very powerful mechanism to make your code
[highly cohesive](http://en.wikipedia.org/wiki/Cohesion_%28computer_science%29) and
[losely coupled](http://en.wikipedia.org/wiki/Coupling_%28computer_programming%29).
However, I believe, decorators are not used actively enough. They should
be everywhere, but they are not. The biggest advantage we get from decorators
is that they are making our code _composable_. That's why the title of the
post &mdash; composable decorators. Instead of decorators we often use imperative
utility methods, which are making our code procedural instead of object-oriented.

<!--more-->

First, a practical example. Here is an interface of a object that is
supposed to read a text somewhere and return it:

{% highlight java %}
interface Text {
  String read();
}
{% endhighlight %}

Here is an implementation that reads the text from a file:

{% highlight java %}
final class TextInFile implements Text {
  private final File file;
  public TextInFile(final File src) {
    this.file = src;
  }
  @Override
  public String read() {
    return new String(
      Files.readAllBytes(), "UTF-8"
    );
  }
}
{% endhighlight %}

And now the decorator, which is another implementation of `Text` that
removes all unprintable characters from the text:

{% highlight java %}
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
{% endhighlight %}

Here is how I'm using it:

{% highlight java %}
final Text text = new PrintableText(
  new TextInFile(new File("/tmp/a.txt"))
);
String content = text.read();
{% endhighlight %}

As you see, the `PrintableText` doesn't read the text from file. It doesn't
really care where the text is coming from. It _delegates_ text reading to
the encapsulated instance of `Text`. How this encapsulated object will
deal with the text and where will get it &mdash; doesn't concern `PrintableText`.

Let's continue and try to create an implemetation of `Text`
that will capitalize all letters in the text:

{% highlight java %}
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
{% endhighlight %}

How about a `Text` that trims the input:

{% highlight java %}
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
{% endhighlight %}

I can go on and on with these decorators. I can create many of them,
suitable for their own individual use cases. But let's see how they all
can play together. Let's say I want to read the text from the file,
capitalize it, trim and remove all unprintable characters. And I want
to be _declarative_. Here is what I do:

{% highlight java %}
final Text text = new AllCapsText(
  new TrimmedText(
    new PrintableText(
      new TextInFile(new File("/tmp/a.txt"))
    )
  )
);
String content = text.read();
{% endhighlight %}

First, I create an instance of `Text`, _composing_ multiple decorators into
a single object. I declaratively define the behavior of `text` without
actually executing anything. Until method `read()` is called, the file is not touched
and the processing of the text is not started. The object `text` is just
a composition of decorators, but not an executable _procedure_. Check this
article about declarative and imperative styles of programming:
[Utility Classes Have Nothing to Do With Functional Programming]({% pst 2015/feb/2015-02-20-utility-classes-vs-functional-programming %}).

This design is much more flexible and reusable than a more traditional one,
where the `Text` object is smart enough to perform all said operations. For
example class [`String`](http://docs.oracle.com/javase/7/docs/api/java/lang/String.html)
from Java is a good example of a bad design. It has
over 20 _utility methods_ that should have beed provided as decorators instead, for
example `trim()`, `toUpperCase()`, `substring()`, `split()` and many others.
When I want to trim my string, upper case it, and then split into pieces,
here is what my code will look like:

{% highlight java %}
final String txt = "hello, world!";
final String[] parts = txt.trim().toUpperCase().split(" ");
{% endhighlight %}

This is an imperative and procedural programming. Composable decorators,
instead, would make this code object-oriented and declarative. Something
like this would be great to have in Java instead (pseudo-code):

{% highlight java %}
final String[] parts = new String.Split(
  new String.UpperCased(
    new String.Trimmed("hello, world!")
  )
);
{% endhighlight %}

To conclude, I would recommend to think twice every time you add
a new utility method to the interface/class. Try to avoid utility methods as much
as possible and use decorators instead. An ideal interface should contain
only methods that you absolutely can not remove. Everything else should be
done through composable decorators.

