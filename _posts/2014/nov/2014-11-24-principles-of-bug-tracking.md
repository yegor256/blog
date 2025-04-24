---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Five Principles of Bug Tracking"
date: 2014-11-24
tags: management
description: |
  Managing work in a ticketing system requires more
  discipline than with a co-located team; this article
  explains which is the most important.
keywords:
  - ticket management system
  - task tracking discipline
  - task management online
  - task management software
  - task management system
image: /images/2014/11/monty-python-argument-sketch.png
jb_picture:
  caption: Monty Python Flying Circus, TV Series (1969-1974)
---

A team working [remotely]({% pst 2014/sep/2014-09-22-remote-programming-interview %})
requires much stronger discipline than
a co-located crew sitting in the same
[office]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %}).
First of all, I mean discipline of
communications. At [Zerocracy](https://www.zerocracy.com), we have developed software
remotely for the last five years. We manage tasks strictly through
ticketing systems (like GitHub, JIRA, Trac, Basecamp, etc.) and
[discourage]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %})
any informal communications, like Skype, HipChat,
[emails]({% pst 2017/apr/2017-04-18-no-help-via-email %}), or phone calls.
Every ticket for us is an isolated task with its own life cycle,
its own participants, and its own goal. Over these years, we've learned
a few lessons that I want to share. If you also work
[remotely]({% pst 2017/may/2017-05-02-remote-slaves %}) with your
team, you may find them useful.

<!--more-->

{% jb_picture_body %}

## 1. Keep It One-on-One

Each ticket (aka "bug") is a link between two people: problem specifier and problem
solver. If it is a bug, I'm reporting it---you're solving it. If it is
a question, I'm asking for an explanation---you're explaining. If it
is a task, I'm ordering you to do it---you're doing it. In any case,
there are two main characters. No matter how many people are involved in the ticket
resolution, only these two characters have formal roles.

{% quote Remember what is happening there — one person is selling his solution to another person. %}

The responsibility of the ticket reporter is to _defend the problem_. When I
[report a bug]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %}),
I have to [insist]({% pst 2020/jul/2020-07-29-open-source-etiquette %})
that it exists---this is my job. Others
may tell me that I'm wrong and the bug is not there. They may tell
me that they can't reproduce it. They may say that my description of
a task is too _vague_ and nobody understands it. There may be many issues
of that kind. My job is to do the best I can in order to *keep the ticket alive*.
Obviously, if the bug is not reproducible, I'll be forced to close
the ticket. However, until the ticket is closed, I'm its guardian angel.

{% youtube 7DYr8GYzJ6Q %}

On the other hand, the responsibility of the ticket solver is to
_defend the solution_. When a ticket is assigned to me and I have to resolve it,
my job is to [convince]({% pst 2020/jul/2020-07-29-open-source-etiquette %})
the reporter that my solution is good enough. He may
tell me that my solution is not sufficient, not the most efficient, or
incomplete. My job is to insist that I'm right and he is wrong. Well, of course,
in a reasonable way. And in order to create a solution that will be
accepted as sufficient enough, I have to understand the problem first, investigate
all possible options, and propose the most elegant implementation. But all this
is secondary. The first thing I will be focused on is how to convince
the reporter. I will always remember that my primary goal is to *close the ticket*.

My point here is that no matter how many people are involved in the
ticket discussion, always remember what is happening there---one
person is selling his solution to another person. Everybody else around
them is help or distraction (see below).

## 2. Close It!

Remember that a ticket is
[not a chat]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %}).
You're not there to talk.
You're there to *close*. When the ticket is assigned to you,
focus on closing it as soon as possible
([Always Be Closing](https://www.youtube.com/watch?v=wVQPY4LlbJ4), remember?).

Also, keep in mind that the sooner you close the ticket, the better job
you will do for the project. Long-living tickets are a
[management]({% pst 2017/jun/2017-06-06-gluten-free-management %}) _nightmare_.
It is difficult to track them and control them. It's difficult to understand
what's going on. Have you seen those two-year-old tickets in
[open source projects]({% pst 2015/dec/2015-12-22-why-dont-you-contribute-to-open-source %})
that have hundreds of comments and no deliverables? It is a mistake
by their
[project managers]({% pst 2015/sep/2015-09-22-micromanagement %})
and ticket participants. Each ticket should be
short and focused---1) a problem, 2) a refinement
question, 3) a short explanation, 4) a solution, 5) closed, thanks everybody.
This is an ideal scenario.

{% quote Long-living tickets are a management nightmare. %}

As soon as you realize that your ticket is turning into a long discussion,
try to close it even faster. How can I close it if the reporter doesn't
like my solution? Find a temporary solution that will satisfy the reporter
and allow you to close the ticket. Use "TO-DO" in your code or dirty
workarounds---they are all better than a ticket hovering for a long time.

Once you see that the solution is provided and is sufficient enough
to close the ticket, ask its reporter to close it. Explicitly ask for that;
don't dance around with "looks like this solution may be accepted, if you don't mind."
Be explicit in your intention to close the ticket and move on. Try this:
"@jeff, please close the ticket if you don't have any further questions."

## 3. Don't Close It!

Every time you raise a bug and create a new ticket, you consume project
resources. Every bug report means money spent on the project: 1) money for your time
spent finding the problem and reporting it; 2) for the time of the
[project manager]({% pst 2016/may/2016-05-24-who-is-project-manager %})
who is working with the ticket and finding who will fix it; 3) for the time
of the ticket solver, who is trying to understand your report and provide
a solution; and also 4) for the time of everybody else who will participate
in the discussion.

{% quote Anything would work, but not nothing. %}

If you close the ticket without a problem being properly solved,
you put this money into the _trash_ bin. Once the ticket is started, there
is no way back. We can't just say, "Nah, ignore it; it's not important anymore."
Your ticket already consumed project time and budget resources, and in order to turn
them into something useful, you have to make sure that *some*
solution is delivered.

It can be a temporary solution. It can be a single line change in the
project documentation. It can be a TO-DO marker in the code saying that
"we are aware of the problem but won't fix it because we're lazy." Anything
would work, but not nothing.

Look at it from a different perspective. When you started that ticket, you had
something in mind. Something was not right with the product. That's why you
reported a bug. If you close the ticket without anyone even touching that place
of code, someone else will have the same concern in a few days or a few years.
And then the project will have to _pay again_ for a similar ticket or discussion
of the same problem. Even if you're convinced that the issue you found in
the code is not really an issue, ask a ticket resolver to document it right
in the source code in order to prevent such confusion from happening again in the future.

## 4. Avoid Noise---Address Your Comments

Every time you post a message to the ticket, address it to someone. Otherwise,
if you post just because you want to express your opinion, your
comments become communication _noise_. Remember, a ticket is a conversation
between two people---one of them reported an issue and the other one is
trying to fix it. Comments like, "How about we try another approach"
or "I remember I had a similar issue some time ago" are very annoying
and distracting. Let's be honest, nobody really needs or cares about "opinions."
All we need in a ticket is a solution(s).

{% quote Don't pollute the air with generic opinions. %}

If you think the ticket should be closed because the introduced solution
is good enough, [address]({% pst 2024/apr/2024-04-01-ping-me-please %})
your comment to the ticket reporter. And start
it with "@jeff, I think the solution you've got already is good enough, because..."
This way, you will help the assigned to close the ticket and move on.

If you think the solution is wrong, address your comment to the assignee
of the ticket, starting with "@jeff, I believe your solution is not good enough
because..." This way, you will help the ticket reporter keep the ticket
open until a proper solution comes up.

Again, don't pollute the air with generic opinions. Instead, be very specific
and take sides---you either like the solution and want the ticket to
be closed, or you don't like it and want the ticket to stay open. Everything
in between is just making the situation more complex and isn't helping the
project at all.

## 5. Report When It Is Broken

I think it is obvious, but I will reiterate: Every bug has
to be reproducible. Every time you
[report a bug]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %}), you should explain
how exactly the product is broken. Yes, it is your job to prove that the
software doesn't work as intended, or is not documented properly, or
doesn't satisfy the
[requirements]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %}), etc.

Every bug report should follow the same simple formula: "This is what we *have*,
this is what we *should have* instead, so fix it." Every ticket, be it a bug,
a task, a question, or a suggestion, should be formatted in this way. By
submitting it, you're asking the project to move from point A to point B. Something
is not right at point A, and it will be much better for all of us to be
at that point B. So it's obvious that you have to explain where these points
A and B are. It is highly desirable if you can explain
how to get there---how to reproduce a problem and how to fix it.

{% quote Your job, as a ticket reporter, is to draw that line from point A to point B. %}

Even when you have a question, you should also follow that format. If you
have a question, it means the project documentation is not sufficient
enough for you to find an answer there. This is what is broken. You should
ask for a fix. So instead of reporting, "How should I use class X?," say
something like, "The current documentation is not complete; it doesn't explain
how I should use class X. Please fix."

If you can't explain how to get there, say so in the ticket: "I see that
this class doesn't work as it should, but I don't know how to reproduce
the problem and how to fix it." This will give everybody a clear message
that you are aware that your [bug report]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %})
is not perfect. The first step
for its resolver will be to refine the problem and find a way to reproduce it.
If such a replica can't be found, obviously your bug will be forced into closing.

Let me reiterate again: Every ticket is dragging the project from point A,
where something is not right, to point B, where it is fixed. Your job,
as a ticket reporter, is to draw that line---clearly and explicitly.
