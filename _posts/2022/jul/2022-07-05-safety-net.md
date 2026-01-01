---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Automated Tests Are the Safety Net that Saves You"
date: 2022-07-05
place: Moscow, Russia
tags: testing
description: |
  Modifying the source code and knowing that there are no
  automated tests in place is similar to working at height
  and knowing that a single mistake could cost you your life.
keywords:
  - safety net
  - testing safety net
  - unit testing
  - testing safety
  - why unit testing
image: /images/2022/06/safety-net.jpg
social:
  - reddit: https://www.reddit.com/r/programming/comments/vrsgcu/automated_tests_are_the_safety_net_that_saves_you/
republished:
  -
    place: "BLOG@CACM"
    title: "Automated Tests Are the Safety Net"
    date: 2023-08-04
    url: https://cacm.acm.org/blogs/blog-cacm/275214-automated-tests-are-the-safety-net/fulltext
---

Automated tests are the ones that are usually called unit tests or integration tests,
or just any tests that are being executed _automatically_. That's the difference
between them and manual tests. What is the purpose of automated tests?
First and foremost, they reduce the amount of routine work: we don't
need to remember how to test a module, the tests remember. We just click
a button and a suite of tests, which may consist of hundreds or thousands,
runs and reports errors, if any are found. Saving time is important,
but it's not the only and, if you ask me, not the most important purpose
of automated tests. A more important one is their role as a safety net.

<!--more-->

{% jb_picture_body %}

Do you know what a safety net is? Wikipedia
[says](https://en.wikipedia.org/wiki/Safety_net) that
it is "a net to protect people from injury after falling from heights."
You most probably have seen it on buildings which are being
constructed or reconstructed.
The red one in the picture is the safety net.

> Unit Tests provide a safety net of regression tests and validation tests so that you can refactor and integrate effectively. As they say at the circus; never work without a net! -- [eXtreme Programming](http://www.extremeprogramming.org/rules/unittests.html)

If construction workers accidentally fall down
or drop their tools, they won't die and won't kill anyone on the ground.
Does this knowledge help them work more effectively? I believe it does. I didn't
find any research on this subject, comparing the productivity
of workers who know that there is a safety net beneath them with the productivity
of workers who know that a mistake would most probably cost them their lives or
the life of child playing on the ground. The results of such research are obvious though,
I believe.

{% youtube Y0Zx_sdVG48 %}

The same is true for us programmers. Modifying the source code and knowing that
there are no automated tests in place is similar to working at height
without a safety net: one mistake could cost you server downtime, a frustrated
customer, lost money, and maybe a lost job. How high would the productivity
of a programmer be while working like this? Do we need to do research to find out?
Or is the answer as obvious as for construction workers?

In order to give you enough confidence, automated tests must not only be
written and committed to a repository, but they must be automatically executed
before every change you try to make to the trunk. You must be able
to run them after every change you make locally, while incrementally developing the code.
Then, you must know that even if you accidentally forget to run them locally
and send your branch to the trunk for merging, the automated merge pipeline
will catch you.

The more time and effort you invest into making your safety net strong,
that is, the better your tests cover your code, then the more _productive_ your
work will be, the safer you will feel in introducing new features or fixing bugs.
Simply put, you will code _faster_ and _better_. Just because you know that
you can't break what you did yesterday.

The first thing you do when you start a new software project is
implement a safety net: you automate the build pipeline and you create
a few simple automated tests. You make sure they protect you. Only then do you
start writing code. Ask construction workers: are they allowed to start a workday
without a safety net? Obviously not. I'm sure it's even illegal. The same
must be true for us programmers: coding without the safety net of automated tests
must be illegal.

When a bug is reported to you by your customers, this should mean
that the safety net has a _hole_. It is not tight enough, that's why the bug
fell down on the head of your customer. What do you do before you fix the bug?
You fix the safety net. You add more automated tests, which will catch this
bug in the future. Only then do you fix the bug.

I believe that the safety net of a software project is its most valuable asset.
