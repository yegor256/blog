---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Twelve Mistakes in Agile Manifesto"
date: 2016-07-11
place: Palo Alto, CA
tags: management agile
description: |
  Agile Manifesto is a great document, which very often is wrongly
  understood by most Agile managers and programmers.
keywords:
  - agile
  - agile sucks
  - agile manifesto
  - why agile doesn't work
  - agile is evil
translated:
  - Russian: https://habr.com/ru/post/436582/
image: /images/2016/07/hail-caesar.jpg
jb_picture:
  caption: Hail, Caesar! (2016) by Coen Brothers
---

Nowadays, [Agile Manifesto](https://www.agilemanifesto.org/) is a Bible of
numerous software teams. It contains
[12 principles](http://agilemanifesto.org/principles.html) which
 show us how software development should be organized.
These principles were invented in 2001.
Generally, I like and agree with all of them. However, in practice, most software teams
misunderstand them. Consequently, here is a summary of what's going on and my
interpretation of each principle.

<!--more-->

{% jb_picture_body %}

**Principle #1**:
"Our highest priority is to satisfy the customer through early and continuous delivery of valuable software."

{% quote If the customer is not satisfied, we find another customer. %}

By focusing on "satisfy the customer," Agile adepts totally forget about
the "through" part. They think that a [happy customer]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %})
is their true objective, while "continuous delivery" is something that obviously
helps, though not crucially. However, this is quite the opposite---the customer
will be satisfied _if_ the software is perfectly created and delivered. If the
customer is not satisfied, we find another customer---that's the
true spirit a professional software team should adhere to. I believe that's what
 the Manifesto means. We make sure that our process is
"early and continuous," which will result to customer satisfaction. We focus on improving
our process, not satisfying the customer. Satisfaction is the consequence, not
the primary objective.

**Principle #2**:
"Welcome changing requirements, even late in development. Agile processes
harness change for the customer's competitive advantage."

Most Agile teams understand the word "welcome" here as a permission to forget
about any [requirements]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %})
management at all. What is the easiest way to welcome
change? Obviously, just get rid of any requirement documents!
In this case, any change will be welcome, since it won't affect anything.
There simply won't be anything to affect. But this is not what the Manifesto
means! This principle means that our requirements management process is so
_powerful_ that it can accept change at any moment. However, it's rather difficult to
achieve, if requirements are actually documented.

{% youtube sZoJ3gO4PSo %}

**Principle #3**:
"Deliver working software frequently, from a couple of weeks to
a couple of months, with a preference to the shorter timescale."

This terrific rule is usually understood as an order for the entire team. The
team has to frequently deliver, while programmers are free to deliver almost
nothing and who knows when. I think the Manifesto here is emphasizing on
both individual and group responsibilities to frequently deliver. I also think
that this frequency should be way higher than just a "couple of weeks." Today, with
modern technologies and instruments, we can deliver way faster---several
times a day.

**Principle #4**:
"Business people and developers must work together daily throughout the project."

{% quote Working together means quicker turnarounds in communication not lack or roles and responsibilities. %}

Working together doesn't mean working without clearly defined
rules and processes. However, most teams understand this principle as
a legalization of chaos. They think that since we work together, we don't need to define roles
any more, we should not document [requirements]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %}),
we shouldn't care about responsibilities. Ultimately in the end, we neither know who is
doing what nor the team's structure. That's not what the Manifesto
is talking about! "Working together" means quicker turnarounds in communication and
shorter response cycles. It definitely doesn't mean lack of roles and responsibilities.

**Principle #5**:
"Build projects around motivated individuals. Give them the environment and support they need, and trust them to get the job done."

{% quote Trust doesn't mean lack of control. %}

Trust is a great word and concept, but it doesn't replace another equally great
word---control. Most Agile teams think that trust means
exactly that---complete lack of any validation, verification, responsibility,
and control. "We trust our programmers to write perfect codes"---I've heard that countless times which is simply wrong. This principle means something completely different.
It means that when clearly defined tasks are assigned to their
performers, we fully delegate responsibilities to them. We
[motivate]({% pst 2014/sep/2014-09-24-why-monetary-awards-dont-work %})
them to be fully responsible for the end result. However, we
[don't help]({% pst 2015/feb/2015-02-16-it-is-not-a-school %}) them.
Instead, we trust them as self-sufficient individuals, capable
of completing assigned tasks on their own.

**Principle #6**:
"The most efficient and effective method of conveying information to and within a development team is face-to-face conversation."

{% quote Face-to-face doesn't mean at the same office, especially now. %}

Face-to-face doesn't mean sitting in the same office. The Manifesto doesn't say
anything about co-located or distributed teams. It's obvious that in modern software projects,
virtual communications (over video calls) are way more effective than
staying together in the same country, same city, same office, and same room.
Therefore, most Agile adepts still promote on-site development style, using
Agile Manifesto as proof. That's a mistake; face-to-face means something
totally different from what it meant 15 years ago, when the Manifesto was written.

**Principle #7**:
"Working software is the primary measure of progress."

This doesn't mean that we should not measure anything else. Of course, the
working software is the _primary_ measure, but there are many other
measures, which we can and must use. For example, the amount of features
documented, implemented and delivered;
or the amount of lines of code added to the project (don't smile, [read]({% pst 2014/nov/2014-11-14-hits-of-code %}));
or the amount of [bugs found]({% pst 2015/sep/2015-09-10-testing-exit-criteria %});
or the amounts of [dollars spent]({% pst 2016/jan/2016-01-19-how-expensive-is-outsourcing %}).
There are many other metrics. We can use many of them. However, a typical
mistake many Agile teams are doing is just ignoring them all. They say
"we measure only the end result." That's not what the Manifesto
is suggesting to do though.

**Principle #8**:
"Agile processes promote sustainable development. The sponsors, developers, and users should be able to maintain a constant pace indefinitely."

{% quote We must remember that any project is first of all a money burning machine. %}

This doesn't mean that we should indefinitely [burn]({% pst 2015/jun/2015-06-02-how-to-estimate-software-cost %})
customers' money. Yes, we
should be developing at some given speed, but we should always remember
whose money we're spending---customers' money. The Manifesto doesn't say anything
about the cost of development and that's probably because it was written by
those who make money (programmers), not those who spend it (customers). We must therefore
remember that any project is first of all a money burning machine. That's why
the team must always measure its
[burn rate]({% pst 2016/jan/2016-01-19-how-expensive-is-outsourcing %})
and make sure it's aligned with
the amount of business value the team delivers. Just being a
[happy team]({% pst 2015/mar/2015-03-02-team-morale-myths-and-reality %})
is not what the Manifesto suggests, but that's exactly how many understand this principle.

**Principle #9**:
"Continuous attention to technical excellence and good design enhances agility."

That's a perfect principle that says so much and doesn't say anything at
the same time. What exactly is "attention?" I can explain. It means
[rules and policies]({% pst 2015/oct/2015-10-13-competition-without-rules %}).
First of all, any policy means [punishment]({% pst 2016/jan/2016-01-05-how-to-punish-employees %}) to those
who violate rules. Thus, if an Agile team really means continuous
attention to technical excellence, it must have a [quality policy]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}).
That policy must clearly define which design is good and which is bad, which piece
of Java code is excellent, which is ugly, etc. Additionally, the policy must say
what happens to those who [violate]({% pst 2015/nov/2015-11-24-imprisonment-for-irresponsible-coding %})
the principles of excellence. However, most Agile
teams understand "quality" as a great flag to hang on the wall, but
get scared when I ask, "what happens if someone delivers low quality?."

**Principle #10**:
"Simplicity---the art of maximizing the amount of work not done---is essential."

That's a great rule which most Agile teams don't follow at all. This principle
means that our tasks are small and simple enough to make sure they are either
doable or cancellable. Huge tasks are the biggest threat to manageability of
any team, be it Agile or not. This principle encourages us to give programmers
small tasks, which they can easily be completed. However, most of Agile adepts
simplicity being equal to stupidity. They are not equal. A simple task doesn't
mean a stupid or non-important tasks. A simple task is a clearly defined, small,
and doable work order.

**Principle #11**:
"The best architectures, requirements, and designs emerge from self-organizing teams."

{% quote Self-organized doesn't mean un-organized. %}

Self-organized doesn't mean un-organized. This rule is often translated
as a legalization of _anarchy_. We don't need any project managers,
processes, discipline, rules, or policies---we've got
[holacracy]({% pst 2016/feb/2016-02-18-holacracy-autocracy %}) instead!
We also don't need a software architect---our programmers can make
all technical decisions at regular [meetings]({% pst 2015/jul/2015-07-13-meetings-are-legalized-robbery %})!
Furthermore, we don't want our programmers
to be individually responsible for anything---they are always together
in all risks and issues. Stop that nonsense! This is not what the Manifesto means.
A self-organizing team is a team that doesn't need any supervision from the outside;
a team that has clearly defined roles from the inside;
a team with a perfect inner discipline;
a team with professional [management]({% pst 2016/may/2016-05-24-who-is-project-manager %}).
Not with the lack of all that.

**Principle #12**:
"At regular intervals, the team reflects on how to become more effective, then tunes and adjusts its behavior accordingly."

That's a great principle which is translated into so-called retrospective
meetings. They work just fine as long as decisions
make the team better. Unfortunately, in most cases, programmers in Agile teams are
trying to [survive]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %}),
instead of making their teams more effective. Even though the
principle says that the team has to become more effective, those retrospective
meetings help programmers to become more effective (read "more secure") in
the team. That's only natural for people, but leads to the overall degradation
of the team. It's well known that the best team is the one that is capable of
quickly and inevitably [rejecting]({% pst 2015/sep/2015-09-16-how-to-fire-someone-right %})
bad elements. Does your team do that effectively?
Do retrospective meetings help in that? I doubt it. Therefore, I believe that
what the Manifesto means here is not the meetings. It means that the team must have
an effective mechanism of self-regulation and self-improvement. Additionally, retrospective
meetings simply can't be that mechanism because they prevent the team from making
difficult disciplinary decisions.

<blockquote class="twitter-tweet"><p lang="et" dir="ltr">Agile is... <a href="https://twitter.com/hashtag/agile?src=hash&amp;ref_src=twsrc%5Etfw">#agile</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1188299842700939264?ref_src=twsrc%5Etfw">October 27, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
