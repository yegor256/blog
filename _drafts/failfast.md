---
layout: post
title: "Need a Robust Software? Make It Fragile."
date: 2015-08-04
tags: architect
description:
  How to create a robust and failure resistant software
  &mdash; by making it fragile and fail fast.
keywords:
  - fail fast vs fail safe
  - failure resilience
  - fail fast
  - fail safe
  - robust architecture
---

In any software, the goal is to make it stable. We don't want it
to break in front of a user. We also don't want our website to show
"interal application error" instead of a web page. We want our software
to work, not to fail. That's a perfectly valid and logical desire,
but in order to achive that we have to make our software as fragile
as possible. This may sound counter intuitive, but that's the way it is.
The more fragile is your app in development, the more robust it is
in production.

<!--more-->

By fragile I mean [Fail Fast](http://martinfowler.com/ieeeSoftware/failFast.pdf)
phylosophy, which is the opposite to
Fail Safe. I believe you know the difference, but let me remind anyway,
by example. This is Fail Safe:

{% highlight java %}
public int size(File file) {
  if (!file.exists()) {
    return 0;
  }
  return file.length();
}
{% endhighlight %}

The method is supposed to calculate and return file size. It is checking
first, whether the file exists. If it doesn't, the method returns zero. Indeed,
the file is absent, there is no size. We may complain that the file is
absent, but what for? Why making noise? Let's keep it quiet and return zero.
We don't fail, we are trying to keep the app running. This is called Fail Safe.

To the contrary, this is how Fail Fast looks:

{% highlight java %}
public int size(File file) {
  if (!file.exists()) {
    throw new IllegalArgumentException(
      "there is no such file, can't get its length"
    );
  }
  return file.length();
}
{% endhighlight %}

We can't find a file? We don't hide this fact. We make this situation
public and visible. We scream and cry. We throw an exception. We **want** the
app to crash, break and fail, because someone gave us a file that doesn't
exist. We complain and protest. This is called Fail Fast.

Which phylosophy, if we follow it everywhere, will make our software
robust and failure resilient? Only the second one &mdash; the Fail Fast.

Why? Because the sooner and the easier is the failure, the faster it will
be fixed. And the fix will be simpler and also more visible. Fail Fast
is a much better approach for maintability. The code becomes cleaner.
It is much easier to track a failure. All methods are ready to break and throw
an exception on each, even the tinest, problem.

Indeed, in this example, if the method returns zero &mdash; it's not obvious
whether the file exists and its size is actually zero, or it's name is wrong
and it is just not found. Fail Safe approach conceals problems and makes
code less maintainable and that's why difficult to stabilize.

In the beginning, in production, we will have many crashes and errors. But
all of them will be visible and easy to understand. We will fix them,
cover with unit tests. Each fix will make our software more stable
and better covered by tests.

A software designed with Fail Safe approach is mind will look more stable
at the beginning, but will degrade quickly and inevitably. Eventually it will
turn into an unmaintainable mess.

A software designed with Fail Fast approach in mind will crash frequently
at the beginning, but will improve stability on every fix and eventually
will become very stable and robust.

That's why, fragility is the key success factor for robustness.
