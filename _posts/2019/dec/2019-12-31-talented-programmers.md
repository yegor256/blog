---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Talented Programmers, Who Are They?"
date: 2019-12-31
place: Moscow, Russia
tags: management
description: |
  Talent is a rare thing in every profession:
  we don't tolerate the lack of it in music,
  but we keep losing it in programming, unfortunately.
keywords:
  - talent for programming
  - talented programmers
  - programming talent
  - how talented are you
  - talent
image: /images/2019/12/goodfellas.jpg
jb_picture:
  caption: Goodfellas (1990) by Martin Scorsese
---

I'm not talking about those who are
famous, well-paid, or the authors of big and popular products.
They are not necessarily talented, even though their _results_ are outstanding.
Talent is something some of us have as God's gift.
Very few of us... otherwise it would not be called a talent.
We all know what talent looks like in music, sport,
poetry, or the art of acting. We can tell right off the bat who's got it and
who is faking it, no matter how hard they try.
Can we do the same after a short interview with a programmer? I believe we can.

<!--more-->

{% jb_picture_body %}

I decided to read what others are saying about the art of interviewing and
how they suggest we detect the talented among all the other regular
software writers.
[Jeff Attwood](https://blog.codinghorror.com/on-interviewing-programmers/)
suggests paying attention to the person's passion, communication skills,
personal attitude, and the ability to work in a team.
[Joel Spolsky](https://www.joelonsoftware.com/2006/10/25/the-guerrilla-guide-to-interviewing-version-30/)
suggests hiring those who are smart and can get things done.
[Haoyi](https://www.lihaoyi.com/post/HowtoconductagoodProgrammingInterview.html)
gives very detailed instructions for the interviewer with the focus being
on the candidate's ability to write code, discuss problems, reason
about constraints, and be a person we would enjoy working with.

All of these make sense, but it's not about talent.
It's about finding a person who can effectively write and maintain
spaghetti code and be _happy_ about it (maybe with just a little
dose of anti-depressants).

{% quote What exactly is talent? It's an innate need to structure things. %}

Imagine yourself recruiting yet another singer for a choir, which consists
of people who have no ear for music. Would you need talent? I doubt a talented
person would be able to sing in that choir. Well, maybe for a while, if you pay well enough. Just like any
other team in any other industry, most software groups
consist of _average_ code writers, not talented programmers. Modern programming, especially in big
projects, is not about talented individuals, it's about the team work of mediocre
coders. That's why all interview gurus teach us how to find yet
another coder: properly educated, trained, skilled, and ready
to write yet another pack of Spring controllers. And, of course, enjoy it.

But sing? No.

So, what exactly is talent?

It's an innate need to _structure_ things.

Just like a musician, a talented programmer _physically_ can't tolerate
what _sounds_ wrong: ambiguity, inconsistency, chaos, irrationality, and
lack of logic. A talented programmer _feels_ these things, while a mediocre
one says "Whatever works!" and gets on with it.

Let me explain by example. Over the last five years I've been using the same
[simple piece of Java code](https://github.com/yegor256/quiz/blob/master/Parser.java)
to interview everybody who is interested in working with me.
I ask them to review it and find what's wrong. Try it now. You have five minutes.

How many issues did you find? Here are the
[answers](https://github.com/yegor256/quiz/wiki/java-answers). There is
a prioritized list of defects I expect candidates to find. The most important
are at the top---they are about _structural_ problems in the code. Mediocre
developers are used to working with bad code and can easily put up with it.
The class name is `Parser`, but it has `get` and `save` methods? Who cares,
as long as it works! The pair of methods is not `get` and `set`, but `get` and ...
all of a sudden `save`? Who cares, it works anyway! And so on. Mediocre
programmers don't feel _annoyed_ when they meet inconsistencies. Just like
people with no ear for music, they _don't hear_ anything wrong!

{% quote A talented programmer constantly demanding discipline and consistency looks like a crazy OCD patient. %}

When I interview programmers, I don't pay attention to how much they know
about Java, how well they understand OOP, or how many projects they've
managed to complete to date. And, of course, I don't care
how potentially likable they are. Instead, I pay attention to how much they _hate_
to see what doesn't look right. I check how _intolerant to chaos_ they are.
This is what my Java test is for.

To be honest, very few of them exhibit these qualities.

And that's because very few projects (and project managers) need these qualities.
Most processes and codebases are poorly structured.
Any sign of intolerance of that structure, or honest attempts to introduce some discipline,
only annoys mediocre programmers, who are always in the majority.
A talented programmer constantly demanding discipline and
consistency looks like a crazy
[OCD patient](https://en.wikipedia.org/wiki/Obsessive%E2%80%93compulsive_disorder).
Nobody understands what's wrong and simply ignores him/her, at best.
Moreover, bad coding practices coming from popular frameworks
and poor management principles are encouraged by Agile and its coaches.
They train us to have no ear for high quality in programming.

The market's demand now is mediocrity, not talent.

Thus, don't worry if you feel that you don't have much of
a talent---in most projects you will be far better off without it.

Unfortunately.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Do you think you have a <a href="https://twitter.com/hashtag/talent?src=hash&amp;ref_src=twsrc%5Etfw">#talent</a> for programming?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1213642929845293058?ref_src=twsrc%5Etfw">January 5, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
