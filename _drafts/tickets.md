---
layout: post
title: "Ticket Discipline"
date: 2014-11-24
tags: mgmt
description:
  Managing work in ticketing system requires more
  discipline than with a co-located team, this article
  explains what is the most important
keywords:
  - ticket management system
  - task tracking discipline
  - task management online
  - task management software
  - task management system
---

A team working remotely requires much stronger discipline than
a co-located crew sitting in the same office. First of all, I mean discipline of
communications. In [teamed.io](http://www.teamed.io) we develop software
remotely for the last five years. We manage tasks strictly through
ticketing systems (like Github, JIRA, Trac, Basecamp, etc) and discourage
any informal communications, like Skype, HipChat, emails or phone calls.
Every ticket for us is an isolated task, with its own lifecycle,
its own participants, and its own goal. Over these years we've learned
a few lessons that I want to share. If you also work remotely with your
team, you may find them useful.

## Keep it One-on-One

Each ticket is a link between two people: problem specifier and problem
solver. If it is a bug, I'm reporting it &mdash; you're solving. If it is
a question, I'm asking for an explanation &mdash; you're explaining. If it
is a task, I'm ordering you to do it &mdash; you're doing. In either case,
there two main characters. No matter how many people are involved in ticket
resolution, only these two characters have formal roles here.

The responsibility of the ticket reporter is to **defend the problem**. When I
report a bug, I have to insist that it exists. This is my job. Others
may tell me that I'm wrong and the bug is not there. They will tell
me that they can't reproduce it. They will say that my description of
a task is too vague and nobody understands it. There may be many issues
of that kind. My job is to do the best I can in order to keep the ticket
alive. Obviously, if the bug is not reproducible, I'll be forced to close
the ticket. Until the ticket is closed, I'm its protecting angel.

On the other hand, the responsibility of the ticket solver is to
**defend the solution**. When a ticket is assigned to me and I have to resolve it,
my job is to convience the reporter that my solution is good enough. He will
tell me that my solution is not sufficient, not the most efficient, and
incomplete. My job is to insist that I'm right and he is wrong. Well, of course,
in a reasonable way. Of course, in order to create a solution that will be
accepted as sufficient enough, I have to understand the problem first, to investigate
all possible options and propose the most elegant implementation. But all this
is secondary. The first thing on what I will be focused is on how to convience
the reporter. I will always remember that my primary goal is to close the ticket.

My point here is that no matter how many people are involved in the
ticket discussion, always remember what is happening there &mdash; one
person is selling his solution to another person. Everybody else around
them, in most cases, is just noise.

## Close It!

Remember that a ticket is not a chat. You're not there to talk.
You're there in order to *close* it. When the ticket is assigned to you,
focus on closing it, as soon as possible.

Also, keep in mind, that sooner you close the ticket, the better job
you will do for the project. Long-living tickets is a management nightmare.
It is difficult to track them and control. It's difficult to understand
what's going on. Have you seen that year-old tickets in open source projects
that have hundrends of comments and no deliverables? It is a mistake
of their project managers and ticket participants. Each ticket should be
short and focused &mdash; 1) the problem, 2) a refinement
questions, 3) a short explanation, 4) a solution, 5) closed, thanks everybody.
This is an ideal scenario.

As soon as you realize that your ticket is turning into a long discussion,
try to close it even faster. How can I close if the reporter doesn't
like my solution? Find a temporary solution which will satisfy the reporter
and allow you to close the ticket. Use "TODO" in your code or dirty
workarounds &mdash; they are all better than a ticket waiting for a long time.

Once you see that the solution is provided and it is sufficient enough
to close the ticket &mdash; ask its reporter to close. Explicitly ask for that,
don't dance arround with "looks like this solution may be accepted, if you don't mind".
Be explicit in your intention to close the ticket and move on. Try this:
"@jeff please, close the ticket if don't have any further questions".

## Don't Close It!

Every time you raise a bug and create a new ticket, you consume project
resources. Every bug report means money spent by the project: 1) your time is
paid for finding the problem and reporting it, 2) the time of the project manager
who is working with the ticket and finding who will fix it, 3) the time
of the ticket solver, who is trying to understand your report and provide
a solution and also 4) time of everybody else who will take participation
in the discussion.

If you close the ticket without a problem being properly solved &mdash;
you put this money into the trash bin. Once the ticket is started, there
is no way back. We can't just say "nah, ignore me, it's not important any more."
Your ticket already consumed project time and budget and in order to turn
them into something useful, you have to make sure that *some*
solution is delivered.

It can be a temporary solution. It can be a single line change in the
project documentation. It can be a TODO marker in the code saying that
"we are aware of the problem but won't fix it because we're lazy". Anything
would work, but not nothing.

Look at it from a different perspective. When you started the ticket you had
something in mind. Something was not right in the product. That's why you
reported that bug. If you close the ticket without even touching that place
of code, someone else will have the same concern in a few days or a few years.
And then the project will have to pay again for a similar ticket/discussion
of the same problem. Even if you're convinced that the issue you found in
the code is not really an issue, ask ticket resolver to document it right
in the source code, to prevent such a confusion from happening in the future.

## Avoid Noise &mdash; Address Your Comments

Every time you post a message to the ticket, address it to someone. Otherwise,
if you post just because you want to express your opinion &mdash; your
comments becomes a communication noise. Remember, a ticket is a conversation
between two people &mdash; one of them reported an issue another one is
trying to fix it. Comments like "how about we try another approach"
or "I remember I had a similar issue some time ago" are very annoying
and distracting. Let's be honest, nobody really needs or cares about "opinions".
All we need in a ticket is solution(s).

If you think that the ticket should be closed because the introduced solution
is good enough &mdash; address your comment to the ticket reporter. And start
them with "@jeff I think the solution you've got already is good enough, because..."
This way you will help the assignee to close the ticket and move on.

If you think that the solution is wrong, address your comment to the assignee
of the ticket, starting with "@jeff I believe your solution is not good enough
because..." This way you will help ticket reporter to keep the ticket
open until a proper solution comes up.

Again, don't pollute the air with generic opinions. Instead, be very specific
and take sides &mdash; you either like the solution and want the ticket to
be closed, or you don't like it and want the ticket to stay open. Everything
in between is just making the situation more complex and isn't helping the
project at all.

## Report When It Is Broken

I think it is obvious, but I will re-iterate &mdash; every bug has
to be reproducible. Every time you report a bug, you should explain
how exactly the product is broken. Yes, it is your job to prove that the
software doesn't work as intended, or is not documented properly or
doesn't satisfy the requirements, etc.

Every bug report should follow the same simple formula: "this is what we have,
this is what we should have, fix it".

