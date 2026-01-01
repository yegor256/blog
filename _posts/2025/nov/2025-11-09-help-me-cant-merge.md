---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Can’t Merge? Don't Despair."
date: 2025-11-09
place: Moscow, Russia
tags: oss etiquette
description: |
  When your pull request won’t merge, don't fight it—fail fast,
  split your changes, file bugs, and move on smarter.
keywords:
  - merge conflict
  - pull request policy
  - discipline of pull requests
  - resolving conflicts
  - pull request
image: /images/2025/11/amores-perros.jpg
jb_picture:
  caption: Amores Perros (2000) by Alejandro González Iñárritu
---

You've made a pull request, but it won't merge.
A reviewer says it's not good or the tests don't pass.
No matter what, you can't get it into the master branch.
You keep fixing the branch, keep convincing the reviewer, keep hating the tests.
Stop.
Try _smarter_ tactics.

<!--more-->

{% jb_picture_body %}

## 1. Give Up Instantly

First, [fail fast].
Give up quickly.
If it doesn't go through smoothly, _close it_.
If the reviewers' complaints are more than stylistic issues, your understanding of the architecture is flawed.

Ask yourself, how did this happen?
Why did you, a smart programmer, get a wrong understanding of the architecture?
Obviously, it's [not your mistake]({% pst 2015/feb/2015-02-16-it-is-not-a-school %}).
It's a bug in the repository.
Its [README]({% pst 2019/apr/2019-04-23-elegant-readme %}) isn't complete, its code isn't clean enough, its documentation is outdated.

What do you do?
You [blame]({% pst 2025/may/2025-05-25-bug-driven-development %}) them by submitting [bug reports]({% pst 2014/apr/2014-04-13-bugs-are-welcome %}).
Then, when they fix the repository, you try again, with a new pull request.

## 2. Take a Smaller Bite

Most likely they don't complain about all the changes you've made.
Something looks good to them, while they refuse to accept something else.
Good, remove the bad parts from your pull request.

Don't waste time trying to sell the entire package in one go.
Instead, give them as much as they're _ready to accept_.
In the end, you will merge a few pull requests instead of one.
The more, the better, at least for us in [Zerocracy], where we [reward]({% pst 2018/jul/2018-07-24-bugs-or-pull-requests %}) each merged pull request.

## 3. Blame Them Wisely

This may be a defect in their existing codebase.
Pretty often it is.
Your code can't merge, not because it's broken, but because one of the existing tests is flaky.
This is tricky and it may get ugly.

Don't get negative or frustrated.
You know that it's not your fault.
But they don't.
They believe that your code is defective and their code is perfect.
Moreover, all CI workflows are [green]({% pst 2014/jul/2014-07-21-read-only-master-branch %}) on master, while your branch is red.
Who do we [blame]({% pst 2025/apr/2025-04-19-dont-merge-into-broken-master %})?
Obviously, you.

{% quote They won't listen if you blame them for the failure in your pull request. %}

You have to collect _enough evidence_ and submit a bug report.
It should explain what's wrong in their master branch.
Don't ever mention your pull request.
It's a trap!
If you try to use your pull request as a proof of their mistakes, they won't listen.

Forget about your pull request for a while.
Submit a bug report as if you were a stranger who just found a _bug in master_.

It may be hard, since master is green.
However, there is no other way around it.
Again, they won't listen if you blame them for the failure in your pull request.
At best, they will explain to you the basics of continuous integration.

## 4. Move On

Just as poker fish (immature players) try to win every hand, junior developers try to merge every pull request.
This is a mistake.
Some problems simply can't be fixed and some features can't be implemented right now.
There will be time for them later.

It's perfectly all right to _close_ a pull request after a negative review.
There's no need to feel obliged to finish it.
It's better to spend time on easier bugs to fix and simpler functionality to implement.

## 5. Don't Call for Help

No matter how hard it is, don't ask them to help you.
"I can't understand why it doesn't merge!"
Don't say this.

They [may help]({% pst 2015/feb/2015-02-16-it-is-not-a-school %}), but it will be annoying for them.
You won't look like a reliable programmer.
The more you ask for help, the more you ruin your reputation.
You must know how to solve issues on your own.

A failed PR isn't a setback.
It's a _lesson_.
Fail fast, blame smart, and move on stronger.

[fail fast]: https://en.wikipedia.org/wiki/Fail_fast
[Zerocracy]: https://www.zerocracy.com
