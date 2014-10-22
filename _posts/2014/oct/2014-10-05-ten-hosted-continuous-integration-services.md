---
layout: post
title: "10 Hosted Continuous Integration Services for a Private Repository"
date: 2014-10-05
tags: ci devops
description:
  I tried to use them all and made a comparison
  chart, which may help you to chose the most
  suitable continuous integration service for a private project
keywords:
  - continuous integration
  - hosted continuous integration
  - cloud continuous integration
  - continuous integration in cloud
  - continuous integration service
categories: jcg
---

Every project I'm working with starts with a setup of continuous
integration pipeline. I'm a big fan of cloud services,
that's why I was always using travis-ci.org. A few of
my clients questioned this choice recently, mostly because
of the price. So I decided to make a brief analysis of the market.

I configured [rultor](https://github.com/yegor256/rultor),
an open source project, in every CI service I managed to find.
All of them are free for open source projects.
All of them are hosted and do not require any server installation
Here they are, in order of my personal preference:

<table>
<thead>
<tr>
  <td></td><td></td>
  <td class="cnt">Linux</td>
  <td class="cnt">Windows</td>
  <td class="cnt">MacOS</td>
</tr>
</thead>
<tbody>
<tr><td><a href="http://www.travis-ci.org">travis-ci.com</a></td>
  <td class="rht"><a href="https://travis-ci.com/plans">$129/mo</a></td>
  <td class="cnt"><i class="icon-yes"></i></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-yes"></i></td></tr>
<tr><td><a href="http://www.snap-ci.com">snap-ci.com</a></td>
  <td class="rht"><a href="https://snap-ci.com/plans">$30/mo</a></td>
  <td class="cnt"><i class="icon-yes"></i></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-no"></i></td></tr>
<tr><td><a href="http://www.semaphoreapp.com">semaphoreapp.com</a></td>
  <td class="rht"><a href="https://semaphoreapp.com/pricing">$29/mo</a></td>
  <td class="cnt"><i class="icon-yes"></i></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-no"></i></td></tr>
<tr><td><a href="http://www.appveyor.com">appveyer.com</a></td>
  <td class="rht"><a href="http://www.appveyor.com/pricing">$39/mo</a></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-yes"></i></td>
  <td class="cnt"><i class="icon-no"></i></td></tr>
<tr><td><a href="http://www.shippable.com">shippable.com</a></td>
  <td class="rht"><a href="http://www.shippable.com/pricing.html">$1/mo</a></td>
  <td class="cnt"><i class="icon-yes"></i></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-no"></i></td></tr>
<tr><td><a href="http://www.wercker.com">wercker.com</a></td>
  <td class="rht">free!</td>
  <td class="cnt"><i class="icon-yes"></i></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-no"></i></td></tr>
<tr><td><a href="http://www.codeship.io">codeship.io</a></td>
  <td class="rht"><a href="https://codeship.io/pricing">$49/mo</a></td>
  <td class="cnt"><i class="icon-yes"></i></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-no"></i></td></tr>
<tr><td><a href="http://www.magnum-ci.com">magnum-ci.com</a></td>
  <td class="rht">?</td>
  <td class="cnt"><i class="icon-yes"></i></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-no"></i></td></tr>
<tr><td><a href="http://www.drone.io">drone.io</a></td>
  <td class="rht"><a href="https://drone.io/pricing">$25/mo</a></td>
  <td class="cnt"><i class="icon-yes"></i></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-no"></i></td></tr>
<tr><td><a href="http://www.circleci.com">circleci.com</a></td>
  <td class="rht"><a href="https://circleci.com/pricing">$19/mo</a></td>
  <td class="cnt"><i class="icon-yes"></i></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-no"></i></td></tr>
<tr><td><a href="http://ci.solanolabs.com">sonolabs.com</a></td>
  <td class="rht"><a href="https://www.solanolabs.com/#pricing">$15/mo</a></td>
  <td class="cnt"><i class="icon-yes"></i></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-no"></i></td></tr>
<tr><td><a href="http://www.hosted-ci.com">hosted-ci.com</a></td>
  <td class="rht"><a href="https://hosted-ci.com/#plans">$49/mo</a></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-yes"></i></td></tr>
<tr><td><a href="http://www.ship.io">ship.io</a></td>
  <td class="rht"><a href="https://ship.io/pricing">free!</a></td>
  <td class="cnt"><i class="icon-yes"></i></td>
  <td class="cnt"><i class="icon-no"></i></td>
  <td class="cnt"><i class="icon-yes"></i></td></tr>
</tbody>
</table>

<!--more-->

If you know any other good continuous integration services,
[email me](/about-me.html), I'll review and add them to this list.
BTW, here is a ["full" list](https://en.wikipedia.org/wiki/Comparison_of_continuous_integration_software)
of continuous integration software and services.

{% badge /images/2014/10/travis.png 64 http://www.travis-ci.org %}

[**travis-ci.org**](http://www.travis-ci.org) is
the best platform I've seen so far. Mostly because
it is the most popular. Perfectly integrates with
Github and has proper documentation. One important
downside is the price of $129 per month. "With this money
you can get a dedicated EC2 instance and install Jenkins there" &mdash;
some of my clients say. I strongly disagree, since Jenkins will
require a 24x7 administration, which costs way more than $129, but
it's always difficult to explain.

{% badge /images/2014/10/snap.png 64 http://www.snap-ci.com %}

[**snap-ci.com**](http://www.snap-ci.com) is a product of
ThoughtWorks, an author of [Go](http://www.go.cd/),
an open source continuous integration server. It looks a bit more
complicated than others, giving you an ability to define "stages"
and combine them into pipelines. I'm not sure yet how these mechanisms
may help in small and medium size projects we're mostly working with,
but they look "cool". There is also a very unfortunate limitation of
2Gb RAM per build &mdash; some of my Java projects fail because of that.

{% badge /images/2014/10/semaphoreapp.png 64 http://www.semaphoreapp.com %}

[**semaphoreapp.com**](http://www.semaphoreapp.com) is easy to
configure and work with. It makes an impression of a light-weight
system, which I generally appreciate. As a downside, they don't have
any Maven pre-installed, but this was solved easily with a short
custom script that downloads and unpacks Maven. Another downside is
that they are not configurable through a file (like `.travis.yml`) &mdash;
you should do everything through a UI.

{% badge /images/2014/10/appveyor.png 64 http://www.appveyor.com %}

[**appveyor.com**](http://www.appveyor.com) is the only one
that runs Windows builds. Even though I'm working mostly with
Java and Ruby, which are expected to be platform independent, they
very often appear to be exactly the opposite. When your build
succeedes on Linux, there is almost no guarantee it will pass on
Windows or Mac. I'm planning to use appveyor in every project,
in combination with some other CI service. I'm still testing it though...

{% badge /images/2014/10/shippable.png 64 http://www.shippable.com %}

[**shippable.com**](http://www.shippable.com) was easy to configure
since it understands `.travis.yml` out of the box. Besides that,
nothing fancy.

{% badge /images/2014/10/wercker.png 64 http://www.wercker.com %}

[**wercker.com**](http://www.wercker.com) is a European product
from Amsterdam, which is still in beta and that's why free
for all projects. The platform looks very promissing. It is still
free for private repositories and is backed up by
[investments](https://gigaom.com/2014/10/01/wercker-takes-in-2-4-million-to-help-developers-test-their-code-in-the-cloud/).
I'm still testing it...

{% badge /images/2014/10/codeship.png 64 http://www.codeship.io %}

[**codeship.io**](http://www.codeship.io) works fine, but their web UI
looks a bit out-dated. Anyway, I'm using them now, will see.

{% badge /images/2014/10/magnum.png 64 http://www.magnum-ci.com %}

[**magnum-ci.com**](http://www.magnum-ci.com) is a very lightweight
and young system. It doesn't connect automatically to Github,
so you should do some manual operations of adding a web hook.
Besides that, works just fine.

{% badge /images/2014/10/drone.png 64 http://www.drone.io %}

[**drone.io**](http://www.drone.io) works fine, but their support
didn't reply to me when I asked for a Maven version update. Besides
that, their badge is not updated correctly in Gitub README.md.

{% badge /images/2014/10/circleci.png 64 http://www.circleci.com %}

[**circleci.com**](http://www.circleci.com) I still don't know why my build
fails there. Really difficult to configure and understand
what's going on. Trying to figure it out...

[**zeroci.com**](http://www.zeroci.com) looks like a one-man project, which
definitely needs usability testing. It was rather difficult to configure
a project via its web interface. The good thing is that it's free, but its
quality is not high enough to recommend it.

[**ship.io**](http://www.ship.io) is building only mobile applications (for iOS and Android).
Besides that, they don't support Maven for Android apps, only Gradle.
I'll try to build iOS Swift app with them soon....

[**solanolabs.com**](http://www.solanolabs.com) testing now...

[**hosted-ci.com**](http://www.hosted-ci.com) testing now...

[**cloudbees.com**](http://www.cloudbees.com) testing now...

[**dploy.io**](http://dploy.io/) testing now...

BTW, if you don't like the idea of keeping continuous integration
in cloud, consider these on-premise software packages (in order or preference):
[Jenkins](http://jenkins-ci.org/),
[TeamCity](http://www.jetbrains.com/teamcity/),
[Go](http://www.thoughtworks.com/products/go-continuous-delivery),
[Strider](http://stridercd.com/),
[BuildBot](http://buildbot.net/).

Keep in mind that no matter how good and expensive your
continuous integration service is, it
[won't help you]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %})
unless you make your
[master branch read-only]({% pst 2014/jul/2014-07-21-read-only-master-branch %}).
