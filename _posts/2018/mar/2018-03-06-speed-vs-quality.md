---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Don't Aim for Quality, Aim for Speed"
date: 2018-03-06
place: Moscow, Russia
tags: management quality
description: |
  When project scope is perfectly decomposed and management
  rules are clear and strict, speed of delivery
  is the virtue, not the quality.
book: code-ahead-1 3
keywords:
  - quality vs speed
  - speed vs quality
  - perfection vs speed
  - speed or perfection
  - speed is king
image: /images/2018/03/house-of-flying-daggers.jpg
jb_picture:
  caption: Shi mian mai fu (2004) by Yimou Zhang
republished:
  -
    place: "BLOG@CACM"
    title: "Blame-Free Quality Control"
    date: 2018-07-30
    url: https://cacm.acm.org/blogs/blog-cacm/229942-blame-free-quality-control/fulltext
---

<!-- https://www.yegor256.com/2017/11/28/microtasking.html#comment-3783321466 -->

I decided to write this blog post after reviewing
[this pull request](https://github.com/yegor256/jpeek/pull/153). What happened
there? The author of the PR wasn't able to figure out
the "right" way to implement it, and the code
reviewer was waiting and waiting. Eventually, the reviewer came to me,
since I was an architect, and [complained](https://github.com/yegor256/jpeek/pull/153#issuecomment-364412192)
that it was taking too long and he wasn't able to
[earn](http://datum.zerocracy.com/pages/policy.html#27) his money for the review
he had done. Then the author of the changes
[explained](https://github.com/yegor256/jpeek/pull/153#issuecomment-364413528) that he couldn't
finish since there were impediments and design inconsistencies; he also
couldn't [earn](http://datum.zerocracy.com/pages/policy.html#4)
the money he deserved for fixing the issue. What did I say?
I [said](https://github.com/yegor256/jpeek/pull/153#issuecomment-364417885):
Forget the quality, just finish it any way possible.

<!--more-->

{% jb_picture_body %}

Was I kidding? Not at all.

I truly believe that quality is not what programmers should care about. They
must care only about speed---close tasks as soon as possible---
which means [make money]({% pst 2018/jan/2018-01-09-micro-budgeting %}).

Won't this attitude ruin the project and turn the code base into a mess?

Yes, it will.

If the project doesn't care about its quality either.

There must be a permanent conflict between a project and its programmers:
1) the project must be configured to reject anything that lowers the
quality of its artifacts and 2) programmers must be interested
in making changes to those artifacts. The project cares about the quality,
the programmers care about fast delivery of modifications.

What do I mean by saying that a project rejects low quality? Here is a list
of preventive measures it may take to make it impossible
to jeopardize the quality:

  * [Automated]({% pst 2014/jul/2014-07-24-rultor-automated-merging %}) pre-flight builds;
  * [Read-only master branch]({% pst 2014/jul/2014-07-21-read-only-master-branch %});
  * High test coverage bar;
  * [Mandatory]({% pst 2018/jan/2018-01-16-educational-aspect-of-static-analysis %}) static analysis;
  * Multi-step code reviews.

What do I mean by saying that programmers must be interested in making changes?
They have to be [motivated]({% pst 2014/sep/2014-09-24-why-monetary-awards-dont-work %})
to close tasks. Not just to [be in the project]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %}),
but to deliver. Here is what
they can do in order to close tasks faster:

  * [Cut corners]({% pst 2015/jan/2015-01-15-how-to-cut-corners %});
  * Make changes [smaller]({% pst 2015/feb/2015-02-09-serious-code-reviewer %});
  * [Don't study]({% pst 2015/feb/2015-02-16-it-is-not-a-school %}) the code, just modify it;
  * Don't feel responsible for all code, just focus on the relevant units/classes;
  * Don't be afraid to [break things]({% pst 2017/mar/2017-03-24-tdd-that-works %}).

If we put these two interests in conflict, we will get a high-quality product, which is
growing very fast. The project will enforce quality, programmers will push
the code forward, making changes fast and frequently.

Unfortunately, most projects have a very different philosophy. They delegate
quality control to programmers, hoping that they "won't do evil."
This leads to frustration, distress, constant fear of mistakes, long delays,
blaming, and shaming. Both the project and its programmers lose.

{% quote If we put these two interests in conflict, we will get a high-quality product, which is growing very fast. %}

Programmers must not be responsible for the quality! They must not care
what they may, or will, break. They must not care how good the code they write is.
They must not "feel responsible" for the overall result. Instead, they must
be focused on making money for their families by writing the largest amount
of code and closing more tickets.

Not because they are ignorant and selfish, but because this is the right
balance of responsibilities. This is how the project will get the most out
of its developers---by freeing their minds of unnecessary and unproductive
quality worries and letting them focus on what they do best---writing code.

{% youtube 55mwAbuDrV8 %}

Of course, not every project will be able to configure itself in the most
effective way. Most projects don't even know how to do it. In those projects,
if you, as a developer, floor the speed pedal, you will most likely ruin
their code base in a few days. That's why the recommendations above are
only applicable to those who really know what they are doing.

[We](https://www.zerocracy.com) know what we are doing in our projects. We don't let any developers
touch any parts of our code, unless the "quality wall" is high and strong enough.
How high is that wall in your projects? Can you say that, no matter how
bad some code is and how sneakily its author introduces it, it will be rejected?
