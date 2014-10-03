---
layout: post
title: "12 Hosted Continuous Integration Services"
date: 2014-10-05
tags: ci devops
description:
  I tried to use them all and made a comparison
  chart, which may help you to chose the most
  suitable continuous integration service
keywords:
  - continuous integration
  - hosted continuous integration
  - cloud continuous integration
  - continuous integration in cloud
  - continuous integration service
---

Every project I'm working with starts with continuous
integration configuration. I'm a big fan of cloud services,
that's why I was always using travis-ci.org. A few of
my clients questioned this choice recently, mostly because
of the price. So I decided to made a brief analysis of the market.

I configured my open source project [rultor](https://github.com/yegor256/rultor)
in every continuous integration service I manged to find.
All of them are free for open source projects.
All of them are hosted and do not require any server installation.

I was mostly interested in prices and their limitations.

<table>
<thead>
<tr><td>service</td><td>price</td><td>why not</td><td></td></tr>
</thead>
<tbody>
<tr><td>travis-ci.com</td><td><a href="https://travis-ci.com/plans">$129/mo</a></td><td></td></tr>
<tr><td>codeship.io</td><td><a href="https://codeship.io/pricing">$49/mo</a></td><td></td></tr>
<tr><td>snap-ci.com</td><td><a href="https://snap-ci.com/plans">$80/mo</a></td><td></td></tr>
<tr><td>semaphoreapp.com</td><td><a href="https://semaphoreapp.com/pricing">$29/mo</a></td><td></td></tr>
<tr><td>shippable.com</td><td><a href="http://www.shippable.com/pricing.html">$1/mo</a></td><td></td></tr>
<tr><td>drone.io</td><td><a href="https://drone.io/pricing">$25/mo</a></td><td></td></tr>
<tr><td>circleci.io</td><td><a href="https://circleci.com/pricing">$19/mo</a></td><td></td></tr>
<tr><td>magnum-ci.com</td><td>?</td><td></td></tr>
<tr><td>wercker.com</td><td>free</td><td></td></tr>
</tbody>
</table>

[travis-ci.org](http://www.travis-ci.org) is
the best platform I've seen so far. Mostly because
it is the most popular. Perfectly integrates with
Github and has proper documentation. One important
downside is the price of $129 per month. "With this money
you can get a dedicated EC2 instance and install Jenkins there" &mdash;
some of my clients say. I strongly disagree, since Jenkins will
require a 24x7 administration, which costs way more than $129, but
it's always difficult to explain.

[codeship.io](http://www.codeship.io)

[snap-ci.com](http://www.snap-ci.com) is a product of
ThoughtWorks, an author of [Go](http://www.go.cd/),
an open source continuous integration server. It looks a bit more
complicated than others, giving you an ability to define "stages"
and combine them into pipelines.

[semaphoreapp.com](http://www.semaphoreapp.com)

[shippable.com](http://www.shippable.com) is rather difficult

[drone.io](http://www.drone.io)

[circleci.io](http://www.circleci.io)

[magnum-ci.com](http://www.magnum-ci.com) is a very lightweight
and young system. It doesn't connect automatically to Github,
so you should do some manual operations of adding a web hook.
Besides that, works just fine.

[wercker.com](http://www.wercker.com) is a European product
from Amsterdam, which is still in beta and that's why free
for all projects.
