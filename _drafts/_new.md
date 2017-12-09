---
layout: post
title: "The Toxic Operator new()"
date: 2017-11-20
place: Moscow, Russia
tags: oop
description: |
  ...
keywords:
  - operator new
  - alan kay about oop
  - message oriented programming
  - messages oop
  - alan kay oop definition
image: /images/2017/12/
jb_picture:
  caption:
---

To instantiate objects, in most object-oriented languages,
including Java, Ruby, and C++, we use operator `new()`. Well, unless
we use static factory methods, which we don't use because
[they are evil]({% pst 2017/nov/2017-11-14-static-factory-methods %}).
Even though it looks so easy to make a new object any time we need it,
I would recommend to be more careful with this rather toxic operator.

<!--more-->

{% jb_picture_body %}

I'm sure you understand that the problem with this operator is that
it couples objects making testing and reuse very difficult or even impossible.
Say, there is a stroy in a file that we need to read as a UTF-8 string
(I'm using
[`TextOf`](http://static.javadoc.io/org.cactoos/cactoos/0.25.6/org/cactoos/text/TextOf.html)
from [Cactoos](http://www.cactoos.org)):

{% highlight java %}
class Story {
  String text() {
    return new TextOf(new File("/tmp/story.txt")).asString();
  }
}
{% endhighlight %}

It seems super simple, but the problem is obvious: class `Story` can't
be reused. It can only read one particular file. Moreover, its testing
will be rather difficult, since it reads the content from exactly one place,
which can't be changed anyhow. More formally this problem is known as a
_unbreakable dependency_&mdash;we can't break the link between `Story`
and `/tmp/story.txt`&mdash;they are together forever.

To solve that we need to introduce a constructor and let `Story` accept
the location of the content as an argument:

{% highlight java %}
class Story {
  private final File file;
  Story(File f) {
    this.file = f;
  }
  String text() {
    return new TextOf(this.file).asString();
  }
}
{% endhighlight %}

Now, each user of the `Story` has to know the name of the file. It's not really
convenient, especially for those users who were using `Story` before, knowing
nothing about the file path. To help them we introduce
a [secondary constructor]({% pst 2015/may/2015-05-28-one-primary-constructor %}):

{% highlight java %}
class Story {
  private final File file;
  Story() { // Here!
    this(new File("/tmp/story.txt"));
  }
  Story(File f) {
    this.file = f;
  }
  String text() {
    return new TextOf(this.file).asString();
  }
}
{% endhighlight %}

I'm sure you're well aware of this technique, which is also known
as [dependency injection](http://martinfowler.com/articles/injection.html).
I'm not saying anything new. What I want you to pay attention here for is
the location and the amount of operators `new` in all three code snippets.

In the first snippet both `new` operators are in the method `text()`.
In the second snippet we lost one of them. In the third snippet one operator
is in the method, while the second one moved up, to the constructor.

Remember this fact and let's move on.

What happens if the file is not in UTF-8 but in [KOI8-R](https://en.wikipedia.org/wiki/KOI8-R)?
Class `TextOf` and then method `Story.text()` will throw an exception.
However, class `TextOf` is capable of reading in any encoding, it just
needs to have a secondary argument for its constructor:

{% highlight java %}
new TextOf(this.file, "KOI8_R").asString();
{% endhighlight %}

In order to make `Story` capable of using different encodings, we need to
introduce a few additional secondary constructors and modify its primary
constructor:

{% highlight java %}
class Story {
  private final Text text;
  Story() {
    this(new File("/tmp/story.txt"));
  }
  Story(File f) {
    this(f, StandardEncodings.UTF_8);
  }
  Story(File f, Encoding e) {
    this(new TextOf(f, e));
  }
  Story(Text t) {
    this.text = t;
  }
  String text() {
    return this.text.asString();
  }
}
{% endhighlight %}

There is nothing new in this technique, it's just dependency injection,
but pay attention to the location of operators `new`. They all are in the
constructors now and none of them left in the method `text()`.





