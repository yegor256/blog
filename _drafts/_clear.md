---
layout: post
title: "Code Must Be Clean. And Clear."
date: 2018-01-29
place: Odessa, Ukraine
tags: maintainability
description: |
  Making code anti-patterns-free is very important for its
  quality, but even more important is to make it easy
  to modify by total strangers.
keywords:
  - clean code
  - clear code
  - maintainability
  - code maintainability
  - how to keep maintainability of code
image: /images/2018/09/
jb_picture:
  caption:
---

There is a famous book by Robert Martin called [_Clean Code_](http://amzn.to/2m7LmaA).
The title is an obvious call to all of us: the code must be _clean_. Clean, as a kitchen,
I suppose---there are no dirty dishes, no garbage on the floor, no smelly
towels. Dirt to be cleaned in a source code, according to Martin, includes
large methods, non-descriptive variable names, tight coupling, lack of SOLID
and SRP compliance, and many other things; read the book, it's worth it. However,
there is yet another aspect of a source code. How _clear_ is it?

<!--more-->

{% jb_picture_body %}

The kitchen is clean, when there is no dirt in the oven. But if its electric panel
speaks French, I can't use the kitchen. Even if it's perfectly clean.
It's not _clear_ how to use it that's why it's useless.

The metaphor applies to the source code. Making it clean is the first
and a very important step, which will remove all those coding anti-patterns
so many books are speaking about, including my favorite
[_Code Complete_](http://amzn.to/2cs4cXW) by Steve McConnell,
[_Working Effectively With Legacy Code_](http://amzn.to/1SdcZ8M)
by Michael Feathers, and
[_Clean Code_](http://amzn.to/2m7LmaA).
A very important step, but not the most important one.
A dirty kitchen that is useful is better than a clean one that I can't use, isn't it?

Making code clean but remaining it difficult to understand by others is the
pitfall most of us fall for. By _others_ I mean everybody, from
our fellow in-project co-developers sitting next to us at the same desk to
imaginative junior contributors who will join the project in five years after
we all are hired by Google. All of them, at this very large interval, must
be able to use the <del>kitchen</del> source code without any additional help.
The oven has to speak their language. Not the language of its designer.

How do you do that? How do you make sure the code is clear, not only clean?

Well, test it. Ask someone who is outside of the project to take a look
at your code and tell you how clear it is. Not how beautiful your classes
and code constructs are---that's what makes it clean. Instead, ask someone to
fix a bug in just 30 minutes and see how they react. You will realize
how clear is the code and whether it speaks the language a _stranger_
can understand.

This is the definition of maintainability. If a stranger can _modify_ your
code and fix a bug in less than an hour, it is maintainable. Obviously,
cleannessness will help. But it's not enough. There has to be something
else, which I don't really know how to describe. The only way to achieve
it is to let strangers regularly touch your code, attempt to make
contribution, and report bugs when something is not _clear_.

Making your code open and encouraging programmers to report bugs when
something is not only broken but unclear---are the best two ways to achieve
high maitainability.
