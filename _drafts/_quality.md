---
layout: post
title: "The Formula for Software Quality"
date: 2017-12-22
place: Voronezh, Russia
tags: quality management
description: |
  How can the quality of a software product be measured
  as a number? Here is my suggestion of the formula
  we can use.
keywords:
  - software quality
  - formula of quality
  - quality metric
  - metric for quality
  - software quality metric
image: /images/2017/12/
jb_picture:
  caption:
---

How do you define quality of a software product? There is definitely an
intrinsic emotional component of it, which means satisfaction of a user,
willingness to pay, appreciation, positive attitude, and all that. However,
if we put emotions aside, how can we really measure it?
IEEE [says](https://standards.ieee.org/findstds/standard/610.12-1990.html) that
the quality is the degree to which a product meets its requirements or
user expectations. But what is the formula? Can we say that it
satisfies requirements and expectations to, say, 73%?

<!--more-->

{% jb_picture_body %}

Here is the formula and the logic I'm suggesting.

As [we know]({% pst 2017/may/2017-05-23-unlimited-number-of-bugs %}),
any software product has an unlimited number of bugs. Some of them
are discovered and fixed by the development team, let's call them _F_.
Some of them are discovered by the end users, let's call them _U_. Thus,
the total amount of bugs we are aware of, out of an infinity, is _F+U_.

Obviously, the smaller is _U_, the higher is the quality. Ideally, _U_ has
to be zero, which will mean that users don't see any bugs at all. How can
we achieve that, if the total amount of bugs is inifinite? The only possible
way to do it is to increase _F_, hoping that _U_ will decrease automatically.

Thus, the quality of a product can be measured as:

{% eqtn Q = \frac{F}{F + U} %}

We simply divide the amount of bugs found by the total amount of bugs
visible. Thus, the more bugs we managed to find before our users, the higher the
quality.

The quality of 100% means that no bugs are found by the users. The quality
of 0% means that all bugs are found by them.

Does it make sense?
