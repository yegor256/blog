---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Good Title — Good Bug Report"
date: 2025-05-31
place: Moscow, Russia
tags: etiquette testing
description: |
  ChatGPT helps us re-format GitHub issue titles
  after their authors submit them --- helping developers
  understand their tasks better.
keywords:
  - bug report title
  - bug title
  - how to make a title for a bug
  - ticket title
  - github issue title
image: /images/2025/05/flawless.jpg
jb_picture:
  caption: Flawless (1999) by Joel Schumacher
---

A few weeks ago, [@horw] released a new GitHub plugin that fixes GitHub issue titles: [issue-title-ai].
Once an issue is created, the plugin asks [ChatGPT]---or [DeepSeek], or [Claude]---to improve its title.
We've already integrated the plugin into [objectionary/eo] and a few other repositories.
Works like a charm.
What's wrong with the titles the way they are, you may ask?
Why do we need to ask ChatGPT to make them "better"?
Because we want every issue---either a bug report, a feature request, or a question---to be formulated as a [complaint]({% pst 2025/may/2025-05-25-bug-driven-development %}).
It seems that very few of us can do it on the first try.
The help of AI is appreciated.

<!--more-->

{% jb_picture_body %}

Let's say, you try to download a PNG file from a web app, but get a text file instead.
You want to report this problem to the team.
How would you title such a bug report?
Pick one, out of these eight:

* "CSV"
* "CSV file downloading"
* "Please, fix CSV-file downloading"
* "CSV downloading must be fixed"
* "Why I get text file instead of PNG?"
* "How can I download PNG file?"
* "I need text file, not PNG"
* "PNG downloading is broken, getting CSV instead"

There may be even more variations... but the best is the last one.
It clearly states that something is **broken**.
It demands a fix.

Even if it's a feature request or a question, it should be filed as a complaint.
This rule---known as [bug driven development]({% pst 2025/may/2025-05-25-bug-driven-development %})---increases our productivity.
In every request made to the team we have to explain the difference between our expectations and reality.
The lack of such an explanation seems to be the primary source of confusion and frustration in task tracking.

Apparently, very few programmers have this skill: formulating a problem as a complaint.
AI should help us.

[@horw]: https://github.com/horw
[issue-title-ai]: https://github.com/horw/issue-title-ai
[objectionary/eo]: https://github.com/objectionary/eo
[Mozilla]: https://www.researchgate.net/publication/2559439_An_Overview_of_the_Software_Engineering_Process_and_Tools_in_the_Mozilla_Project
[ChatGPT]: https://chatgpt.com
[Claude]: https://claude.ai/
[DeepSeek]: https://www.deepseek.com/
