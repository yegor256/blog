---
layout: post
title: "Enrich an Exception On Every Re-throw"
date: 2015-10-26
place: San Jose, CA
tags: java
description:
  ...
keywords:
  - rethrow exception
  - rethrow exception java
  - rethrow exception c++
  - rethrow exception scala
  - rethrow exception with new message
---

I keep repeating the same mistake again and again. It's time to
stop and make a rule, to prevent this from happening. The mistake
is fatal, but very annoying. I look at production logs and see
something like `"no such file or directory"`. What file? What directory?
What did the server try to do with it? What was going on, a second before
it crashed? There is no answer in the logs, and it's totally my fault.
I just re-throw system exceptions without adding more context to them.
It's time to stop this bad practice.

<!--more-->

Here is what I see in logs, to be more precise:

{% highlight text %}
{% endhighlight %}

This is how my code, the one the produced these log lines, looks:

{% highlight java %}
try {
  file.delete();
} catch (IOException ex) {
  throw new IllegalArgumentException(ex);
}
{% endhighlight %}

That's what I usually do and it's wrong. I re-throw an exception
just because I [have to]({% pst 2015/jul/2015-07-28-checked-vs-unchecked-exceptions %})
&mdash; `IOException` is a checked one, while `IllegalArgumentException` is un-checked.
But

{% highlight java %}
try {
  file.delete();
} catch (IOException ex) {
  throw new IllegalArgumentException(
    String.format("can't delete %s", file),
    ex
  );
}
{% endhighlight %}

