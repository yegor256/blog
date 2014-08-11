---
layout: post
title: Why Static Analysis Is So Annoying
date: 2014-04-20
tags: quality
description:
  For most of XDSD newcomers static analysis looks
  too strict and annoying, while we think that it
  is still too loose
keywords:
  - static analysis
  - pre-flight builds
  - static quality control
  - java static analysis
  - static analysis ci
---

Code formatting is a headache, it takes too much time, any ideas?

Well, we believe that properly formatted code (also called “clean code”) is of a
very big importance in any software development project. And it’s not only about
indentations and braces. Our static analysis instruments are rather complex and
strict, which may surprise you when you start working with us. What may also
surprise you is that we don’t merge your code into master until it passes all
quality controls. Most software teams don’t take static analysis that seriously.
We do.

You may also wonder, why don’t we provide IDE plugins, which would re-format
dirty code to make it clean. The reason is that we want our code to be written
with care by people who understand every quality rule we enforce, by heart :)
Seriously, we want you to share our passion about quality, and follow our
standards.

Well, maybe these IntelliJ IDEA settings may help you:
[idea-settings.jar](http://img.tpc2.com/idea-settings.jar)

Just give it some time, you will love quality like we do.
