---
layout: post
title: "Single Statement Unit Tests"
date: 2017-05-13
place: Odessa, Ukraine
tags: testing
description: |
  ...
keywords:
  - testing
  - junit
  - hamcrest
  - junit design
  - testing design patterns
image: /images/2015/03/?
jb_picture:
  caption: xxx
---

There are tons of articles and books about unit testing patterns
and anti-patterns. I want to add one more recommendation, which, I believe,
can help us make tests _and_ code more _object-oriented_:
a test method may contain nothing but a single `assert`.

<!--more-->

{% jb_picture_body %}

Look at this test method from `RandomStreamTest` from OpenJDK&nbsp;8,
created by Brian Goetz:

{% highlight java %}
@Test
public void testIntStream() {
  final long seed = System.currentTimeMillis();
  final Random r1 = new Random(seed);
  final int[] a = new int[SIZE];
  for (int i=0; i < SIZE; i++) {
    a[i] = r1.nextInt();
  }
  final Random r2 = new Random(seed);
  final int[] b = r2.ints().limit(SIZE).toArray();
  assertEquals(a, b);
}
{% endhighlight %}

There are two parts in this method: the algorithm and the assertion. The
algorithm prepares two arrays of integers and the assertion compares them
and throws `AssertionError` if they are not equal.

I'm saying that the first part, the algorithm, is the one we should try
to avoid. The only thing we must have is the assertion. Here is
how I would re-design this test method:

{% highlight java %}
@Test
public void testIntStream() {
  final long seed = System.currentTimeMillis();
  assertEquals(
    new ArrayFromRandom(
      new Random(seed)
    ).toArray(SIZE),
    new Random(seed).ints().limit(SIZE).toArray()
  );
}
private static class ArrayFromRandom {
  private final Random random;
  ArrayFromRandom(Random r) {
    this.random = r;
  }
  int[] toArray(int s) {
    final int[] a = new int[s];
    for (int i=0; i < s; i++) {
      a[i] = this.random.nextInt();
    }
    return a;
  }
}
{% endhighlight %}

If Java would have "monikers", this code would look even nicer:

{% highlight java %}
@Test
public void testIntStream() {
  assertEquals(
    new ArrayFromRandom(
      new Random(System.currentTimeMillis() as seed)
    ).toArray(SIZE),
    new Random(seed).ints().limit(SIZE).toArray()
  );
}
{% endhighlight %}

As you see, there is only one "statement" in this method: `assertEquals()`.
