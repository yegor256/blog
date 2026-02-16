---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Software Outsourcing Survival Guide"
date: 2015-06-15
tags: outsourcing
description: |
  Here is a few basic recommendations that will help prevent
  you from becoming a victim of a bad software outsourcing project
  and increase your chances of success.
keywords:
  - software outsourcing
  - software outsourcing best practices
  - software outsourcing pros and cons
  - software outsourcing companies
  - software outsourcing trends
  - software outsourcing definition
image: /images/2015/06/u-turn.jpg
jb_picture:
  caption: U Turn (1997) by Oliver Stone
---

Software outsourcing is what you go for when you want to create
a software product but software engineering is not your core
competence. It's a [smart business practice]({% pst 2015/oct/2015-10-27-outsourcing-doesnt-work %})
being employed by everyone
from $1,000 personal website owners to Fortune 100 monsters.
And all of them fail, to some extent. Actually, it's very difficult
not to fail. Here is my list of simple hints to everyone who
decides to outsource software development (the most important ones are
at the bottom). I wish someone would have given it to me 15 years ago.

<!--more-->

{% jb_picture_body %}

**Have a "Work for Hire" Agreement**.
Make sure [the contract]({% pst 2015/may/2015-05-04-how-to-protect-business-idea %})
you have with the [software outsourcing team]({% pst 2015/oct/2015-10-27-outsourcing-doesnt-work %})
includes something like this: "Parties shall deem all deliverables created by
the developer as _works made for hire_ as is defined under the
[Copyright Law of the United States](https://www.copyright.gov/title17/)."
This is the shortest and easiest definition of "whatever you create
for me is mine." Put this into the contract and the outsourcing company
won't be able to claim that the software it created belongs to it,
which happens here and there.

**Own Your Source Code Repository**.
Make sure the source code repository is under your control. The best
way to do this is to create a private GitHub repository for
[$7 per month](https://github.com/pricing). The repository will be visible and
accessible only by you and your outsourcing team. Moreover, make sure
the team has read-only access and can't change the code directly except
through pull requests. In Git, it's possible to destroy the entire history
with a single "forced" push to the `master` branch. So it would be much better
for you to be the only person with write access. To make life simpler,
I would recommend you use [Rultor]({% pst 2014/jul/2014-07-24-rultor-automated-merging %})
as a tool for merging those pull requests semi-automatically.

{% quote Don't rely on reports, promises, guarantees, and extensive documentation. %}

**Regularly Collect Metrics**.
Ask your outsourcing team members to regularly collect metrics from the software
they create and send you them somehow (by email, maybe). I would recommend using
[Hits-of-Code]({% pst 2014/nov/2014-11-14-hits-of-code %}),
unit test coverage (or just the total number of unit tests), tickets opened and closed,
and build duration. I'm talking here about process metrics. This is not what
you're already getting from NewRelic. These metrics will measure the
performance of the team, not of the product under development. I'm not saying
you should manage the team by the metrics, but you have to keep
an eye on these numbers and their dynamics.

**Conduct Independent Technical Reviews**.
I wrote about these already in my
[You Do Need Independent Technical Reviews!]({% pst 2014/dec/2014-12-18-independent-technical-reviews %})
post a few months ago. The importance of such reviews is difficult
to overrate. In software outsourcing, they are especially crucial.
Actually, this is the best and likely only way of collecting
objective information about the software you're getting from the outsourcer.
Don't rely on reports, promises, guarantees, and extensive documentation.
Instead, [hire]({% pst 2016/jun/2016-06-21-how-to-hire-programmer %})
someone else on an hourly basis and ask that person
to review what your outsourcing partner is developing. Do such reviews
regularly and systematically. Don't be afraid to offend your programmers.
Honestly explain the reviewer's concerns to them. If they are professionals, they
will understand and respect your business objectives.
You can also show them this article.

**Automate and Control Deployment**.
Ask your
[outsourcing team]({% pst 2015/oct/2015-10-27-outsourcing-doesnt-work %})
to automate the entire deployment pipeline and
keep it under your control. I would recommend you do this during the first
days of the project. This means the product should be compiled, tested,
packaged, installed, and deployed to a production repository (or server/s) by
a single click. Some
[script]({% pst 2014/sep/2014-09-11-deployment-script-vs-rultor %})
should be created to automate this chain
of operations. That's what your outsourcing partner has to create for you.
Then, when development starts, every time a new change is made to the
repository that has to be deployed to production, the same script has
to be executed. What is important here is that you should know how
this script works and how to run it. You should be able to build and deploy your
product by yourself.

**Demand Weekly Releases**.
Don't wait for the final version. Ask your outsourcing team to release
a new version
[every week]({% pst 2015/jun/2015-06-08-deadly-sins-software-project %}).
No matter how intensive the development is and
how many features are "in progress," it's always possible to package
a new version and release it. If the development is really intensive,
ask your team to use
[GitFlow](http://nvie.com/posts/a-successful-git-branching-model/)
or something similar to isolate a stable
production branch from development branches. But don't wait! Make sure
you see your software packaged and deployed every single week, no exceptions
and no excuses. If your outsourcing team can't give that to you, start worrying
and change something.

{% quote They have to know what will happen to them if they succeed and how much they will suffer if they fail. %}

**Hire an Independent CTO**.
This advice is mostly for small companies or individuals who
[outsource]({% pst 2015/may/2015-05-21-avoid-software-outsourcing-disaster %})
software development and rely on their expertise while staying focused
on their own business development. That's unwise; you should have an independent
chief technical officer (CTO) who reports to you and controls how the
[outsourcing team works]({% pst 2015/may/2015-05-21-avoid-software-outsourcing-disaster %}).
This person must be on a different payment
schedule with different goals, terms, and objectives. You should talk to
the CTO and the CTO should control the offshore team. Very often,
business owners try to become software savvy and control the software
team directly, learning their software jargon, principles of DevOps,
and even Java syntax (I've seen that). This is a route to failure.
Be smart---you do the business development, the CTO reports to you,
and the software team reports to the CTO.

**Define Rewards and Punishments**.
There is no
[management]({% pst 2015/sep/2015-09-22-micromanagement %})
without these two key components. You're not supposed
to manage all programmers in the outsourcing shop, but you have to manage
the entire shop as a single unit of control. You have to give them some
structure of
[motivation]({% pst 2014/sep/2014-09-24-why-monetary-awards-dont-work %}).
They have to know what will happen to them
if they succeed and how much they will suffer if they fail. If you don't
make this mechanism explicit, you will deal with an
[implicit version]({% pst 2015/oct/2015-10-13-competition-without-rules %})
of it where your chances of winning are very low. Most people assume the best
and the only motivation for a software team is to stay on the project. You're
paying them and that's enough, right? Wrong. Management can't be effective
when a monthly bank transfer is a reward and its absence is a
[punishment]({% pst 2016/jan/2016-01-05-how-to-punish-employees %}).
It is too coarse-grained; that's why it's absolutely ineffective. Find a better and
more fine-grained mechanism. This post may help:
[Why Monetary Awards Don't Work]({% pst 2014/sep/2014-09-24-why-monetary-awards-dont-work %}).

Added on the 14th of October, 2018:

**Don't Spend More Than a Month**.
Some say [12 weeks](http://12weekmvp.com/process.html), I say a month.
And I'm [not alone](https://medium.freecodecamp.org/the-developers-workflow-in-practice-how-we-built-our-mvp-in-30-days-c60d804695a8).
Do you know that the first version of Minecraft (which was later
[sold](https://mojang.com/2014/09/yes-were-being-bought-by-microsoft/)
to Microsoft for $2.5B) was released in just [six](https://www.techradar.com/news/the-history-of-minecraft)
days? There are many other examples, including Uber, Dropbox,
[Buffer](https://blog.bufferapp.com/idea-to-paying-customers-in-7-weeks-how-we-did-it),
and
[others](https://hackernoon.com/this-will-change-the-way-you-build-a-mvp-minimum-viable-product-in-2017-99daabb4bf1b).
Eric Ries in his book
[_Lean Startup_](https://www.amazon.com/Lean-Startup-Entrepreneurs-Continuous-Innovation-ebook/dp/B004J4XGN6)
called it a Minimum Viable Product (MVP), I'm sure you've heard this acronym.
If developers are promising to deliver the product in a few months,
you are doing something wrong. You absolutely must get some working software
in less than a month and it has to be ready for real paying users. Most
of my [pet projects](/pets.html) I created in less than a week each.

**Don't Pay Salaries**.
Of course, they will want you to pay monthly, plus health insurance,
laptops, vacations, and a nice sunny office. That's where your plan falls short.
Make them happy and you lose. You must find a way to align your objectives
(deliver the MVP as soon as possible and start making money) with theirs
(buy a new car and spend the next vacation on a beach).
Can you do that? It's difficult. That's why we created [Zerocracy](https://www.zerocracy.com), which makes
[incremental billing]({% pst 2014/oct/2014-10-21-incremental-billing %})
and paying by results possible. You can either [move](https://www.zerocracy.com) your
project to our platform and manage your developers there, or invent something
on your own. But remember, no monthly salaries! Only pay by results delivered.

**Don't let them _experiment_**.
Every smart programmer wants to use your new project as a test ground for
some new technologies. Nobody likes to do exactly the same thing they were doing
yesterday, unless they are stupid and boring people. Thus, your guys
will recommend that you use something new: a new framework, a new database,
a new cloud hosting solution, new deployment tools. They are doing this
for their own purposes, not to help the project. Don't fall for this. Insist
that they use what they have experience with, at least at the MVP stage. Promise them
freedom to experiment, but later, when the MVP is launched.
