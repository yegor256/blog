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
(and [Stream API](https://docs.oracle.com/javase/8/docs/api/java/util/stream/package-summary.html))
introduced in Java&nbsp;8.
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
Java&nbsp;8 is just catching up. The question is whether it is a good
or a bad idea&mdash;to have these functional programming elements in
an object-oriented language? I think it's a bad idea, especially how Java&nbsp;8
implemented it.

<!--more-->

The problem lambda expressions are solving in Java and all other OO languages
is obvious&mdash;verbosity of code. Very often we need small objects to
serve a single isolated and one-time purpose. We don't need them to exist
or be visible for the entire application. Instead, we just need them
right here and for once.

For example, let's say we have a simple list of strings:

{% highlight java %}
Iterable<String> list = Arrays.asList(
  "one", "two", "", "three", "four", ""
);
{% endhighlight %}

Now, we want to have another list that doesn't have empty strings.
We want to exclude them. A good old procedural
way to do that would be to create a new list and move acceptable
items into it using a `for` loop:

{% highlight java %}
List<String> target = new LinkedList<>();
for (String item : list) {
  if (!item.empty()) {
    target.add(item);
  }
}
{% endhighlight %}

Needless to say that this approach is imperative and not object-oriented
at all. It's difficult to reuse, test, and maintain. Moreover, it's not
lazy at all: it goes through the entire list even if we don't really
need all items to be filtered immediately.

A better and a much more object-oriented way to do that would be a decorator that _encapsulates_
the original list adding the filtering behavior to it. Here is how
we would do it in Java&nbsp;7;

{% highlight java %}
class CleanIterable implements Iterable<String> {
  private final Iterable<String> origin;
  CleanIterable(Iterable<String> list) {
    this.origin = list;
  }
  @Override
  public Iterator<String> iterator() {
    final Iterator<String> iterator = this.origin.iterator();
    return new Iterator<String>() {
      private Queue<String> buf = new LinkedList<>();
      @Override
      public String next() {
        if (!this.hasNext()) {
          throw new NoSuchElementException();
        }
        return this.buf.poll();
      }
      @Override
      public boolean hasNext() {
        while (this.buf.isEmpty() && iterator.hasNext()) {
          String item = iterator.next();
          if (!item.isEmpty()) { // here!
            this.buf.add(item);
          }
        }
        return !this.buf.isEmpty();
      }
      @Override
      public void remove() {
        throw new UnsupportedOperationException();
      }
    };
  }
}
{% endhighlight %}

Now, to have a list that doesn't have empty strings we just decorate
an original one with `CleanIterable`:

{% highlight java %}
Iterable<String> list = new CleanIterable(list);
{% endhighlight %}

Works great, but what will happen if we need another decorator, which
will, for example, capitalize all strings? Or filter out strings that
are longer than three characters? Or retain only strings without
leading or trailing spaces. Or how about a decorator that will
work with integers instead of strings and will filter out negative
numbers? There are many other possible use cases, where we will have
to create many filtering decorators, which will look very similar to each other.
There will be tons of classes that will look like twins, except just
a few lines. Actually, just a single line will be different. This one:

{% highlight java %}
if (!item.isEmpty()) {
{% endhighlight %}

An obvious solution is a so called [Strategy Design Pattern](https://en.wikipedia.org/wiki/Strategy_pattern):
we create a _general purpose_ decorator that encapsulates a "predicate" object. That
predicate will have a single method accepting `String` and returning `boolean`:

{% highlight java %}
interface Predicate<T> {
  boolean allow(T item);
}
{% endhighlight %}

Then, our filtering decorator will look like this (pay attention,
it's generic now):

{% highlight java %}
class CleanIterable<T> implements Iterable<T> {
  private final Iterable<T> origin;
  private final Predicate<T> predicate;
  CleanIterable(Iterable<T> list, Predicate<T> pred) {
    this.origin = list;
    this.predicate = pred;
  }
  @Override
  public Iterator<T> iterator() {
    final Iterator<T> iterator = this.origin.iterator();
    return new Iterator<T>() {
      private Queue<T> buf = new LinkedList<>();
      @Override
      public T next() {
        if (!this.hasNext()) {
          throw new NoSuchElementException();
        }
        return this.buf.poll();
      }
      @Override
      public boolean hasNext() {
        while (this.buf.isEmpty() && iterator.hasNext()) {
          String item = iterator.next();
          if (CleanIterable.this.predicate.allow(item)) {
            this.buf.add(item);
          }
        }
        return !this.buf.isEmpty();
      }
      @Override
      public void remove() {
        throw new UnsupportedOperationException();
      }
    };
  }
}
{% endhighlight %}

Now, we can use it like this (with the help of an anonymous inner class):

{% highlight java %}
Iterable<String> list = new CleanIterable<String>(
  list,
  new Predicate<String>() {
    @Override
    public boolean allow(String item) {
      return !item.isEmpty();
    }
  }
);
{% endhighlight %}

This is how it worked in Java for years. You definitely know [Guava](https://github.com/google/guava),
a very popular Java library from Google, that implements exactly that
design.

Java&nbsp;8 simplified that syntax by allowing us making instances
of that "predicates" (they are called "functional interfaces")
in much less lines of code. Here is how our code will look in Java&nbsp;8:

{% highlight java %}
Iterable<String> list = new CleanIterable<String>(
  list,
  item -> !item.isEmpty()
);
{% endhighlight %}

This definitely is a great optimization comparing to the code we
had in Java before. Instead of six lines of code we have to write
just one!

However, the question is whether we are optimizing the right thing?
Whether the Strategy Pattern we've been using for years in Guava and
many other places was actually a good object-oriented design? Whether
it was a good idea to solve code duplication problem with
similar filtering decorators?

I believe that the very idea of that Strategy Pattern is wrong. Well,
it is not object-oriented, that's why I call it wrong. It doesn't really
help objects stay solid and cohesive. Instead, by injecting foreign behavior
into objects we open them up and violate the very principle of
encapsulation.

This is very similar to the
[configurable objects]({% pst 2016/apr/2016-04-19-object-must-not-be-configurable %})
problem discussed earlier: injecting configurational parameters into
objects seriously violate encapsulation principle. Here, with injectable
functionality we make even a bigger mistake: the `CleanIterable` doesn't
really know what exactly it is doing any more, either filtering empty
strings or negative numbers. It is not an object, but a template of
an object, a surrogate, a cripple.

What is a better alternative? What would be the right object-oriented
design? This is how I would do it, in a pseudo-language, similar to Java:



