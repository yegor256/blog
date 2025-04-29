---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Trust Them to Get the Job Done, ... Not!"
date: 2019-05-28
place: Moscow, Russia
tags: management agile
description: |
  Treating programmers in a binary way as either trustable or not is a typical
  mistake of a weak manager, which leads to fear and chaos
  in a team.
keywords:
  - agile
  - punishment
  - rewards
  - bonuses
  - trust
image: /images/2019/05/metro-manila.jpg
jb_picture:
  caption: Metro Manila (2013) by Sean Ellis
book: code-ahead-1 3.1
---

There are [twelve]({% pst 2016/jul/2016-07-11-mistakes-in-agile-manifesto %})
principles in the [Agile Manifesto](http://agilemanifesto.org/principles.html).
The fifth one says: "Build projects around motivated individuals.
Give them the environment and support they need,
and trust them to get the job done."
I disagree. Strongly. This formula suggests treating people in a binary way: they
are either motivated and trusted or ... what? They have to be let go?
This mindset is very typical, according to my observations, and leads
to [poor management]({% pst 2017/nov/2017-11-21-trust-pay-lose %}) and project failures.
Instead, our people management must be more _iterative_ and much less _rigid_.

<!--more-->

{% jb_picture_body %}

Just a few days ago I posted a [quote](https://www.instagram.com/p/Bx6gJAngsT5/) from
[_Code Ahead_](/code-ahead.html), my recent book about
software engineering, on Instagram. I've got an interesting and very typical
response from one of my readers (polished a bit):

> Why should I get punished in the first place;
  if my mistake is unforgiven they should fire me, and I believe this
  is less humiliating than getting punished and then staying with them.

This is what I hear almost always when I start talking about rewards and
punishment in a software team. I hear that it is _humiliating_ and
programmers should _never_ be punished. Instead, as [Samir](https://www.instagram.com/samir.bouazza.2017/)
suggested, they should be fired when they make
an _unforgiven_ mistake. Thus, we either trust them 100% or, when a mistake
happens, we ... fire the bloody bastard, he was useless anyway!

Well, maybe this is part of human nature: First we love, then we hate, and
[the stronger we love, the stronger we hate](https://drhurd.com/2018/04/29/stronger-love-stronger-hate/).
But what do these emotions have to do with professional
[project management]({% pst 2016/may/2016-05-24-who-is-project-manager %})?

As [William Edwards Deming](https://en.wikipedia.org/wiki/W._Edwards_Deming)
suggested many years ago, good management is always about a simple
[Plan-Do-Check-Act](https://en.wikipedia.org/wiki/PDCA) cycle.
No matter what and who we manage, we have to _plan_ first,
let ourselves and our people _do_ the work, then _check_ what the results look like, comparing
them with our plans, and finally _act_ according to the findings, correcting
the plans. Then, we go back to the planning part and the cycle starts
over again:

{% figure https://upload.wikimedia.org/wikipedia/commons/4/42/PDCA-Multi-Loop.png 600 %}

We all know that this is how software has to be developed. Many years ago
we all realized that a [Waterfall model](https://en.wikipedia.org/wiki/Waterfall_model),
where everything was planned upfront
and then implemented according to the plans, which didn't change during the
course of the project, was a bad idea. A much better idea is to deliver
the software [incrementally](https://en.wikipedia.org/wiki/Incremental_build_model),
making changes to the plans and specifications
after each iteration. This [guarantees](https://en.wikipedia.org/wiki/Iterative_and_incremental_development)
higher quality, faster reaction to mistakes,
and a much better predictability. It's obvious, right?

Why don't we do the same with people? Why do we motivate them upfront
and then trust them ... until they turn out to be completely _untrustworthy_?
Can't we regularly check
how they are performing and correct our _trust_ accordingly? Why are they
either "great" for us or "useless"? Why can't we grade them after each
iteration, according to both mistakes _and_ achievements they make?

Let's see how the formula that Agile suggests can be applied to the
PDCA continuum:

  * Plan: Find individuals and motivate them
  * Do: Trust them and they get the job done
  * Check: &mdash;
  * Act: &mdash;

It seems that two important pieces are missing. We don't check whether
we can still trust them, whether they are still motivated, whether they are
interested in getting the job done, and whether it's time to
[replace]({% pst 2015/sep/2015-09-16-how-to-fire-someone-right %})
some of them.

Why so? What are we afraid of?

Moreover, why do programmers find it humiliating when their results are being
regularly checked, leading to micro rewards and penalties, while at the same
time they find it totally OK to be fired for a single "unforgiven" mistake?

I have an answer.

Because their managers are [weak and stupid]({% pst 2017/aug/2017-08-01-how-to-manage-a-manager %}),
in most cases. They simply
don't know how to reward and penalize programmers incrementally. They don't
know how to measure the progress of people, incrementally. Their control instruments
are based on guilt and fear: They put programmers together,
~~brainwash~~ [motivate]({% pst 2016/dec/2016-12-06-how-to-pay-programmers-less %})
them, and then make them scared of making an unforgivable mistake.

{% youtube KPbKqTXfZwA %}

What exactly that mistake is, nobody really knows---it's
a personal decision of a manager. It could be a broken unit test,
a missed [meeting]({% pst 2015/jul/2015-07-13-meetings-are-legalized-robbery %}),
a rude email, or drinking in the office. The scale is
very wide and at which point the programmer will be fired, nobody
knows either. Even the manager can't explain it. The decision in most cases is
[emotional and personal]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %}).

You know that a very typical mistake in scope management is treating
large tasks with the 0/100 completeness rule: they are either "not even started"
or "fully complete," and nothing in the middle. You can do that with
[small tasks]({% pst 2017/nov/2017-11-28-microtasking %}),
but never with large ones, because it will lead to lack of control
and much higher risk of more expensive failures. You must break your scope
into smaller pieces and then apply the 0/100 rule.

The same is true about people. You can't [trust]({% pst 2017/nov/2017-11-21-trust-pay-lose %})
them 0/100: either you trust
them fully or you fire them. This is too risky. You have to _decompose_
their trustworthiness and their motivation into smaller pieces and deliver your
satisfaction and frustration incrementally. How do you do that? Via
[micro-bonuses]({% pst 2018/jan/2018-01-09-micro-budgeting %}) and
[micro-penalties]({% pst 2018/jan/2018-01-09-micro-budgeting %}).

How else?

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">How to not hire a bad programmer? <a href="https://twitter.com/hashtag/management?src=hash&amp;ref_src=twsrc%5Etfw">#management</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1140200517555146753?ref_src=twsrc%5Etfw">June 16, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
