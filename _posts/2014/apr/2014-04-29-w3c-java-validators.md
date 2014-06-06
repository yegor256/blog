---
layout: post
title: "W3C Java Validators"
date: 2014-04-29
tags: w3c validator
description:
  The article explains how to use jcabi-w3c,
  which is a Java adapter of W3C online validators,
  for HTML and CSS
keywords:
  - w3c validator
  - java w3c validator
  - w3c java validator
  - w3c jigsaw java css validator
  - java w3c jigsaw
  - jigsaw css w3c validator
---

{% badge http://img.jcabi.com/logo-square.png 64 %}

A few years ago, I created two Java wrappers for W3C validators: ([HTML](http://validator.w3.org/) and
[CSS](http://jigsaw.w3.org/css-validator/)).
Both wrappers seemed to be working fine and were
even listed by W3C on [their website](http://validator.w3.org/docs/api.html)
in the API section. Until recently, these wrappers have
always been part of [ReXSL](http://www.rexsl.com) library.

A few days ago, though, I took the wrappers out of ReXSL
and published them as a standalone library &mdash;
[jcabi-w3c](http://w3c.jcabi.com). Consequently, now seems
to be a good time to write a few words about them.

Below is an example that demonstrates how you can validate
an HTML document against W3C compliancy rules:

{% highlight java linenos=table %}
import com.jcabi.w3c.ValidatorBuilder;
assert ValidatorBuilder.html()
  .validate("<html>hello, world!</html>")
  .valid();
{% endhighlight %}

The `valid()` method is a black or white indicator that
returns `false` when the document is not valid. Additionally,
you can obtain more information through a list of "defects" returned by the W3C server:

{% highlight java linenos=table %}
Collection<Defect> defects = ValidatorBuilder.html()
  .validate("<html>hello, world!</html>")
  .errors();
{% endhighlight %}

The same can be done with CSS:

{% highlight java linenos=table %}
Collection<Defect> defects = ValidatorBuilder.css()
  .validate("body { font-family: Arial; }")
  .errors();
{% endhighlight %}

Personally, I think it is a good practice to validate all
of HTML pages produced by your application against W3C during
integration testing. It's not a matter of seeking perfection,
but rather of preventing bigger problems later.

These dependencies are mandatory when using jcabi-w3c:

{% highlight xml %}
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-w3c</artifactId>
  <version>1.0</version>
</dependency>
<dependency>
  <groupId>org.glassfish</groupId>
  <artifactId>javax.json</artifactId>
  <version>1.0.4</version>
</dependency>
<dependency>
  <groupId>com.sun.jersey</groupId>
  <artifactId>jersey-client</artifactId>
  <version>1.18.1</version>
</dependency>
<dependency>
  <groupId>org.hamcrest</groupId>
  <artifactId>hamcrest-core</artifactId>
  <version>1.3</version>
</dependency>
{% endhighlight %}
