---
layout: post
title: "Every Build in Its Own Docker Container"
date: 2014-07-16
tags: docker rultor ci
description:
  Rultor.com runs every build in its own Docker
  container, perfectly isolating configurations
  and making them cacheable and reproducible
keywords:
  - continuous integration
  - docker continuous integration
  - continuous delivery
  - docker continuous delivery
  - jenkins docker
  - docker builds ci
  - unit tests in docker
  - docker container continuous integration
---

Docker is a command line tool that can run a shell command in
virtual Linux inside an isolated file system. Every time we
build our Java projects, we want them to run in their own
Docker containers, for example:

{% highlight bash %}
$ sudo docker run -i -t ubuntu mvn clean test
{% endhighlight %}

This command will start a new Ubuntu system and execute `mvn clean test`
inside it. Rultor.com, our virtual assistant, does exactly that
with our builds, when we deploy, package, test and merge.

<!--more-->

## Why Docker?

What benefits does it give us? And why Docker, when there are many
[other virtualization technologies](https://en.wikipedia.org/wiki/Operating_system-level_virtualization),
like LXC, for example?

Well, there are a few very important benefits.

 * Image repository (hub.docker.com)

 *

Let's discuss them in details.

## Image Repository

Docker images

