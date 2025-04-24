---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: Hits-of-Code Instead of SLoC
date: 2014-11-14
tags: management
description: |
  The Hits of Code (HoC) metric is an alternative measurement
  indicator that can replace Software Lines Of Code (SLoC) and help
  in software development progress tracking.
keywords:
  - lines of code
  - lines of code metric
  - lines of code github
  - hits of code
  - lines of code counter
---

[Lines-of-Code](https://en.wikipedia.org/wiki/Source_lines_of_code)
(aka SLoC) is a metric with a terrible reputation.
Try [to google](https://www.google.com/search?q=line+of+code+metric)
it yourself and you'll find tons of articles bad-mouthing about its
counter-effectiveness and destructiveness for a software development process.
The main argument is that we can't measure the progress of programming
by the number of lines of code written. Probably the most famous quote is
attributed to [Bill Gates](https://en.wikipedia.org/wiki/Bill_Gates):

> Measuring programming progress by lines of code is like measuring aircraft building progress by weight

Basically, this means that certain parts of the aircraft will take
much more effort at the same time being much lighter than others
(like a central computer, for example). Instead
of measuring the weight of the aircraft we should measure the effort put into it... somehow.
So, here is the idea. How about we measure the amount of times programmers
_touch_ the lines. Instead of counting the number of lines we'll count
how many times they were actually modified---we can get this information
from Git (or any other SCM). The more you touch that part
of the aircraft---the more effort you spent on it, right?

<!--more-->

I called it Hits-of-Code (HoC) and created a small tool to help us
calculate this number in just one line. It's a
[Ruby gem](https://rubygems.org/gems/hoc), install it and run:

```bash
$ gem install hoc
$ hoc
54687
```

The number 54687 is a total number of Hits-of-Code in your code base. The
principle behind this number is primitive---every time a line of code
is modified, created or deleted in a Git commit, the counter increments.

The main reason why this metric is better than LoC is that
it is much better aligned with the actual effort invested into the code
base. Here is why.

## It Always Increments

The HoC metric always goes up. Today it can not be lower than it
was yesterday---just like the effort, it always increments.
Lines-of-Code is not acting like this. You may have a huge code
base today, but after refactoring it will become much smaller. The number
of lines of code is decreased. Does it mean you are less effective?
Definitely not, but the LoC metric says so, to a non-programmer.
A project
[manager]({% pst 2015/sep/2015-09-22-micromanagement %}),
for example, may decide that since the size
of the code base stayed the same over the last month, the team is not working.

HoC doesn't have this counter-intuitive effect. Instead, HoC grows together with your
every commit. The more you work on the code base, the bigger the HoC. It doesn't
matter how big or small the absolute size of the your product. What matters is
how much effort you put into it. That's why HoC is very intuitive and may be
used as a measurement of software development progress.

{% figure /gnuplot/2014/11/hoc-vs-loc.svg 600 %}

Look at this 18-month graph; it shows both metrics together. I used the
same Java code base of [rultor](https://github.com/yegor256/rultor),
a [DevOps assistant]({% pst 2014/jul/2014-07-24-rultor-automated-merging %}).
The code base experienced a major refactoring a few months ago, as you
see on the graph. I think it is obvious which metric on this graph tells us more about
the efforts being invested into the product.

## It Is Objective

For HoC it doesn't matter how big the absolute size of the code base,
but only how big your relative contribution to it.

{% youtube hTs_R0dFoFM %}

Let's say, you have 300K lines of code and 95% of them were copy-pasted from some
third-party libraries (by the way, it is a very common and terrible practice---to keep third-party code inside your own repository). The amount of lines
of code will be big, but the actual custom code part will be relatively small. Thus,
the LoC metric will be misleading---it will always show 300K with
small increments or decrements around it. Everybody will have a feeling that the
team is working with 300K lines code base.

On the other hand, HoC will always take into account the part of code that
is actually being modified. The value of HoC will be objectively
correlated with the actual effort of programmers working with the code base.

## It Exposes Complexity of Lines

LoC is usually criticized for its neutrality towards code complexity.
An auto-generated ORM class or a complex sorting algorithm may have the same
size in terms of lines of code, but the first takes seconds to write, while
the second may take weeks or months. That's why lines of code is usually
considered a false metric.

Hits-of-Code takes complexity into account, because the longer you work
with that sorting algorithm the more modifications you make to its
lines. Well, this statement is true if you use Git regularly and commit
your changes frequently---that is how you tell Git about your work progress.

## Conclusion

Finally, look at [this list of open projects](http://at.teamed.io/portfolio.html)
completed by our team over the
last few years. Every project has two metrics: Lines-of-Code and Hits-of-Code.
It is interesting to see how relatively small projects have very big
(over a million) HoC numbers. This immediately reminds me how much
time we invested into it and how old they are.

I used the HoC metric in this analysis: [How much do you pay per line of code?]({% pst 2014/apr/2014-04-11-cost-of-loc %}).
That post compares a traditional project that paid $3.98 per HoC and
an [open source]({% pst 2015/dec/2015-12-22-why-dont-you-contribute-to-open-source %})
one, managed by [Zerocracy](https://www.zerocracy.com), that paid &cent;13.

My conclusion is that this Hits-of-Code metric can be used as a tool of
progress tracking in a software development project. Moreover, it
can be used for estimations of team size, project budget, development
schedule and so forth. Obviously, HoC can't be the only metric, but in
combination with others it may greatly help in estimating, planning
and tracking.

PS. Try [`hitsofcode.com`](https://hitsofcode.com/).
