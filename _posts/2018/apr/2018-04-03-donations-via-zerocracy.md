---
layout: post
title: "Fully Transparent Donations via Zerocracy"
date: 2018-04-03
place: Moscow, Russia
tags: zerocracy
description: |
  Open source projects rarely receive donations, for many
  reasons; Zerocracy transparently simplifies the process
  to attract more donors.
keywords:
  - open source donate
  - donate open source
  - give money to open source
  - risk management in software
  - software risk management
image: /images/2018/04/last-tango-in-paris.jpg
jb_picture:
  caption: Last Tango in Paris (1972) by Bernardo Bertolucci
---

Open source is free, as in beer: you write code, nobody pays you. Of course,
there are [many ways]({% pst 2015/dec/2015-12-22-why-dont-you-contribute-to-open-source %})
to monetize your efforts, but there will be no
direct cash payments from your users, usually. There are [ways](https://hackernoon.com/why-funding-open-source-is-hard-652b7055569d)
to collect money, which include an obvious "tip jar" button on your GitHub project page.
The chances anyone will pay
[are low](https://news.ycombinator.com/item?id=14446516) though. In my opinion,
this is mostly because nobody trusts you enough---they are not sure you will
use the money to make the product better. Most likely you will just spend it
and nothing will change. But they want the product, not to make you happier.
At least that's what I feel when I see a [Patreon](https://patreon.com/) button.

<!--more-->

{% jb_picture_body %}

[Zerocracy](https://www.zerocracy.com) is a platform that manages programmers remotely.
Moreover, it's absolutely [free](https://www.zerocracy.com/policy.html#23) for open source projects. Take a
look at [Cactoos](https://www.cactoos.org) or [Takes](https://www.takes.org)---they
are both managed by
[Zerocrat]({% pst 2018/mar/2018-03-21-zerocracy-announcement %}). These projects
are funded by myself. I add money to Zerocracy out of my pocket and Zerocracy
[pays]({% pst 2018/jan/2018-01-09-micro-budgeting %})
programmers when they close their [microtasks]({% pst 2017/nov/2017-11-28-microtasking %}) in GitHub.

{% badge //www.0crat.com/svg/logo.svg 100 https://www.zerocracy.com %}

A few days ago someone approached me by email and literally said: "There
is a bug in your project, I'm happy to pay you for your time if you can come
up with a solution." He was ready to donate and wanted me (or us) to solve
his specific issue. I could just take his money over PayPal and fix the issue,
but I'm not really an active maintainer of the project he was interested in,
and I'm busy at the moment.

I realized that the best way would be to take the money,
break down the problem into pieces, and delegate them to a few programmers,
just like it usually works in Zerocracy. In other words, I decided to suggest
he fund the project and then let us use the funds for
[microtasking]({% pst 2017/nov/2017-11-28-microtasking %}),
keeping the focus on the issue he was interested in.

Moreover, this concept was
[earlier proposed](https://github.com/zerocracy/datum/issues/212)
by [`@skapral`](https://github.com/skapral).

He gladly accepted the offer.
We [implemented](https://github.com/zerocracy/farm/issues/866) the functionality in
[Zerocrat](https://www.0crat.com) and he contributed $128 via Stripe.

Now [anyone](https://www.zerocracy.com/policy.html#50)
can give a few dollars to a project, if it's
managed by Zerocracy. The contributor will see how those funds are being spent, down to each and every dollar!
Try, for example, one of these buttons and you will see detailed
financial reports of each project and will be able to add your funds:

Cactoos.org:<br/>
[![Donate via Zerocracy](https://www.0crat.com/contrib-badge/C63314D6Z.svg)](https://www.0crat.com/contrib/C63314D6Z)

Takes.org:<br/>
[![Donate via Zerocracy](https://www.0crat.com/contrib-badge/C3FFK3YAY.svg)](https://www.0crat.com/contrib/C3FFK3YAY)

The advantage of this approach, compared to, for example,
[BountySource](https://www.bountysource.com/), is that the money will
be distributed in micro-payments and will be fully traceable. I believe
that this makes a difference for donators---they are interested to see
how their money is being used.


