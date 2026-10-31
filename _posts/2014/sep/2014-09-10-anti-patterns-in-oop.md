---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: Anti-Patterns in OOP
date: 2014-09-10
tags: oop
description: |
  An ideal object-oriented design and architecture doesn't
  have getters and setters, signletons, static methods,
  NULL references and many other anti-patterns
keywords:
  - object-oriented design
  - oop anti-patterns
  - anti-patterns and worst practices
  - anti-patterns java
  - anti-patterns in object-oriented design
---

Here they come:

 * [NULL References]({% pst 2014/may/2014-05-13-why-null-is-bad %})

 * [Utility Classes]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %})

 * [Mutable Objects]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %})

 * [Getters and Setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})

 * [Data Transfer Object (DTO)]({% pst 2016/jul/2016-07-06-data-transfer-object %})

 * [Object-Relational Mapping (ORM)]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %})

 * [Singletons]({% pst 2016/jun/2016-06-27-singletons-must-die %})

 * [Controllers, Managers, Validators]({% pst 2015/mar/2015-03-09-objects-end-with-er %})

 * [Public Static Methods]({% pst 2015/feb/2015-02-20-utility-classes-vs-functional-programming %})

 * [Class Casting]({% pst 2015/apr/2015-04-02-class-casting-is-anti-pattern %})

 * [Traits and Mixins]({% pst 2017/mar/2017-03-07-traits-and-mixins %})

<!--more-->

Avoid them at all cost. Check
[this list]({% pst 2014/apr/2014-04-27-typical-mistakes-in-java-code %})
and [this one]({% pst 2016/feb/2016-02-03-design-patterns-and-anti-patterns %})
too.
