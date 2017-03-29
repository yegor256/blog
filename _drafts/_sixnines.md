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
image: /images/2015/03/?
jb_picture:
  caption: ?
---

{% badge http://www.sixnines.io/images/logo.png 64 http://www.sixnines.io %}

Availability is a metric that demonstrates how often your web site
is available to its users. Technically it's a ratio between the number of successful
attempts to open the website and the number of failed ones. If one out of a hundred
attempts failed we can say that the availability is 99%. High-quality
websites aim for so called "six nines"
[high availability](https://en.wikipedia.org/wiki/High_availability), named so by the
amount of 9's in the number: 99.9999%. We created a service that helps
you measure this metric and demonstrate its value to to your users:
[SixNines](http://www.sixnines.io).

<!--more-->

{% jb_picture_body %}

All you need to do is login using your
[GitHub](https://www.github.com) account and register
your URI, which [SixNines](http://www.sixnines.io) will
validate. This operation will cost you
$4.95 (processed by [Stripe](https://www.stripe.com)).
It's a once-in-a-lifetime fee
(if you got no money, [email](mailto:free@sixnines.io) us, we'll figure something out).
As soon as your URI is in the system we will monitor it
[forever](http://www.sixnines.io/terms).

The key problem with the availability metric is that it must take
_a lot_ of time in order to really guarantee that it's "six nines."
Indeed, look at the ratio: 99.9999% means that only one attempt
out of a _million_ fails. In order to ping your web site at least a million
times we will have to work for 694 days, if we ping every minute. This
will take over two years.

Only after that two years of 24x7 work we will be able to _prove_ that
your web site is of "high availability" and the value of the metric
really is equal to 99.9999% (you will have all reasons to be proud of it).

You can see some big web sites being checked by
[SixNines](http://www.sixnines.io) already:

Google<br/>
[![Google at SixNines](http://www.sixnines.io/b/4739)](http://www.sixnines.io/h/4739)

Facebook<br/>
[![Facebook at SixNines](http://www.sixnines.io/b/e203)](http://www.sixnines.io/h/e203)

Twitter<br/>
[![Twitter at SixNines](http://www.sixnines.io/b/cd52)](http://www.sixnines.io/h/cd52)

Yahoo<br/>
[![Yahoo at SixNines](http://www.sixnines.io/b/63d1)](http://www.sixnines.io/h/63d1)

This is my blog's availability (it's hosted on GitHub Pages):

[![Yegor256 at SixNines](http://www.sixnines.io/b/3ba1652f)](http://www.sixnines.io/h/3ba1652f)

As you see, their numbers are far from "six nines," because we just started
to measure them. In two years we will see what their real availability will be.

[SixNines](http://www.sixnines.io) is written in Ruby and is open source, hosted in
[GitHub](https://github.com/yegor256/sixnines). Don't hesitate to contribute.

