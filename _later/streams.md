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
According to [Oracle](https://www.oracle.com/technetwork/java/javase/8-whats-new-2157071.html),
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
is obvious&mdash;verbosity of code. Very often we need small **one-method** objects to
serve a single isolated and one-time purpose. We don't need them to exist
or be visible for the entire application. Instead, we just need them
right here and for once.

For example, let's say we have a simple ~~collection~~ iterator of strings:

```java
Iterator<String> list = Arrays.asList(
  "one", "two", "", "three", "four", ""
).iterator();
```

Now, we want to have another iterator that doesn't have empty strings.
We want to exclude them. A good old procedural
way to do that would be to create a new iterator and move acceptable
items into it using a `for` loop:

```java
List<String> target = new LinkedList<>();
for (String item : list) {
  if (!item.empty()) {
    target.add(item);
  }
}
```

Needless to say that this approach is imperative and not object-oriented
at all. It's difficult to reuse, test, and maintain. Moreover, it's not
"lazy" at all: it goes through the entire iterator even if we don't really
need all items to be filtered immediately.

A better and a much more object-oriented way to do that would
be a decorator that _encapsulates_
the original iterator adding the filtering behavior to it. Here is how
we would do it in Java&nbsp;7 (I omit `remove()` for the sake of brevity);

```java
class CleanIterator implements Iterator<String> {
  private final Iterator<String> origin;
  private final Queue<String> buf;
  CleanIterator(Iterator<String> list) {
    this.origin = list;
    this.buf = new LinkedList<>();
  }
  @Override
  public String next() {
    if (!this.hasNext()) {
      throw new NoSuchElementException();
    }
    return this.buf.poll();
  }
  @Override
  public boolean hasNext() {
    while (this.buf.isEmpty()
      && this.origin.hasNext()) {
      String item = iterator.next();
      if (!item.isEmpty()) { // here!
        this.buf.add(item);
      }
    }
    return !this.buf.isEmpty();
  }
}
```

Now, to have an iterator that doesn't have empty strings we just decorate
an original one with `CleanIterator`:

```java
Iterator<String> list = new CleanIterator(list);
```

Works great, but what will happen if we need another decorator, which
will, for example, capitalize all strings? Or filter out strings that
are longer than three characters? Or retain only strings without
leading or trailing spaces. Or how about a decorator that will
work with integers instead of strings and will filter out negative
numbers? There are many other possible use cases, where we will have
to create many filtering decorators, which will look very similar to each other.
There will be tons of classes that will look like twins, except just
a few lines. Actually, just a single line will be different. This one:

```java
if (!item.isEmpty()) {
```

An obvious solution is a so called
[Strategy Design Pattern](https://en.wikipedia.org/wiki/Strategy_pattern):
we create a _general purpose_ decorator that encapsulates a "predicate" object. That
predicate will have a single method accepting `String` and returning `boolean`:

```java
interface Predicate<T> {
  boolean allowed(T item);
}
```

Then, our filtering decorator will look like this (pay attention,
it's generic now):

```java
class FilteringIterator<T> implements Iterator<T> {
  private final Iterator<T> origin;
  private final Predicate<T> predicate;
  private final Queue<T> buf;
  FilteringIterator(Iterator<T> list,
    Predicate<T> pred) {
    this.origin = list;
    this.predicate = pred;
    this.buf = new LinkedList<>();
  }
  @Override
  public T next() {
    if (!this.hasNext()) {
      throw new NoSuchElementException();
    }
    return this.buf.poll();
  }
  @Override
  public boolean hasNext() {
    while (this.buf.isEmpty()
      && this.origin.hasNext()) {
      T item = this.origin.next();
      if (this.predicate.allowed(item)) {
        this.buf.add(item);
      }
    }
    return !this.buf.isEmpty();
  }
}
```

Now, we can use it like this (with the help of an anonymous inner class):

```java
Iterator<String> list = new FilteringIterator<String>(
  list,
  new Predicate<String>() {
    @Override
    public boolean allowed(String item) {
      return !item.isEmpty();
    }
  }
);
```

This is how it worked in Java for years.
You definitely know [Guava](https://github.com/google/guava),
a very popular Java library from Google, that implements exactly that
design.

Java&nbsp;8 simplified that syntax by allowing us to make instances
of that "predicates", called "functional interfaces",
in much less lines of code. Here is how our code will look in Java&nbsp;8:

```java
Iterator<String> list = new FilteringIterator<String>(
  list,
  item -> !item.isEmpty()
);
```

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
functionality we make even a bigger mistake: the `FilteringIterator` doesn't
really know what exactly it is doing any more, either filtering empty
strings or negative numbers. It is not an object, but a template of
an object, a surrogate, a cripple.

Yet another problem here is that we have to move data between two
objects through method `allowed()`. The `item` is exactly the naked
data, which we must try to avoid. With a simple `String` or `int` this
may be not a big problem, but with bigger pieces of data we will
have rather procedural code. The predicate will indeed be a _procedure_
that is expecting data to arrive, processing them and returning back
`boolean`. The predicate is not really a "functional interface",
it's a "procedural interface."

What is a better alternative? What would be the right object-oriented
design? The first option that comes to mind is an abstract class, with the
same non-verbose syntax. How about this (this is pseudo-syntax, not Java)?:

```java
Iterator<String> list = new AbstractFilteringIterator<String>(list) {
  allowed(item): item -> !item.isEmpty()
}
```

Here `AbstractFilteringIterator` encapsulates the original iterator and
lets us implement its abstract method `allowed()`. We are free to implement
other methods here too. The object is more solid than the one with injected
predicate before, but still `AbstractFilteringIterator` is a template, not
a "proper" class. Moreover, we agreed already that implementation
inheritance is a
[bad idea]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %}).

Let's stop for a second and think whether the code we're dealing with is
actually object-oriented. I'm talking about the `Iterator` by itself. What is
it? What kind of "object" is that? Isn't it just a data container with
completely naked data of type `T`? Doesn't it expose the entire collection
to the public making it impossible to encapsulate anything?

I believe that `Iterator` is a purely procedural idea, inherited from
old procedural languages, like
[CLU](https://en.wikipedia.org/wiki/CLU_%28programming_language%29)
(if [Wikipedia](https://en.wikipedia.org/wiki/Iterator) is not lying).
It is just a container, where we are supposed to retrieve objects from,
one by one. There could be even more complex iterators, like bi-directional
and random-access ones. All of them are _not objects_.

A much better design would be to let collections return objects with
"iterational" behavior. Let's say, we have a list of strings:

```java
List<String> list = Arrays.asList(
  "one", "two", "", "three", "four", ""
);
```

Then, I want to iterate through them. First, I retrieve the first item:

```java
String item = list.first();
```

However, it's not just a `String` any more. It has a few more methods,
since its type is not only `String`, but also `Iterated` (I'm making this
up, Java doesn't have it):

```java
item.hasNext();
item.next();
item.remove();
```

Method names are the same as Java `Iterator` has, but they are implemented
by the object itself. See the difference?

To be continued...


