---
layout: post
title: "EO"
date: 2016-11-14
tags: oop
place: Tallinn, Estonia
description: |
  EO is a new object-oriented programming language
  we started designing a few days ago; we're looking for your
  contribution.
keywords:
  - eolang
  - EO language
  - EO programming language
  - OO language
  - object-oriented language
---

It's time to do it! We've started work on a new programming language. Its
name is **EO** (as in "Elegant Objects"): [eolang.org](http://www.eolang.org).
It's open source and community driven:
[yegor256/eo](https://github.com/yegor256/eo) GitHub repo. It's still in
very early draft form, but the direction is more or less clear: It has to be
truly object-oriented, with no compromises. You're welcome to join us.

<!--more-->

Why yet another language? Because there are no object-oriented languages
on the market that are really object-oriented, to my knowledge. Here are the
things I think do not belong in a pure object-oriented language:

  * static methods
  * classes (only types and objects)
  * implementation inheritance
  * mutability
  * NULL
  * reflection
  * constants
  * type casting
  * annotations
  * operators (`for`, `while`, `if`, etc.)

And many other minor mistakes that Java and C++ are full of.

At the moment, we think that EO will compile into Java. Not into byte-code,
but into `.java` files, later compilable to byte-code.

I really count on your contribution. Please submit your ideas as
tickets and pull request to the
[yegor256/eo](https://github.com/yegor256/eo) GitHub repo.
