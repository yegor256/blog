---
layout: post
title: "A Distributed Team Delivers Code of Higher Quality"
date: 2016-07-20
place: Las Vegas, NV
tags: management
description: |
  ...
keywords:
  - ...
  - ...
  - ...
  - ...
  - ...
---

OK, the title is not exactly accurate. I've missed the "can" word. A distributed
team **can** deliver code of much higher quality, than a co-located team
and now I'll explain why. Of course, not every distributed team can do that.
Most of them can't even deliver code that works, forget about the quality.
But if a team, a distributed one, is managed according to the principles
I'll explain now, the quality will be much higher than the same team can
achieve, if being co-located. What I'm going to show is that working in a
remote mode, if done right, **guarantees** higher quality of code. Surprised?
Follow my logic.

<!--more-->

There are basically four simple ingridents of success... You know, there is
actually one main ingrident and it's name is **control**. If we want quality
to be at some level, we have to **enforce** it. We can't just declare it, we
need to **make** it high.

How usually software teams make quality high? Oh, there are tons of methods.
First, you need a very modern office, where <del>programmers</del> developers
will sit on cushion chairs, play table tennis, drink smoothies and write
on the walls. Second, you should buy them many many books. Books have to be
everywhere in the office, and they have to be about everything, from Python
and Haskell to Docker, Agile and lean startups. The more books, the higher
the quality of the code they write. And third, you have to pay them well. The
more expensive is the developer, the higher the quality.

I'm sure you understand that I'm kidding. None of these methods will either
guarantee quality or motivate serious software engineers. Quality can
be achieved only if it is controlled and enforced. And this is also what
will motivate programmers best of all &mdash; the fact that the quality
is so important for the management that they found mechanisms of
control and enforcment and invested into them. Table tennis and lean
startup books are not any of those mechanisms.

So, now let's discuss that four ingridents of quality enforcement, which
we practice in our projects:

  * **Read-Only Master Branch**. Nobody can't make changes directly to
    the master branch, neither the architect nor the project sponsor. The
    master branch is technically read-only. This means that in order
    to lower the quality of our code everybody has to go through a
    pull request procedure.

  * **Chats Are Prohibited**. Any, even a very small, modification to
    our codebase, must be submitted in a pull request. A code review
    must also happen in the pull request. We strictly disallow any
    informal communications between programmers, including chats, phone
    calls, emails or coffee breaks. This means that there won't be any
    friendship and that's why quality compromises.

  * **Quality Bar is High**. We believe that the quality of code


strict build: static analysis etc

pay for result
