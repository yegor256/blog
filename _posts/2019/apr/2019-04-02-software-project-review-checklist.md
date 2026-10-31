---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Software Project Review Checklist"
date: 2019-04-02
place: Moscow, Russia
tags: architect
description: |
  They ask you to review a project; how do you do
  that? What do you pay attention to? What will your
  report look like?
keywords:
  - independent review
  - independent technical review
  - independent project review
  - independent review of software project
  - independent quality review
image: /images/2019/04/the-people-vs-larry-flynt.jpg
jb_picture:
  caption: The People vs. Larry Flynt (1996) by Milos Forman
---

A few years ago I wrote about the
[independent technical reviews]({% pst 2014/dec/2014-12-18-independent-technical-reviews %})
any software project must regularly go through in order
to make sure everything is under control. I even
[said recently]({% pst 2017/nov/2017-11-21-trust-pay-lose %})
that there is no excuse for not doing them. Moreover, the more
we trust programmers, the higher the necessity to review their projects regularly.
Here is a short summary of what a report from a reviewer must include.

<!--more-->

{% jb_picture_body %}

I tried to touch on this subject in a few recent talks:
[Make Customers Trust You](https://youtu.be/oiNI2jF46h0) at BDMSummit 2017,
[How to Be Honest and Keep a Client](https://youtu.be/Rip_04Bv3Jk) at PMCon Kharkiv 2017,
and
[How to Avoid Outsourcing Disaster](https://www.youtube.com/watch?v=DLk_5BmgTVk) at [Kyiv Outsourcing Forum 2017](http://outsourceforum.org/).
Also, there are a number of blog posts along the same lines, including
[Seven Deadly Sins of a Software Project]({% pst 2015/jun/2015-06-08-deadly-sins-software-project %}),
[How to Avoid a Software Outsourcing Disaster]({% pst 2015/may/2015-05-21-avoid-software-outsourcing-disaster %}),
and
[Software Outsourcing Survival Guide]({% pst 2015/jun/2015-06-15-software-outsourcing-survival-guide %}).
Here, finally, is a more or less complete list of things a good report must include.

Basically it's a list of questions a reviewer must answer.
When all the answers are collected, the report is ready.
The most important questions are at the top.

  * Is the release procedure documented, automated, and does it work?
  * Do releases happen frequently, at least once a week?
  * How big is the technical debt (the things that "eventually" should be fixed)?
  * Is the delivery pipeline strong enough to reject mistakes?
  * How clean is the code? How many [anti-patterns]({% pst 2016/feb/2016-02-03-design-patterns-and-anti-patterns %}) appear?
  * Are all bugs and features registered as [tickets]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %})?
  * Is the code base covered by unit tests, and is coverage visible?
  * Are "Work for Hire" agreements signed with all developers?
  * Are key architectural technical decisions documented?
  * Is static analysis in place and [mandatory]({% pst 2018/jan/2018-01-16-educational-aspect-of-static-analysis %}) for new changes?
  * Is [CI]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %}) in place, and are its reports taken into account?
  * Is master branch [read-only]({% pst 2014/jul/2014-07-21-read-only-master-branch %})?
  * Are programming metrics collected and regularly reviewed?
  * Is the source code repository under the customer's ownership?
  * Is the requirements documentation [short and up to date]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %})?
  * Do key classes, methods and functions have in-code documentation?
  * Is the source code repository garbage free?
  * Are UI/UX interfaces documented?
  * Are the production logs visible and regularly reviewed?
  * How responsive is the team to the tickets?
  * Does Git have a clear history of documented changes?

Essentially, this is a very short compilation of the most important things that
you can find in the [CMMI](https://en.wikipedia.org/wiki/Capability_Maturity_Model_Integration).
They require all this, and a large list of other things on top. But a small
project doesn't need everything that they ask you to have. My list is shorter
and, I'm sure, will be just enough for most of you.

By the way, you can see the reports volunteers create for the participants
of my [Software Quality Award](/award.html). They analyze open source projects
and briefly report the problems they find. I believe that they are trying to answer
exactly the same set of questions.
