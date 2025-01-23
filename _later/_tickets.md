---
layout: post
title: "25 Rules of Ticketing"
date: 2019-07-23
place: Moscow, Russia
tags: management
description: |
  ...
keywords:
  - tickets
  - management by tickets
  - micro tasking
  - tasks and tickets
  - ticketing
image: /images/2017/12/
jb_picture:
  caption:
---

I wrote [Five Principles of Bug Tracking]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %})
three years ago. This new blog post is a refinement of the point
I tried to deliver back then. Here is a list of my best practices, habits,
principles, and recommendations for those who manage their software
development projects using ticket tracking systems, like [JIRA](https://www.atlassian.com/software/jira),
[GitHub](https://github.com), or what have you.

<!--more-->

{% jb_picture_body %}

Always start your comments with the name of the recipient, like I did
[here](https://github.com/zerocracy/datum/issues/222#issuecomment-358065191);
here is [why]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %}#4-avoid-noiseaddress-your-comments).

Always report problems, not solutions&mdash;ticket title and description must explain
what is broken, not how it should be fixed;
here is [why]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %}#5-report-when-it-is-broken).

Never start discussions, always report problems;
if something is not clear&mdash;it's a bug in the documentation.

Never re-open tickets;
always start a new one, even if the same problem re-appears.

Always link a new ticket to an existing one, if they are relevant.

Always be closing;
remember that your primary and only objective is to
change the status of the ticket from "open" to "closed," if it is assigned to you;
here is [why]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %}#2-close-it).

Never close, as a ticket reporter, unless you see something tangible;
here is [why]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %}#3-dont-close-it)

Always mention a pull request where you solved the problem,
like it was done
[here](https://github.com/zerocracy/farm/issues/404#issuecomment-360015046).

Never discuss problems outside of their tickets, like it was done
[here](https://github.com/zerocracy/farm/pull/439#issuecomment-360698197);
always keep all discussions inside the ticket they belong to.

Never close tickets that you didn't create; ask their authors to close them.

Always be very critical about new tickets&mdash;don't accept them to the
project unless you are absolutely sure they make sense.

Never submit bugs that don't exist in master, but only in your branches,
like it was done [here](https://github.com/yegor256/jpeek/issues/128);
instead, use PDD or [cut corners]({% pst 2015/jan/2015-01-15-how-to-cut-corners %}).
