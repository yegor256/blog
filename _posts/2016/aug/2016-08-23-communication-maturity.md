---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Eight Levels of Communication Maturity"
date: 2016-08-23
tags: management
place: Tallinn, Estonia
description: |
  Chats, emails, phone calls, mailing lists, issue
  tracking systems, face-to-face meetings, and other
  communication instruments for a software project.
keywords:
  - meetings
  - slack project management
  - skype meetings
  - github
  - bitbucket
image: /images/2016/08/schizopolis.jpg
jb_picture:
  caption: Schizopolis (1996) by Steven Soderbergh
---

Each software team organizes its communications in its own
specific way. Some use Slack, Trello, or GitHub; others just sit together
in the same room. There are many methods and tools. I believe
it's possible to rank them by the amount of _damage_ they cause
to your project. This is the list of all of them I'm aware of at the moment.

<!--more-->

{% jb_picture_body %}

The damage I'm talking about is caused mostly by the distance between these communication
channels and project artifacts. The farther away people stay from documents,
the bigger the risk of [losing information]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %}).
And lost information is the first source of trouble in any project.

Here is the list; it starts with the most damaging communication means
and goes down to the most _mature_ and professional ones, which cause the
least amount of trouble:

  * **Coffee Breaks**.
    This is the most dangerous thing---you can never
    keep track of them, you won't know what they were about, and there
    is no "search" button anywhere. Everything you say standing next
    to that coffee machine will be lost. Nothing will be converted
    to project artifacts.

  * **Phone Calls**.
    A bit better than coffee breaks but still a big issue. Phone calls
    are completely untraceable. Information you
    exchange on those calls is gone forever. Well, you can record them,
    but searching through phone call records is a tough task that nobody will
    do, ever.

  * **Meetings**.
    This is the next step after coffee breaks, because there is some structure
    and minutes. Meetings can be recorded (both on and offline), with their results filed somewhere
    and decisions documented. In reality, none of that will actually happen.
    Meetings will just kill your time and your sponsor's money.

  * **Emails**.
    If you can put some formality into emails and discipline all participants,
    your email history may be considered a project artifact in itself. How
    organized and easily browseable will that artifact be? That's a good question.
    In most cases, it will just be a mess.

  * **Mailing Lists**.
    They are better than emails, because some software is archiving them and
    making them available and browseable. But it will be difficult to find where
    exactly what topic was discussed, where decisions were made and why,
    who suggested what, etc.

  * **Slack**.
    There are many similar alternatives that are basically online chats.
    The main problem with all of them is that it's difficult to categorize
    such a chat, group messages together, or find something later. It's merely a flow
    of information that becomes useless just a few days after. Of course,
    if you really want to find something there, it's possible. But the quality
    of such a "document" is very low.

  * **Trello**.
    By Trello I mean any task/ticket tracking system---they are great instruments
    to immediately turn conversations and discussions into project artifacts.
    You don't need to document anything; it's already there. The problem is
    that they are still rather far away from the main project artifact:
    the source code with its commits, merge conflicts, build logs, etc.

  * **GitHub**.
    This is the best instrument you can use. It integrates communications
    with the product itself. The code you write and the discussions you
    have around it are literally in the same place.

Which one of these is your project using right now? I would strongly recommend
you stay away from communication channels at the top of this list.
