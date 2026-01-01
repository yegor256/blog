---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "How Expensive Is Your Outsourcing Team?"
date: 2016-01-19
place: Palo Alto, CA
tags: outsourcing
description: |
  Hourly rate is a misleading metric that doesn't help
  calculate the costs of outsourcing. Use results per dollar
  instead.
keywords:
  - software outsourcing
  - price of outsourcing
  - outsourcing prices
  - outsourcing rates
  - rates of outsourcing
image: /images/2016/01/the-fan.jpg
jb_picture:
  caption: The Fan (1996) by Tony Scott
---

Let me put it this way: $15 per hour for a senior Java developer---is that cheap or expensive? It's cheap, right? Right. What would you
say if I told you this cheap Java developer hardly writes two
primitive lines of code per day? You're paying $600 every week but
rarely getting anything back. How cheap is this Java guy now?
My point is that using hourly rate as a cost indicator is a very bad idea,
whether with [outsourcing]({% pst 2015/oct/2015-10-27-outsourcing-doesnt-work %})
or in-house teams.

<!--more-->

{% jb_picture_body %}

I actually decided to write this after a short sales meeting recently
with a prospect from Illinois. He wanted to hire [Zerocracy](https://www.zerocracy.com) for his
Java project and seemed to like our approach. I explained how we work,
how we control [quality]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}),
and why and how we're [different]({% pst 2014/apr/2014-04-17-how-xdsd-is-different %})
from everybody else. He seemed to be impressed.
Then, he asked, "_How much_ do you charge?"

{% badge //www.0crat.com/svg/logo.svg 100 https://www.zerocracy.com %}

I told him that we are also different in the way we bill for our work,
because we don't charge for the time spent by our programmers sitting
in front of monitors. Instead, we bill for _results_ produced, merged,
and delivered. I showed him this article about
[incremental billing]({% pst 2014/oct/2014-10-21-incremental-billing %}).
He seemed to understand the advantages of our approach, compared to the
[hourly salaries]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %})
being paid by ~~almost~~ everybody else in the market.

Still, the question remained---how much?

What could I do? I had to give him an answer.

{% quote Under different management, programmers deliver very different results in the same 60 minutes. %}

I told him that our best Java programmers earn $30 to $50 per hour and
we add our margin on top of that, in the amount of 100 percent, for management.
In the end, "one hour" will cost him $60 to $100. He ran away.

What did I do wrong? I think I know what it was.
I didn't explain to him that, under different management,
programmers deliver very different results in the same
60 minutes. By "very different," I mean _dramatically_ different. Let
me demonstrate the numbers (I actually did that already almost two
years ago, in my [How Much Do You Pay Per Line of Code?]({% pst 2014/apr/2014-04-11-cost-of-loc %})
post, but will try again from a different perspective).

Take a look at [yegor256/takes#430](https://github.com/yegor256/takes/issues/430),
a feature request in the [Takes Framework](https://www.takes.org),
one of the projects we're managing.
Let's see how much the project paid for the work done in this ticket:

  * 15 minutes to me for creating a new ticket
  * 30 minutes to [@hdous](https://github.com/hdouss) for fixing it
  * 52 minutes to [@pinaf](https://github.com/pinaf) for code review
  * 20 minutes to [@ypshenychka](https://github.com/ypshenychka) for QA review

Assuming that an average price "per hour" is $50
($25 for developers and $25 for our management),
the total cost of this new feature was $97.50 (117 minutes).

Look at these two tickets again.
[#430](https://github.com/yegor256/takes/issues/430) is the feature
request and [#493](https://github.com/yegor256/takes/issues/493) is
the pull request with two new Java files and code review comments.

Four people worked on this feature. If you put them all together
in an office, full-time, with the same hourly rate, they will cost
$800 per day (I'm not adding any management costs!).
Now the question is whether they will be able to
create _eight_ new features _every day_.

If you're a manager, you know the velocity of your programmers.
If you're a programmer, you know how much code you can write in a day.
Now, honestly tell me if you find and solve eight bugs per day with that
level of complexity, detailed code review, and precision of
documentation? I seriously doubt it.

{% badge https://www.xdsd.org/images/logo.svg 100 https://www.xdsd.org %}

In that [How Much Do You Pay Per Line of Code?]({% pst 2014/apr/2014-04-11-cost-of-loc %})
post, I actually did a comparison of a co-located project, where I was an architect,
with a distributed one, where I also was an architect. My numbers tell
me that a traditionally managed team is at least 10 times less
productive than a team managed by [Zerocracy](https://www.zerocracy.com) under
[XDSD](https://www.xdsd.org) principles.

My point is that asking "What is your hourly rate?" is just as wrong as
asking [How Much for This Software?]({% pst 2015/jun/2015-06-02-how-to-estimate-software-cost %})
if we're talking about software developers motivated by results,
not [office slaves]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %}).

Instead, we should ask: How much can you do for $100?

As you can see, we can easily demonstrate how much we are capable
of delivering for $100. Can you and your team do the same?

Thus, your [ROI](https://en.wikipedia.org/wiki/Return_on_investment)
while working with an [outsourced team]({% pst 2015/may/2015-05-21-avoid-software-outsourcing-disaster %}) mostly
depends on their _results per dollar_, not dollars per hour. The first
metric is difficult to calculate, and only the best teams will be able
to do so. The second metric is absolutely misleading, but anyone
will give it to you.

An [outsourced team]({% pst 2015/jun/2015-06-15-software-outsourcing-survival-guide %})
is expensive when its results per dollar are low,
no matter how big or small its dollars-per-hour rate is. To the contrary,
a team is financially very efficient if its results per dollar is high.
It doesn't really matter what the value of the second metric is.

P.S. I'm going to show this article to that prospect who ran away. Maybe
he will come back.
