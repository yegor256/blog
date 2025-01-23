---
layout: post
title: "If. Then. Throw. Else. WTF?"
date: 2015-01-21
tags: java oop
categories: jcg
description: |
  When it comes to an if-then-else statement that
  throws an exception or exits by break or continue,
  there is an obvious optimization that is very often overlooked.
keywords:
  - if-throw-else
  - if throw exception
  - if throw exception java
  - if then else exception
  - if throw else exception
---

This is the code I could never understand:

```java
if (x < 0) {
  throw new Exception("X can't be negative");
} else {
  System.out.println("X is positive or zero");
}
```

I have been trying to find a proper metaphor to explain its incorrectness.
Today I finally found it.

<!--more-->

If-then-else is a [forking]({% pst 2016/aug/2016-08-10-if-then-else-code-smell %})
mechanism of procedural programming. The CPU
either goes to the left and **then** does something or goes to the right and
does something **else**. Imagine yourself driving a car and seeing this sign:

{% figure /images/2015/01/if-then-throw-1.png 500 %}

It looks logical, doesn't it? You can go in the left lane if you're not driving a truck.
Otherwise you should go in the right lane. Both lanes meet up
in a while. No matter which one you choose, you will end up on the same road.
This is what this code block does:

```java
if (x < 0) {
  System.out.println("X is negative");
} else {
  System.out.println("X is positive or zero");
}
```

Now, try to imagine this sign:

{% figure /images/2015/01/if-then-throw-2.png 500 %}

It looks very strange to me, and you will never see this sign anywhere
simply because a dead end means an *end*, a full stop, a finish.
What is the point of drawing a lane
after the dead end sign? There is no point.

This is how a proper sign would look:

{% figure /images/2015/01/if-then-throw-3.png 500 %}

This is how a proper code block would look:

```java
if (x < 0) {
  throw new Exception("X can't be negative");
}
System.out.println("X is positive or zero");
```

The same is true for loops. This is wrong:

```java
for (int x : numbers) {
  if (x < 0) {
    continue;
  } else {
    System.out.println("found positive number");
  }
}
```

While this is right:

```java
for (int x : numbers) {
  if (x < 0) {
    continue;
  }
  System.out.println("found positive number");
}
```

There is no road after the dead end! If you draw it, your code looks
like this very funny snippet I found a few years ago reviewing
sources written by some very well-paid developer in one very serious
company:

```java
if (x < 0) {
  throw new Exception("X is negative");
  System.exit(1);
}
```

Don't do this.
