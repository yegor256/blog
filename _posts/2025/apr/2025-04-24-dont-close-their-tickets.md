---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Let the Bug Reporter Have the Last Word"
date: 2025-04-24
place: Sochi, Russia
tags: mood oss
description: |
  Even if the fix looks obvious to you, don't close the bug report;
  instead, let its author do this after your request.
keywords:
  - triaging rules
  - bug triaging
  - close bug
  - who can close bug
  - close a bug
image: /images/2025/04/analyze-this.jpg
jb_picture:
  caption: Analyze This (1999) by Harold Ramis
---

Someone has submitted a bug report to your repository.
You fix the bug.
You close the bug report.
Stop.
This is wrong.
You shouldn't close it.
Instead, you should ask the reporter to review your fix.
Then, maybe, they will close the ticket.
If they don't, you make another fix, until they do.

<!--more-->

{% jb_picture_body %}

According to [Joel Spolsky], ``the only person who can close a bug is the person who opened it in the first place.''
But, why?
Why shouldn't you close it, when it's obvious that the bug is fixed?
There are at least three reasons.

First, this is **offensive** and **demotivating**.
Why do I report a bug or suggest a feature?
Because I'm not happy with your code in its current state.
Something is broken or doesn't work as expected.
I want you to fix it to make me happy.
I want you to confirm with me whether your fix has made me happy.
If you don't ask and simply close the ticket, I **feel** like I'm being **ignored**.
Why would I bother reporting another bug or feature request?

Second, this is a **quality threat**.
Quality is always a product of conflict.
The most productive conflict is the one between programmers and testers.
Testers try to prove that the software is bad by submitting bug reports.
Programmers try to prove that the software is good by covering it with tests.
If you close without confirmation from the reporter, you don't give them a chance to argue with you.
Of course, they may shrug their shoulders and reopen the ticket.
However, not everybody will do this, trying to avoid being disrespectful.
In the end, no formal acceptance---no quality.

Third, this leads to ticket **duplication**.
Most bug reporters won't argue when you close their tickets without asking their permission.
Instead, they will open new tickets with exactly the same or a similar description.
The most disciplined will refer to the original ticket.
Others will fill up the backlog with duplicates, making it messy.

<hr/>

There are a few exceptions, though.
If the ticket is an obvious duplicate, you close it right away.
No need to ask its author for permission.
If it's a question---not a bug report---you close it with an answer.
Also, if you aren't planning to fix it, attach the `won't fix` badge to it and close.

[Joel Spolsky]: https://www.joelonsoftware.com/2000/11/08/painless-bug-tracking/
