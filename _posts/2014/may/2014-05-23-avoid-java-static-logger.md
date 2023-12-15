---
layout: post
title: "Get Rid of Java Static Loggers"
date: 2014-05-23
tags: java jcabi
description: |
  Using static logger is a very common practice in Java,
  which pollutes the code and is a noise, which can
  easily be eliminated by using jcabi-log
keywords:
  - java logging
  - java static logger
  - java slf4j
  - java log4j
  - java util logging
  - java static logger property
  - simple logging java
---

This is a very common practice in Java
(using [`LoggerFactory`](https://www.slf4j.org/apidocs/org/slf4j/LoggerFactory.html)
from [slf4j](https://www.slf4j.org/)):

```java
import org.slf4j.LoggerFactory;
public class Foo {
  private static final Logger LOGGER =
    LoggerFactory.getLogger(Foo.class);
  public void save(String file) {
    // save the file
    if (Foo.LOGGER.isInfoEnabled()) {
      Foo.LOGGER.info("file {} saved successfuly", file);
    }
  }
}
```

What's wrong with it? Code duplication.

<!--more-->

This static `LOGGER` property has to be declared in every class
where logging is required. Just a few lines of code, but
this is pure noise, as I see it.

{% badge https://www.jcabi.com/logo-square.svg 64 https://log.jcabi.com %}

To make life easier, I created a library about two years
ago, [jcabi-log](https://log.jcabi.com), which has a convenient
utility class [`Logger`](https://log.jcabi.com/apidocs-0.12.2/com/jcabi/log/Logger.html)
(yes, I know that [utility classes are evil]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %})).

```java
import com.jcabi.log.Logger;
public class Foo {
  public void save(String file) {
    // save the file
    Logger.info(this, "file %s saved successfuly", file);
  }
}
```

This looks much cleaner to me and does exactly
the same---sends a single log line to the SLF4J
logging facility. Besides, it check automatically whether a given logging
level is enabled (for performance optimization) and formats the
given string using [`Formatter`](http://docs.oracle.com/javase/7/docs/api/java/util/Formatter.html)
(same as [`String.format()`](http://docs.oracle.com/javase/7/docs/api/java/lang/String.html#format%28java.lang.String,+java.lang.Object...%29)).

For convenience, there are also a number of "[decors](https://log.jcabi.com/decors.html)"
implemented in the library.

The library ships as a JAR dependency in
[Maven Central](https://repo1.maven.org/maven2/com/jcabi/jcabi-log)
(get its latest versions in [Maven Central](http://search.maven.org/)):

```xml
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-log</artifactId>
</dependency>
```
