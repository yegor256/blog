---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Help the Agent to Feel"
date: 2026-05-29
place: Moscow, Russia
tags: ai architect
description: |
  Claude Code programs better than me but with no taste,
  so I train it to feel my sense of code beauty
  through a CLAUDE.md manifesto and custom style checkers.
keywords:
  - AI coding agents
  - Claude Code
  - code aesthetics
  - CLAUDE.md manifesto
  - custom style checkers
image: /images/2026/05/crocodile-dundee.jpg
jb_picture:
  caption: Crocodile Dundee (1986) by Peter Faiman
---

Since the [release of Opus 4.7] in April, I don't write code by hand anymore.
I only talk to [Claude Code].
Not because I'm lazy or don't like coding, but because he is a better programmer than I.
Also faster and much cheaper.
However, for most tasks I can't let it fly solo in an "[auto mode]."
Because his standards are lower than I would expect even in a junior developer.
He is like [Mowgli]: smart and strong, but rude and clumsy.
My job is to teach him elegance, my way.
And unlike with most developers, with him I can do this.

<!--more-->

{% jb_picture_body %}

I know that he spent the first few months of his life in the wild.
Technically, in GitHub, StackOverflow, and software development blogs and books.
This is where he learned how others code, by looking at billions of lines of code.
Obviously, we can't expect most of the lines to be pretty.
We can't even expect them to be correct.

However, while correctness is a verifiable deterministic category, code prettiness is not.
It's not only almost impossible to validate, but also hard to formulate.
Not only because it's a matter of personal taste, but because it's an _emotion_, not an algorithm.
You either feel it or you don't.

Let me give you an example by sharing a list of what I'm particular allergic to in programming:

* The [absence]({% pst 2015/jul/2015-07-16-fools-dont-write-unit-tests %}) of tests
* Knowledge duplication
* [Global]({% pst 2018/jul/2018-07-03-global-variables %}) state
* [Mutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}) object attributes
* Swallowed exceptions
* [NULL references]({% pst 2014/may/2014-05-13-why-null-is-bad %})
* A class [inheriting]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %}) another class
* Type [casting]({% pst 2015/apr/2015-04-02-class-casting-is-anti-pattern %}) or introspection
* Functions accepting 10+ arguments
* Objects encapsulating 10+ attributes
* [Compound]({% pst 2015/jan/2015-01-12-compound-name-is-code-smell %}) variable names
* [Comments]({% pst 2026/jan/2026-01-11-no-documentation-comments %}) in the code
* Emojis in documentation 😢

This is a tiny part of what I can call source code _ugly_ for.
I'm sure you agree with a few items, disagree with a few others, and don't understand the rest.
Claude would react similarly if he saw this list.

Functionality goes first, aesthetics next.
We implicitly teach this principle in programming schools.
Claude learned it too by looking at those billions of lines.
If an algorithm doesn't work, it doesn't matter how pretty your code is.
This is his philosophy, and that of a million human programmers.

I believe in the opposite: aesthetics over functionality.
Simply because elegantly designed software is easier to fix
  than to make working software elegant.

{% quote In software development I believe in aesthetics over functionality %}

By a lack of elegance I mean not only inconsistent indentation, though that's an obvious sin.
I also mean lack of modularity, inadequate error handling, inconsistent naming,
  tight coupling, low cohesion, and high complexity.
If you read [Code Complete (2004)] and [Object Thinking (2004)], you know what I'm talking about.
Software may be correct functionality-wise even if most of the principles are violated.
But it would be _ugly_ software.
For me and maybe for some of you.
Not for Claude.

A billion Java programs taught him to see source code as an _intermediate byproduct_
  between user's intent and the computer.
However, I prefer working with programmers
  who see source code as a piece of art, a product by itself.
I expect them to _feel_ the beauty of the code they write.

It's hard to find and recruit such people.
It's even harder to convert a regular programmer who doesn't care into an _aesthete_.
Unlike most people, Claude Code can be converted.

With the help of the carrot-and-stick method,
  [as usual]({% pst 2016/sep/2016-09-27-command-control-innovate %}).

The _carrot_ is the `CLAUDE.md` file, the [agentic manifesto].
Here is mine, at [this repo][prompt].
In the file I preach to Claude, trying to formulate what beauty means for me.
It's hard, since I have to stay short in the system prompt.
That's why I sound pretty abrupt, as you can see.

The _stick_ is style checkers and static analyzers.
I used to have them for years in my repositories, but my arsenal was limited.
I was forced to use [PMD], [Checkstyle], [Rubocop], [Pylint], and whatever else the market provided.
Making my own checkers was a complex task that I didn't have the time or skills for.
Today, I can make my own checkers, because I have Claude.

Here is an example.
Recently I've launched a new version of [Qulice], a checker for Java code.
It extends PMD and Checkstyle with 59 additional checkers.
New checkers express my personal taste for Java code,
  which sometimes contradicts what the community believes is right.
Qulice is not a new project.
It's 14 years old.
However, I was only recently able to implement all these additional checkers.
Because I didn't have Claude for 14 years.

Yet another example.
I've been using Rubocop for more than 10 years.
An amazing style checker for Ruby code.
However, it lacks a few important rules that my personal taste demands.
A month ago I implemented [an extension][rubocop-elegant] for Rubocop.
Now I'm fully equipped.
Of course, Claude implemented it, not me.

A combination of both, the carrot (manifesto) and the stick (checkers) does the job.
The manifesto inspires Claude to do the right thing.
The checkers punish him for doing wrong things.
Of course, the checkers cover only the formalizable part of beauty.
Inconsistent indentation, a NULL reference, or a type cast — a tool can catch these.
Tight coupling, low cohesion, or clumsy error handling — no checker can feel them (so far!).
That heavier half stays on the manifesto.

When the manifesto is inspirational and the checkers are strong, Claude starts "feeling" me.
Well, at least that's what it seems (or maybe it trully does feel me?!).
He appreciates my views and rarely writes anything that contradicts them.
When he does, the checkers punish him, and he [remembers][claude-mem].

I can't imagine a human reacting the same way.
A few years ago I hired a guy who didn't care much about code elegance.
However, he was good with algorithms and knew Java pretty well.
Apparently, he wasn't ready to put aesthetics over functionality.
He quit in two weeks.

Claude doesn't quit.
And he costs just $108 a month.

[prompt]: https://github.com/yegor256/prompt
[rubocop-elegant]: https://github.com/yegor256/rubocop-elegant
[claude-mem]: https://github.com/thedotmack/claude-mem
[PMD]: https://pmd.github.io
[Checkstyle]: https://checkstyle.org
[Rubocop]: https://rubocop.org
[Pylint]: https://pylint.readthedocs.io
[Qulice]: https://www.qulice.com
[Mowgli]: https://en.wikipedia.org/wiki/Mowgli
[Claude Code]: https://github.com/anthropics/claude-code
[release of Opus 4.7]: https://www.anthropic.com/news/claude-opus-4-7
[auto mode]: https://code.claude.com/docs/en/auto-mode-config
[Code Complete (2004)]: https://jttu.net/mcconnell2004code
[Object Thinking (2004)]: https://jttu.net/west2004object
[agentic manifesto]: https://www.agenticmanifesto.org/
[carrot-and-stick]: https://en.wikipedia.org/wiki/Carrot_and_stick
