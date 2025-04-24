---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "The Pain of Daily Reports"
date: 2020-11-03
place: Moscow, Russia
tags: management
description: |
  Why do we Agile teams need those famous daily
  standup meetings? I believe, daily reports may
  serve the very same purpose, but better.
keywords:
  - daily reports
  - daily standups
  - daily scrum
  - daily morning stand-up
  - daily agile
image: /images/2020/11/norsemen.jpg
jb_picture:
  caption: Norsemen (2017) by Jon Iver Helgaker et al.
---

A few days ago I asked
[my Twitter](https://twitter.com/intent/follow?screen_name=yegor256)
followers to vote in a
[simple poll](https://twitter.com/yegor256/status/1318899898364866560).
They did, screaming in comments that only a ~~stupid~~
incompetent manager would ask programmers to send daily reports,
while everything they do can easily be tracked in tickets, Git history, and so on.
Indeed, why on earth would a sane manager ask software engineers, already very busy with coding,
to spend time on writing these ridiculous reporting emails?
Let me try to give you a good reason.

<!--more-->

{% jb_picture_body %}

I'm sure that in your team
1) every contribution programmers make goes to the source code,
2) each pull request passes a mandatory and strict review process,
and 3) everybody is paid
[only]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %})
according to the amount of results they contribute.
Of course, thanks to such an objective and fair process, all programmers
are self-disciplined and self-motivated. They know what they work for,
how to achieve better results, and exactly what needs
to be done in order to help the project move forward: all metrics are
right in front of you, and them. By the end
of the month you just open the dashboard, see the numbers and
[reward]({% pst 2014/sep/2014-09-24-why-monetary-awards-dont-work %})
the best of them.

Is this how your team works? I doubt it. I was kidding.

Most probably it works like this:
1) some people occasionally commit some code
while others barely touch the keyboard spending most of their "work time"
sitting in
[meetings]({% pst 2015/jul/2015-07-13-meetings-are-legalized-robbery %})
and chatting online,
2) everybody gets paid
[regularly]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %}),
no matter how much they contribute
and those who don't do anything get as much as the hard-workers, or even more,
3) code reviews are hardly mandatory and very often dirty code
gets through, just because nobody wants to offend its author
or the review takes too long with no chances to see code improvements,
simply because the author doesn't care.
I can continue, if you like.

{% youtube Yj1VFGK9vqc %}

Sound familiar?

In this situation, which is much more popular than the previous
story, how do you, being a
[manager]({% pst 2016/may/2016-05-24-who-is-project-manager %}),
make people actually work? I'm talking about
those people who don't work simply because it would be stupid to work
when nobody can control the output and can't really punish anyone for its
absence. How do you _enforce_ the discipline in such a team?

You can, of course, go to the tracking system and check how many
tickets were closed by Jeff during the day. You can also read the
Git history and find out how many lines of code Jeff wrote. Or you can
monitor the dashboard every day to see what tasks assigned
to Jeff were resolved during the week. You can do all that. The question
is---what do you do when you find out that Jeff doesn't do anything? Or that he
does much less than everybody else? An even bigger question is: what do you do when you
realise that everybody in your team is lazy and does as little as they
can do or nothing at all?

Sounds weird and has nothing to do with your reality? Really?
Look at [this](https://twitter.com/yegor256/status/1322877629024948226) Twitter poll.

So, what do you do with the team, if you can't really fire anyone
and you can't motivate them in any way: they are paid regardless. How do you
discipline them?

The only possible instrument is _guilt_.
I [wrote]({% pst 2019/sep/2019-09-03-injection-of-guilt %}) about this before.
You have to find a way to make them feel guilty when they get
lazy and deliver less than they could. The most popular way to do
that is [daily standups]({% pst 2015/jan/2015-01-08-morning-standup-meetings %}).
You line them up every morning and make them
feel uncomfortable reporting the progress. It works and works well
in so many teams over the world, thanks to the popularity of Agile.
Without these guilt-triggering standups I don't know where the tech
industry would be.

Yet another instrument of the same kind is _daily reports_. You make your programmers
summarize their work during the day and email you. To make the feeling of guilt
even stronger, ask them to CC a few other people, like their colleagues,
maybe an HR person, maybe someone from another team. Make this list
mandatory. It will be very hard to say in the email that the day
ended and no results were achieved. They will have to make something
up and eventually will start actually doing something.

Some of them will complain that it's
[micromanagement]({% pst 2015/sep/2015-09-22-micromanagement %}).
Tell them that you are not interested in how they spend their days, but only
in knowing the results they delivered. Ask them to report only tangible
and visible things, like "ticket closed," "document created,"
or "the experiment conducted." In my opinion, this daily reporting
is not micromanagement at all, since you don't tell them how to achieve
their goals. It may be a fine-grained control mechanism, but there
is nothing wrong with
[control]({% pst 2018/oct/2018-10-09-can-you-control-us %}),
in any management paradigm. Thus,
if they go to your supervisor and complain about your actions,
you have a perfect explanation: you just want to know about their
results, that's all.

They may say that the information is already
available in the tracking system, but you can say that you prefer
to get it by email, since it's faster and more convenient for you.
Moreover, how much will such a daily report cost them? Five
minutes every day, right? Not a big deal.

Don't tell them about the guilt part, of course.
Let it be your secret.

The bottom line is that in the absence of proper management, both morning standups and
evening daily reports are the best tools to manage people. What else can you use
to connect their performance directly with guilt mechanisms in
their brains?

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Your team leader is asking you to email him every day with a summary of your daily results. Your reaction:</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1318899898364866560?ref_src=twsrc%5Etfw">October 21, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
