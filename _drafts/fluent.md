---
layout: post
title: "Are Java Streams Really Object-Oriented?"
date: 2016-04-29
place: Palo Alto, CA
tags: oop java
description: |
  Stream API in Java 8 is a very popular feature,
  which seems to be very convenient; however, the
  question is whether it's really a good feature?
keywords:
  - fluent interface
  - fluent interface java
  - java 8 stream api
  - fluent interface python
  - fluent interface oop
---

Let's talk about [lambda expressions](https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html)
and [Stream API](https://docs.oracle.com/javase/8/docs/api/java/util/stream/package-summary.html)
in Java 8.
According to [Oracle](http://www.oracle.com/technetwork/java/javase/8-whats-new-2157071.html),
they "enable you to treat functionality as a method argument"
and "support functional-style operations" respectively. In other words, they are
guests from the world of functional programming.
And it's not a surprise. Similar features existed in many "object-oriented"
languages long before Java 8. For example,
in Ruby as [blocks](http://ruby-doc.com/docs/ProgrammingRuby/html/tut_containers.html),
in C# as [delegates](https://msdn.microsoft.com/en-us/library/ms173171.aspx),
in PHP as [anonymous functions](http://php.net/manual/en/functions.anonymous.php),
and in JavaScript as [functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions).
Java 8 is just catching up. The question is whether it's a good
or a bad idea &mdash; to have these functional programming elements in
an object-oriented language? I think it's a bad idea.

<!--more-->

Say, we have a list of short texts:

{% highlight java %}
List<String> list = Arrays.asList(
  "one", "two", "three"
);
{% endhighlight %}

This is how we would trim them and print only long ones, in Java 7:

{% highlight java %}
for (String item : list) {
  String trimmed = item.trim();
  if (trimmed.length() > 3) {
    System.out.println(trimmed);
  }
}
{% endhighlight %}

This is what we do in Java 8:

{% highlight java %}
list.stream()
  .map(t -> t.trim())
  .filter(t -> t.length() > 3)
  .forEach(t -> System.out.println(t))
{% endhighlight %}

The first approach is procedural. The second one is functional. Where
is the object-oriented one?


