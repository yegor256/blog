---
layout: post
title: "How to Review a Software Project"
date: 2018-07-12
place: Moscow, Russia
tags: management
description: |
  They ask you to review a project; how do you do
  that, what do you pay attention to, how your
  report will like?
keywords:
  - independent review
  - independent technical review
  - independent project review
  - independent review of software project
  - independent quality review
image: /images/2018/07/
jb_picture:
  caption:
---

A few years ago I wrote about [independent technical reviews]({% pst 2014/dec/2014-12-18-independent-technical-reviews %})
any software project must regularly go through in order
to make sure everything is under control. I even [said recently]({% pst 2017/nov/2017-11-21-trust-pay-lose %})
that there could be no excuse for not doing them. Moreover, the more
we trust programmers, the higher the necessity to review their projects regularly.
Here is a short summary of what a report from a reviewer must include.

<!--more-->

{% jb_picture_body %}

I tried to touch this subject in a few recent talks:
[Make Customers Trust You](https://youtu.be/oiNI2jF46h0) at [BDMSummit 2017](http://bdmsummit.com/yegor-bugayenko-2017s/),
[How to Be Honest and Keep a Client](https://youtu.be/Rip_04Bv3Jk) at [PMCon Kharkiv 2017](http://pmcon.dev-pro.net/),
and
[How to Avoid Outsourcing Disaster](https://www.youtube.com/watch?v=DLk_5BmgTVk) at [Kyiv Outsourcing Forum 2017](http://outsourceforum.org/).
Also, there were a number of blog posts about that, including
[Seven Deadly Sins of a Software Project]({% pst 2015/jun/2015-06-08-deadly-sins-software-project %}),
[How to Avoid a Software Outsourcing Disaster]({% pst 2015/may/2015-05-21-avoid-software-outsourcing-disaster %}),
and
[Software Outsourcing Survival Guide]({% pst 2015/jun/2015-06-15-software-outsourcing-survival-guide %}).
Here is finally a more or less complete list of things a good report must include.

Basically, it's a list of questions a reviewer must answer.
When all answers are collected, the report is ready.
Most important questions are at the top.

  * The release procedure is documented and automated?
  * Releases happen frequently, at least once a week?
  * How big is the technical debt (things the "eventually" should be fixed)?
  * The delivery pipeline is strong enough to reject mistakes?
  * How clean is the code? How many [anti-patterns]({% pst 2016/feb/2016-02-03-design-patterns-and-anti-patterns %})?
  * Bugs and features are registered as [tickets]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %})?
  * The code base is covered by unit tests?
  * "Work for Hire" agreements are signed with all developers?
  * Key architectural technical decisions are documented?
  * Static analysis is in place and is [mandatory]({% pst 2018/jan/2018-01-16-educational-aspect-of-static-analysis %}) for new changes?
  * Continuous integration is in place, its reports are taken into account?
  * Master branch is [read-only]({% pst 2014/jul/2014-07-21-read-only-master-branch %})?
  * Programming metrics are collected and reviewed regularly?
  * The source code repository is under customer's ownership and control?
  * Requirements documentation is short and up to date?
  * Code coverage metric is under control?
  * Key classes, methods and functions have in-code documentation?
  * The source code repository is garbage free?
  * User interfaces are documented?
  * Production logs are visible and regularly reviewed?
  * How responsive the team is to the tickets?
  * Revision control system has a clear history of documented changes?

Maybe I forgot something?
Please post your comments below and I will update the list.

By the way, you can see the reports volunteers create for the participants
of my [Software Quality Award](/award.html). They analyze open source projects
and briefly report the problems found. I believe, they are trying to answer
to exactly the same set of questions.
