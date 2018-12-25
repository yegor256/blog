---
layout: post
title: "What If the Architect Is Wrong?"
date: 2019-01-01
place: Moscow, Russia
tags: architect
description: |
  The architect is a technical dictator in a software project,
  who takes full responsibility for all mistakes; but what
  if the mistake is too expensive?
keywords:
  - software architect
  - architect
  - trust software architect
  - how to find software architect
  - good architect
image: /images/2019/01/
jb_picture:
  caption:
---

You most probably know what I think about an
[architect]({% pst 2014/oct/2014-10-12-who-is-software-architect %})
role in a software project---it's a _dictator_ that makes all technical decisions
and bears the entire responsibility for the final result. I [wrote]({% pst 2014/oct/2014-10-12-who-is-software-architect %})
about it and even made a speech [_Who Is a Software Architect?_](https://www.youtube.com/watch?v=R1lA7pN60xg)
at BuildStuff in 2016. However, the obvious question you may ask is:
What happens if the architect is wrong? Does it mean the entire project
is at risk of failure? And isn't it better to make the entire team responsible
for the result, instead of having one single point of failure?

<!--more-->

{% jb_picture_body %}

The question indeed is obvious. Dictatorship is a [great]({% pst 2016/sep/2016-09-27-command-control-innovate %})
management model, provided the dictator is _smart_. This means, first of all, the ability
1) to analyze the reality, 2) [collect]({% pst 2015/may/2015-05-13-two-instruments-of-software-architect %})
all available different opinions, and 3) find
the best possible option, leaving personal emotions aside. How many people
truly can do that? <del>None</del> Very few.

Everybody else will most likely abuse the power and turn into a bad dictator,
who doesn't listen to anyone, doesn't pay attention to different opinions,
and makes technical decisions out of personal feelings. How many
software architects like that are out there? <del>All</del> Many.

What is the solution?

How about we get rid of the dictator in the first place and let the team
decide what is the right architecture? How about we replace dictatorship
with [democracy]({% pst 2016/feb/2016-02-18-holacracy-autocracy %})
and let software developers _vote_ somehow, so that there will
be no single point of failure? They all will be responsible for the product,
and when it breaks---they all will be guilty. Right?

Wrong!

"Quality and responsibility mean nothing unless they are attributed personally,"
I said in my book [_Code Ahead_](/code-ahead.html). Group responsibility
is the most terrible mistake a team can only make. So, no! No voting and no democracy.

What than?

Imagine a real project, where an architect makes a decision of using MongoDB, a NoSQL database, for persisting
user payments. It's a questionable decision, since traditionally relational databases
are considered as a better option for financial data. However, we know that the architect
is a dictator and we are not supposed to argue. We can't tell the architect
that the decision is wrong. Moreover, we should not ask the architect to
[convince]({% pst 2016/jul/2016-07-21-convince-me %}) us. The decision is made. It's done.

What can we do?

We can recall that the only real boss of the architect is: _requirements_. The
architect may no listen to us, to developers, to customers, to anyone. But
the requirements is the undisputable boss. Did the requirements document
have anything about the choice of the database? Most likely there was nothing
about that. So, the architect did everything right. The requirements said
that payments have to be persisted and they are. The requirements wanted
the system to process up to a hundred payments per second and it does. So,
what is the mistake?

Well, we just _feel_ that the choice of MongoDB was a bad idea. It's just gut feeling.
But maybe we are wrong and the architect is right?

To make situation more explicit and resolve the conflict,
we have to amend the requirements document. We have
to say that something else is required for this particular decision. Say,
we may add this line:

> The choice of each third-party product has
to grounded by a multi-factor analysis of
at least four alternatives.

Once this requirement clause is approved, the architect will have to improve the
product documentation. There will have to appear an analysis of MongoDB,
PostgreSQL, Oracle, and some other databases. There will be some selection
criteria defined and the architect will provide some numbers to make the
choice of MongoDB look reasonable.

Once it's done, the opinion of the architect will turn into a digital artifact,
which _may_ have defects. How many defects are there and how soon we find them
becomes a management question, which is relatively easy to resolve. We just
need a few additional pairs of eyes to look at this artifact and tell us
what's wrong there. For example, we can ask someone from the team to review
the analysis and tell us what's wrong. Or we can [hire]({% pst 2014/dec/2014-12-18-independent-technical-reviews %})
someone from the market, who is very expensive, but
very professional in the area of database management.

Once defects are reported, they will have to be resolved somehow by the
architect. They will have to get some answers: either the analysis will have
to be improved, or the decision will have to be changed, if the facts will
start paying against it.

The lower the risk tolerance in the project, the more pairs of eyes we need
to look at those decisions the architect is making. If the quality is very
important or the professional level of the architect is questionable, we need
more decisions to be documented and more frequently reviewed. It's a simple
game of numbers. If the architect is completely trusted and the project is not
expensive and short-term---we just let the architect do whatever he or she
wants.

On the other hand, if the architect is junior and the project is very important
to us, we must demand the majority of technical decisions to be documented
and analyzed. We must organize as many reviews of those documents as possible,
inviting [independent experts]({% pst 2014/dec/2014-12-18-independent-technical-reviews %}).

Thus, to summarize my points, we must not expect the architect to be an expert
capable of solving all problems. On the other hand, we must not replace the
architect with a democratic vote. Both ideas are wrong. The right approach is
to control the quality of decisions the architect makes via regular reviews.

Do you have such reviews in your project? If not, why?
