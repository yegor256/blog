---
layout: post
title: "Micro Budgeting for Micro Tasking"
date: 2017-11-20
place: Moscow, Russia
tags: xdsd
description: |
  Microtasking means that all tasks are very small in
  scope and in cost; micro-budgeting is what raises
  the biggest amount of concerns.
keywords:
  - xdsd budgeting
  - fixed budget
  - micro tasking
  - task estimating
  - pay per task
image: /images/2017/12/
jb_picture:
  caption:
---

Micro tasking, which [I explained]({% pst 2017/nov/2017-11-28-microtasking %})
earlier, works only when each task has a very specific reward
for success and a punishment for failure.
I [believe]({% pst 2014/sep/2014-09-24-why-monetary-awards-dont-work %})
that the best rewarding and punishing instrument is money. The budget
is fixed, the programmer gets it only when the task is completed (reward), no matter
how much time it costed; if it is not completed, there is no money at all
(punishment). Pure and simple. However, a logical question arises: how can we
know upfront what is the right budget? Who sets it?

<!--more-->

{% jb_picture_body %}

When we started to play with micro tasking in our projects, in 2009, we were
asking programmers to estimate each task. It did work, but only with very
simple and obvious tasks. More compex ones almost always were suffering
from either under-estimating or padding&mdash;numbers were either very small
and task performers were complaining in the end, or they were too big and
customers were asking for refunds. It was not a manageable situation.

Then, we realized that it would be better if all tasks would be rather
small, with exactly the same budget. We tried to use two hours as a universal
and fixed estimate. All tasks that didn't fit into it programmers were allowed
to reject. This model didn't really work either, because our managers had
to deal with a very big amount of rejected tasks and didn't know how to make
them smaller, since they were not programmers.

Finally, in March 2010 we found a solution, which was labeled
[Puzzle Driven Development]({% pst 2009/mar/2009-03-04-pdd %}) (PDD). According to
this concept: 1) Any task has a very small fixed budget (we use 30 minutes);
2) Task performer is allowed to complete only part of the task;
3) The code that is being returned to the code base must include `@todo` markers, called "puzzles";
4) Puzzles are automatically converted into new tasks later.

The beauty of this approach is that the most complicated part of the software
project management&mdash;scope decomposition&mdash;is shifted to the shoulders
of those who are the best at it: programmers.

We are using PDD in all our projects now and even created a public instrument
for GitHub projects, which allows anyone to play with PDD at no cost:
[0pdd.com]({% pst 2017/apr/2017-04-05-pdd-in-action %}). This is exactly
the same tool we are using in our commercial projects.

However, if and when you decide to apply micro-budgeting to your project,
together with PDD, this is the top list of problems you most likely will face:

  * **Old habits**.
    In the modern world, programmers are used to heroism-driven development
