---
layout: post
title: "How Long It Takes to Close"
date: 2018-09-07
place: Moscow, Russia
tags: zerocracy
description: |
  Why does it take days to close a half-hour task and
  what can a programmer do to make it faster?
keywords:
  - zerocracy
  - management
  - microtasking
  - zerocrat
  - AI in management
---

Our [Policy](http://www.zerocracy.com/policy.html) expects our developers
to be fast. Section [§36](http://www.zerocracy.com/policy.html#36) pays for
quicker delivery and [§8](http://www.zerocracy.com/policy.html#8) penalizes
slow movers by removing them if they don't close in
ten days (at the time of writing). Why even ten days, if our tasks are
[so small](https://www.yegor256.com/2017/11/28/microtasking.html)?
And how long does it really take to close an average task?
Can we do something to close them sooner?

<!--more-->

This is a very common confusion, which is why I decided to write this blog post.
When I talk to our new clients, they usually ask me how can it be that
a small half-hour task takes five days to close and isn't that a serious
bottleneck for the entire project? They're more used to thinking that a programmer
says it will take a week to implement, and then in one calendar week, give or take,
the result is delivered.

In our case a programmer says that it will take 30 minutes and the result
is delivered in, say, seven days. And then the programmer is paid for 30 minutes
of his or her work time. It sounds weird for those who don't understand
how pay-per-result microtasking works. Let me explain.

There are two different things in each task, which are barely connected to each other:
the budget (cost) and the duration (time). We programmers are the resources
the project purchases to complete its work packages, which, when they
get assembled together, produce a working software module. When a house
is built, the resources are the bricks, the cement, the windows, the tiles,
and the hands of construction workers. When a software product is created,
the resources are... the hands of programmers and almost nothing else.

These resources are the first axis of a project's multi-dimensional matrix, while
the calendar time is the second one. To build a house we need, say, five
people to work for 80 hours straight, which
equates to 400 staff hours. And we obviously also need the bricks, the cement,
and everything else. Ten calendar days won't be enough, for example, if the truck that
delivers the bricks is delayed for a few days. We may spend those 400 staff hours
many times over if our work is not properly organized, or just because people are
people.

The same is true for software projects, but there are no bricks and cement. There
are only people, and they are late, very often. When a task of 30 minutes
is in the hands of one programmer, it doesn't mean he or she can finish it
in exactly 30 minutes. There are many dependencies, things which we have
to wait for, sometimes for days. Here is a non-exhaustive summary of what
a regular programmer has to go through in order to complete a pretty regular
microtask:

  * Understand the scope of the ticket;
  * Ask ticket reporter to refine the description;
  * Open up the code repository;
  * Find the place where the changes are required;
  * Submit a few other tickets, if the code is not clear and clean enough;
  * Discuss the changes made in those tickets;
  * Close the tickets and maybe submit new ones;
  * Create a Git branch;
  * _Make changes_;
  * Run the build and make sure it's green;
  * Commit and push the changes;
  * Create a pull request;
  * Respond to the comments of the code reviewer;
  * Make required changes to the branch;
  * Respond to the comments of the architect and make changes;
  * Make sure the PR passes the merge pipeline;
  * Ask ticket author to close it;
  * Argue with the author;
  * Start it all over if the problem is not solved.

As you see, the actual code writing line is somewhere in the middle
of this list and it's called "Make changes." Everything else is not
directly related to code writing. It's all about delivering the changes
and making sure they are accepted.

The smartest programmers know how to keep the "make changes" part
as small and quick as possible, in order to leave more time and energy
for everything else. Also, the smartest programmers know how to make changes
in a way that gets them accepted faster. It seems to be a combination of discipline,
enthusiasm, and art. It's difficult to explain what exactly needs to be
done and how. This is what sociotech skills are all about.

The bottom line is that our best programmers close 30-minute micro
tasks in 4-5 days each. Zerocrat assigns them many tasks at the same time,
in accordance with section [§3](http://www.zerocracy.com/policy.html#3),
expecting each programmer to close from six to eight tasks per day.
