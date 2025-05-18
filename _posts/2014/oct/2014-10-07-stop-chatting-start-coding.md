---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Stop Chatting, Start Coding"
date: 2014-10-07
tags: xdsd
description: |
  In XDSD everybody is motivated to produce
  tangible and meaningful results. That's why
  we don't use emails, Skype, HipChat or phone calls.
keywords:
  - communications in agile team
  - agile team meetings
  - agile conference calls
  - chat with programmers
  - formal project communications
categories: jcg
image: /images/2014/10/barton-fink.png
jb_picture:
  caption: Barton Fink (1991) by Joel Coen
---

{% badge https://www.xdsd.org/images/logo.svg 100 https://www.xdsd.org %}

The first principle of eXtremely Distributed Software Development
([XDSD](https://www.xdsd.org)) states that
"everyone gets paid for verified deliverables." This literally
means that, in order to get paid, every programmer
has to write the code, commit it to the repository,
pass a code review and make sure the code is
[merged into the destination branch]({% pst 2014/jul/2014-07-21-read-only-master-branch %}).
Only then, is his result appreciated and paid for.

<!--more-->

{% jb_picture_body %}

For most of my [clients]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %})
this already sounds extreme.
They are used to a traditional scheme of paying
[per hour]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %})
or per month. They immediately realize the benefits of XDSD, though,
because for them this approach means that project
funds are
[not wasted]({% pst 2015/feb/2015-02-16-it-is-not-a-school %})
on activities that don't produce results.

{% youtube qRZYJGYdrwk %}

But that's not all.

This principle also means that nobody is paid for anything except
tasks explicitly assigned to him/her. Thus, when a programmer has a question
about current design,
[specification]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %}), configuration, etc.---nobody will be interested in answering it. Why not? Because there is no payment attached to this.
Answering questions in Skype, Slack, or HipChat, or by email is something that
is not appreciated in XDSD in any way. The project simply doesn't pay for
this activity. That's why none of our programmers do this.

More about this philosophy here:
[It's Not a School!]({% pst 2015/feb/2015-02-16-it-is-not-a-school %})

We don't use **any** (I mean it!) [informal communication channels]({% pst 2016/aug/2016-08-23-communication-maturity %}) in
XDSD projects. We don't do meetings or conference calls. We never discuss
any technical issues on Skype or by phone.

{% quote Every hour spent by a team member is traceable to the line of code produced. %}

So, how do we resolve problems and share information?

We use task tracking systems for that. When a developer has a question,
he submits it as a new "ticket." The project
[manager]({% pst 2015/sep/2015-09-22-micromanagement %}) then picks it up
and assigns it to another developer, who is able to answer it. Then, the
answer goes back through the tracking system or directly into
the source code.

The "question ticket" gets closed when its author is satisfied with the
answer. When the ticket is closed, those who answered it get paid.

Using this model, we significantly improve project communications, by making
them clean and transparent. We also save a lot of project funds, since
every hour spent by a team member is traceable to the line of code he produced.

{% youtube LB_YLWhGrco %}

You can see how this happens in action, for example, in this ticket
(the project is [open source]({% pst 2015/dec/2015-12-22-why-dont-you-contribute-to-open-source %}); that's why all communications are open):
[jcabi/jcabi-github#731](https://github.com/jcabi/jcabi-github/issues/731).
One Java developer is having a problem with his Git repository. Apparently
he did something wrong and couldn't solve the problem by himself. He asked
for help by submitting a new bug to the project. He was paid for the
[bug report]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %}).
Then, another team member was assigned to help him. He did,
through a number of suggestions and instructions. In the end, the
problem was solved, and he was also paid for the solution. In total, the
project spent 45 minutes, and the problem was solved.
