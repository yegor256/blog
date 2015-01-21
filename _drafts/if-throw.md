---
layout: post
title: "If. Then. Throw. Else. Wtf?"
date: 2015-01-24
tags: java oop
description:
  There is an obvious optimization of If-Then-Else statement
  that throws an exception or exits by Break or Continue, which
  is very often overlooked.
keywords:
  - if-throw-else
  - if throw exception
  - if throw exception java
  - if then else exception
  - if throw else exception
---

This is the code I could never understand:

{% highlight java %}
if (x < 0)
  throw new Exception("X can't be negative");
} else {
  System.out.println("X is positive or zero");
}
{% endhighlight %}

I was trying to find a proper metaphor to explain its incorrectness.
Today I finally found it.

<!--more-->

It-then-else is a forking mechanism of a procedural programming. The CPU
either goes on the left and **then** does something or goes to the right and
does something **else**. Imagine yourself driving a car and seeing this
sign on the road (americans, don't be surprised,
there are many of that blue signs in Europe):

It looks logical, isn't it? You can go to the left lane, if you're not driving a truck. You
should go to the right lane otherwise. Both lanes meet
in a while. No matter which one you chose, you will end up on the same road.
This is what this code block does:

{% highlight java %}
if (x < 0)
  System.out.println("X is negative");
} else {
  System.out.println("X is positive or zero");
}
{% endhighlight %}

Now, can you imagine this sign?:

It looks very strange to me and you will never see this sign anywhere,
simply because a dead end means an *end*, a full stop, a finish.
What is the point of drawing a lane
after the dead end sign? There is no point.

This is how a proper sign would look:

This is how a proper code block would look:

{% highlight java %}
if (x < 0)
  throw new Exception("X can't be negative");
}
System.out.println("X is positive or zero");
{% endhighlight %}

The same is true for loops. This is wrong:

{% highlight java %}
for (int x : numbers) {
  if (x < 0) {
    continue;
  } else {
    System.out.println("found positive number");
  }
}
{% endhighlight %}

While this is right:

{% highlight java %}
for (int x : numbers) {
  if (x < 0) {
    continue;
  }
  System.out.println("found positive number");
}
{% endhighlight %}

There is no lane after the dead end! If you draw it, your code looks
like this very funny snippet I've found a few years ago reviewing
sources written by some very well-paid developer in one very serious
company:

{% highlight java %}
if (x < 0) {
  throw new Exception("X is negative");
  System.exit(1);
}
{% endhighlight %}

Don't do this.

