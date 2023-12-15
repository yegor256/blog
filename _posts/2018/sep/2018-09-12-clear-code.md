---
layout: post
title: "Code Must Be Clean. And Clear."
date: 2018-09-12
place: Odessa, Ukraine
tags: maintainability
description: |
  Making code anti-pattern-free is very important for its
  quality, but even more important is to make it easy
  to modify for total strangers.
keywords:
  - clean code
  - clear code
  - maintainability
  - code maintainability
  - how to keep maintainability of code
image: /images/2018/09/rum-diary.jpg
jb_picture:
  caption: The Rum Diary (2011) by Bruce Robinson
---

There is a famous book by Robert Martin called [_Clean Code_](https://amzn.to/2m7LmaA).
The title is an obvious call to all of us: the code must be _clean_. Clean, like a kitchen,
I suppose---there are no dirty dishes, no garbage on the floor, no smelly
towels. Dirt to be cleaned in a code base, according to Martin, includes
large methods, non-descriptive variable names, tight coupling, lack of
[SOLID]({% pst 2017/mar/2017-03-28-solid %})
and [SRP]({% pst 2017/dec/2017-12-19-srp-is-hoax %}) compliance,
and many other things. Read the book, it's worth it. However,
there is yet another aspect of source code. How _clear_ is it?

<!--more-->

{% jb_picture_body %}

The kitchen is clean when there is no dirt in the oven. But if its electric panel
speaks French, I can't use the kitchen. Even if it's perfectly clean.
It's not _clear_ how to use it---that's why it's useless.

{% youtube 9tC7p2UTLsU %}

The metaphor applies to the source code. Making it clean is the first
and very important step, which will remove all those coding anti-patterns
so many books speak about, including my favorite
[_Code Complete_](https://amzn.to/2cs4cXW) by Steve McConnell,
[_Working Effectively With Legacy Code_](https://amzn.to/1SdcZ8M)
by Michael Feathers, and
[_Clean Code_](https://amzn.to/2m7LmaA).
A very important step, but not the most important one.
A dirty kitchen that is useful is better than a clean one that I can't use, isn't it?

Making code clean but leaving it difficult to understand by others is the
pitfall most of us fall for. By _others_ I mean everybody, from
our fellow in-project co-developers sitting next to us at the same desk, to
imaginative junior contributors who will join the project in five years after
we're all hired by Google. All of them, across this very large time frame, must
be able to use the ~~kitchen~~ source code without any additional help.
The oven has to speak their language. Not the language of its designer.

How do you do that? How do you make sure the code is clear, not just clean?

{% quote If a stranger can modify your code and fix a bug in less than an hour, it is maintainable. %}

Well, test it. Ask someone who is outside of the project to take a look
at your code and tell you how clear it is. Not how beautiful your classes
and code constructs are---that's what makes it clean. Instead, ask someone to
fix a bug in just 30 minutes and see how they react. You will realize
how clear the code is and whether it speaks the language a _stranger_
can understand.

This is the definition of maintainability. If a stranger can _modify_ your
code and fix a bug in less than an hour, it is maintainable. Obviously,
cleanliness will help. But it's not enough. There has to be something
else, which I don't really know how to describe. The only way to achieve
it is to let strangers regularly see your code, attempt to make a
contribution, and report bugs when something is not _clear_.

Making your code open and encouraging programmers to report bugs when
something is not only broken but unclear---are the best two ways to achieve
high maintainability.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">How do you feel when your buddy says that your code is crap? <a href="https://twitter.com/hashtag/codeahead?src=hash&amp;ref_src=twsrc%5Etfw">#codeahead</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1071662601883607040?ref_src=twsrc%5Etfw">December 9, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
