---
layout: post
title: "Employee Turnover is Good for the Maintainability of Your Code Base"
date: 2015-12-24
place: Kiev, Ukraine
tags: management
description:
  Low turnover is a bad symptom, while a reasonable
  amount of it will lead to higher maintainability
  and robustness of the software.
keywords:
  - employee turnover
  - hero driven development
  - fire fighting
  - high turnover
  - low turnover
---

This is what Wikipedia [says](https://en.wikipedia.org/wiki/Turnover_%28employment%29) about it:
"high turnover may be harmful to a company's
productivity if skilled workers are often leaving
and the worker population contains a high percentage of novices."
I agree. However, I believe that a low turnover may also
be very harmful.

<!--more-->

I've found this
[good article](http://www.eremedia.com/ere/a-low-turnover-rate-could-mean-that-you-have-ugly-employees/),
where John Sullivan explains why low turnover could be a negative
symptom. A eally good read, but a rather generic. It is not specifically about software
teams. My experience is mostly focused on programmers and their
turnover. I've learned that low turnover negatively affects code maintainability
and encourages **hero-driven development** and **strong code ownership**
(both of them are bad practices).

"Turnover" is basically the act of replacing an employee
with a new employee. By any reason, including termination,
retirement, resignation, or any other. Simply put, the more
people your team looses every year, the higher your turnover.
If there are 20 programmers in your team and 5 of them
walk away every year, your turnover is 25%.

I can't say what is the number you should aim for, but I strongly believe
that if you consider **programmers** to be a **valuable long-term asset**,
trying to retain them at all cost, you're doing it wrong.

My point is that a healthy software team must
**replace** programmers **regularly**. I would say, having one
person on board for longer than a year is a bad symptom.

By replacing I don't necessarily mean firing. Not at all. I mean moving them
**away** from the code base. Obviously, if you have a single code
base, replacing will mean firing.

When programmers stay together for a long time, working with the
same code base, they inevitably become subject matter **experts**. First of
all, this leads to strong code ownership. Naturally, each of them
becomes a specialist in his/her own part of the code. Mostly because
it's easier to work with something you're familiar with. Instead of jumping
from module to module. No need to say that strong code ownership is
a bad practice. Collective code ownership is a much better alternative,
as [explained](http://martinfowler.com/bliki/CodeOwnership.html) by Martin Fowler.

Then, having strong experts in the team, inevitably leads to
hero-driven development, where fire-fighting is very much appreciated.
An expert doesn't want to lose his/her positions and always tries to demonstrate
how valuable he/she is for the team. The best way to do it is to
solve a problem that nobody else can solve. That's how one gets "job security".
And that's how the team starts to degrade.
This [blog post](http://highlevelbits.com/2014/08/hero-driven-development.html)
by Fredrik Rubensson is right about this problem.

Thus, to achieve higher maintainability of the source code and
robustness of the product, we must **rotate** programmers, preventing
them from becoming subject matter experts.

I realize that this idea sounds counter-intuitive, but try to think again.
By keeping people together, working on the same problem, for a long time,
we put a lot of knowledge into their heads. Not our source code, but
these people become the **asset**. They become smarter, they know the
solution very well, they solve all issues rather fast.
But the code base degrades.

When time comes to change someone (for any reason), the loss will be
damaging. We may lose a big piece of knowledge and the code base left
behind will be unmaintainable. In most cases, we will have to re-write.
That's why in most software teams the management is **afraid** of programmers.
They are scared to lose key software developers, because the
consequences may be fatal.

In the end, programmers control the management, not the other way around.

[It's Not a School!]({% pst 2015/feb/2015-02-16-it-is-not-a-school %}) &mdash;
this earlier post explains how this problem can be solved without
firing or rotating of programmers. But few teams, especially co-located ones,
can afford it. If your team can't, just try to keep your turnover high
enough, to prevent appearance of **heros** (a.k.a. subject matter experts).

