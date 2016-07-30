---
layout: post
title: "A Distributed Team Delivers Code of Higher Quality"
date: 2016-07-20
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
---

OK, the title is not exactly accurate. I've missed the "can" word. A distributed
team **can** deliver code of much higher quality, than a co-located one
and now I'll explain why. Of course, not every distributed team can do that.
Most of them can't even deliver code that works, don't even mention quality.
But if a team, a distributed one, is managed according to the principles
I'll explain now, the quality will be much higher than the same team can
achieve, if being co-located. What I'm going to show is that working in a
remote mode, if done right, **guarantees** higher quality of code. Surprised?

<!--more-->

There are basically four simple ingridents of success... You know, there is
actually _one_ main ingrident and its name is **control**. If we want quality
to be at some level, we have to **enforce** it. We can't just declare it, we
need to **make** it high.

How software teams make quality high? Oh, there are many proven methods.
First, you need a very modern office, where <del>programmers</del> developers
sit on cushion chairs, play table tennis, drink smoothies and write
diagrams on walls. Second, you should buy them many books. Books have to be
everywhere in the office, and they have to be about everything, from Python
and Haskell to Docker, Agile and lean startups. The more books, the higher
the quality of the code they write. And third, you have to pay them well. The
more expensive is the developer, the higher is the quality he or she writes.

I'm sure you understand that I'm joking. None of these "proven methods" will either
guarantee quality or motivate serious software engineers. Quality can
be achieved only if it is **controlled and enforced**. And this is also what
motivates programmers best of all &mdash; the fact that the quality
is so important for the management that they find mechanisms of
control and enforcement and invest in them. Table tennis and lean
startup books are not even close to those mechanisms.

So, now let's discuss that four ingridents of quality enforcement, which
we practice in our projects:

  * **Read-Only Master Branch**. Nobody can make changes directly to
    the master branch, neither the architect nor the project sponsor. The
    master branch is technically read-only. This means that in order
    to compromise the quality of our code everyone has to go through a
    pull request, pre-flight build and automated merge procedure.

  * **Chats Are Prohibited**. Any, even a very small, modification to
    our codebase, must be submitted in a pull request. A code review
    must also happen in the pull request. We strictly disallow any
    informal communications between programmers, including chats, phone
    calls, emails or face-to-face discussions. This means that chances
    of quality compromises due to friendship, informal agreements, and trade-offs
    are very low.

  * **Build Is Fragile**. We believe that the higher the quality bar, the more
    difficult it is to modify any piece of code without breaking the build.
    We put a lot of quality checks right into the build to make life
    of programmers full of trouble. Well, this is not our goal, but it
    happens. The code has to pass all static analysis
    checks, test coverage threshold, mutability threshold, and many others.
    This means that bad code won't reach the repo, ever.

  * **Micro Payments for Deliverables**. We pay only for closed tickets and
    they are very small (up to two hours). We don't pay for time spent
    in the office or in front of the computer. We pay only when that tickets
    are closed, &mdash; no close, no pay. This means that programmers are motivated
    to **close** them, nothing else.

Thus, as you can see, there is a conflict, intentionally created. On one hand
programmers have to close tickets and deliver working code. On the other
hand, it's rather difficult to do, because quality bar is high, there is
no chance to make compromises and there is no technical possibility to
go around. Good programmers survive in this conflict and manage to deliver
and get paid. Well paid.

And now, to the main point of this blog post &mdash; do you think it's possible
to build all that in a co-located team? I don't think so. First of all,
you won't be able to prohibit informal communications. No matter how many
times you will ask developers to communicate in tickets, they will resolve
most of their technical questions face-to-face. It's inevitable.

Second, you won't be able to pay for results only, because programmers will
complain that they are doing a lot of communications in the office, which
have to be paid somehow. In reality, they will spend 2-3 hours per day for
actually writing some code and the rest of the time will be spent on
coffee breaks, Trump talks and Facebook scrolling. Again, it's
inevitable.

And third, people are people. Nobody likes to hit that quality bar
multiple times a day. They will complain and eventually you will give them
direct access to the master branch. First, you will give it to the architect,
then to a few senior developers, then to a few good friends who you
absolutely trust. Then, to everybody, just in case. It's inevitable.

To summarize, I believe that co-located teams are just not made for
quality programming. For fun &mdash; yes. For creativity &mdash; maybe.
For burning investor's money &mdash; absolutely. For quality &mdash; not really.

