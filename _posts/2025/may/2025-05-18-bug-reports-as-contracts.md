---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "No BTW in Bug Reports"
date: 2025-05-18
place: Moscow, Russia
tags: mgmt testing
description: |
  Keep your ticket focused---one issue per report, no distractions,
  no "by the way"---this is how you help your team achive higher efficiency.
keywords:
  - bug reports
  - bug reporting
  - quality of bugs
  - good bug report
  - discipline of bug reporting
image: /images/2025/05/bronx-tale.jpg
jb_picture:
  caption: Bronx Tale (1993) by Robert De Niro
---

Every ticket---a bug report or a feature request---is a short-term contract.
You, the reporter, hire them to make a fix or implement a feature.
They, the team of developers, do it for you---provided you pay, or their motivation is intrinsic---for example, in open source.
The discussion that happens along the way may help clarify the requirements of the contract.
It may also help the team convince you that the bug doesn't deserve a fix.
Also, it may help them deliver the fix to you and convince you to close the ticket.
However, the discussion may also **distract** both parties if it loses focus.

<!--more-->

{% jb_picture_body %}

This is how it happens:

```text
Bug #42: The CSV file is saved in the wrong format.
Team: Can you provide an example?
You: Sure, here it is (attached).
Team: Looks like quotes are missing, we'll fix it.
You: BTW, why does the file have no header line?
Team: This is another problem, report it separately.
```

Indeed, the missing header line might also be a bug.
It's related to the issue you just reported---but it's not part of the contract you've established with the team.
Answering your question could distract them and blur their focus.
You don't want that.
You want them to stay focused on the problem at hand.

A few more good recipes to distract them:

* "**BTW**, it would be great to have another feature that..."

* "**BTW**, why this code is designed this way?"

* "**BTW**, I wonder, how this works?"

All of these questions, complaints and suggestions are perfect candidates for new bug reports.

You might think a ticket is an opportunity to [chat]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %}) with the team.
They're already responding---so why not ask all your questions while you have their attention?
It feels like they're interested, so you don’t want to lose the momentum.
But that's a false assumption.
They're [not motivated]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %}) to keep the discussion open.
What they really want is to close the ticket---ASAP.
Dragging out the conversation only risks **annoying** them.

{% quote Nothing hurts a software team more than a silent customer and an empty bug tracker. %}

You might also believe that submitting a ticket offends the team.
They already have a lot of work to do---why bother them with even more?
Every bug report or feature request might seem like an extra burden on their shoulders.
But again, that's a false belief.
Bug reports are the [fuel]({% pst 2018/feb/2018-02-06-where-to-find-more-bugs %}) for their engines.
They [need]({% pst 2014/apr/2014-04-13-bugs-are-welcome %}) your tickets.
First, because they help clarify requirements.
Second, because they provide a sense that their work is **needed** and **appreciated**.
Nothing hurts a software team more than a silent customer and an empty bug tracker.

So, avoid saying "BTW" when talking to the team in a ticket.
Stick to requesting a fix for the bug you originally reported.
If something else comes to mind along the way---whether it's a question, another bug, or a feature request---submit a **new ticket**.
We—and [Mozilla]—believe that every ticket should be a [bug report]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %}).

You might also consider moving the conversation to a mailing list, as [suggested by Karl Fogel].
Or even to Slack or Telegram.
But I [don’t recommend]({% pst 2016/aug/2016-08-23-communication-maturity %}) it.

[suggested by Karl Fogel]: https://producingoss.com/da/bug-tracker-usage.html
[Mozilla]: https://www.researchgate.net/publication/2559439_An_Overview_of_the_Software_Engineering_Process_and_Tools_in_the_Mozilla_Project
