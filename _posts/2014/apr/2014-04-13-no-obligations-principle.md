---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: No Obligations
date: 2014-04-13
tags: xdsd management
description: |
  In XDSD projects we recommend to manage accountability
  of team members by clearly defining task scope and borders
  or responsibility
keywords:
  - responsibility of programmers
  - management of programmers
  - obligations in software project
  - project management
  - risk management
  - micro management
  - project responsibility
image: /images/2014/04/big-lebowski-her-life-is-in-your-hands.png
jb_picture:
  caption: The Big Lebowski (1998) by Joel Coen
---

{% badge https://www.xdsd.org/images/logo.svg 100 https://www.xdsd.org %}

It is a very common problem in project management---how to make team
members more responsible and avoid [micro
management](https://en.wikipedia.org/wiki/Micromanagement)?
We start with creating plans, drawing Gantt charts, announcing milestones,
motivating everybody and promising big bonuses on success.

<!--more-->

{% jb_picture_body %}

## Excuses

Then everybody begins working and we start hearing excuses:

 * "The task is not yet ready. I was doing something else"
 * "May I take a day off? Tomorrow is my birthday?"
 * "May I skip the unit test because I don't know how to fix it?"
 * "I don't know how to do it, can someone help me?"
 * "I tried, but this doesn't work; what can I do?"
 * "This installation requires all of my time. I can't finish the task"

With excuses, team members transfer responsibility back to the project
[manager]({% pst 2015/sep/2015-09-22-micromanagement %}).
There was a very famous article [_Management Time: Who's Got the Monkey?_](http://hbr.org/1999/11/management-time-whos-got-the-monkey/ar/1)
published in the Harvard Business Review about this very subject.

I recommend that you read it. Its authors present problems as monkeys sitting on
our shoulders. When the
[project manager]({% pst 2016/feb/2016-02-18-holacracy-autocracy %})
assigns a task to a programmer---he moves the monkey from his shoulders to the programmer's shoulders.

{% youtube qRZYJGYdrwk %}

The programmer usually presents the excuse "I don't know what to do." Now the
monkey is back on the shoulders of the managers. The goal of the manager is to
send the monkey back to make it the programmer's problem again.

One of traditional way of transferring responsibility back to team members is to
become an aggressive manager. For instance the
[manager]({% pst 2017/aug/2017-08-01-how-to-manage-a-manager %}) may say, "You have a
birthday tomorrow? I don't care, you still have to meet your deadline" or "You
don't know how to fix the unit test? Not my problem, it should be fixed by
tomorrow," etc.

We've all seen multiple examples of that type of aggressive management.
Personally, I find this management style extremely annoying and destructive for
the project. The project environment becomes very unhealthy and good people
usually end up leaving.

{% quote To keep the project on track and meet all milestones, responsibility must be on the shoulders of the team members. %}

Another traditional management method is
[micro-management]({% pst 2015/sep/2015-09-22-micromanagement %}). This results when the
[project manager]({% pst 2016/may/2016-05-24-who-is-project-manager %})
checks task statuses every few hours and tells people what to do
and how to handle problems. Needless to say, this management style ruins the
team and causes good people to leave even faster.

However, in order to keep the project on track and meet all milestones,
responsibility _must be_ on the shoulders of the team members. They should be
responsible for their own tasks and report back to the project manager when they
are finished with their jobs.

Implementation problems should be solved by team members on their own. So, how
do we accomplish this in [XDSD](https://www.xdsd.org)?

## I Owe You Nothing

In [XDSD](https://www.xdsd.org), there is the first fundamental principle that says everybody should be
paid for deliverables. Based on this idea, we can go even further and declare a
"No Obligations" principle.

In essence, for every team member, it says: if you don't like the task assigned
to you, don't have time or you're simply not in the mood---don't do it.

You have no obligation to do anything. You're free to reject every second task
that a project manager gives to you or even all of them.

On the other hand, though, the project manager is not obliged to keep a task
assigned to you for longer than 10 days (we think that this time frame is
logical).

If you get a task, and don't deliver within ten days, the project manager can
take it away and pay you nothing---no matter how much time you invested in
the task already or the reasons for your failure to complete it.

## Where Are The Monkeys Now?

This principle helps us to separate responsibilities between project manager and
team members. The manager is responsible for finding the right people and
assigning them appropriate tasks. There is a problem with the project manager's
management style if he receives too many rejections from the team.

On the other hand, his team members are responsible for their tasks and should
not provide excuses for non-completion. Well, team members can make excuses, but
they won't change anything. No matter what their excuses are, the deliverables
will be purchased only from members who manage to complete their tasks on time.

## How Does This Affect Me?

When you're working with [XDSD](https://www.xdsd.org)-inspired project, you should always keep the "No
Obligations" principle in mind. You should start a task only if you're sure that
you can finish it in a few days. You should pursue your tasks and control
deadlines yourself. The project manager will not ask you for status updates, as
usually happens with traditional projects. He will just take the task away from
you after ten days if you don't finish it. To avoid that, you should control
your tasks and their deadlines.

With every task, try to be as
[lazy]({% pst 2018/apr/2018-04-17-how-to-be-lazy %})
as possible and cut every corner you can. The
smaller the amount of work you perform on a task, the easier it will be to
deliver it and pass all quality controls.

Always remember that your efforts are not appreciated---only the
deliverables matter.
