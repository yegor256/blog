---
layout: post
title: "How to Deploy to CloudBees, in One Click"
date: 2014-08-24
tags: java rultor devops
description:
  This tutorial explains how a Java web application can be
  deployed to CloudBees in just one click and
  zero maintenance efforts, using Rultor.com, DevOps assistant
keywords:
  - deploy to cloudbees
  - how to deploy a java app to cloudbees
  - deploying to cloudbees
  - deploy in cloudbees
  - publish java web app to cloudbees
  - continuous delivery cloudbees
---

When I deploy a new version of [stateful.co](http://www.stateful.co),
a Java web application, to CloudBees, it takes 30 seconds of my time.
Maybe even less. Recently, I deployed version . You can see
how it all happened, in [Github issue #80](https://github.com/jcabi/jcabi-aspects/issues/80):

{% figure http://img.yegor256.com/2014/08/github-ticket-80.png 600 %}

As you see, I gave a command to [Rultor](http://www.rultor.com),
and it released a new version to Maven central. I didn't do anything else.

Now let's see how you can do the same. How you can configure your project
so that the release of its new version to Maven Central
takes just a few seconds of your time.

<!--more-->

## Run It!

{% badge http://img.rultor.com/logo.svg 100 http://www.rultor.com %}

Now it's time to see how it all works. Create a new ticket in the
Github issue tracker, and post something like that into it
(read more about [Rultor commands](http://doc.rultor.com/basics.html)):

{% highlight text %}
@rultor release, tag is `0.1`
{% endhighlight %}

You will get a response in a few seconds. The rest will be done by Rultor.

Enjoy :)

BTW, if something doesn't work as I've explained, don't hesitate to
submit a ticket to
[Rultor issue tracker](https://github.com/yegor256/rultor/issues).
I will try to help you.
