---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "A Distributed Team Delivers Code of Higher Quality"
date: 2016-08-05
place: Las Vegas, NV
tags: management
description: |
  A properly configured distributed team of programmers
  can and must deliver a higher quality of code than
  a co-located one.
keywords:
  - software quality
  - software quality assurance
  - software quality control
  - remote programming
  - distributed programming
image: /images/2016/08/oceans-twelve.jpg
jb_picture:
  caption: Ocean's Twelve (2004) by Steven Soderbergh
---

OK, the title is not exactly accurate. I've missed the "can" word. A distributed
team _can_ deliver code of much higher quality than a co-located one,
and now I'll explain why. Of course, not every distributed team can do that.
Most of them can't even deliver code that works, let alone quality code.
But if a team---a distributed one---is managed according to the principles
I'll explain now, the quality will be much higher than the same team can
achieve if co-located. What I'm going to show you is that working in a
[remote mode]({% pst 2017/may/2017-05-02-remote-slaves %}),
if done right, _guarantees_ higher quality of code. Surprised?

<!--more-->

{% jb_picture_body %}

There are basically four simple ingredients to success ... you know what, there is
actually _one_ main ingredient, and its name is _control_. If we want quality
to be at some level, we have to _enforce_ it. We can't just declare it; we
need to _make_ it high.

{% quote Quality can be achieved only if it is controlled and enforced. %}

How do software teams make high-quality code? Oh, there are many proven methods.
First, you need a very modern office where ~~programmers~~ developers
sit on cushioned chairs, play table tennis, drink smoothies, and write
diagrams on walls. Second, you should buy them many books. Books have to be
everywhere in the office, and they have to be about everything from Python
and Haskell to Docker, Agile, and lean startups. The more books, the higher
the quality of the code they write. And third, you have to pay them well. The
more expensive the developer is, the higher the quality he or she writes.

I'm sure you understand that I'm joking. None of these "proven methods" will either
guarantee quality or motivate serious software engineers. Quality can
be achieved only if it is _controlled and enforced_. And this is also what
motivates programmers best of all---the fact that the quality
is so important for management that they find mechanisms of
control and enforcement, and they invest in them. Table tennis and lean
startup books are not even close to those mechanisms.

So, now let's discuss those four ingredients of quality enforcement, which
we practice in our projects:

  * **Read-Only Master Branch**. Nobody can make changes directly to
    the master branch; neither the architect nor the project sponsor. The
    master branch is technically read-only. This means that in order
    to compromise the quality of our code, everyone has to go through a
    pull request, pre-flight build, and automated merge procedure.

  * **Chats Are Prohibited**. Any modification to our code base, even a very small one,
    must be submitted in a pull request. A code review
    must also occur in the pull request. We strictly disallow any
    [informal communications]({% pst 2016/aug/2016-08-23-communication-maturity %})
    between programmers, including chats, phone
    calls, emails, or face-to-face discussions. This means that the chances
    of quality compromises due to friendship, informal agreements, and trade-offs
    are very low.

  * **Build Is Fragile**. We believe that the higher the quality bar, the more
    difficult it is to modify any piece of code without breaking the build.
    We put a lot of quality checks right into the build to make the lives
    of programmers more difficult. Well, this is not our goal, but it
    happens. The code has to pass all static analysis
    checks, a test coverage threshold,
    [mutation coverage](https://en.wikipedia.org/wiki/Mutation_testing) threshold, and many others.
    This means that bad code won't reach the repo, ever.

  * **Micro Payments for Deliverables**. We pay only for closed tickets, and
    they are each very small (up to two hours). We don't pay for time spent
    in the office or in front of the computer. We pay only when tickets
    are closed---no close, no pay. This means that programmers are motivated
    to _close_ them, nothing else.

Thus, as you can see, there is an intentionally created conflict. On one hand,
programmers have to close tickets and deliver working code. On the other
hand, it's rather difficult to do; because the quality bar is high, there is
no room to make compromises, and there is no technical possibility to
go around an issue. Good programmers survive in this conflict and manage to deliver
and get paid. Well-paid.

And now, to the main point of this blog post---do you think it's possible
to build all that in a co-located team? I don't think so. First of all,
you won't be able to prohibit
[informal communications]({% pst 2016/aug/2016-08-23-communication-maturity %}). No matter how many
times you ask developers to communicate in tickets, they will resolve
most of their technical questions face-to-face. It's inevitable.

{% quote People are people; nobody likes to hit that quality bar multiple times a day. %}

Second, you won't be able to pay for results only, because programmers will
complain that they are doing a lot of communication in the office that
has to be paid somehow. In reality, they will spend two to three hours per day on
actually writing code, and the rest of the time will be spent on
coffee breaks, Trump talks, and Facebook scrolling. Again, it's
inevitable.

And third, people are people. Nobody likes to hit that quality bar
multiple times a day. They will complain, and eventually you will give them
direct access to the master branch. First, you will give it to the architect,
then to a few senior developers, then to a few good friends who you
absolutely trust. Then to everybody, just in case. It's inevitable.

To summarize, I believe that co-located teams are just not made for
quality programming. For fun---yes. For creativity---maybe.
For burning investors' money---absolutely. For quality---not really.
