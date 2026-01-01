---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Cache Java Method Results"
date: 2014-08-03
tags: java jcabi aop
description: |
  Caching Java method results is easy with jcabi-aspects,
  a small library that uses AspectJ and Java annotations
keywords:
  - aop caching
  - java aop cache
  - cache java method
  - cache result of java method
  - java method caching
  - java cache method results
  - java method cache annotation
  - "@Cacheable"
---

{% badge https://www.jcabi.com/logo-square.svg 64 https://aspects.jcabi.com %}

Say, you have a method that takes time to execute and you want
its result to be cached. There are [many solutions](https://www.coderanch.com/how-to/java/CachingStrategies),
including
[Apache Commons JCS](http://commons.apache.org/proper/commons-jcs/),
[Ehcache](https://www.ehcache.org),
[JSR 107](https://jcp.org/en/jsr/detail?id=107),
[Guava Caching](https://code.google.com/p/guava-libraries/wiki/CachesExplained)
and many others.

[jcabi-aspects](https://aspects.jcabi.com/annotation-cacheable.html) offers a very simple one,
based on AOP aspects and Java6
[annotations]({% pst 2016/apr/2016-04-12-java-annotations-are-evil %}):

```java
import com.jcabi.aspects.Cacheable;
public class Page {
  @Cacheable(lifetime = 5, unit = TimeUnit.MINUTES)
  String load() {
    return new URL("http://google.com").getContent().toString();
  }
}
```

The result of `load()` method will be cached in memory for five minutes.

<!--more-->

## How It Works?

This post about [AOP, AspectJ and method logging]({% pst 2014/jun/2014-06-01-aop-aspectj-java-method-logging %})
explains how "aspect weaving" works (I highly recommend that you read it first).

Here I'll explain how caching works.

The approach is very straight forward. There is a static hash map with keys
as "method coordinates" and values as their results. Method coordinates consist
of the object, an owner of the method and a method name with parameter types.

In the example above, right after the method `load()`
finishes, the map gets a new entry (simplified example, of course):

```text
key: [page, "load()"]
value: "<html>...</html>"
```

Every consecutive call to `load()` will be intercepted by the aspect
from [jcabi-aspects](https://aspects.jcabi.com) and resolved immediately
with a value from the cache map. The method will not get any control until
the end of its lifetime, which is five minutes in the example above.

## What About Cache Flushing?

Sometimes it's necessary to have the ability to flush cache before
the end of its lifetime. Here is a practical example:

```java
import com.jcabi.aspects.Cacheable;
public class Employees {
  @Cacheable(lifetime = 1, unit = TimeUnit.HOURS)
  int size() {
    // calculate their amount in MySQL
  }
  @Cacheable.FlushBefore
  void add(Employee employee) {
    // add a new one to MySQL
  }
}
```

It's obvious that the number of employees in the database
will be different after `add()` method execution and the
result of `size()` should be invalidated in cache. This invalidation
operation is called "flushing" and `@Cacheable.FlushBefore` triggers it.

Actually, every call to `add()` invalidates all cached methods
in this class, not only `size()`.

There is also `@Cacheable.FlushAfter`. The difference is that
`FlushBefore` guarantees that cache is already invalidated
when the method `add()` starts.
`FlushAfter` invalidates cache after method `add()` finishes. This small difference makes a big one, sometimes.

This article explains [how to add jcabi-aspects to your project](https://aspects.jcabi.com/example-weaving.html).
