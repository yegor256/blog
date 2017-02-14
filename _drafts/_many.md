---
layout: post
title: "When Too Many Classes Is a Problem"
date: 2017-01-10
place: Odessa, Ukraine
tags: oop
description: |
  Very often I hear that too many classes in
  object-oriented design is a problem; let's investigate
  when this may happen and how to avoid it.
keywords:
  - too many classes
  - OOP classes
  - class names in OOP
  - naming classes in OOP
  - many classes
image: ...
jb_picture:
  caption: ...
---

In almost [every presentation](/talks.html) where I'm explaining
[my view]({% pst 2016/jul/2016-07-14-who-is-object %})
of [object-oriented programming]({% pst 2016/aug/2016-08-15-what-is-wrong-object-oriented-programming %})
there is always someone with a comment:
"If we follow your advice we will have so many small classes."
And my answer is always the same: "Of course we will and it's great!"
I honestly believe that "a lot of classes" is, if not a virtue,
but at least not a drawback of an truly object-oriented code. However,
they may become a problem, let's see when and how.

<!--more-->

{% jb_picture_body %}

There were a number of "rules" mentioned before, which, if applied,
would obviously lead to a big amount of classes, including:
a) all public methods [must be]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}) declared in interfaces;
b) objects must not have more than four attributes (Section 2.1 of [Elegant Objects](/elegant-objects.html));
c) static methods are [not allowed]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %});
d) constructors [must be]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}) code-free;
e) objects must expose less than five public methods (Section 3.1 of [Elegant Objects](/elegant-objects.html)).

The biggest concern, of course, is maintainability: "if instead of 50 longer classes
we would have 300 shorter ones&mdash;the code would be less readable."
This shouldn't happen, but it may. Types (or classes) in OOP constitute
your _thesaurus_, which explains the world around your code&mdash;the
world you can work with. The richer the thesaurus, the more powerful is your
instrument.

clean names
no duplication
no er-s
packaging
suffixes-prefixes




