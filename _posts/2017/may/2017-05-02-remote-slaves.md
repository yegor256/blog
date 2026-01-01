---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "A Remote Slave Is Still a Slave"
date: 2017-05-02
place: Moscow, Russia
tags: management sarcasm
description: |
  Working remotely doesn't solve the key problem of
  modern management---a lack of motivation for results---but
  rather makes things worse.
keywords:
  - working remotely
  - office slavery
  - slavery in programming
  - slavery
  - office slave
image: /images/2017/05/happiness.jpg
jb_picture:
  caption: Happiness (1998) by Todd Solondz
republished:
  -
    place: "BLOG@CACM"
    title: "The Remote Revolution Has to be Driven by Output, Not Salaries"
    date: 2020-05-29
    url: https://cacm.acm.org/blogs/blog-cacm/245277-the-remote-revolution-has-to-be-driven-by-output-not-salaries/fulltext
---

Working remotely is definitely a trend, according to the
[BLS](https://www.bls.gov/opub/ted/2016/24-percent-of-employed-people-did-some-or-all-of-their-work-at-home-in-2015.htm)
and my personal observations.
"Let them work from home"
seems to be the silver bullet for
every second startup and even some big companies like
[Buffer](https://open.bufferapp.com/remote-team-connect/),
[Automattic](https://www.linkedin.com/pulse/billion-dollar-tech-company-offices-email-glenn-leibowitz),
[Groove](https://www.groovehq.com/blog/remote-work-tips),
and
[many others](https://www.forbes.com/sites/laurashin/2017/01/31/work-from-home-in-2017-the-top-100-companies-offering-remote-jobs/).
However, in most cases, the replacement of a brick-and-mortar office with a virtual one
doesn't help companies and their ~~slaves~~ employees
become more productive.

<!--more-->

{% jb_picture_body %}

Working from home, also known as working from anywhere,
working remotely, or simply telecommuting, usually leads to four
radical changes:

  * First, we replace office security cameras on the ceiling with screen
    _monitoring_ software and/or web cameras that constantly watch us.
    [Upwork does](https://support.upwork.com/hc/en-us/articles/211064098-Log-Time-with-the-Upwork-Desktop-App-)
    it to its thousands of ~~monkeys~~ freelancers,
    requiring them to install a background screen capture utility
    and make sure it is running during their entire working time.

  * Second, we replace meeting rooms with conference software
    like [Zoom](https://zoom.us/) or good old [Skype](https://www.skype.com/en/),
    and [learn](https://hbr.org/2015/03/how-to-run-a-great-virtual-meeting)
    how to make _virtual meetings_ productive. The main principle is similar to
    the one we use for traditional meetings: Make it fun. Otherwise we will
    switch to Facebook or PokerStars while the manager is
    still ~~acting~~ talking in her window.

  * Third, we replace Post-it stickies and Scrum boards with tickets and
    tasks in [Trello](https://trello.com/)
    or [any other](https://www.quora.com/What-are-the-best-alternatives-to-Trello)
    _task tracker_.
    We keep everybody busy learning new tools and filling them with data.

  * Fourth, and most importantly, we replace office chit-chats with
    [Slack](https://slack.com/) channels or [HipChat](https://www.hipchat.com/) groups.
    Instead of being in the office at 9 a.m.,
    everybody will have the ability to demonstrate the level of their
    [presenteeism](https://en.wikipedia.org/wiki/Presenteeism) using emojis.

Your life, as a developer, will be very different on a team that
works remotely. It will be full of real freedom. However, there will be
certain problems:

**It's Harder to Prove Innocence**.
How does your
[manager]({% pst 2017/jun/2017-06-06-gluten-free-management %}) know you're actually working,
not watching TV, playing with your kids, or grooming your favorite
open source pets? In the office, it's easier; you just sit in front of the monitor
and the boss is happy. At home or in a coffee shop, you are
[guilty]({% pst 2019/sep/2019-09-03-injection-of-guilt %}) by
default until you prove the opposite by creating new tickets,
posting emojis to Slack, and sending emails with multiple CCs.

**It's Harder to Find Information**.
In the office, you can always ask your question out loud for
the most knowledgeable person to help you. Remotely, however, you will have
to search Wiki pages, Google Docs,
and, god forbid, Git logs. Be prepared for almost nobody
to be interested in sharing knowledge or teaching you remotely---what
is the point if nobody sees him doing it? You will be on your own
in front of that year-old documentation made by someone fired
right after writing it up.

**It's Harder to Avoid Overtime**.
In the office, you just walk away with everybody else when time is up. Remotely,
you will have phone calls and Slack discussions in the middle of the night on Sunday,
especially if the team is distributed across multiple time zones. Everybody
will expect 24-7 availability because you're working from home. And changing
the status to "Do not disturb" in Skype will only offend them and seriously
damage your reputation. In a work-from-home environment, good programmers are
those who are always online.

**It's Harder to Defend Yourself**.
You won't know where to expect the next bout of trouble from. In the office,
you can visually observe the territory, smell conflict in the air, see
how people move, what they talk about, and who is the next victim. Remotely,
you're sitting in isolation, extracting pieces of information from Slack.
You can easily become the next victim without even noticing it. Simply put,
they will stab you in the back while you're writing Java and thinking
about a new unit test.

**It's Harder Not to Waste Time**.
It sounds counter-intuitive, but while sitting at home, you waste much more time
than in the office. Meetings will be called more frequently, and they will
be less effective, thanks to constant issues with scheduling, quality of
connection, software failure, and of course a lack of online communication
skills. The manager will call more meetings largely in order to convince
himself that the team is actually working; hearing your voice many times a day is
a perfect confirmation that you are busy and he is a good manager.

{% quote Remote work will happen automatically as soon as everybody starts getting their paychecks for the results they deliver, not the time they spend. %}

On a more serious note, I believe that working remotely
only makes things _worse_ when the motivation of the team
is still based on [hourly pay]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %}).
A slave working remotely is still a slave. Moreover, this slave
is harder to manage and control. First, we have to switch to a results-based
payment model and then go remote. Actually, remote work will happen automatically
as soon as everybody starts getting their paychecks for the results they
deliver, not the time they spend. They will simply stop showing up at the office,
but their results will keep coming to the project,
without any web cameras or Slack channels.

It's no surprise that many big companies have already decided to stop this telecommuting
nonsense and put their slaves back behind closed doors; take
[Google](https://www.tbray.org/ongoing/When/201x/2014/02/19/Leaving-Google),
[Yahoo](http://money.cnn.com/2013/02/25/technology/yahoo-work-from-home/index.html?iid=EL), and
[Best Buy](http://money.cnn.com/2013/03/05/technology/best-buy-work-from-home/index.html)
for example.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">After switching from in-the-office to remote work your performance ...</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1249367849073872900?ref_src=twsrc%5Etfw">April 12, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
