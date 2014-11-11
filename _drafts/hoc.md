---
layout: post
title: Hits-of-Code Instead of SLoC
date: 2014-11-14
tags: mgmt
description:
  Hits of Code (HoC) metric is an alternative measurement
  indicator that can replace Software Lines Of Code (SLoC) and help
  in software development progress tracking
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
of measing the weight of the aircraft we should measure the effort,... somehow.
So, here is the idea. How about we measure the amount of times programmers
**touch** the lines. Instead of counting the number of lines we'll count
how many times they were actually modified &mdash; we can get this information
from Git (or any other SCM). The more you touch that part
of the aircraft &mdash; the more efforts you spent on it, don't you?

<!--more-->

I called it Hits-of-Code (HoC) and created a small tool to help us
calculate this number in just one line. It's a
[Ruby gem](https://rubygems.org/gems/hoc), install it and run:

{% highlight bash %}
$ gem install hoc
$ hoc
54687
{% endhighlight %}

The number 54687 is a total number of Hits-of-Code in your code base. The
principle behind this number is primitive &mdash; every time a line of code
is modified, created or deleted in a Git commit, the counter increments.

The main reason why this metric is better than LoC is that
it is much better aligned with the actual effort invested into the code
base. Here is why.

## It Always Increments

The HoC metric always goes up. Today it can not be lower than it
was yesterday &mdash; just like the effort, it always increments.
Lines-of-Code is not acting like this. You may have a huge code
base today, but after refactoring it will become much smaller. The number
of lines of code is decreased. Does it mean you are less effective?
Definitely not, but the LoC metric says so, to a non-programmer.
A project manager, for example, may decide that since the size
of the code base stays the same over the last month, the team is not working.

HoC doesn't have this counter-intuitive effect. Instead, HoC grows together with your
every commit. The more you work on the code base, the bigger the HoC. It doesn't
matter how big or small is the absolute size of the your product. What matters is
how much effort you put in it. That's why HoC is very intuitive and may be
used as a measurement of software development progress.

-- graph

Look at this three-years graph, it shows two metrics together. I used the
same Java code base of [Netbout](https://github.com/netbout/netbout),
a three-years old project. The code base experienced a few refactorings, as you
see on the graph. I think it is obvious which metric tells us more about
the efforts being invested into the product.

## It Is Objective

For HoC it doesn't matter how big is the absolutely size of the code base.
Let's say, you have 300K lines of code and 90% of them were copy-pasted from some
third-party libraries (it is a very common and terrible practice &mdash;
to keep third-party code inside your own repository). The amount of lines
of code will be big, but the actual custom code part will be relatively small. Thus,
the LoC metric will be misleading &mdash; it will always show 300K with
small increments or decrements around it. We will have a feeling that the
team is working with 300K lines code base.

-- graph

On the other hand, HoC will always take into account the part of code that
is actually being modified. The value of HoC will be objectively
related to the actual effort of programmers working with the code base.

## It Exposes Complexity of Lines

LoC is usually critized for its neutrality towards code complexity.
An auto-generated ORM class or a complex sorting algorithm may have the same
size in terms of lines of code, but the first takes seconds to write, while
the second may take weeks or months. That's why lines of code is usually
considered a false metric.

Hits-of-Code takes complexity into account, because the longer you work
with that sorting algorithm the more modifications you will make to its
lines. Well, this statement is true only if you use Git regularly and commit
your changes frequently &mdash; that is how you tell Git about your work progress.

## Practical Examples

Finally, look at this list of open projects completed by our team over the
last few years. Every project has two metrics: Lines-of-Code and Hits-of-Code.
Here are the most interesting of them:


