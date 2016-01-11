---
layout: post
title: "How Expensive Is Your Outsourcing Team?"
date: 2016-01-18
place: Palo Alto, CA
tags: outsourcing
description:
  Hourly rate is a misleading metric, which doesn't help
  in measuring costs of outsourcing. Use results-per-dollar
  instead.
keywords:
  - software outsourcing
  - price of outsourcing
  - outsourcing prices
  - outsourcing rates
  - rates of outsourcing
---

Let me put it this way &mdash; $15 per hour of a senior Java developer &mdash;
is it cheap or expensive? It's cheap, right? Right. What do you
say if I tell you that this cheap Java developer is hardly writing two
primitive lines of code per day. You're paying $600 every week,
rarely getting anything back. How cheap is this Java guy now?
My point is that using hourly rate as a cost indicator is a very wrong idea.
Either with outsourcing or in-house teams.

<!--more-->

{% badge http://img.teamed.io/logo.svg 100 http://www.teamed.io %}

I actually decided to write this after a short sales meeting yesterday,
with a prospect from Illinois. He wanted to hire [Teamed.io](http://www.teamed.io) for his
Java project and seemed to like our approach. I explained how we work,
how we control [quality]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}),
why and how we're [different]({% pst 2014/apr/2014-04-17-how-xdsd-is-different %})
from everybody else. He seemed to be impressed.
Then, he asked &mdash; **how much** do you charge?

I told him that we are also different in the way we bill for our work,
since we don't charge per time spent by our programmers for sitting
in front of monitors. Instead, we bill for **results** produced, merged
and delivered. I showed him this article about
[incremental billing]({% pst 2014/oct/2014-10-21-incremental-billing %}).
He seemed to understand the advantages of our approach, comparing with
[hourly salaries]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %})
being paid by <del>almost</del> everybody else on the market.

Still, the question remained &mdash; how much?

What could I do? I had to give him an answer.

I told him that our best Java programmers earn $30-50 per hour and
we add our margin on top of that, in amount of 100%, for management.
In the end, "one hour" will cost him $60-100. He ran away.

What did I do wrong? I think I know what was it.
I didn't explain him that, under different management,
programmers deliver very different amount of result, in the same
60 minutes. By "very different" I mean **dramatically** different. Let
me demonstrate the numbers (I actually did that already almost two
years ago, in [How Much Do You Pay Per Line of Code?]({% pst 2014/apr/2014-04-11-cost-of-loc %})
post, but will try again, from a different perspective).

Take a look at [yegor256/takes#430](https://github.com/yegor256/takes/issues/430),
a feature request in [Takes Framework](http://www.takes.org),
one of the projects we're managing.
Let's see, how much the project paid, for the work done in this ticket:

  * 15 minutes to me, for creating a new ticket
  * 30 minutes to [@hdous](https://github.com/hdouss) for fixing it
  * 52 minutes to [@pinaf](https://github.com/pinaf) for code review
  * 20 minutes to [@ypshenychka](https://github.com/ypshenychka) for QA review

Assuming that an average price "per hour" is $50
($25 for developers and $25 for our management),
the total cost of this new feature is $97.50 (117 minutes).

Look at these two tickets again.
[#430](https://github.com/yegor256/takes/issues/430) is the feature
request and [#493](https://github.com/yegor256/takes/issues/493) is
the pull request with two new Java files and code review comments.

Four people were working with this feature. If you put them all together
in an office, full time, with the same hourly rate, they will spend
$800 per day (I'm not adding any management costs!).
Now the question is whether they will be able to
create **eight** new features **every day**?

If you're a manager, you know the velocity of you programmers.
If you're a programmer, you know how much code you can write a day.
Now, honestly, tell me, do you find and solve eight bugs per day with that complexity,
detailed code reviews, and that level of preciseness of
documentation? I seriously doubt it.

{% badge http://img.xdsd.org/logo.svg 100 http://www.xdsd.org %}

In this [How Much Do You Pay Per Line of Code?]({% pst 2014/apr/2014-04-11-cost-of-loc %})
post I actually did a comparison of a co-located project, where I was an architect,
with a distributed one, where I also was an architect. My numbers tell
me that a traditionally managed team is at least 10 times less
productive, than a team managed by [Teamed.io](http://www.teamed.io), under
[XDSD](http://www.xdsd.org) principles.

My point is that asking "What is your hourly rate?" is as wrong as
asking [How Much For This Software?]({% pst 2015/jun/2015-06-02-how-to-estimate-software-cost %}).
If we're talking about software developers motivated by results,
not [office slaves]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %}).

Instead, we should ask: How much you can do for $100?

As you can see, we can easily demonstrate how much we are capable
of delivering in $100. Can you and your team do the same?

Thus, your [ROI](), while working with an outsourcing team, mostly
depends on their **results-per-dollar**, not dollars-per-hour. The first
metric is difficult to calculate and only the best teams will be able
to do so. The second metric is absolutely misleading, but anyone
will give it to you.

An outsourcing team is expensive when its results-per-dollar is low,
no matter how big or small is dollars-per-hour. To the contrary,
a team is financially very efficient if its results-per-dollar is high.
Doesn't really matter what is the value of the second metric.

P.S. I'm going to show this article to that prospect, who ran away. Maybe
he will come back :)
