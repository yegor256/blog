---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "How XDSD Is Different"
date: 2014-04-17
tags: xdsd management
description: |
  This article lays out the most important and critical
  differences between XDSD and traditional software
  development methodologies, including Agile
keywords:
  - extremely distributed development
  - motivation of programmers
  - project management
  - effective project management
  - xdsd
image: /images/2014/04/revolver-avi-with-dollar.png
jb_picture:
  caption: Revolver (2005) by Guy Ritchie
---

{% badge https://www.xdsd.org/images/logo.svg 100 https://www.xdsd.org %}

eXtremely Distributed Software Development, or [XDSD](https://www.xdsd.org) for short, is a methodology
that differs significantly from working in traditional software development
teams. Most [XDSD](https://www.xdsd.org) methods are so different (yet critical) that many newcomers get
confused. This article should help you bootstrap once you join a project managed
with by [XDSD](https://www.xdsd.org) principles---either as a developer or a project sponsor.

<!--more-->

{% jb_picture_body %}

## We Pay Only For Closed Tasks

Unlike with many other projects, in [XDSD](https://www.xdsd.org), we pay only for closed tasks and the
agreed upon time budget. Let me explain by example. Let's say, you are a Ruby
programmer and you get a new task that requires you to fix a broken unit test.
The task has a time [budget]({% pst 2018/jan/2018-01-09-micro-budgeting %})
of 30 minutes, as is the case most of the time.
Sometimes, though, tasks may have time budgets of fifteen minutes or one hour.

{% youtube 7EytYc7K5JA %}

In our example, we agree upon a contract rate of $50 per hour. With the broken
test, you will receive $25 for completing the task---30 minute tasked billed at
$50 per hour.

It does not matter how long it actually takes you to fix the test. Your actual
time spent on the project may be five minutes or five hours. Nevertheless, you
will receive compensation for 30 minutes of work only. If you fix the broken
test in 5 minutes, you receive $25. If the task takes you an hour, or even a
month, to complete, you still receive only $25.

Furthermore, if you fail to fix the unit test and close the task altogether, you
will receive no pay at all for the assignment.

You can view more details about this principle in the following articles:
[No Obligations Principle]({% pst 2014/apr/2014-04-13-no-obligations-principle %})
or
[Definition of Done]({% pst 2014/apr/2014-04-15-definition-of-done %}).

As mentioned above, this is one of the most important differences between XDSD
and other methods. Many people get confused when they see this principle in
action, and some leave our projects because of it. They simply are used to being
paid by the end of the month---no matter how much work they actually
deliver. In XDSD, we consider this type of approach very unfair. We feel that
people who deliver more results should receive more cash. Conversely, those who
don't deliver should get less.

## We Deliver Unfinished Components

Since most of our tasks are half an hour in size, we encourage developers to
deliver unfinished components. Read more about this concept in the article
below:
[Puzzle Driven Development]({% pst 2014/apr/2014-04-12-puzzle-driven-development-by-roles %}).

## No Informal Communications

Unlike many other projects or teams you may have worked with, XDSD uses
[no informal communication channels]({% pst 2016/aug/2016-08-23-communication-maturity %}).
To clarify, we never use emails, we never chat
on Skype and we don't do any meetings or phone calls. Additionally, XDSD
maintains no type mailing list. Our only method of communication is a ticket
tracking system (which in most projects consists of
[GitHub Issues]({% pst 2014/apr/2014-04-15-github-guidelines %}).)

{% youtube qRZYJGYdrwk %}

Moreover, we discourage horizontal communications between developers regarding
the scope of individual tasks. When assigned a task, your single and only point
of contact (and your only customer) is the task author. You communicate with the
author in the ticket to clarify task requirements.

When the [requirements]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %})
of a task are clear---and you understand them fully---deliver the result to the author and wait for him to close the task.
After the author closes the task, the
[project manager]({% pst 2016/feb/2016-02-18-holacracy-autocracy %}) pays you.

We're very strict about this principle---no informal communications.
However, it doesn't mean that we are not interested in your opinions and
constructive criticism. Rather, we encourage everyone to submit their
suggestions and bugs. By the way, we pay for
[bugs]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %})
(see the next section for further details about bug reporting and payments.)

Since we have no formal communications, members of project teams are not
required to work at specific times. Instead, team members work at times
convenient for them in their time zones. This includes weekdays and weekends.

## We Pay For Bugs

Unlike many other software teams, XDSD welcomes
[bug reports]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %}) in all our projects.
Therefore, we ask for bugs openly and expect team members to report them.
Review the following article for complete details on XDSD bug reporting:
[_Bugs Are Welcome_]({% pst 2014/apr/2014-04-13-bugs-are-welcome %}).

We expect everyone involved with a project to report every bug found.
Additionally, we encourage team members to make suggestions. In XDSD, we pay
team members for every properly reported bug.

{% youtube tCr9dtGdi2c %}

XDSD makes payments for reported bugs because we believe that the more of them
we can find, the higher the
[quality]({% pst 2017/apr/2017-04-11-flexibility-equates-lower-quality %}) of the end product. Some new developers are
surprised when they receive tasks such as "you must find 10 bugs in class A."
Often, the natural reaction is to ask "what if there are no bugs?" However,
[we believe]({% pst 2017/may/2017-05-23-unlimited-number-of-bugs %})
that any software product may have an unlimited amount of bugs; it is
just a matter of expending the time and effort needed to discover them.

## Only Pull Request

We never grant team member access to the `master` branch---no matter how
long you work on a project. Consequently, you must always submit your changes
through pull requests (most of our projects are done in
[GitHub]({% pst 2014/apr/2014-04-15-github-guidelines %}).)

We enforce this policy not because we don't trust our developers, but simply
because we don't trust anyone. It's a joke, of course. Read this article:
[Master Branch Must Be Read-Only]({% pst 2014/jul/2014-07-21-read-only-master-branch %}).

## No Compromises About Code Quality

Before merge any changes to the `master` branch, we check the entire code base
with unit tests and [static analyzers]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}).
Unit testing is a very common component in
modern software development, and one by which you should not be surprised.
However, the strictness of static analysis is something that often frustrates
XDSD newcomers, and we understand that. We pay much more attention to the
quality and uniformity of our source code than most of our competing software
development teams.

Even more important is that we never make compromises. If your pull request
violates even one rule of the static analyzer, it won't be accepted. And, it
doesn't matter how small or innocent that violation may look. This merging
process is [fully automated]({% pst 2014/jul/2014-07-24-rultor-automated-merging %})
and can't be bypassed.
