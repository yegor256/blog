---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Daily Stand-up Injection of Guilt"
date: 2019-09-03
place: Moscow, Russia
tags: management agile
description: |
  Those software teams that practice daily stand-up
  meetings demonstrate utter disrespect to their programmers
  and complete management incompetence.
keywords:
  - daily standups are evil
  - daily standup
  - daily stand-up meetings
  - evil daily standup
  - guilt of meetings
image: /images/2019/09/barfuss.jpg
jb_picture:
  caption: Barfuss (2005) by Til Schweiger
book: code-ahead-1 1.4
---

A few years ago I wrote a [blog post]({% pst 2015/jan/2015-01-08-morning-standup-meetings %})
about the daily stand-up meetings many software
teams are doing regularly. Since then, the article has been getting comments
from both sides. Readers either
1) [strongly agree](https://www.yegor256.com/2015/01/08/morning-standup-meetings.html#comment-4586377932)
with me or
2) [accuse me](https://www.yegor256.com/2015/01/08/morning-standup-meetings.html#comment-2021779372)
of having no idea what morning stand-ups are for.

My point was: only weak managers need such meetings to coordinate
the team, while strong ones use more formal instruments to
organize the flow of information. However, as
[someone noted](https://www.yegor256.com/2015/01/08/morning-standup-meetings.html#comment-3516161968),
morning meetings are not supposed to be used by managers to coordinate anyone,
but "to discuss progress, impediments and to plan."
I'm not buying it.

<!--more-->

{% jb_picture_body %}

Let's put the manager aside, since many of you
[believe](https://www.yegor256.com/2015/01/08/morning-standup-meetings.html#comment-2021783252)
that "it's a team that delivers a product," not a manager. Even though I'm not buying this either,
let's imagine a team that doesn't need a
[manager]({% pst 2016/may/2016-05-24-who-is-project-manager %}) and can perfectly
coordinate the work on its own. Even in this case I still ask the same question:
why do we need to stand up and talk face-to-face in order "to discuss progress
and impediments"? Why can't we do this in writing, in a chat,
by email, or even via a phone call? Well,
[ideally]({% pst 2016/aug/2016-08-23-communication-maturity %})
we should use tickets,
[of course]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %}).

{% quote Why can't we do this in writing, in a chat, by email, or even via a phone call? %}

Why do "planning for the next day" and "discussing progress" need to be done
personally in a standing-up circle instead of digitally? Why can't we update
each other about progress via an email letter, a status board,
or an Excel spreadsheet? Why can't planning be done in a software tool, which
the market is full of? What's wrong with registering impediments as tickets,
prioritizing, assigning, and resolving them one by one?

Nothing. All of this can and should be done online. That's what computers
were invented for. Everybody realizes that. However, Agile adepts
[strongly](https://www.mountaingoatsoftware.com/agile/scrum/meetings/daily-scrum)
believe in face-to-face meetings, including this daily scrum ceremony. Why?

As I said in
[_Code Ahead_](/code-ahead.html), my recently published book,
the only reasonable explanation I have is that
the group needs this ritual in order to stay _united_. And I meant the group
with a weak and incompetent ~~manager~~ management.

A strong and professional management keeps the group together and makes it achieve
the goal through 1) _explicitly-defined_ personal objectives
and 2) _non-ambiguous_ motivational instruments. Simply put,
at every moment of time everybody knows exactly what they have to do in order to get
~~money~~ what they are there for.

However, _most_ software groups don't have such great management, for many
reasons. Thanks to how
[Agile]({% pst 2016/jul/2016-07-11-mistakes-in-agile-manifesto %})
has been diminishing project management for
years, replacing it with leadership and "team work," many of the potentially good
managers have lost their motivation to work as such. Needless to say, talent
among managers is as rare as it is among programmers, dentists, or interior designers.
Moreover, great management does not tolerate mediocrity and makes mistakes visible, which, of course,
the majority is always against---it will do everything possible to sabotage this.
In most software teams an attempt to manage effectively, defining objectives
explicitly and motivating by results, will most likely lead to a dismissal
of such a courageous manager.

As a result, most programmers neither have personal objectives nor motivational instruments:
they stay in the office [from nine till five]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %})
and get a raise every few years only by switching company. And they have
supervisors, mentors, coaches, leaders, you name it, ... instead of managers.

{% quote Programmers, lined up every morning and forced to explain themselves, inevitably feel guilty. %}

Thus, how is it possible to keep the group together and make sure programmers
at least pretend to be working, if they have no personal responsibilities,
their motivation is close to zero, and they can't be discharged because the
cost of recruiting new ones is extremely high? Moreover, new ones will behave exactly
the same, simply because this is the most effective behavior for them, when the management
is weak (or absent). What instrument can be employed to _make_ them work?

Guilt.

This emotion is one of a few fundamental ones. Most people feel it after
harming someone and will try to avoid it. Programmers, lined up every morning
and forced to explain themselves, inevitably feel guilty: for mistakes,
for impediments, for lack of progress, for their dress, for their accent,
for many other things. It doesn't matter what they feel guilty for; what is
important is to _regularly_ make them feel ashamed of letting other people down,
even if they don't. The emotion kicks in when the group is listening and
an individual is speaking, even if there is no real harm done to the group by the
speaking individual. [_Code Ahead_](/code-ahead.html) quotes a number
of academic papers confirming that, but there is no need to have a PhD
in psychology in order to understand how vulnerable and scary the position
of someone speaking in front of a group can be (I can confirm that too as a
[regular](/talks.html) public speaker). Guilt kicks in and the programmer
feels that his or her actions may cause or have already caused problems to others.
The programmer gets back to the computer and starts working hard, without
any objectives or motivation. Except to not let ~~mommy~~ others down!

To the contrary, a strong and competent management employs formal reward-and-punishment mechanisms
in order to align the personal objectives of each team member with the business
goals the team is trying to achieve. Here are a few examples of such a mechanism
(rewards and punishment mixed together):

  - For each successful deployment you get $120
  - When this unit test is fixed you get $200
  - Every time the server is down for 5+ minutes you lose $500
  - You [interview]({% pst 2016/mar/2016-03-01-how-we-interview-programmers %}) a new Java programmer and get $100
  - You get $75 for each critical bug you can find
  - If you don't fix this ticket in 3 days, you won't be paid for it

In order to put such an obvious and explicit motivational system in place
the management has to be pretty smart and strong. Moreover, it will require a lot
of work to do and may lead to serious problems with the team, since, as was
mentioned above, the mediocre majority will try to sabotage it.

Meetings, especially morning stand-ups, are a "perfect" substitute, because
they make it possible to humiliate programmers regularly, triggering their
innate guilt emotion, which sends these or similar signals to their brains:

  - Don't stop working, you will disappoint ~~your mom~~ the team!
  - Don't open Facebook, it upsets everybody!
  - Work on this ticket, we rely on you!
  - Deploy it faster, don't let us down!
  - Be a good boy/girl, don't keep us waiting!
  - If you don't fix it now, you will be ashamed tomorrow morning!

Every morning stand-up meeting is a refreshment of guilt every programmer
needs in order to stay "motivated" and "engaged." This is the real
reason why they are "more effective" than digital and formal
flows of information.

Maybe some time in the future we will find a way to deliver guilt
in a small pill that every programmer will have to swallow in the morning.
Until such a pill is invented, keep doing morning stand-ups.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Who needs regular status meetings? <a href="https://twitter.com/hashtag/codeahead?src=hash&amp;ref_src=twsrc%5Etfw">#codeahead</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1170661449854803968?ref_src=twsrc%5Etfw">September 8, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
