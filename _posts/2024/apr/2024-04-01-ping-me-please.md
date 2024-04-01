---
layout: post
title: "Ping Me, Please!"
date: 2024-04-01
place: Moscow, Russia
tags: mood
description: |
  ...
keywords:
  - code review
  - open source
  - programming team
  - collaborative programming
  - communications in github
image: /images/2024/04/
jb_picture:
  caption: ...
---

There is a big difference between distributed and colocated teams: the
communication in distributed teams is asynchronous, which essentially
means that when you ask something, a response doesn't arrive
immediately. Moreover, it may never arrive. This can be very
uncomfortable for those who are used to the office work setup, where
most communications are synchronous: any question is answered
immediately, one way or another. In open-source repositories,
everything is asynchronous. Here is a simple rule that may help you
decrease the level of frustration in GitHub projects: ping them every
time you need an answer or attention to be paid to your code.

<!--more-->

{% jb_picture_body %}

There are four basic scenarios:

* You submitted a new issue?
Post a message asking project architect to pay attention.
Otherwise, the owner of the backlog may miss your issue and it will
not be resolved, for a long time.

* You sent a new pull request?
Post a message right in the PR, asking the architect to review it.
Otherwise, the architect may simply miss the pull request and
it will stay in "waiting for review" state for a long time.

* You made changes in a pull request, after code reviewers asked you?
Post a message, asking them to look at your code again.
Otherwise, they may never see the changes you just made.

* You post any message in an issue or a pull request?
[Start it]({% pst 2020/jul/2020-07-29-open-source-etiquette %})
with the nickname of a person who you talk to.
Otherwise, the person who should help you may not receive
a notification about your message and it will be missed.

Also, listen to what Ben Batler from GitHub
[said once](https://ben.balter.com/2014/11/06/rules-of-communicating-at-github/):
You essentially _never_ "walk over" to a coworker's desk, virtual or otherwise.
Whenever possible, prefer issues and chat, to "just in time" communications.
