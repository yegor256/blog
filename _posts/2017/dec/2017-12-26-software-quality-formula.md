---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "The Formula for Software Quality"
date: 2017-12-26
place: Voronezh, Russia
tags: quality management
description: |
  How can the quality of a software product be measured
  as a number? Here is my suggestion for a formula
  we can use.
keywords:
  - software quality
  - formula of quality
  - quality metric
  - metric for quality
  - software quality metric
image: /images/2017/12/coco-chanel-and-igor-stravinsky.jpg
jb_picture:
  caption: Coco Chanel & Igor Stravinsky (2009) by Jan Kounen
---

How do you define the quality of a software product? There is definitely an
intrinsic emotional component to it, which means satisfaction for the user,
willingness to pay, appreciation, positive attitude, and all that. However,
if we put emotions aside, how can we really measure it?
The IEEE [says](https://standards.ieee.org/findstds/standard/610.12-1990.html) that
quality is the degree to which a product meets its requirements or
user expectations. But what is the formula? Can we say that it
satisfies requirements and expectations to, say, 73%?

<!--more-->

{% jb_picture_body %}

Here is the formula and the logic I'm suggesting.

As [we know]({% pst 2017/may/2017-05-23-unlimited-number-of-bugs %}),
any software product has an unlimited number of bugs. Some of them
are discovered and fixed by the development team, let's call them _F_.
Some of them are discovered by the end users, let's call them _U_. Thus,
the total amount of bugs we are aware of, out of an infinity of them, is _F+U_.

Obviously, the smaller _U_ is, the higher the quality. Ideally, _U_ has
to be zero, which will mean that users don't see any bugs at all. How can
we achieve that, if the total amount of bugs is infinite? The only possible
way to do it is to increase _F_, hoping that _U_ will decrease automatically.

Thus, the quality of a product can be measured as:

{% eqtn Q = \frac{F}{F + U} %}

We simply divide the amount of bugs found by the total amount of bugs
visible. Thus, the more bugs we manage to find before our users see them, the higher the
quality.

A quality of 100% means that no bugs are found by the users. A quality
of 0% means that all bugs are found by them.

Does it make sense?

{% badge /images/2017/12/managing-the-testing-process.jpg 96 https://amzn.to/2EEe2o6 %}

P.S. It seems that I'm not the inventor of the formula. This is the quote
from [_Managing the Testing Process: Practical Tools and Techniques for Managing Hardware and Software Testing_](https://amzn.to/2GvhMEV) (2009)
by Rex Black, page 109:
A common metric of test team effectiveness measures whether the test team
manages to find a sizeable majority of the bugs prior to release. The production
or customer bugs are sometimes called _test escapes_. The implication is that
your test team missed these problems but could reasonably have detected them
during test execution. You can quantify this metric as follows:

{% eqtn \mathit{Defect Detection Effectiveness} = \frac{\mathit{bugs (test)}}{\mathit{bugs (test) + bugs (production)}} %}

P.P.S. Here is another similar metric by Capers Jones at
[_Software Defect Removal Efficiency_](http://ieeexplore.ieee.org/document/488361/),
Computer, Volume&nbsp;29, Issue&nbsp;4, 1996:
"Serious software quality control involves measurement of defect removal efficiency (DRE).
Defect removal efficiency is the percentage of defects found and repaired prior to release.
In principle the measurement of DRE is simple. Keep records of all defects found
during development. After a fixed period of 90 days, add customer-reported defects
to internal defects and calculate the efficiency of internal removal. If the development
team found 90 defects and customers reported 10 defects, then DRE is of course 90%."

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Do you measure the <a href="https://twitter.com/hashtag/quality?src=hash&amp;ref_src=twsrc%5Etfw">#quality</a> of your software product?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1107257289864556546?ref_src=twsrc%5Etfw">March 17, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
