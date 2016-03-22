---
layout: post
title: "Try. Finally. If. Null."
date: 2016-02-16
place: Palo Alto, CA
tags: java oop
description:
  Opening a resource inside a try/catch block and then
  finally checking for null is such a typical and
  annoying mistake.
keywords:
  - close stream java
  - java try catch
  - java finally
  - java close stream in finally
  - java close stream try catch
---

There is a very typical mistake in pre-Java7 "try/finally" scenario,
which I keep seeing in so many code reviews. I just have to write about it.
Java7 introduced a solution, but it doesn't cover all situations.
Sometimes we need to deal with non-AutoCloseable resources. Let's
open and close them correctly, please.

<!--more-->

This is how it looks (assuming we are in Java 6):

{% highlight java %}
InputStream input = null;
try {
  input = url.openStream();
  // reads the stream, throws IOException
} catch (IOException ex) {
  throw new RuntimeException(ex);
} finally {
  if (input != null) {
    input.close();
  }
}
{% endhighlight %}

I already wrote about [`null`]({% pst 2014/may/2014-05-13-why-null-is-bad %})
and its evil nature. Here it comes again. If you just follow the rule
of "not using NULL anywhere ever," this code would need an immediate
refactoring. Its correct version will look like this:

{% highlight java %}
final InputStream input = url.openStream();
try {
  // reads the stream, throws IOException
} catch (IOException ex) {
  throw new RuntimeException(ex);
} finally {
  input.close();
}
{% endhighlight %}

There is no `null` anymore and it's very clean. Isn't it?

There are situations when opening the resource itself throws `IOException`
and we can't put it outside of `try/catch`. In that case, we have to have
**two** `try/catch` blocks:

{% highlight java %}
final InputStream input;
try {
  input = url.openStream();
} catch (IOException ex) {
  throw new RuntimeException(ex);
}
try {
  // reads the stream, throws IOException
} catch (IOException ex) {
  throw new RuntimeException(ex);
} finally {
  input.close();
}
{% endhighlight %}

But there should be no `null`, never!

The presence of `null` in Java code is a clear indicator of code smell. Something
is not right if you have to use `null`. The only place where the presence of `null`
is justified is where we're using third-party APIs or JDK. They may return
`null` sometimes because... well, their design is bad. We have
no other option but to do `if(x==null)`. But that's it. No other places
are good for `null`.

