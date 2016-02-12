---
layout: post
title: "Try, Finally, If, Null. Stop This Nonsense!"
date: 2016-02-16
place: Palo Alto, CA
tags: java oop
description:
  Opening a stream inside try/catch block and then
  checking for null in finally is such a typical and
  annoying mistake.
keywords:
  - close stream java
  - java try catch
  - java finally
  - java close stream in finally
  - java close stream try catch
---

There is a very typical mistake in Java "try with resources" scenario,
which I keep seeing in so many code reviews. I just have to write about it.
The

<!--more-->

This is how it looks:

{% highlight java %}
InputStream input = null;
try {
  input = url.openStream();
  // read the stream
} finally {
  if (input != null) {
    input.close();
  }
}
{% endhighlight %}

I wrote already about [`null`]({% pst 2014/may/2014-05-13-why-null-is-bad %})
and its evil nature. Here it comes again. If you just follow the rule
of "not using NULL anywhere ever", this code would need an immediate
refactoring. Its correct version will look like this:
