---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Streams vs. Decorators"
date: 2017-10-10
place: Odessa, Ukraine
tags: java
description: |
  Streams from Java 8 help us manipulate collections,
  but they ruin the idea of objects; decorators, on the
  other hand, do the same but in an object-oriented way.
keywords:
  - streams API
  - decorators vs streams
  - guava vs streams
  - java streams
  - streams
social:
  - dzone: https://dzone.com/articles/streams-vs-decorators
image: /images/2017/10/la-haine.jpg
jb_picture:
  caption: La Haine (1995) by Mathieu Kassovitz
buffer:
  - "The Streams API was introduced in Java 8. I didn't really like it and went back to good old decorators"
  - "The biggest issue with this streaming API is the very interface Stream, it's huge!"
  - "There is no such thing as forEachWithIndex() in the Stream interface as of Java 8 (and Java 9 too)"
---

The [Streams API](https://www.oracle.com/technetwork/articles/java/ma14-java-se-8-streams-2177646.html)
was introduced in Java&nbsp;8, together with
[lambda expressions](http://openjdk.java.net/projects/lambda/), just a few
years ago. I, as a disciplined Java adept, tried to use this new feature
in a few of my projects, for example
[here](https://github.com/yegor256/jare/blob/0.11/src/main/java/io/jare/dynamo/DyUser.java#L85-L88) and
[here](https://github.com/yegor256/wring/blob/0.17.2/src/main/java/io/wring/dynamo/DyEvents.java#L95-L98).
I didn't really like it and went back to good old decorators. Moreover, I
created [Cactoos](https://www.cactoos.org), a library of decorators, to replace
[Guava](https://github.com/google/guava), which is not so good in so many places.

<!--more-->

{% jb_picture_body %}

Here is a primitive example. Let's say we have a collection of measurements
coming in from some data source, they are all numbers between zero and one:

```java
Iterable<Double> probes;
```

Now, we need to show only the first 10 of them, ignoring zeros and ones,
and re-scaling them to `(0..100)`. Sounds like an easy task, right? There
are three ways to do it: procedural, object-oriented, and the Java&nbsp;8 way. Let's
start with the procedural way:

```java
int pos = 0;
for (Double probe : probes) {
  if (probe == 0.0d || probe == 1.0d) {
    continue;
  }
  if (++pos > 10) {
    break;
  }
  System.out.printf(
    "Probe #%d: %f", pos, probe * 100.0d
  );
}
```

Why is this a procedural way? Because it's imperative. Why is it imperative?
Because it's procedural. Nah, I'm kidding.

It's imperative because we're
giving instructions to the computer about what data to put where and how to
iterate through it. We're not declaring the result, but imperatively
building it. It works, but it's not really scalable. We can't take part of this
algorithm and apply it to another use case. We can't really modify it easily,
for example to take numbers from two sources instead of one, etc.
It's procedural. Enough said. Don't do it this way.

Now, Java&nbsp;8 gives us the
[Streams API](https://www.oracle.com/technetwork/articles/java/ma14-java-se-8-streams-2177646.html),
which is supposed to offer a
functional way to do the same. Let's try to use it.

First, we need to create an instance of
[`Stream`](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.html),
which
[`Iterable`](https://docs.oracle.com/javase/8/docs/api/java/lang/Iterable.html)
[doesn't](https://stackoverflow.com/questions/23114015/)
let us obtain directly. Then we use the stream API to do the job:

```java
StreamSupport.stream(probes.spliterator(), false)
  .filter(p -> p == 0.0d || p == 1.0d)
  .limit(10L)
  .forEach(
    probe -> System.out.printf(
      "Probe #%d: %f", 0, probe * 100.0d
    )
  );
```

This will work, but will say `Probe #0` for all probes, because `forEach()`
doesn't work with indexes. There is no such thing as `forEachWithIndex()`
in the [`Stream`](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.html)
interface as of Java&nbsp;8 (and Java&nbsp;9
[too](http://download.java.net/java/jdk9/docs/api/java/util/stream/Stream.html)).
Here is a [workaround](https://stackoverflow.com/a/18552071/187141) with
an atomic counter:

```java
AtomicInteger index = new AtomicInteger();
StreamSupport.stream(probes.spliterator(), false)
  .filter(probe -> probe != 0.0d && probe != 1.0d)
  .limit(10L)
  .forEach(
    probe -> System.out.printf(
      "Probe #%d: %f",
      index.getAndIncrement(),
      probe * 100.0d
    )
  );
```

"What's wrong with that?" you may ask. First, see how easily we got into
trouble when we didn't find the right method in the `Stream` interface. We
immediately fell off the "streaming" paradigm and got back to the
good old procedural global variable (the counter). Second, we don't
really see what's going on inside those `filter()`, `limit()`, and `forEach()`
methods. How exactly do they work? The documentation says that this
approach is "declarative" and each method in the `Stream` interface returns
an instance of some class. What classes are they? We have no idea by
just looking at this code.

{% quote The biggest issue with this streaming API is the very interface Stream, it's huge! %}

These two problems are connected. The biggest issue with this streaming API
is the very interface `Stream`---it's huge. At the time of writing
there are 43 methods. Forty three, in a single interface! This is against
each and every
[principle]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %})
of object-oriented programming, starting with
[SOLID]({% pst 2017/mar/2017-03-28-solid %}) and then up to more serious
ones.

What is the object-oriented way to implement the same algorithm? Here
is how I would do it with [Cactoos](https://www.cactoos.org), which is just a collection of
~~primitive~~ simple Java classes:

```java
new And(
  new Mapped<Double, Scalar<Boolean>>(
    new Limited<Double>(
      new Filtered<Double>(
        probes,
        probe -> probe != 0.0d && probe != 1.0d
      ),
      10
    ),
    probe -> () -> {
      System.out.printf(
        "Probe #%d: %f", 0, probe * 100.0d
      );
      return true;
    }
  )
).value();
```

Let's see what's going on here. First,
[`Filtered`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/iterable/Filtered.html)
decorates our iterable `probes` to take certain items out of it.
Notice that `Filtered` implements `Iterable`. Then
[`Limited`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/iterable/Limited.html),
also being an `Iterable`, takes only the first ten items out. Then
[`Mapped`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/iterable/Mapped.html)
converts each probe into an instance of
[`Scalar<Boolean>`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/Scalar.html),
which does the line printing.

Finally, the instance of `And` goes through the list of "scalars" and ask
each of them to return `boolean`. They print the line and return `true`. Since
it's `true`, `And` makes the next attempt with the next scalar. Finally,
its method `value()` returns `true`.

But wait, there are no indexes. Let's add them. In order to do that we
just use another class, called `AndWithIndex`:

```java
new AndWithIndex(
  new Mapped<Double, Func<Integer, Boolean>>(
    new Limited<Double>(
      new Filtered<Double>(
        probes,
        probe -> probe != 0.0d && probe != 1.0d
      ),
      10
    ),
    probe -> index -> {
      System.out.printf(
        "Probe #%d: %f", index, probe * 100.0d
      );
      return true;
    }
  )
).value();
```

Instead of `Scalar<Boolean>` we now map our probes to
[`Func<Integer, Boolean>`](http://static.javadoc.io/org.cactoos/cactoos/0.16/org/cactoos/Func.html)
to let them accept the index.

The beauty of this approach is that all classes and interfaces are small
and that's why they're very composable. To make an iterable of probes limited
we decorate it with `Limited`; to make it filtered we decorate it with
`Filtered`; to do something else we create a new decorator and use it. We're
not stuck to one single interface like `Stream`.

The bottom line is that decorators are an object-oriented instrument to
modify the behavior of collections, while streams is something else which
I can't even find the name for.

P.S. By the way, this is how the same algorithm can be implemented
with the help of Guava's
[`Iterables`](https://google.github.io/guava/releases/21.0/api/docs/com/google/common/collect/Iterables.html):

```java
Iterable<Double> ready = Iterables.limit(
  Iterables.filter(
    probes,
    probe -> probe != 0.0d && probe != 1.0d
  ),
  10
);
int pos = 0;
for (Double probe : probes) {
  System.out.printf(
    "Probe #%d: %f", pos++, probe * 100.0d
  );
}
```

This is some weird combination of object-oriented and functional styles.
