---
layout: post
title: "Streams vs. Decorators"
date: 2017-10-05
place: Odessa, Ukraine
tags: java
description: |
  ...
keywords:
  - streams API
  - decorators vs streams
  - guava vs streams
  - java streams
  - streams
image: /images/2017/02/...
jb_picture:
  caption:
---

[Streams API](http://www.oracle.com/technetwork/articles/java/ma14-java-se-8-streams-2177646.html)
was introduced in Java&nbsp;8 together with
[lambda expressions](http://openjdk.java.net/projects/lambda/), just a few
years ago. I, as a disciplined Java adept, tried to use this new feature
in a few projects of mine, for example
[here](https://github.com/yegor256/jare/blob/0.11/src/main/java/io/jare/dynamo/DyUser.java#L85-L88) and
[here](https://github.com/yegor256/wring/blob/0.17.2/src/main/java/io/wring/dynamo/DyEvents.java#L95-L98).
I didn't really like it and got back to good old decorators. Moreover,
created [Cactoos](http://www.cactoos.org), a library of them, to replace
[Guava](https://github.com/google/guava), which is not so perfect in so many places.

<!--more-->

{% jb_picture_body %}

Here is a primitive example. Let's say, we have a collection of measurements
coming in from some data source, they are all numbers between zero and one:

{% highlight java %}
Iterable<Double> probes;
{% endhighlight %}

Now we need to show only the first 10 of them, ignoring zeros and ones,
and rescaling them to `(0..100)`. Sounds like an easy task, right? There
are three ways to do it: procedural, object-oriented, and Java&nbsp;8 way. Let's
start with the procedural one:

{% highlight java %}
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
{% endhighlight %}

Why this is a procedural way? Because it's imperative. Why it's imperative?
Because it's procedural. Nah, I'm kidding. It's imperative because we're
giving instuctions to the computer what data to put where and how to
iterate through them. We're not declaring the result, but imperatively
build it. It works, but it's not really scalable. We can't take part of this
algorithm and apply to another use case. We can't really modify it easily,
for example to take numbers from two sources instead of one, etc.
It is procedural, enough said. Don't do it this way.

Now, Java&nbsp;8 gives us Streams API, which is supposed to offer a
functional way to do the same. Let's try to use it.

First, we need to create an instance of
[`Stream`](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.html),
which
[`Iterable`](https://docs.oracle.com/javase/8/docs/api/java/lang/Iterable.html)
[doesn't](https://stackoverflow.com/questions/23114015/)
let us obtain directly. Then, we will use stream API and do the job:

{% highlight java %}
StreamSupport.stream(probes.spliterator(), false)
  .filter(p -> p == 0.0d || p == 1.0d)
  .limit(10L)
  .forEach()
{% endhighlight %}




