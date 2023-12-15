---
layout: post
title: "How Much Do You Pay Per&nbsp;Line&nbsp;of&nbsp;Code?"
date: 2014-04-11
tags: xdsd management
categories: jcg
description: |
  This article compares two projects and calculates
  their average costs per one line of code changed.
  The experiment proves economical advantage of a distributed development.
keywords:
  - line of code
  - cost of LoC
  - cost of line of code
  - cost of software development
  - price per line of code
image: /images/2014/04/brazil-crowded-office.png
jb_picture:
  caption: Brazil (1985) by Terry Gilliam
---

{% badge https://www.xdsd.org/images/logo.svg 100 https://www.xdsd.org %}

Yes, I know, "line of code" (LoC)
is a [very wrong metric](http://stackoverflow.com/questions/966800/mythical-man-month-10-lines-per-developer-day-how-close-on-large-projects).
There are [tons of articles](http://blog.codinghorror.com/diseconomies-of-scale-and-lines-of-code/)
written about it, as well as famous books.
However, I want to compare two projects in which I have participated recently
and discuss some very interesting numbers.

<!--more-->

{% jb_picture_body %}

## Project #1: Traditionally Co-located

The first project I was a part of was performed  by a traditionally co-located
group of programmers. There were about 20 of them (I'm not counting
[managers]({% pst 2015/sep/2015-09-22-micromanagement %}),
analysts, product owners, SCRUM masters, etc.) The project was a web auctioning
site with pretty high traffic numbers (over two million page views per day).

The code base size was about 200k lines, of which 150k was PHP, 35k JavaScript
and the remainder CSS, XML, Ruby, and something else. I'm counting only
non-empty and non-comment lines of code, using
[`cloc.pl`](http://cloc.sourceforge.net/).

It was a commercial project, so I can't disclose its name.

The team was co-located in one
[office]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %})
in Europe where everybody was working
"from nine 'til five." We had meetings, lunches, desk-to-desk chats and lots of
other [informal communications]({% pst 2016/aug/2016-08-23-communication-maturity %}).
All tasks were tracked in JIRA.

## Project #2: Extremely Distributed

The second project was an open source Java product, developed by an [extremely
distributed](https://www.xdsd.org) team of about 15 developers. We didn't have
any chats or any other informal communications. We discussed everything in
GitHub issues. The code base was significantly smaller with only about 30k
lines, of which about 90% was Java and the rest in XML.

{% picture /images/2014/04/shaolin-temple-jet-li.png 0 Shaolin Temple (1982) by Chang Hsin Yen %}

## Maturity of Development

Both projects hosted their code bases on GitHub. Both teams were developing in
[feature branches](http://martinfowler.com/bliki/FeatureBranch.html)- even for
small fixes.

Both teams used build automation,
[continuous integration]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %}),
pre-flight builds,
static analysis and code reviews. This indicates the maturity of the project
teams.

Both projects satisfied the
[requirements]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %})
of their users. I'm mentioning this to
emphasize that both projects produced valuable and useful lines of code. There
was no garbage and almost no [code
duplication](http://en.wikipedia.org/wiki/Duplicate_code).

## Show Me the Money

In both projects, my role was called that of lead architect, and I knew their
financial details. Besides that, I had access to both Git repositories,
so I can measure how many new lines (or changed lines) were introduced by both
teams in, say, a three-month period.

Now, let's see the numbers.

{% youtube qRZYJGYdrwk %}

The first project (the one that was co-located) was paying approximately
&euro;50,000 annually to a good developer, which was about $5,600 per month or
$35 per hour. The second one (the extremely distributed project) was paying
$20-35 per hour, for completed tasks only according to one of the principles of
[XDSD](https://www.xdsd.org).

The first one, in three months, produced 59k new lines and removed 29k in
changes in the `master` branch, which totals 88k lines of code. The project
resulted in about 10,000 man hours to produce these lines (20 programmers, three
months, 170 working hours per month)---which equates to about $350k. Therefore,
the project
[cost]({% pst 2015/jun/2015-06-02-how-to-estimate-software-cost %}) a whopping

<p class="red center em2">$3.98 per line</p>

The second project, in the same three month period, produced 45k new lines and
removed 9k, which comes to 54k in all. To complete this work, we spent only $7k
(approximately 350 working hours in 650 tasks). Thus, the project cost merely:

<p class="green center em2">&cent;13 per line</p>

This also means that programmers were writing approximately 150 lines per hour
or over a thousand per day.
[The Mythical Man-Month](http://en.wikipedia.org/wiki/The_Mythical_Man-Month)
talks about 10 lines per day, which is a hundred times less than we saw in our project.

$350k vs $7k, $3.98 vs &cent;13? What do you think?

## How to Validate the Numbers?

If you're curious, I'm using [hoc](https://github.com/yegor256/hoc)
to get the numbers from Git (it is explained in
[Hits-of-Code Instead of SLoC]({% pst 2014/nov/2014-11-14-hits-of-code %})).
You can validate the numbers for the second project here on GitHub:
[jcabi/jcabi-github](https://github.com/jcabi/jcabi-github).

## Conclusion

What I'm trying to express with these numbers is that distributed programming is
[much more effective]({% pst 2016/aug/2016-08-05-distributed-teams-are-higher-quality %}),
money-wise, than a co-located team. Again, I can hear you
saying that "line of code" is not a proper metric. But, come on, $0.13 vs.
$3.98? Thirty times more expensive?

{% picture /images/2014/04/lebowski-they-did-not-receive-the-money.png 0 The Big Lebowski (1998) by Joel Coen %}

It's not about metrics any more. It's about preventing wasteful man hours and
the huge waste of money that comes with them?

## Can We Do the Same?

Of course, the same results can't be achieved by just telling your programmers
to work from home and never come to the
[office]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %}). XDSD is not about that.
[XDSD](https://www.xdsd.org) is about strict quality principles, which should be
followed by the entire team.

And when these principles are in place---you pay thirty times less.

By the way, this is what people say about their projects:

 * $12&ndash;103: [crazyontap.com](https://www.crazyontap.com/topic.php?TopicId=242135)
 * $15&ndash;40: [betterembsw.blogspot.nl](http://betterembsw.blogspot.nl/2010/10/embedded-software-costs-15-40-per-line.html)
 * over $5: [joelonsoftware.com](http://discuss.joelonsoftware.com/default.asp?biz.5.467536.25)

What are your numbers? Please post your comments below.
