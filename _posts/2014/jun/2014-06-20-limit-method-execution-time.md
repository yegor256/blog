---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Limit Java Method Execution Time"
date: 2014-06-20
tags: java aop
description: |
  Aspect oriented programming with AspectJ and jcabi-aspects can
  help you to control maximum execution time for any single Java method
keywords:
  - aop java
  - limit method execution time java
  - java limit method execution time
  - aspect oriented programming java
  - aop annotations Timeable
  - aop method time annotations
  - aspectj timing
  - aspectj weaving annotations
---

{% badge https://www.jcabi.com/logo-square.svg 64 https://aspects.jcabi.com %}

Say, you want to allow a Java method to work for
a maximum of five seconds and want an exception
to be thrown if the timeframe is exceeded. Here is how
you can do it with [jcabi-aspects](https://aspects.jcabi.com)
and [AspectJ](http://eclipse.org/aspectj/):

```java
public class Resource {
  @Timeable(limit = 5, unit = TimeUnit.SECONDS)
  public String load(URL url) {
    return url.openConnection().getContent();
  }
}
```

<!--more-->

Keep in mind that you should weave your classes after
compilation, as explained [here](https://aspects.jcabi.com/example-weaving.html).

Let's discuss how this actually works, but first,
I recommend you read [this post]({% pst 2014/jun/2014-06-01-aop-aspectj-java-method-logging %}),
which explains how AOP aspects work together with
[Java annotations]({% pst 2016/apr/2016-04-12-java-annotations-are-evil %}).

Due to [`@Timeable`](https://aspects.jcabi.com/annotation-timeable.html)
annotation and class weaving, every call to a method `load()`
is intercepted by an aspect from [jcabi-aspects](https://aspects.jcabi.com).
That aspect starts a new thread that monitors the execution of a method
every second, checking whether it is still running.

If the method runs for over five seconds, the thread
calls [`interrupt()`](http://docs.oracle.com/javase/7/docs/api/java/lang/Thread.html#interrupt%28%29)
on the method's thread.

Despite a very common expectation that a thread should be terminated
immediately on that call, it is not happening at all.
[This article](http://docs.oracle.com/javase/1.5.0/docs/guide/misc/threadPrimitiveDeprecation.html)
explains the mechanism in more detail. Let's discuss it briefly:

  1. [`interrupt()`](http://docs.oracle.com/javase/7/docs/api/java/lang/Thread.html#interrupt%28%29)
    sets a marker in a thread;

  2. The thread checks [`interrupted()`](http://docs.oracle.com/javase/7/docs/api/java/lang/Thread.html#interrupt%28%29)
    as often as it can;

  3. If the marker is set, the thread stops and throws
    [`InterruptedException`](http://docs.oracle.com/javase/7/docs/api/java/lang/InterruptedException.html)

This method will **not** react to `interrupt()` call and will work until JVM is killed (very bad design):

```java
public void work() {
  while (true) {
    // do something
  }
}
```

This is how we should refactor it in order to make
sensitive to interruption requests:

```java
public void work() {
  while (true) {
    if (Thread.interruped()) {
      throw new InterruptedException();
    }
    // do something
  }
}
```

In other words, your method can only stop itself. Nothing else can do it.
The thread it is running in can't be terminated by another thread. The best
thing that the other thread can do is to send your thread a "message"
(through `interrupt()` method) that it's time to stop. If your thread
ignores the message, nobody can do anything.

Most I/O operations in JDK are designed this way. They check the
interruption status of their threads while waiting for I/O resources.

Thus, use `@Timeable` annotation, but keep in mind that there could
be situations when a thread can't be interrupted.
