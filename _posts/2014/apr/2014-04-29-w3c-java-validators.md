---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "W3C Java Validators"
date: 2014-04-29
tags: java jcabi
place: Amsterdam, Holland
description: |
  The article explains how to use jcabi-w3c,
  which is a Java adapter of W3C online validators,
  for HTML and CSS
keywords:
  - w3c validator
  - w3c validator java example
  - w3c validator java library
  - java w3c validator
  - w3c java validator
  - w3c jigsaw java css validator
  - java w3c jigsaw
  - jigsaw css w3c validator
---

{% badge https://www.jcabi.com/logo-square.svg 64 http://w3c.jcabi.com %}

A few years ago, I created two Java wrappers for W3C validators: ([HTML](http://validator.w3.org/) and
[CSS](http://jigsaw.w3.org/css-validator/)).
Both wrappers seemed to be working fine and were
even listed by W3C on [their website](http://validator.w3.org/docs/api.html)
in the API section. Until recently, these wrappers have
always been part of [ReXSL](https://github.com/yegor256/rexsl) library.

A few days ago, though, I took the wrappers out of ReXSL
and published them as a standalone library---[jcabi-w3c](http://w3c.jcabi.com). Consequently, now seems
to be a good time to write a few words about them.

Below is an example that demonstrates how you can validate
an HTML document against W3C compliance rules:

```java
import com.jcabi.w3c.ValidatorBuilder;
assert ValidatorBuilder.html()
  .validate("<html>hello, world!</html>")
  .valid();
```

<!--more-->

The `valid()` method is a black or white indicator that
returns `false` when the document is not valid. Additionally,
you can obtain more information through a list of "defects" returned by the W3C server:

```java
Collection<Defect> defects = ValidatorBuilder.html()
  .validate("<html>hello, world!</html>")
  .errors();
```

The same can be done with CSS:

```java
Collection<Defect> defects = ValidatorBuilder.css()
  .validate("body { font-family: Arial; }")
  .errors();
```

Personally, I think it is a good practice to validate all
of HTML pages produced by your application against W3C during
integration testing. It's not a matter of seeking perfection,
but rather of preventing bigger problems later.

These dependencies are mandatory when using jcabi-w3c
(get their latest versions in [Maven Central](http://search.maven.org/)):

```xml
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-w3c</artifactId>
</dependency>
<dependency>
  <groupId>org.glassfish</groupId>
  <artifactId>javax.json</artifactId>
</dependency>
<dependency>
  <groupId>com.sun.jersey</groupId>
  <artifactId>jersey-client</artifactId>
</dependency>
<dependency>
  <groupId>org.hamcrest</groupId>
  <artifactId>hamcrest-core</artifactId>
</dependency>
```
