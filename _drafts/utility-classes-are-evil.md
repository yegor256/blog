---
layout: post
title: "Utility Classes Are Evil"
date: 2014-05-02
tags: quality oop design
description:
  Since I consider static methods and variables one of the biggest
  mistakes in OOP languages (maybe next to NULL-s), this article
  explains how to avoid them
keywords:
  - static methods
  - static is evil
  - utility class is evil
  - utility class
  - utility classes
  - how to avoid utility classes
  - utility class alternative
  - alternative of utility class
  - singleton is evil
  - bad practices utility class
  - helper class is evil
  - helper class is bad
---

A utility class (aka helper class)
is a "structure" that has only static methods and encapsulate
no state. `StringUtils`, `IOUtils`, `FileUtils` from
[Apache Commons](http://commons.apache.org/);
`Iterables` and `Iterators` from
[Guava](https://code.google.com/p/guava-libraries/),
and [`Files`](http://docs.oracle.com/javase/7/docs/api/java/nio/file/Files.html) from JDK7
are perfect examples of utility classes.

This design idea is very popular in Java
world (as well as C#, Ruby, etc.),
because utility classes provide common functionality used everywhere.
We want to follow
[DRY principle](http://en.wikipedia.org/wiki/Don't_repeat_yourself)
and avoid duplication. We place
common code blocks into utility classes and reuse them when necessary.
Indeed, a very convenient technique:

{% highlight java %}
// This is a terrible design, don't reuse
public class Calc {
  public static int max(int a, int b) {
    return a > b ? a : b;
  }
}
{% endhighlight %}

However, in a object-oriented world they are considered as
a very bad (some may say "terrible") practice.
There were many discussions of this subject, to name a few:
[Are Helper Classes Evil?](http://blogs.msdn.com/b/nickmalik/archive/2005/09/06/461404.aspx) by Nick Malik,
[Why helper, singletons and utility classes are mostly bad](http://smart421.wordpress.com/2011/08/31/why-helper-singletons-and-utility-classes-are-mostly-bad-2/) by Simon Hart,
[Avoiding Utility Classes](http://www.marshallward.org/avoiding-utility-classes.html) by Marshal Ward,
[Kill That Util Class!](http://www.jroller.com/DhavalDalal/entry/kill_that_util_class) by Dhaval Dalal,
[Helper Classes Are A Code Smell](http://www.robbagby.com/posts/helper-classes-are-a-code-smell/) by Rob Bagby.

There are a few questions on StackExchange about it:
[If a “Utilities” class is evil, where do I put my generic code?](http://stackoverflow.com/questions/3339929/if-a-utilities-class-is-evil-where-do-i-put-my-generic-code),
[Utility Classes are Evil](http://stackoverflow.com/questions/3340032/utility-classes-are-evil).

A dry summary of all their arguments is that
utility classes are not proper objects that's why they don't fit
into object-oriented world. They were inherited from
procedural programming, mostly because most of us were
used to a functional decomposition paradigm back then.

Assuming you agree with the arguments and want to stop using utility
classes, I'll show by example how these creatures can be replaced
with proper objects.

## Usage Example

Say, you have a text that contains words separated
by spaces. You want to remove spaces around the text, split it into words and
then join them again, separating by comma. This is how this can be done with
[`StringUtils`](http://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html):

{% highlight java %}
String result = StringUtils.join(
  StringUtils.split(
    StringUtils.trim(text),
    ' '
  ),
  ","
)
{% endhighlight %}

There are three static calls to methods `join()`, `split()` and `trim()` of
"class" `StringUtils`.

This is how I would design the same functionality, in
a better object-oriented way:

{% highlight java %}
String result = new Joined(
  new Split(
    new Trimmed(text),
    ' '
  ),
  ","
).toString();
{% endhighlight %}

Now we have three classes being instantiated and encapsulating each other.

Technically, this works exactly the same. What are the benefits?
Well, besides the fact that this is an object oriented
programming instead of procedural one, the following
benefits are obvious.

## Inversion of Control

In my code, the `text` is not processed until a final call to `Joined.toString()`
is made. Instead of controlling an execution flow, my script simply lets
instantiated objects to fetch their data when they need them.

This mechanism is called [Inversion of Control](http://martinfowler.com/articles/injection.html).


