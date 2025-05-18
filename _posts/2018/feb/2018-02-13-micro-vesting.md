---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Microvesting"
date: 2018-02-13
place: Moscow, Russia
tags: business zerocracy
description: |
  At early stages in most startups programmers work
  for shares instead of cash; here is how Zerocracy
  helps you distribute shares automatically in small increments.
keywords:
  - vesting
  - startup vesting
  - vesting increments
  - vesting instant
  - vesting zerocracy
image: /images/2018/02/la-comunidad.jpg
jb_picture:
  caption: La comunidad (2000) by Álex de la Iglesia
---

Most startups don't have enough cash to pay programmers as much as
they deserve, [unfortunately]({% pst 2016/jan/2016-01-12-good-programmers-dont-work-for-equity %})
(or maybe not). Instead of cash, startups give their early employees
[shares of stock](https://en.wikipedia.org/wiki/Stock#Shares), which they will be able to either 1)
sell in a few years and become ~~millionaires~~ billionaires,
or 2) throw away and remain nobodies. It's a
[common practice](https://www.quora.com/Do-founders-vest/answer/Charlie-Cheever).
The question, however, is what
is the right procedure, and the optimal algorithm, to transfer those shares to programmers.
When exactly do they become shareholders? What is the formula?

<!--more-->

{% jb_picture_body %}

There are a few typical approaches.

One of the most [popular](https://www.feld.com/archives/2005/05/term-sheet-vesting.html) is
"[four years with a one-year cliff](https://thenextweb.com/entrepreneur/2013/07/21/startup-founders-heres-why-vesting-is-your-best-friend/),"
which means that if they had 50% equity and leave after two years
they will only retain 25%. The longer they stay, the larger the percentage of
their equity that will be vested until they become fully vested in the 48th month.
However, because they have a one year cliff, if they leave before the 12th month,
they get nothing. There could be
[slight modifications](https://medium.com/@ipaullee/let-s-revise-the-vesting-schedule-for-startup-founders-and-employees-7817fcb301ea)
to the numbers, of course.

{% quote Most vesting formulas are perfectly aligned with the popular "be nice" paradigm and is not beneficial, either to the company or to its slaves. %}

The disadvantage of this approach is that their primary motivation is
to stay in the company, instead of achieving results. This vesting
formula is perfectly aligned with the popular
[be nice]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %})
paradigm and is not beneficial, either to the company or to
its ~~slaves~~ employees.

Another option is [milestone-based](https://techcrunch.com/2015/12/09/milestone-based-vesting-for-startup-founders/)
vesting, which defines a set of value milestones, each of which unlocks
an additional part of the programmer's equity.

On top of the [inability](https://medium.com/swlh/why-milestone-based-agreements-are-bad-for-early-stage-startups-15c759995121)
to predict milestones accurately, this vesting formula
promotes group responsibility, which, in my opinion,
is [the least]({% pst 2015/nov/2015-11-21-ringelmann-effect-vs-agile %})
effective way to motivate. Programmers writing Java classes can't be
responsible for the "next round of VC funding," simply because they
don't have any idea how to make that round happen. It's not their job,
not their responsibility.

You may say that writing those Java classes is exactly how we make the next
round happen, but it's far from being true, in most cases. We all know that
investments come to those who can ~~fool~~
[pitch]({% pst 2016/mar/2016-03-28-unspoken-secrets-of-elevator-pitch %}) an investor,
not to those who write the best Java code. Thus, the work programmers do
and the "value events" the startup is aiming to reach are pretty much disconnected.

{% quote Using microvesting with valuation and hourly rate the company can influence programmers' motivation. %}

A more logical formula is _microvesting_, which we practice in projects managed
by [Zerocracy](https://www.zerocracy.com). It is as simple as that: A company has
a valuation, which is set by its founders; let's say, it's $1,000,000. A programmer
has an hourly rate, say, $40. Thus, when a [one-hour]({% pst 2017/nov/2017-11-28-microtasking %})
[fixed-budget]({% pst 2018/jan/2018-01-09-micro-budgeting %}) task is completed, the
programmer earns 0.004% of equity ($40 / $1,000,000). Our software calculates
it all automatically, increasing their shares after each completed task.

Using these two variables---valuation and hourly rate---the company
can influence programmers' motivation.

No need to [lie]({% pst 2015/mar/2015-03-02-team-morale-myths-and-reality %}) to
them about big-money milestones or keep them in the office
for four years. Just let them be focused on the results they can produce and
give them back what they deserve. Incrementally. That's it.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Does your company need your work results? <a href="https://twitter.com/hashtag/motivation?src=hash&amp;ref_src=twsrc%5Etfw">#motivation</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1206231040437686279?ref_src=twsrc%5Etfw">December 15, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
