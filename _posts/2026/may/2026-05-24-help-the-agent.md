---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Help the Agent to Feel You"
date: 2026-03-24
place: Moscow, Russia
tags: ai architect
description: |
  ...
keywords:
  - ...
  - ...
  - ...
  - ...
  - ...
image: /images/2026/05/crocodile-dundee.jpg
jb_picture:
  caption: Crocodile Dundee (1986) by Peter Faiman
---

Since the release of Opus 4.7 in April, I don't write code by hands anymore.
I only talk to Claude Code.
Not because I'm lazy or don't like coding, but because he is a better programmer than I.
Also faster and much cheaper.
However, for most tasks I can't let it fly solo in an "auto mode."
Because his standards are lower than I would expect even in a junior developer.
He is like Maugli: smart and strong, but rude and clumsy.
My job is to teach him elegance, my way.
And unlike with most developers, with him I can do this.

<!--more-->

{% jb_picture_body %}

I know that he spent the first few months of his life in the wild.
Technically, in GitHub, StackOverflow, and software development blogs and books.
This is where he learned how others code, by looking at billions of lines of code.
Obviously, we can't expect the majority of the lines to be pretty.
We can't even expect them to be correct.

However, while correctness is a verifiable determinstic category, code prettiness is not.
It's not only almost impossible to validate, but may hardly be formulated.
Not only because it's a matter of personal taste, but since it's an emotion, not a algorithm.
You either feel it or you don't.

Let me give you an example by sharing a list of what I'm alergic to in programming:

* The absence of tests
* Knowledge duplication
* Global state
* Mutable object attribures
* Swallowed exceptions
* NULL references
* A class inheriting another class
* Type casting or introspection
* Methods of 100+ lines long
* Functions accepting 10+ arguments
* Compound variable names
* Comments in the code
* Emojis in documentation 😢

This is just a tiny part of what I can call source code _ugly_ for.
I'm sure you agree with a few items, disagree with a few others, and don't understand the rest.
Claude would react similarly if he sees this list.

Functionality goes first, aesthetics next.
This principle we implicitly teach in programming schools.
Claude learned it too by looking at those billions of lines.
If an algorithm doesn't work, no matter how pretty is your code.
This is the philosophy of him and million human programmers.

I believe in the opposite: aesthetics over functionality.
Simply because an elegantly designed software is easier to fix
  than to make a working software elegant.

By a lack of elegance I mean not only inconsistent indentations, while it's an obvious sin.
I also mean lack of modularity, inadequate error handling, inconsistent naming,
  tight coupling, low cohesion, and high complexity.
If you read Code Complete (2004), Object Thinking (2004), and Clean Code (2008),
  you know what I'm talking about.
A software may be correct functionality-wise even if most of the principles are violated.
But it would be an ugly software.
For me and maybe for some of you.
Not for Claude.

A billion Java programs tought him to see source code as a intermediate byproduct
  between user's intent and the computer.
However, I prefer working with programmers
  who see source code as a piece of art, a product by itself.
I expect them to _feel_ the beauty of the code they write.

It's hard to find and recruit such people.
It's even harder to convert a regular programmer who doesn't care to an aesthete.
Unlike most people, Claude Code can be converted.

With the help of carrot-and-stick method, as usual.

The _carrot_ is the `CLAUDE.md` file, the agentic manifesto.
Here is mine, at [this repo][prompt].
In the file I preach to Claude, trying to formulate what a beauty means for me.
It's hard, since I have to stay short in the system prompt.
That's why I sound pretty abrupt, as you can see.

The _stick_ is style checkers and static analyzers.
I used to have them for year in my repositories, but my arsenal was limited.
I was forced to use PMD, Checkstyle, Rubocop, Pylint, and what else the market could provide.
Making own checkers was a complex task which I didn't have time/skills for.
Today, I can make my own checkers, because I have Claude.

A few examples.
Recently I've launched a new version of Qulice, a checker for Java code.
It extends PMD and Checkstyle with 77 additional checkers.
New checkers express my personal taste for Java code,
  which sometimes contradicts with what the community believes is right.

A combination of both, the carrot (manifesto) and the stick (checkers) does the job.
The manifesto inspires Claude to do the right thing.
The checkers punish him for doing wrong things.

Eventually, when the manifesto is inspirational enough and the checkers are strong,
  Claude starts feeling me.
Well, at least that's what it seems.
He appreciates my views and most often doesn't write what may contradict.

I can't imagine a human to react same way.
A few years ago I hired a guy who was one of those who didn't care much about code elegance.
However, he was good with algorithms and knew Java pretty well.
Apparently, he wasn't ready to put aesthetics over functionality.
He quit in two weeks.

Claude doesn't quit.
And he costs just $108 a month.

[prompt]: https://github.com/yegor256/prompt
