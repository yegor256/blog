---
layout: post
title: "Software Outsourcing, Survival Guide"
date: 2015-05-21
tags: outsourcing mgmt
description:
  Here is a few basic recommendations that will help you
  to not become a victim in a software outsourcing project
  and increase your chances of success.
keywords:
  - software outsourcing
  - software outsourcing best practices
  - software outsourcing pros and cons
  - software outsourcing companies
  - software outsourcing trends
  - software outsourcing definition
---

Software outsourcing is what you go for when you want to create
a software product, but software engineering is not your core
competence. It's a smart business practice, being employed by everybody,
from $1,000 personal website owners to Fortune-100 monsters.
And all of them fail, to some extend. Actually, it's very difficult
not to fail. Here is a list of my simple hints to everybody, who
decides to outsource software development (most important are at the bottom).
I wish someone would give it to me fifteen years ago.

<!--more-->

**Have "Work For Hire" Agreement**.
Make sure the contract you have with software outsourcing team
includes something like this: "Parties shall deem all deliverables created by
the developer as _works made for hire_ as is defined under the
[Copyright Law of the United States](http://www.copyright.gov/title17/)".
This is the shortest and the easiest definition of "whatever you create
for me is mine". Put this into the contract and the outsourcing company
won't be able to claim that the software they created belongs to them,
which happens here and there.

**Own Source Code Repository**.
Make sure the source code repository is under your control. The best
way to do this is to create a private Github repository for
[$7/month](https://github.com/pricing). The repository will be visible and
accessible only by you and your outsourcing team. Moreover, make sure
the team has read-only access and can't change the code directly, but only
through pull requests. In Git it's possible to destroy the entire history
just by a single "forced" push to `master` branch. So, would be much better
if you will be the only person with write access. To make life simplier,
I would recommend to use [Rultor]({% pst 2014/jul/2014-07-24-rultor-automated-merging %}),
as a tool for merging that pull requests semi-automatically.

**Regularly Collect Metrics**.
Ask your outsourcing team to regularly collect metrics from the software
they create and send you somehow (by email, maybe). I would recommend to use
[Hits-of-Code]({% pst 2014/nov/2014-11-14-hits-of-code %}),
unit test coverage (or just total amount of unit tests), tickets opened/closed,
build duration. I'm talking here about process metrics. This is not what
you're already getting from NewRelic. These metrics will measure the
performance of the team, not of the product under development. I'm not saying
that you should manage the team by the metrics, but you have to keep
an eye on these numbers and their dynamics.

**Make Independent Technical Reviews**.
I wrote about them already in
[You Do Need Independent Technical Reviews!]({% pst 2014/dec/2014-12-18-independent-technical-reviews %})
post, a few months ago. The importance of such reviews is difficult
to overrate. In software outsourcing they are especially crucial.
Actually, this is the best and the only way of collecting
objective information about the software you're getting from the outsourcer.
Don't rely on reports, promises, guarantees and extensive documentation.
Instead, hire someone else, on an hourly basis, and ask that person
to review what your outsourcing partner is developing. Do such reviews
regularly and systematically. Don't be afraid to offend your programmers.
Honestly explain their concerns to them. If they are professionals, they
will understand and respect your business objectives.
You can also show them this article :)

**Automate and Control Deployment**.
Ask your outsourcing team to automate the entire deployment pipeline and
keep it under your control. I would recommend to do this during the first
days of the project. This means that the product should be compiled, tested,
packaged, installed and deployed to production repository (or server/s) by
a single click. Some script should be created to automate this chain
of operations. That's what your outsourcing partner has to create for you.
Then, when development starts, every time a new change is made to the
repository that has to be deployed to production, the same script has
to be executed. What is important here is that you should know how
this script works and how to run it. You should be able to build and deploy your
product by yourself.

**Demand Weekly Releases**.
Don't wait for the final version. Ask your outsourcing team to release
a new version every week. No matter how intensive is the development and
how many features are "in progress", it's always possible to package
a new version and release it. Well, if the development is really intensive,
ask your team to use GitFlow or something similar, to isolate a stable
production branch from development branches. But don't wait! Make sure
you see your software packaged and deployed every single week, no exceptions
and no excuses. If outsourcing team can't give that to you, start worring
and changing something.

**Hire Independent CTO**.
This advice is mostly for small companies or individuals who outsource
software development and rely on their expertise, while staying focused
on business development. That's wrong. You should have an independent
CTO (chief technical officer) who reports to you and controls how
outsourcing team works. This person must be on a different payment
schedule, on different goals, terms and objectives. You should talk to
the CTO and the CTO should control the offshore team. Very often,
business owners are trying to become software-savvy and control software
team directly, learning their software jargon, principles of DevOps,
and even Java syntax (I've seen that). This is a route to failure.
Be smart &mdash; you do the business development, CTO reports to you,
the software team reports to the CTO.

**Define Rewards and Punishments**.
There is no management without these two key components. You're not supposed
to manage all programmers in the outsourcing shop, but you have to manage
the entire shop as a single unit of control. You have to give them some
structure of motivation. They have to know what will happen to them
if they succeed and how much will they suffer if they fail. If you don't
make this mechanism explicit, you will deal with an implicit version of it,
where your chanced to win are very low. Most people assume that the best
and the only motivation for a software team is to stay in the project. You're
paying them and that's enough, right? Wrong. The management can't effective
when a monthly bank transfer is a reward and its absence is a punishment.
It is too coarse-grained that's why is absolutely ineffective. Find a better and
fine-grained mechanism. This post may help:
[Why Monetary Awards Don't Work?]({% pst 2014/sep/2014-09-24-why-monetary-awards-dont-work %})

