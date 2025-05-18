---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Incremental Billing"
date: 2014-10-21
tags: xdsd management
description: |
  With either a Fixed Price or Time and Material contract,
  your chances of getting the project done are very low.
keywords:
  - fixed price vs time and material
  - types of contract in software development
  - software contract
  - fixed cost contract
  - time and material contract
  - outsourcing contract
  - types of outsourcing contracts
---

When you hire a software developer (individual or a team), there are
basically two types of contracts:
[fixed price](https://en.wikipedia.org/wiki/Fixed-price_contract) or
[time-and-material](https://en.wikipedia.org/wiki/Time_and_materials).
They are fundamentally different but the truth is that in either case---**you lose**.

{% badge https://www.xdsd.org/images/logo.svg 100 https://www.xdsd.org %}

In the eXtremely Distributed Software Development
([XDSD](https://www.xdsd.org)) methodology everything is different, including
the way we invoice our clients. Let's see what happens in traditional
contracts and what changes in XDSD, which we practice
in [Zerocracy](https://www.zerocracy.com).

<!--more-->

The difference between fixed-cost and T&M is in who takes the risk of spending
money and getting nothing in return. This risk is huge in the software
development industry, especially in [outsourcing]({% pst 2015/oct/2015-10-27-outsourcing-doesnt-work %}).
[Over 80%](https://www.projectsmart.co.uk/docs/chaos-report.pdf) of all
software projects fail to achieve their objectives and
[about 30%](http://thenextweb.com/insider/2014/09/25/top-20-reasons-startups-fail-report/)
of startups fail by running out of
[cash]({% pst 2016/apr/2016-04-08-revenue-may-kill-startup %}).
However, very few programmers (if any)
[fail]({% pst 2015/may/2015-05-21-avoid-software-outsourcing-disaster %})
to get their monthly salaries on time.

What does this tell us?

I guess it means that in all failures you---the client---will be the loser.

## Time and Material

{% figure /images/2014/10/time-and-material-contract.svg 500 %}

In T&M you will simply
[pay and pray]({% pst 2015/jun/2015-06-02-how-to-estimate-software-cost %}).
If your programmers
appear to be honest workaholics you may get lucky and get something done.
As you can see from the numbers above, however, this is rarely the case. Don't fool yourself;
there won't be any workaholics in your project. Even if you adopt
[micro-management]({% pst 2015/sep/2015-09-22-micromanagement %})
and corporal [punishment]({% pst 2016/jan/2016-01-05-how-to-punish-employees %}), your overall
[costs]({% pst 2015/jun/2015-06-02-how-to-estimate-software-cost %})
will be much higher than expected and the quality will
[suffer]({% pst 2015/may/2015-05-21-avoid-software-outsourcing-disaster %}).

{% quote If your programmers appear to be honest workaholics you may get lucky and get something done %}

This is what a monthly T&M invoice will look like. You will pay for
the time spent by programmers pretending to be working on your project.
Well, as I said above, some of them will occasionally do something useful,
but overall
[statistics]({% pst 2014/apr/2014-04-11-cost-of-loc %})
tell us that most of that time will be wasted.

No matter how good or bad the code written during that month---you still have
to pay the bill. How many more invoices you will get until the
product is done? Nobody knows.

In the end---you lose.

## Fixed Price

{% figure /images/2014/10/fixed-price-contract.svg 500 %}

In Fixed Price you will feel secure at the beginning---"the statement
of work specifies everything and the price is fixed, how can I lose?"
According to the statistics above, however, programmers are much smarter than their
[clients]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %}).
You will lose in quality. Yes, you will get something for that
fixed price, but it will be a throw-away software. And when you decide to
modify it, new costs will bubble up. In the end, the whole project will be
[ruined]({% pst 2015/may/2015-05-21-avoid-software-outsourcing-disaster %})
and your money will simply be turned into programmers' salaries. This model is even more
risky than T&M, where you at least have a chance.

Once in a while you will receive an invoice with a list of milestones reached.
Every milestone will contain a certain set of features implemented in
the product. Keep in mind that the primary motivation of your programmers will
be to do less and charge more. Every time you ask for improvements
or corrections, there will be a fight about budget. You will either give
up and lose a lot of money or your team will significantly jeopardize
quality, in order to stay profitable.

In either case---you lose.

## Incremental Billing

So, what is the solution? Is it possible to have win-win
contracts with programmers?

{% figure /images/2014/10/xdsd-invoice-example.svg 500 %}

Yes, [it is]({% pst 2016/jan/2016-01-19-how-expensive-is-outsourcing %}).
We call it "Incremental Billing."

Remember, in [XDSD](https://www.xdsd.org) we work with a stream of micro-tasks, usually completed
in less than an hour. Each completed task produces a new increment (aka a "release" or "version") of software.
An increment could be a bug fix, a [bug report]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %}),
a new feature or
a micro-step towards any of these.

By the end of a week you get a bill that lists every single increment
delivered during the week, the amount of time spent on its development
and its
[total cost]({% pst 2015/jun/2015-06-02-how-to-estimate-software-cost %}).
Every increment costs you 30-60 minutes of a programmer's
time (plus our fees).

Besides that, by the end of the week, you get an updated version
of a project plan, with a re-estimated budget. Thus, you see what was
done so far and how much needs to be done, according to our estimate.

How does this help you not lose/waste money? Here's how:

 * you fully control your budget
 * you pay only for the work completed
 * you track the progress with few-minutes-granularity
 * you don't pay for meetings, chats, lunches or coffee breaks
 * programmers stay very motivated, since they are paid by result
 * there is no long-term commitment, and you can stop at any time
 * every increment passes all quality checks

As you can see, [XDSD methodology](https://www.xdsd.org) not only
improves the way we develop software but also fixes the flaws in
the way you pay for it. Since it is a win-win model, it is beneficial
for both programmers and for you---the paying project sponsor.
