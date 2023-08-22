---
layout: post
title: "How Micro Is Your Tasking?"
date: 2017-11-28
place: Moscow, Russia
tags: management xdsd zerocracy
description: |
  Micro-tasking is a management paradigm we've been
  practicing for over eight years, to the benefit
  of our programmers and project sponsors.
keywords:
  - micro-tasking
  - micromanagement
  - xdsd micro tasking
  - micro management
  - management tasking
image: /images/2017/11/carlitos-way.jpg
jb_picture:
  caption: Carlito's Way (1993) by Brian De Palma
buffer:
  - "\"What are you doing now?\"---when you hear this question from your boss, be aware: you're dealing with a micromanager"
  - "The more aggressive you are, the higher the chances you win"
  - "One of the key success factors for manageability is the famous 0/100 rule, which requires any task to be either \"in progress\" or \"complete.\" There can be nothing in the middle"
  - "In our projects we break project scope into tasks of 30 minutes each. This may sound too extreme for you, but it works for us"
  - "Money works. When tasks are very small, we can use good old dollar bills to motivate programmers. We can throw away literally all other instruments."
  - "Most professional and self-motivated developers were enjoying micro-tasking, while their less mature and less skilled colleagues were finding it difficult to keep up."
---

"What are you doing now?"---when you hear this question
from your boss, be aware: you're dealing with a
[micromanager]({% pst 2015/sep/2015-09-22-micromanagement %}).
Keeping us busy is the key objective of these creatures and this
is what makes them so annoying. To the contrary,
[effective managers]({% pst 2016/may/2016-05-24-who-is-project-manager %})
make sure we are _productive_, meaning that our results satisfy
their expectations. They are not interested in knowing what we are
doing to deliver them---they manage the project, instead of managing us.
And the first step to making the project manageable is to decompose its
scope into smaller pieces.

<!--more-->

{% jb_picture_body %}

Imagine you want to re-design your apartment, having a few thousand
dollars for this job. You hire a group of people and give them all your
money up front. They ask you to come back in two months, when everything will
be ready. You say "OK" and wait for two months. I'm sure you already know
what I'm getting at---this project most probably will be a failure, to
some extent. In the worst case you won't see these guys ever, they will just
steal your money. In the best case, they will do something that will
look "nice," but not as nice as you expected.

## Why do we micromanage?

What do you do in order to increase your chances of getting the best case scenario?
That's right, you micromanage them: you visit them every day, you ask them
the famous "What are you doing now?" question, you push them when they are
getting lazy, you control, you dominate, you annoy, you
"stay on top," you play the guilt card when they miss or forget,
you [punish]({% pst 2016/jan/2016-01-05-how-to-punish-employees %})
them every way you can.

{% quote The more aggressive you are, the higher the chances you win. %}

You don't do that because you're evil. You just know that otherwise they
will trash your apartment, will forget things, will miss
something, will make mistakes, will spend more time and money than they are
supposed to, will choose wrong fabrics, will purchase the furniture
you don't like, and will do many other things you're well aware of if you've
ever dealt with interior designers and house builders.

The more aggressive you are, the higher the chances you win.

And it's not because you are evil. You're not evil, you're stupid
(not you personally, my dear and respected reader, but you get the point).

{% youtube uhDmHkMAYnM %}

The problem is that the project is not manageable. That's why you
have to resort to the last possible measure---micromanagement. Why is the
project not manageable? Because its scope is not broken down into
pieces. It contains a large single job called "Redesign The Apartment."

One of the key success factors for manageability is the famous 0/100 rule, which
requires any task to be either "in progress" or "complete." There can be
nothing in the middle. When such a rule is in place, the task can be
delegated to its performer and they can become responsible for its completion,
they can be trusted.

We can't "trust" our single large task to the performer, simply because it's too
big to be trusted. If they fail, the cost of failure will be too high. We have
to take a _micro_-scope and get into the task to manage it from the inside,
annoying its performers, whom we are supposed to trust. The micromanagement
we do is _inevitable_, because the scope is not broken down.

{% youtube tHeXxLdGqqI %}

Scope decomposition was invented mostly in order to solve this very problem:
to make the project more manageable. We need small tasks in the scope in order
to be able to delegate them and never go inside in order to check what's going on
there, who is doing what, why, and where.

The smaller the tasks we can break the scope into, the better.

## How small can tasks be?

In our projects we break project scope into tasks of 30 minutes each.
This may sound too extreme for you, but it works for us. We call them micro-tasks.
We started to practice micro-tasking about seven years ago. We experimented
with different task sizes, from 10 hours to 15 minutes, but eventually
came down to 30 minutes.

When tasks are bigger, we lose the manageability and simply get back to
macro-tasking. When tasks are smaller, the context switching overhead
becomes too annoying.

{% youtube 1rmZN3r5SWg %}

In our experience, a senior programmer, if fully dedicated to a project, completes
6-10 tasks a day. This means that they spend 3-5 hours working, while
the rest of the time is spent on doing something else. This is a much more
effective use of work time than we can achieve with traditional macro-tasking
management, where programmers barely work for two hours a day, spending
the rest of their time on something else (my personal observation).

## What obstacles did we have?

If you decide to go for micro-tasking, you will most likely have the same or similar
obstacles that we've had. Here is a short list of them and my advice, which
may help if one day you decide to break a "Develop a Mobile App" task
into, say, 2,500+ micro tasks:

  * **Vagueness**.
    Definition of done, exit criteria, requirements, expectations---there
    are many names, which are all about our inability to define
    what exactly we expect programmers to do. Software development
    by definition includes a lot of unknowns, creativity, experiments,
    and risks. Programmers will tell you that they can't guarantee anything
    in most cases, and can't really give any valid promises.
    We solve that by
    [PDD]({% pst 2010/mar/2010-03-04-pdd %}).

  * **Distraction**.
    Programmers are used to doing many different things at the same time:
    they write code, help others, watch YouTube, scroll Facebook,
    swear at Reddit, and read my blog. Initially most of them
    won't like the idea of having explicit tasks in front of them,
    simply because they put a structure on their work time, making it
    much more visible to the management. They will tell you that they
    have many other things to do aside from your bloody tasks.
    We solve that by
    [paying by result]({% pst 2014/apr/2014-04-17-how-xdsd-is-different %}) and
    [prohibition of chitchats]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %}).

{% quote They are simply spoiled by the traditional macro-tasking where they are paid by the month and nobody really controls their results. %}

  * **Laziness**.
    Just like that apartment designers, programmers also love to get paid
    and do nothing. Who doesn't, right? They will tell you that their
    work is more complicated than you think, that they need much more time,
    that they need to investigate the problem first, that reading
    documentation also takes a lot of time, etc. They are simply spoiled
    by the [traditional macro-tasking]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %})
    where they are paid by the month and nobody
    really controls their results. They are used to being ~~office slaves~~ lazy.
    We solve that by
    [paying by result]({% pst 2014/apr/2014-04-17-how-xdsd-is-different %})
    and the lazy ones simply quit.

  * **Responsibility**.
    Micro-tasking will make individual results visible. When tasks are large
    people tend to work with them in groups and it's unclear exactly who is responsible
    for failures and successes. Smaller tasks emphasize mistakes
    and make people "pay" for them. Not necessarily with cash,
    but definitely some way or other. Most programmers will find this concept
    very new and disturbing---they've almost never paid for their own
    mistakes before and never had their own tasks. The responsibility was
    always spread across the group.
    We solve that by
    [monetary rewards and punishments]({% pst 2014/sep/2014-09-24-why-monetary-awards-dont-work %}),
    which make them very motivated and failure-ready.

  * **Resentment**.
    This is one of the most popular and the most annoying of problems: they
    will tell you that they are "not monkeys." They will actually combine
    all problems listed above and say that the right way to solve them
    is to give programmers freedom and let them do their job, since they
    are smart enough and don't need any management from the top. And they
    will mostly be saying it quite honestly, with no intent to manipulate. The thing
    is that they are used to macro-tasking and believe that this is the
    only and the right way.
    I'm trying to solve this by writing this very blog post.

There could be something else, but this is a more or less an exhaustive list
of the problems we were faced with.

## Where micro-tasking didn't work

Obviously, any approach has its pros and cons. Micro-tasking seems to be
the most effective management paradigm for us. However, it's not applicable
everywhere, according to our experience. There are territories where
we failed to apply it.

  * **Prototyping**.
    Every project or a new big feature starts with a prototype, which
    requires one or two people sitting next to each other, thinking, and
    experimenting. We tried to break this piece of work into smaller
    parts, but failed. It [seems]({% pst 2014/oct/2014-10-06-software-project-lifecycle %})
    that this process has to be done as a single
    solid work package.

  * **UI/UX**.
    We were mostly working with server-side Java/Ruby/C++ projects for the last
    few years and didn't have many opportunities to apply micro-tasking to the
    UI/UX jobs. However, whatever we did try never really worked: graphic
    designers weren't able to decompose their tasks into smaller parts.

  * **Customers**.
    We [tried]({% pst 2014/apr/2014-04-26-incremental-requirements-with-requs %})
    to decompose the task of eliciting requirements from our
    clients and failed a few times. Maybe our clients were stupid
    (I doubt that), maybe requirements were too complex, or maybe
    our system analysts were not professional enough. The bottom line
    is that we realized that such a task must be done as a solid piece of
    work, without any decomposition.

  * **Fire-fighting**.
    When the speed of delivery is the most important concern, micro-tasking
    doesn't work for us. The overhead for dispatching and specifying tasks
    was taking too much time. When something is really urgent, we have
    to do the traditional macro-tasking and just "make it work." Then
    we get back to micro-tasking.

Everything else, including programming, unit testing, manual testing,
performance/load testing, integration testing, deployment, code review,
documentation, and even training, can and must be managed via micro tasks.

## What benefits do we get?

The most important benefit of micro-tasking is that the project becomes
more manageable, as was mentioned above. Here is a more detailed break
down:

  * **Money works**.
    When tasks are very small, we can use [good old dollar bills]({% pst 2014/sep/2014-09-24-why-monetary-awards-dont-work %})
    to motivate programmers. We can throw away literally
    [all other]({% pst 2015/mar/2015-03-02-team-morale-myths-and-reality %})
    instruments.

  * **We pay less**.
    We seriously lower our expenses, even though hourly rates of our programmers
    are
    [higher]({% pst 2014/oct/2014-10-29-how-much-do-you-cost %})
    than many other projects can afford. I did a more or less
    [detailed analysis]({% pst 2014/apr/2014-04-11-cost-of-loc %})
    a few years ago, which demonstrated that our projects
    were 30 (!) times more cost efficient than traditional ones.

  * **Motivation is high**.
    Despite a very common stereotype that small and isolated tasks demotivate
    their performers, we see quite the opposite reaction: programmers
    are excited when it finally becomes possible to work within well-defined
    and explicit boundaries, independently, and in isolation. Not all of them,
    [though]({% pst 2018/jan/2018-01-09-micro-budgeting %}).
    My personal observation is: only 25% of them can understand and enjoy
    micro-tasking. Others are either not professional enough or spoiled
    by [office slavery]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %}),
    where it's possible to do almost nothing and stay very respected and well rewarded.

  * **Turnover is not painful**.
    To make micro-tasking possible the management has to learn how to
    specify them: explicitly, unambiguously, and fast. When such a high
    level of transparency, formality, and agility (at the same time) is
    achieved, the project becomes less dependent on
    [experts]({% pst 2015/dec/2015-12-29-turnover-is-good-for-maintainability %}).
    We lose the fear of losing people, because almost everything
    we need to know about the project is inside our task tracking system
    and project documentation.

  * **Easier to parallel**.
    Smaller tasks are easier to delegate to a larger amount of programmers.
    In some projects we sometimes have over 40 programmers at the same time, while
    the amount of tasks is relatively small (up to 200).

  * **Metrics work**.
    When one programmer closes 40-50 tasks per week and another one closes
    5-10, it does mean something, keeping in mind that all tasks are almost
    equal in size. We use this metric (and [a few others](https://www.0crat.com/gang))
    to make organizational
    and discipline decisions. In a macro-tasking environment almost no HR metrics
    really work.

  * **Quality is enforceable**.
    Large amounts of small tasks implies that we constantly and frequently
    close them. Each closure is an important point for quality control. That's
    exactly where we have the ability to say "No" and reject the deliverables
    that violate our quality standards. With big tasks this "No" is much more
    painful for programmers.

  * **Risks are acceptable**.
    It's impossible to accept the risk of the entire apartment redesign failure,
    since its cost is too high---a few thousand dollars. However,
    it is absolutely affordable to accept a risk of a kitchen lamp installation.
    Even if it falls and breaks, we will spend a few dollars and buy a new one.
    We don't need to control the "lamp person"---we have a luxury
    to delegate and trust.

The benefits programmers get overlap with our benefits. If they
are professional and motivated enough they find it effective and productive
to work with micro tasks, which are always well defined and properly paid.

## Are we monkeys or not?

Now the most typical complaint we hear about micro-tasking is: "It is for
junior programmers who are OK with being code monkeys." To be honest,
I also thought so a few years ago, when we started to experiment with
[XDSD]({% pst 2014/apr/2014-04-17-how-xdsd-is-different %}). What I quickly
found out is that the most professional and self-motivated developers
were enjoying micro-tasking, while their less mature and less skilled colleagues
were finding it difficult to keep up.
