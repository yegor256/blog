---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "More Bugs, Please"
date: 2018-02-06
place: Moscow, Russia
tags: testing
description: |
  We encourage programmers to find bugs and report them;
  we even pay for each bug found; this article
  suggests some places where they can easily be found.
keywords:
  - sources of bugs
  - finding bugs
  - software bugs
  - bugs
  - testing
image: /images/2018/02/american-honey.jpg
jb_picture:
  caption: American Honey (2016) by Andrea Arnold
---

A [bug]({% pst 2015/jun/2015-06-11-wikipedia-bug-definition %})
is something we find in a software product that "doesn't look right" (this
is my personal definition). A bug can be hidden or visible; it can be
"already fixed" or "still present"; it can be critical or cosmetic; it
can be urgent or of a low priority. What is important is that the
[more]({% pst 2017/may/2017-05-23-unlimited-number-of-bugs %})
bugs we are able to find and fix before our customers see them, the higher
the perceived [quality]({% pst 2017/dec/2017-12-26-software-quality-formula %})
of the software. Simply put, bugs are a
[very good thing]({% pst 2014/apr/2014-04-13-bugs-are-welcome %}),
if they are found by us, not our customers.
[We](https://www.zerocracy.com) pay our programmers for
[each bug]({% pst 2014/apr/2014-04-17-how-xdsd-is-different %})
they find. Here is a cheat sheet for them, showing where
and how they can find those bugs, to make more money.

<!--more-->

{% jb_picture_body %}

Obviously, if something is broken, it's a bug; no need to mention it here.
However, when a product is [more or less stable]({% pst 2017/mar/2017-03-24-tdd-that-works %}),
not too many things are
visibly broken. But we still pay for bugs. What should you look out for? Read on. This
list (in no particular order) will help you.

**Lack of functionality**.
If a class
([yegor256/cactoos#558](https://github.com/yegor256/cactoos/issues/558))
or the entire module
([yegor256/cactoos#399](https://github.com/yegor256/cactoos/issues/399))
doesn't provide the functionality you _expect_ it to have,
it's a bug.

**Lack of tests**.
If a class doesn't have a unit test
([yegor256/takes#43](https://github.com/yegor256/takes/issues/43))
or
the existing test doesn't cover some critical aspects of the class
([yegor256/cactoos#375](https://github.com/yegor256/cactoos/issues/375)),
it's a bug.

**Lack of documentation**.
If, say, a Javadoc block for a class does not clearly explain to you
how to use the class, or the entire module is not documented well
([yegor256/takes#790](https://github.com/yegor256/takes/issues/790)),
it's a bug.

**Suboptimal implementation**.
If a piece of code doesn't look good to you, and you think it can be
refactored to look better, it's a bug.

**Design inconsistency**.
If the design doesn't look logical to you
([yegor256/cactoos#436](https://github.com/yegor256/cactoos/issues/436))
and you know how it can be improved,
it's a bug.

{% youtube F3bjFXFRsI8 %}

**Naming is weird**.
If class, variable or package names don't look consistent and
obvious to you, and you know how they can be fixed
([yegor256/cactoos#274](https://github.com/yegor256/cactoos/issues/274)),
it's a bug.

**Unstable test**.
If a unit test fails sporadically
([yegor256/takes#506](https://github.com/yegor256/takes/issues/506))
or doesn't work in some particular environment
([yegor256/jpeek#151](https://github.com/yegor256/jpeek/issues/151)),
it's a bug.

Also, it's worth mentioning that minor, cosmetic, or poorly formulated
[bug reports]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %})
will most likely be rejected or not paid for. If you want us to pay for your bug reports,
make sure they [sound right]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %}),
in order to help us move the project forward to a better state.

<!--

There are some examples of minor bugs, which are not worth paying
for, even though they are valid:

  * [yegor256/jpeek#158](https://github.com/yegor256/jpeek/issues/158)

Cosmetic bugs are those that

-->
