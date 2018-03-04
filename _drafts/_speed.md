---
layout: post
title: "Don't Aim for Quality, Aim for Speed"
date: 2018-02-20
place: Moscow, Russia
tags: management
description: |
  When project scope is perfectly decomposed and management
  rules are clear and strict, the speed of delivery
  is a virtue, not the quality.
keywords:
  - quality vs speed
  - speed vs quality
  - perfection vs speed
  - speed or perfection
  - speed is king
image: /images/2017/02/...
jb_picture:
  caption:
---

<!-- http://www.yegor256.com/2017/11/28/microtasking.html#comment-3783321466 -->

I decided to write this blog post after reviewing
[this pull request](https://github.com/yegor256/jpeek/pull/153). What happened
there? The author of the PR wasn't able to figure out what was
the "right" way to implement it, and the code
reviewer was waiting and waiting. Eventually, the reviewer came to me,
since I was an architect, and [complained](https://github.com/yegor256/jpeek/pull/153#issuecomment-364412192)
that it was taking too long and he wasn't able to
[earn](http://datum.zerocracy.com/pages/policy.html#27) his money for the review
he has done. Then, the author of the changes
[explained](https://github.com/yegor256/jpeek/pull/153#issuecomment-364413528), that he couldn't
finish since there were impediments and design inconsistencies; he also
couldn't [earn](http://datum.zerocracy.com/pages/policy.html#4)
the money he deserved, for fixing the issue. What did I say?
I [said](https://github.com/yegor256/jpeek/pull/153#issuecomment-364417885):
Forget the quality, just finish it any possible way.

<!--more-->

{% jb_picture_body %}

Was I kidding? Not at all.

I truly believe that quality is not what programmers should care about. They
must care only about speed&mdash;close tasks as soon as possible&mdash;
which means [make money]({% pst 2018-01-09-micro-budgeting %}).

Won't this attitude ruin the project and turn the code base into mess?

Yes, it will, if the project won't care about its quality too.

There must be a permanent conflict between a project and its programmers:
1) the project must be configured to reject anything that lowers the
quality of its artifacts and 2) programmers must be interested
in making changes to those artifacts. The project cares about the quality,
the programmers care about fast delivery of modifications.

What do I mean by saying that a project rejects low quality? Here is a list
of preventive measures it may take to make it impossible
to jeopardize the quality:

  * [Automated]({% pst 2014/jul/2014-07-24-rultor-automated-merging %}) pre-flight builds
  * [Read-only master branch]({% pst 2014/jul/2014-07-21-read-only-master-branch %})
  * High test coverage bar
  * [Mandatory]({% pst 2018/jan/2018-01-16-educational-aspect-of-static-analysis %}) static analysis
  * Multi-steps code reviews

What do I mean by saying that programmers must be interested in making changes?
They have to be [motivated]({% pst 2014/sep/2014-09-24-why-monetary-awards-dont-work %})
to close tasks. Not just to [be in the project]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %}),
but to deliver. Here is what
they can do in order to close tasks faster:

  * [Cut corners]({% pst 2015/jan/2015-01-15-how-to-cut-corners %})
  * Make changes [smaller]({% pst 2015/feb/2015-02-09-serious-code-reviewer %})
  * [Don't study]({% pst 2015/feb/2015-02-16-it-is-not-a-school %}) the code, just modify it
  * Don't feel responsible for all code, just focus on their units/classes
  * Don't be afraid to [break things]({% pst 2017/mar/2017-03-24-tdd-that-works %})

If we put these two interests in conflict, we will get a high-quality product, which is
growing very fast. The project will enforce quality, programmers will push
the code forward, making changes fast and frequently.

Unfortunately, most projects have a very different philosophy. They delegate
quality control to programmers, hoping that they "won't do evil."
This leads to frustration, distress, constant fear of mistakes, long delays,
blaming, and shaming. Both the project and its programmers lose.

Programmers must not be responsible for the quality! They must not care
what may or will they break. They must not care how good is the code they write.
They must not "feel responsible" for the overall result. Instead, they must
be focused on making money for their families by writing the biggest amount
of code and closing more tickets.

Not because they are so ignorant and selfish, but because this is the right
balance of responsibilities. This is how the project will get the most out
of its developers&mdash;by freeing their minds of unnecessary and unproductive
quality worries and letting them focus on what they do best&mdash;writing code.

Of course, not every project will be able to configure itself the most
effective way. Most projects don't even know how to do it. In those projects,
if you, as developer, floor the speed pedal, you will most likely ruin
their code base in a few days. That's why, the recommendations above are
only applicable to those who really know what they are doing.

We know what we are doing in our projects. We don't let any developers
touch any parts of our code, unless the "quality wall" is high and strong enough.
How high is that wall in your projects? Can you say that no matter how
bad is some code and how sneaky its author introduces it, it will be rejected?
