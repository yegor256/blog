---
layout: post
title: "SixNines.io, Your Website Availability Monitoring"
date: 2017-04-05
place: Moscow, Russia
tags: pets
description: |
  Availability monitoring of a web system is a long-term
  task that must take years in order to accurate; SixNines.io
  does it for you.
keywords:
  - six nines
  - availability
  - availability monitoring
  - web site availability
  - availability checker
---

Availability is a metric that demonstrates how often your web site
is available to its users. Technically it's a ratio between successful
attempts to open the website and failed ones. If one out of a hundred
attempts failed we can say that the availability is 99%. High-quality
websites aim for so called "six nines"
[high availability](https://en.wikipedia.org/wiki/High_availability), named so by the
amount of 9's in the number: 99.9999%. I created a service that helps
you measure this metric and show it to your users:
[SixNines.io](http://www.sixnines.io).

<!--more-->

All you need to do is to login using your GitHub account and register
your URI, which [SixNines](http://www.sixnines.io) will validate. This operation will cost you
$4.95 (processed by [Stripe](https://www.stripe.com)). It's a one-time fee. Once your URI is in the system, we will
monitor it forever.

The key problem with the availability metric is that it must take
a lot of time in order to really guarantee that it's "six nines."
Indeed, look at the ratio: 99.9999% means that only one attempt
out of a _million_ fails. In order to ping your web site at least a million
times we will have to work for 694 days, if we ping every minute. This
will take over two years.

Only after that two years of 24x7 work we will be able to prove that
your web site is of high availability and the value of the metric is
really 99.9999%.

You can see some big web sites being checked by SixNines already:

Google<br/>
<a href="http://www.sixnines.io/h/4739"><img src="http://www.sixnines.io/b/4739"/></a>

Facebook<br/>
<a href="http://www.sixnines.io/h/e203"><img src="http://www.sixnines.io/b/e203"/></a>

Twitter<br/>
<a href="http://www.sixnines.io/h/cd52"><img src="http://www.sixnines.io/b/cd52"/></a>

Yahoo<br/>
<a href="http://www.sixnines.io/h/63d1"><img src="http://www.sixnines.io/b/63d1"/></a>

As you see, their numbers are far from "six nines," because I just started
to measure them. In two years we will see what their real availability will be.

SixNines is written in Ruby and is open source, hosted in
[GitHub](https://github.com/yegor256/sixnines). Don't hesitate to contribute.

