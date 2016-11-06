---
layout: post
title: "Java Lambdas Are a Mistake"
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
in Java&nbsp;8.
According to [Oracle](http://www.oracle.com/technetwork/java/javase/8-whats-new-2157071.html),
they "_enable you to treat functionality as a method argument_"
and "_support functional-style operations_" respectively. In other words, they are
guests from the world of
[functional programming](https://en.wikipedia.org/wiki/Functional_programming).
And it's not a surprise. Similar features existed in other "object-oriented"
languages long before Java&nbsp;8, for example
in Ruby as [blocks](http://ruby-doc.com/docs/ProgrammingRuby/html/tut_containers.html),
in C# as [delegates](https://msdn.microsoft.com/en-us/library/ms173171.aspx),
in PHP as [anonymous functions](http://php.net/manual/en/functions.anonymous.php),
and in JavaScript as [functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions).
Java 8 is just catching up. The question is whether it is a good
or a bad idea&mdash;to have these functional programming elements in
an object-oriented language? I think it's a bad idea, especially how Java&nbsp;8
implemented it.

<!--more-->

Let's start with an example. Say, we have a list of short texts:

{% highlight java %}
Iterable<String> list = Arrays.asList(
  "one", "two", "three", "four"
);
{% endhighlight %}

This is how we would trim them and print only long ones, in Java&nbsp;7:

{% highlight java %}
for (String i : list) {
  String t = i.trim();
  if (t.length() > 3) {
    System.out.println(t);
  }
}
{% endhighlight %}

This approach is procedural. It's
obvious that, even though it's rather intuitive, testability, reusability,
and maintainability of it are very low&mdash;it is just a script that is written
once and either works or we have to re-write it. The algorithm is visible,
but almost impossible to decompose, since there are no _blocks_ that it can be
broken down to, but only operators and statements.

This is how we can implement the same algorithm in Java&nbsp;8, with lambdas
and streams:

{% highlight java %}
list.stream()
  .map(i -> i.trim())
  .filter(t -> t.length() > 3)
  .forEach(t -> System.out.println(t))
{% endhighlight %}

It looks like a functional approach, since _lambda expressions_ (functions) are
parameters of methods `map()`, `filter()` and `forEach()`. Since it's
functional it is supposed to make Java code less procedural, more abstract,
and more readable. However, I disagree. I don't think lambdas
and streams actually achieve any of these goals. Moreover, I believe they
only turn Java into a bigger mess. Here are my arguments.

  * **



Objects, as well as functions, were invented to make software elements
[less coupled](https://en.wikipedia.org/wiki/Coupling_%28computer_programming%29)
and [more cohesive](https://en.wikipedia.org/wiki/Cohesion_%28computer_science%29),
in order to give us an ability to test
them separately, to re-use them, and to easily maintain. Then,
using [object composition](https://en.wikipedia.org/wiki/Object_composition) in OOP or
[function composition](https://en.wikipedia.org/wiki/Function_composition_%28computer_science%29) in FP
we _compose_ them together, in order to create the result.

Java streams, as I understand, is a good old procedural approach, where
implementations of so called _functional interfaces_ can be inlined by
lambda expressions, for brevity and readability. However, the way we
interact with the list is still very imperative: we tell it what to do,
by calling that methods of `Stream` class. No matter what is happening
inside that methods (you may say that they are not actually filtering
and mapping, but only decorating the list), for the user of class `List`
they look like explicit _directives_.

And this is exactly what makes this approach neither functional nor
object-oriented: lack of _composition_. Nothing is really composed. Instead,
instructions are given, one by one, in a
[fluent](https://en.wikipedia.org/wiki/Fluent_interface) style.
Every next method call returns a new _modified_ object. It could be the
same object, if it's mutable, but the manipulation is done already, when
we move on to the next step of the "ladder."

A _composition_ works and looks differently. In functional programming
it would look like this (pseudo-code, close to Lisp):

{% highlight lisp %}
(defun result (list)
  (forEach (lambda (t) (print t))
    (filter (lambda (t) (> (length t) 3))
      (map (lambda (i) (trim i))
        list))))
{% endhighlight %}

Functions get composed one into another, creating a bigger and a more
complex one, up to the function of the highest level: `result`. Yes, the
`result` is also a function, which will be calculated eventually. Or maybe not.
What we do in functional programming is _composing_ functions.

This is not what is happening with Java streams, on the surface level. No
matter how `Stream` is implemented in every particular collection, it looks
absolutely imperative to those who is going to use it.

There is a second reason, why `Stream` doesn't really fit into either
functional or object composition paradigm: it makes collections aware of
their manipulators. Indeed, the collection has to implement method `filter()`,
for example, in order to let its clients actually filter. This is not
what we have in Lisp&mdash;the collection doesn't know anything about those
who filters it. And it must not know anything about them!

It must be a collection&mdash;a rock solid object, which encapsulates
everything, exposing only _certain_ behavior. Injecting an executable




I believe, what `Stream` is doing it's a serious violation of encapsulation.

The same happens here, but with injectable

In a true functional programming, for example in Closure, we would
do the same manipulations with the list through a composition of
functions:

{% highlight clojure %}
(
(filter #(> (:length %) 3)
  )
list.stream()
  .map(item -> item.trim())
  .filter(t -> t.length() > 3)
  .forEach(t -> System.out.println(t))
{% endhighlight %}


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


decorate List {
  List(list),
  iterator() {

  }
}





{% highlight java %}
List<String> trimmed = new List<>() {

};
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
