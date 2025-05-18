---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Good Title — Good Bug Report"
date: 2025-05-25
place: Moscow, Russia
tags: management testing
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
Once an issue is created, the plugin asks ChatGPT---or DeepSeek, or Claude---to improve its title.
We've already integrated the plugin into [objectionary/eo] and a few other repositories.
Works like a charm.
What's wrong with the titles the way they are, you may ask?
Why do we need to ask ChatGPT to make them "better"?
It's simple and important.
A properly formulated problem---this essentially is a title---leads to faster and more accurate bug resolution.

<!--more-->

{% jb_picture_body %}

Let's say, you try to download a PNG file, but get a text file instead.
You want to report this problem to the team.
How would you title such a bug report?
Pick one, out of these five:

* "CSV file downloading"
* "Fix CSV-file downloading feature"
* "Why I get text file instead of PNG?"
* "I need text file, not PNG"
* "PNG file downloading is broken"

Now, let's say you want to be able to download a PDF file.
How would you title this feature request?
Pick one:

* "PDF files"
* "Immplement PDF file feature"
* "Why don't have have PDF feature?"
* "CSV files are not enough, PDF needed"
* "I can't download PDF file"

Finally, let's say you want to fix the PDF feature.
However, you don't understand into which package you should put new Java classes.
You decide to submit a ticket, asking the team for help.
How would you title such a request?
Pick a title:

* "Java packages"
* "Where should I place my classes?"
* "Why classes are misplaced?"
* "Not clear where new Java classes belong"
* "Layout of Java classes is not documented"

I can continue with examples.
They will all look similar.
I believe, you've already figured out that the best titles are the last in the lists.

You may disagree and say that it's a matter of taste.
That's true.
A matter of bad taste vs. good taste.

If the taste is bad, ticket are titled chaotically.
If the taste is good, tickets are **uniformly** named.

There are three styles of naming I can think of:

* A **summary** briefly explains what the problem is about,
for example "PDF-downloading";

* An **order** tells the person who fixes the issue what needs to be done,
for example "Implement PDF-downloading";

* An **offense** blaims the product for the absence of the feature
or the presence of the bug, for example "I can't download PDF".

We prefer the third style.
Because we believe that every ticket much be a bug report.
We---and [Mozilla]---call it **bug-driven development**.

[@horw]: https://github.com/horw
[issue-title-ai]: https://github.com/horw/issue-title-ai
[objectionary/eo]: https://github.com/objectionary/eo
[Mozilla]: https://www.researchgate.net/publication/2559439_An_Overview_of_the_Software_Engineering_Process_and_Tools_in_the_Mozilla_Project
