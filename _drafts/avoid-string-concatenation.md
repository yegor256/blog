---
layout: post
title: "How to Avoid String Concatenation in Java"
date: 2014-06-14
tags: strings java programming
description:
  String concatenation in Javan is a bad practice; this article
  explains how to avoid it and make your code cleaner
keywords:
  - java string concatenation
  - avoid string concatenation
  - bad practice java
  - best practice string concatenation
  - how to avoid string concatenation
  - replacement of string concatenation
  - alternative of string concatenation
  - string concatenation is evil
  - string concatenation is a bad practice
---

String concatentation is a bad practice, in Java (and in many other
languages/platforms):

{% highlight java %}
// bad practice, don't reuse!
String text = "Hello, " + name + "!";
{% endhighlight %}

Why? Two reasonse. First of all, because it is slow.
On every `+` operator `String` class allocates a new
block in memory. In reality, this "nice" piece of code works like this:

{% highlight java %}
String t1 = "Hello, ";
String t2 = t1 + name;
String t3 = "!";
String text = t2 + t3;
{% endhighlight %}

There are three supplementary memory blocks created. This is time
consuming and slow.

Second, it's not as clean and readable as the alternatives listed below.
Let's discuss them.

## String.format()

`String.format()` is a static utility method that mirrors
`sprintf()` from C. It allows you to build a string using a pattern
and substitutors:

{% highlight java %}
String text = String.format("Hello, %s!", name);
{% endhighlight %}

This code looks much cleaner and shorter. Besides that, it
is much more powerful, since we can use multiple formatting options. On top
of that, the string can be much easier localized.

Of course,
[it is slower than concatenation](http://stackoverflow.com/questions/925423/is-it-better-practice-to-use-string-format-over-string-concatenation-in-java),
because it involves parsing of the pattern and formatting of the arguments.
However, I strongly recommend to use it, where performance is not mission critical.
Lack of code maintainability usually causes bigger problems that lack of performance.

## StringBuilder

`StringBuilder` allocates a memory block for the entire string, and fills
it on calls to its `append()` methods:

{% highlight java %}
String text = new StringBuilder(50) // initial length
  .append("Hello, ").append(name).append('!').toString();
{% endhighlight %}

This method consumes more memory than string concatenation, but works faster
since it performs less copy operations.
Since it is not as readable as `String.format()`, I'd recommend to
use it when a string is long (longer than, say, 50 characters).

## Apache Commons StringUtils.join()

There is an utility class `StringUtils` in Apache commons-lang3, which
concatenates multiple strings:

{% highlight java %}
import org.apache.commons.lang3.StringUtils;
String text = StringUtils.join("Hello, ", name, "!");
{% endhighlight %}

A necessity to include an additional JAR dependency to your classpath
may be considered a downside of this method:

{% highlight xml %}
<dependency>
  <groupId>org.apache.commons</groupId>
  <artifactId>commons-lang3</artifactId>
  <version>3.3.2</version>
</dependency>
{% endhighlight %}

This method and the next one are very convenient when you need
to present a very long string inside Java source code. For example,
an XML document:

{% highlight java %}
String xml = StringUtils.join(
  "<?xml version='1.0'?>",
  "<html><body>",
  "<p>This is a test XHTML document,",
  " which would look ugly,",
  " if we would use a single line"
  " or string concatenation.</p>"
  "</body></html>"
);
{% endhighlight %}

## Guava Joiner

`Joiner` is a convenient concatenator of strings from Google Guava:

{% highlight java %}
import com.google.common.base.Joiner;
String text = Joiner.on('').join("Hello, ", name, "!");
{% endhighlight %}

Again, a dependency is required in this case:

{% highlight xml %}
<dependency>
  <groupId>com.google.guava</groupId>
  <artifactId>guava</artifactId>
  <version>17.0</version>
</dependency>
{% endhighlight %}

If you know any other methods of avoiding string concatenation, please
comment below :)

