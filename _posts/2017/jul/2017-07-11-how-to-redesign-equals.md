---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "How I Would Re-design equals()"
date: 2017-07-11
place: Copenhagen, Denmark
tags: java oop
description: |
  The design of equals() and compareTo() in Java
  is far from perfect; this is how I would improve
  it and make more object-oriented.
keywords:
  - design of equals()
  - design of compareTo()
  - object-oriented compare objects
  - oop object comparison
  - how to compare objects
image: /images/2017/07/lultimo-capodanno.jpg
jb_picture:
  caption: L'ultimo capodanno (1998) by Marco Risi
buffer:
  - "No more violation of encapsulation, no more type casting, no more ugly code inside those equals() and compareTo() methods"
  - "Now I know what exactly is wrong and how I would design this \"object-to-object comparing\" mechanism better"
---

I want to rant a bit about Java design, in particular about the methods
[`Object.equals()`](https://docs.oracle.com/javase/7/docs/api/java/lang/Object.html#equals%28java.lang.Object%29)
and
[`Comparable.compareTo()`](https://docs.oracle.com/javase/7/docs/api/java/lang/Comparable.html#compareTo%28T%29).
I've hated them for years, because, no matter how hard
I try to like them, the code inside looks ugly. Now I know what exactly
is wrong and how I would design this "object-to-object comparing" mechanism
_better_.

<!--more-->

{% jb_picture_body %}

Say we have a ~~simple~~ primitive class `Weight`, objects of which
represent the weight of something in kilos:

```java
class Weight {
  private int kilos;
  Weight(int k) {
    this.kilos = k;
  }
}
```

Next, we want two objects of the same weight to be equal to each other:

```java
new Weight(15).equals(new Weight(15));
```

Here is how such a method may look:

```java
class Weight {
  private int kilos;
  Weight(int k) {
    this.kilos = k;
  }
  public boolean equals(Object obj) {
    if (!(obj instanceof Weight)) {
      return false;
    }
    Weight weight = Weight.class.cast(obj);
    return weight.kilos == this.kilos;
  }
}
```

The ugly part here is, first of all, the
[type casting]({% pst 2015/apr/2015-04-02-class-casting-is-anti-pattern %})
with `instanceof`. The second problem
is that we touch the internals of the incoming object. This design makes
polymorphic behavior of the `Weight` impossible. We simply can't pass
anything else to the `equals()` method, besides an instance of the
class `Weight`. We can't turn it into an interface and introduce
multiple implementations of it:

```java
interface Weight {
  boolean equals(Object obj);
}
```

This code will not work:

```java
class DefaultWeight implements Weight {
  // attribute and ctor skipped
  public boolean equals(Object obj) {
    if (!(obj instanceof Weight)) {
      return false;
    }
    Weight weight = Weight.class.cast(obj);
    return weight.kilos == this.kilos; // error here!
  }
}
```

The problem is that one object decides for the other whether they are
equal. This inevitably leads to a necessity to touch private attributes in order
to do the actual comparison.

What is the solution?

This is what I'm offering. Any comparison, no matter what types we
are talking about, is about comparing two digital values. Either we
compare a weight with a weight, text with text, or a user with a user---our
CPUs can only compare numbers. Thus, we introduce a new interface
`Digitizable`:

```java
interface Digitizable {
  byte[] digits();
}
```

Next, we introduce a new class `Comparison`, which _is_ the comparison of
two streams of bytes (I'm not sure the code is perfect, I tested it
[here](https://github.com/yegor256/blog/tree/master/_samples/2017/07/equals),
feel free to improve and contribute with a pull request):

```java
class Comparison<T extends Digitizable> {
  private T lt;
  private T rt;
  Comparison(T left, T right) {
    this.lt = left;
    this.rt = right;
  }
  int value() {
    final byte[] left = this.lt.digits();
    final byte[] right = this.rt.digits();
    int result = 0;
    int max = Math.max(left.length, right.length);
    for (int idx = max; idx > 0; --idx) {
      byte lft = 0;
      if (idx <= left.length) {
        lft = left[max - idx];
      }
      byte rht = 0;
      if (idx <= right.length) {
        rht = right[max - idx];
      }
      result = lft - rht;
      if (result != 0) {
        break;
      }
    }
    return (int) Math.signum(result);
  }
}
```

Now, we need `Weight` to implement `Digitizable`:

```java
class Weight implements Digitizable {
  private int kilos;
  Weight(int k) {
    this.kilos = k;
  }
  @Override
  public byte[] digits() {
    return ByteBuffer.allocate(4)
      .putInt(this.kilos).array();
  }
}
```

Finally, this is how we compare them:

```java
int v = new Comparison<Weight>(
  new Weight(400), new Weight(500)
).value();
```

This `v` will either be `-1`, `0`, or `1`. In this particular case it will be `-1`,
because `400` is less than `500`.

No more violation of encapsulation, no more type casting, no more
ugly code inside those `equals()` and `compareTo()` methods.
The class `Comparison` will work with all possible types. All our objects
need to do in order to become comparable is to implement `Digitizable` and
"provide" their bytes for inspection/comparison.

This approach is actually very close to the
[printers]({% pst 2016/apr/2016-04-05-printers-instead-of-getters %})
I described earlier.
