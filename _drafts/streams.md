---
layout: post
title: "Are Java Streams Really Object-Oriented?"
date: 2016-04-29
place: Palo Alto, CA
tags: oop java
description: |
  Lambda Expressions and Streams in Java 8 are very popular features,
  which seem to be also very convenient; however, the
  question is whether they are really good design.
keywords:
  - lambda java 8
  - java lambda
  - java stream
  - java stream is bad
  - java lambda is bad
---

Let's talk about [lambda expressions](https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html)
and [Stream API](https://docs.oracle.com/javase/8/docs/api/java/util/stream/package-summary.html)
in Java 8.
According to [Oracle](http://www.oracle.com/technetwork/java/javase/8-whats-new-2157071.html),
they "_enable you to treat functionality as a method argument_"
and "_support functional-style operations_" respectively. In other words, they are
guests from the world of
[functional programming](https://en.wikipedia.org/wiki/Functional_programming).
And it's not a surprise. Similar features existed in other "object-oriented"
languages long before Java 8, for example
in Ruby as [blocks](http://ruby-doc.com/docs/ProgrammingRuby/html/tut_containers.html),
in C# as [delegates](https://msdn.microsoft.com/en-us/library/ms173171.aspx),
in PHP as [anonymous functions](http://php.net/manual/en/functions.anonymous.php),
and in JavaScript as [functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions).
Java 8 is just catching up. The question is whether it is a good
or a bad idea &mdash; to have these functional programming elements in
an object-oriented language? I think it's a bad idea, especially how Java 8
implemented it.

<!--more-->

Let's start with an example. Say, we have a list of short texts:

{% highlight java %}
List<String> list = Arrays.asList(
  "one", "two", "three", "four"
);
{% endhighlight %}

This is how we would trim them and print only long ones, in Java 7:

{% highlight java %}
for (String item : list) {
  String t = item.trim();
  if (t.length() > 3) {
    System.out.println(t);
  }
}
{% endhighlight %}

This is what we do in Java 8, with lambdas and streams:

{% highlight java %}
list.stream()
  .map(item -> item.trim())
  .filter(t -> t.length() > 3)
  .forEach(t -> System.out.println(t))
{% endhighlight %}

The first approach is procedural. The second one looks like functional, since
_lambda expressions_ are parameters of methods `map`, `filter` and `forEach`.
However, where is the object-oriented one? It's not here yet.
I'll show it in a minute.

First, let's discuss what is wrong with the second "functional" approach. We don't
need to discuss what is wrong with the procedural one, right? It's
obvious that, even though it's very intuitive, testability, reusability,
and maintainability of it are very low &mdash; it is just a script that is written
once and either works or we have to re-write it.

Objects, as well as functions, were invented to make software elements
less coupled and more cohesive, in order to give us an ability to test
them separately, to re-use them, and to maintain them easily. Then,
using [object composition](https://en.wikipedia.org/wiki/Object_composition) in OOP or
[function composition](https://en.wikipedia.org/wiki/Function_composition_%28computer_science%29) in FP
we _compose_ them together, in order to achieve the final result.

Java streams, as I understand, is a good old procedural approach with functions
on top of it, without even function composition. It's neither functional
programming, since there is no composition of functions, nor object-oriented
one, since there is no composition of objects.

Why there is no composition of functions

First, let's see what is so wrong about
OOP and FP combination.


{% highlight java %}
String text = new Join(
  new Mapped(
    new Filtered(
      new Mapped(
        list,
        new Mapping() { item -> item.trim() }
      ),
      new Predicate() { t -> t.length() > 3 }
    ),
    new Mapping() { t -> t.toString() }
  ),
  "\n"
);
System.out.println(text);
{% endhighlight %}


