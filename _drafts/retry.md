---
layout: post
title: "Retry Java Method Call"
date: 2014-08-12
tags: jcabi java aop
description: |
  @RetryOnFailure annotation from jcabi-aspects allows
  you to retry a Java method call a few times before 
  implementing an exception
keywords:
  - java retry method call
  - retry method call in java
  - aop retry method call
  - aspectjs retry method call
  - java method re-run
---

{% badge http://img.jcabi.com/logo-square.svg 64 http://aspects.jcabi.com %}

If you have a method that fails occasionally and
you want to retry it a few times before throwing
an exception. [`@RetryOnFailure`](http://aspects.jcabi.com/annotation-retryonfailure.html) from
[jcabi-aspects](http://aspects.jcabi.com) can help.
For example, if you're downloading the following web page:

{% highlight java %}
@RetryOnFailure(attempts = 3, delay = 10, unit = TimeUnit.SECONDS)
public String load(URL url) {
  return url.openConnection().getContent();
}
{% endhighlight %}

This method call will throw an exception only after three
failed executions within a ten second interval.

<!--more-->

[This post]({% post_url 2014/jun/2014-06-01-aop-aspectj-java-method-logging %})
explains how [jcabi-aspects](http://aspects.jcabi.com)
works with binary weaving. This mechanism integrates AspectJ with
your code.

When method `load()` from the example above is called, this is what
is happening behind the scene (pseudo-code):

{% highlight java %}
while (attempts++ < 3) {
  try {
    return original_load(url);
  } catch (Throwable ex) {
    log("we failed, will try again in 10 seconds");
    sleep(10);
  }
}
{% endhighlight %}

This approach may be very useful in the following situations
(based on my experience):

 * Executing JDBC `SELECT` statements

 * Loading data from HTTP, S3, FTP, etc resources

 * Uploading data over the network

 * Fetching data through RESTful stateless APIs

The project is in [Github](https://github.com/jcabi/jcabi-aspects).
