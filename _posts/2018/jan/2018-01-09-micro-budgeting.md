---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Five Stages of Microbudgeting"
date: 2018-01-09
place: Moscow, Russia
tags: xdsd zerocracy
description: |
  Microtasking means that all tasks are very small in
  scope and in cost; microbudgeting is how those
  tasks are paid.
keywords:
  - xdsd budgeting
  - fixed budget
  - microtasking
  - task estimating
  - pay per task
image: /images/2018/01/taxi-driver.jpg
jb_picture:
  caption: Taxi Driver (1976) by Martin Scorsese
buffer:
  - "I believe that the best reward and punishment instrument is money"
  - "Task performers were complaining, customers were asking for refunds... finally, we found a solution"
  - "They get very angry. They call us crooks, fraudsters, and many other names..."
  - "Follow the rules: be greedy, selfish, egoistic, money-driven, result-oriented, lazy, misanthropic..."
---

Microtasking, which [I explained]({% pst 2017/nov/2017-11-28-microtasking %})
in an earlier post, works only when each task has a very specific reward
for success and a punishment for failure.
I [believe]({% pst 2014/sep/2014-09-24-why-monetary-awards-dont-work %})
that the best reward and punishment instrument is money. The budget
is fixed, the programmer gets it only when the task is completed (reward), no matter
how much time it costs; if it is not completed, there is no money at all
(punishment). Pure and simple. However, a logical question arises: how can we
know upfront what is the right budget?
Who [sets]({% pst 2015/jun/2015-06-02-how-to-estimate-software-cost %}) it?

<!--more-->

{% jb_picture_body %}

When we started to play with microtasking in our projects, in 2009, we were
asking programmers to estimate each task. It did work, but only with very
simple and obvious tasks. More complex ones almost always suffered
from either under-estimating or padding---numbers were either very small
and task performers were complaining in the end, or they were too big and
customers were asking for refunds. It was not a manageable situation.

Then, we realized that it would be better if all tasks were rather
small, with exactly the same budget. We tried to use two hours as a universal
and fixed estimate. Everything else that didn't fit---programmers were allowed
to reject. This model didn't really work either, because our managers had
to deal with a very large amount of rejected tasks and didn't know how to make
them smaller, since they were not programmers.

{% quote The beauty of this approach is that the task of scope decomposition is moved to the shoulders of programmers. %}

Finally, in March 2010 we found a solution, which was labeled
[Puzzle Driven Development]({% pst 2010/mar/2010-03-04-pdd %}) (PDD). According to
this concept: 1) Any task has a very small fixed budget (we use 30 minutes);
2) The task performer is allowed to complete only part of the task;
3) The code that is being returned to `master` must include `todo` markers, called "puzzles";
4) Puzzles are automatically converted to new tasks.

The beauty of this approach is that the most complicated part of the software
project management---scope decomposition---is moved to the shoulders
of those who are the best at it: programmers.

We are using PDD in all our projects now and have even created a public instrument
for GitHub repositories, which allows anyone to play with PDD at no cost:
[0pdd.com]({% pst 2017/apr/2017-04-05-pdd-in-action %}). This is exactly
the same tool we are using in our commercial projects.

However, if and when you decide to apply microbudgeting to your project,
together with PDD, there will be problems. Psychological ones mostly. In my
experience, people go through five stages when they face microbudgeting
for the first time:

  * **Denial**.
    They ask "How is it possible?" and then refuse to hear any explanations.
    There are many reasons why microbudgeting and microtasking may not
    work---you will hear them all. Very often they demand a traditional
    model of payment, especially if they were invited. They just say that
    our model is insane, and if we want to see them work on our projects we have to
    pay for as much time as they spend. Most of them quit.

  * **Anger**.
    Some of them decide to try. Thanks to their previous multi-year experience,
    they expect to be
    paid by the end of the day/week/month, no matter what they were doing. Very soon they
    realize that the total income for the first day of work was $0.00, even though
    they were doing something. They get very angry. They call us crooks, fraudsters,
    and many other names. Asking them to read the [policy](http://datum.zerocracy.com/pages/policy.html)
    again doesn't help. They simply can't believe that we are
    not going to pay them anything, even
    though they were doing something. Most of them quit.

  * **Bargaining**.
    Almost everybody at this stage recommends we change the model. They
    explain why it's not really effective and how great it would be if we
    would pay them the traditional way. They give us examples of their previous
    projects, send references from previous employees, and criticize
    my blog posts. With some of them I try to argue, when their criticism
    is constructive. Most of them quit.

  * **Depression**.
    Most programmers are used to doing work because they feel guilty
    if the task is not done or the bug is not fixed. Microbudgeting requires
    a completely opposite attitude: we all are supposed to work because
    we are greedy. Money has to motivate us, not guilt. If there is no money,
    we don't work. Most people, when they see this new motivational paradigm
    and don't see the usual guilt, lose coordination and don't know what to do.
    They can't really achieve anything, because there is no traditional manager
    standing behind them and pushing them forward. They are supposed to go for
    the money. They don't, and so they don't make any money. Most of them quit.

  * **Acceptance**.
    Finally, the best of them realize that the model can work if they
    follow the rules, which are very simple: be greedy, selfish, egoistic,
    money-driven, result-oriented, lazy, misanthropic, heartless, and arrogant.
    They accept the fact that they lose, compete, work, and make money only
    when they produce results. They start enjoying meritocracy at its best.

You understand already that the vast majority of those who try to work with us
can't really get to the final point---they quit somewhere in the middle.
Most probably something very similar will happen on your projects too.

What is the solution? I don't really know.

Statistically speaking, three to five people out of a hundred manage to survive and
become effective and productive. Thus, to build a team of twenty people
you will have to screen and try at least 400.
