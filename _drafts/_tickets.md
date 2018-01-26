---
layout: post
title: "25 Rules of Ticketing"
date: 2018-01-10
place: Moscow, Russia
tags: management
description: |
  ...
keywords:
  - ...
  - ...
  - ...
  - ...
  - ...
image: /images/2017/12/
jb_picture:
  caption:
---

I wrote [Five Principles of Bug Tracking]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %})
three years ago. This blog post is a refinement of the point
I tried to deliver back then. Here is a list of my best practices, habits,
principles, and recommendations for those who manage their software
development projects using ticket tracking systems.
I'm planning to update this page regularly.

<!--more-->

{% jb_picture_body %}

Always start your comments with the name of the recipient, like I did
[here](https://github.com/zerocracy/datum/issues/222#issuecomment-358065191);
here is [why]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %}#4-avoid-noiseaddress-your-comments).

Always report problems, not solutions&mdash;ticket title and description must explain
what is broken, not how it should be fixed;
here is [why]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %}#5-report-when-it-is-broken).

Never re-open tickets;
always start a new one even if the same problem re-appears.

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
