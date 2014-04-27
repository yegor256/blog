---
layout: post
title: "W3C Java Validators"
date: 2014-04-27
tags: w3c validator
description:
  jcabi-w3c
keywords:
  - w3c validator
  - java w3c validator
  - w3c java validator
  - w3c jigsaw java css validator
  - java w3c jigsaw
  - jigsaw css w3c validator
---

{% badge http://img.jcabi.com/logo-square.png 64 %}

I've made two Java wrappers of W3C validators
([HTML](http://validator.w3.org/) and
[CSS](http://jigsaw.w3.org/css-validator/)) a few years
ago. They seemed to be working fine and were even listed by
W3C on [their website](http://validator.w3.org/docs/api.html)
among other APIs. Until now, these wrappers were
part of [ReXSL](http://www.rexsl.com) library.

A few days ago I took them out of ReXSL and published
as a standalone library &mdash; [jcabi-w3c](http://w3c.jcabi.com). So, it's
a good moment to write a few words about them.

Let's see the example. This is how you can
validate an HTML document against W3C compliancy rules:

{% highlight java linenos=table %}
import com.jcabi.w3c.ValidatorBuilder;
assert ValidatorBuilder.html()
  .validate("<html>hello, world!</html>")
  .valid();
{% endhighlight %}

This `valid()` method is a black or white indicator that
return `false` when the document is not valid. More information
you can get through a list of "defects" returned by W3C server:

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

I think, it is a good practice to validate all of HTML
pages produced by your application against W3C, during
integration testing. It's not a matter of perfectionism,
but a prevention of bigger problems.
