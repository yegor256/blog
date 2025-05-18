---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Constructors Must Be Code-Free"
date: 2015-05-07
tags: java oop
categories: jcg
description: |
  It is a bad idea to put executing statements into class
  constructors because that leads to side effects and
  uncontrollable behavior.
keywords:
  - how much code in constructors
  - constructors in java
  - oop constructors best practices
  - best practices java constructors
  - how much code to put into constructors
book: elegant-objects-1 1.3
image: /images/2015/05/kill-bill.jpg
jb_picture:
  caption: "Kill Bill: Vol. 2 (2004) by Quentin Tarantino"
---

How much work should be done within a constructor? It seems reasonable
to do some computations inside a constructor and then encapsulate
results. That way, when the results are required by object methods, we'll have them
ready. Sounds like a good approach? No, it's not. It's a bad idea
for one reason: It prevents composition of objects and makes them
un-extensible.

<!--more-->

{% jb_picture_body %}

Let's say we're making an interface that would represent a name of a person:

```java
interface Name {
  String first();
}
```

Pretty easy, right? Now, let's try to implement it:

```java
public final class EnglishName implements Name {
  private final String name;
  public EnglishName(final CharSequence text) {
    this.name = text.toString().split(" ", 2)[0];
  }
  @Override
  public String first() {
    return this.name;
  }
}
```

What's wrong with this? It's faster, right? It splits the name into
parts only once and encapsulates them. Then, no matter how many times we
call the `first()` method, it will return the same value and won't need
to do the splitting again. However, this is flawed thinking! Let me show
you the right way and explain:

```java
public final class EnglishName implements Name {
  private final CharSequence text;
  public EnglishName(final CharSequence txt) {
    this.text = txt;
  }
  @Override
  public String first() {
    return this.text.toString().split("", 2)[0];
  }
}
```

This is the right design. I can see you smiling, so let me prove my point.

Before I start proving, though, let me ask you to read this article:
[Composable Decorators vs. Imperative Utility Methods]({% pst 2015/feb/2015-02-26-composable-decorators %}).
It explains the difference between a static method and composable decorators.
The first snippet above is very close to an imperative utility method, even
though it looks like an object. The second example is a true object.

{% youtube 9yjtsCK6Wdk %}

In the first example, we are abusing the `new` operator and turning it into
a static method, which does all calculations for us _right here and now_.
This is what _imperative_ programming is about. In imperative programming,
we do all calculations right now and return fully ready results. In declarative
programming, we are instead trying to delay calculations for
as long as possible.

Let's try to use our `EnglishName` class:

```java
final Name name = new EnglishName(
  new NameInPostgreSQL(/*...*/)
);
if (/* something goes wrong */) {
  throw new IllegalStateException(
    String.format(
      "Hi, %s, we can't proceed with your application",
      name.first()
    )
  );
}
```

In the first line of this snippet, we are just making an instance of an object
and labeling it `name`. We don't want to go to the database yet and fetch
the full name from there, split it into parts, and encapsulate them
inside `name`. We just want to create an instance of an object. Such a parsing
behavior would be a side effect for us and, in this case,
will slow down the application.
As you see, we may only need `name.first()` if something goes wrong and
we need to construct an exception object.

My point is that having **any** computations done inside a constructor is a bad
practice and must be avoided because they are side effects and are not
requested by the object owner.

What about performance during the re-use of `name`, you may ask. If we make an
instance of `EnglishName` and then call `name.first()` five times, we'll
end up with five calls to the `String.split()` method.

To solve that, we create another class,
a [composable decorator]({% pst 2015/feb/2015-02-26-composable-decorators %}),
which will help us solve this "re-use" problem:

```java
public final class CachedName implements Name {
  private final Name origin;
  public CachedName(final Name name) {
    this.origin = name;
  }
  @Override
  @Cacheable(forever = true)
  public String first() {
    return this.origin.first();
  }
}
```

I'm using the [`Cacheable`](https://aspects.jcabi.com/annotation-cacheable.html)
annotation from [jcabi-aspects](https://aspects.jcabi.com/), but you can use any other
caching tools available in Java (or other languages), like
[Guava Cache](https://code.google.com/p/guava-libraries/wiki/CachesExplained):

```java
public final class CachedName implements Name {
  private final Cache<Long, String> cache =
    CacheBuilder.newBuilder().build();
  private final Name origin;
  public CachedName(final Name name) {
    this.origin = name;
  }
  @Override
  public String first() {
    return this.cache.get(
      1L,
      new Callable<String>() {
        @Override
        public String call() {
          return CachedName.this.origin.first();
        }
      }
    );
  }
}
```

But please don't make `CachedName` mutable and lazily
loaded---it's an anti-pattern, which I've discussed before in
[Objects Should Be Immutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}).

This is how our code will look now:

```java
final Name name = new CachedName(
  new EnglishName(
    new NameInPostgreSQL(/*...*/)
  )
);
```

It's a very primitive example, but I hope you get the idea.

In this design, we're basically splitting the object into two parts. The first
one knows how to get the first name from the English name. The second one
knows how to cache the results of this calculation in memory. And now it's
my decision, as a user of these classes, how exactly to use them. I will
decide whether I need caching or not. This is what object composition is all about.

Let me reiterate that the only allowed statement inside
a constructor is an assignment. If you need to put something else there,
start thinking about refactoring---your class definitely needs a redesign.
