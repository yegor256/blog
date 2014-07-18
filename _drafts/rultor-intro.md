---
layout: post
title: "Rultor.com, Merging Bot"
date: 2014-07-16
tags: rultor ci
description:
  Rultor.com is a bot that talks to you in Github
  issue tracking helping you to merge pull requests
  passing them through full testing cycle
keywords:
  - docker continuous integration
  - pre-flight builds
  - pre-flight builds docker
  - preflight builds
  - preflight builds docker
  - continuous integration pre-flight builds
  - continuous integration preflight builds
  - continuous delivery pre-flight builds
  - continuous delivery preflight builds
  - merging pull request docker
  - github pull request docker
  - continous delivery docker
  - builds in docker containers
  - jenkins pre-flight builds
  - jenkins preflight builds
---

You get a Github pull request. You review it. It looks correct &mdash; it's time
to merge it into `master`. You post a comment into it, asking
[@rultor](https://github.com/rultor) to test and merge. Rultor starts a new Docker container,
merges pull request into `master`, runs all tests, and, if everything looks
clean, &mdash; merges, pushes, and closes the request.

Then, you ask [@rultor](https://github.com/rultor) to deploy
current version to production environment. It checks out
your repository, starts a new Docker container, executes your
deployment scripts, and reports you right there, in Github issue.

<!--more-->

## Why not Jenkins or Travis?

There are many tools on the market, which automate continuous integration
and continuous delivery. For example, downloadable open-source [Jenkins](http://www.jenkins-ci.org)
and hosted [Travis](http://travis-ci.org). Why do we need one more?

Well, there are three features that are very important for our
projects, and we didn't find their complete set in any of
CI tools available on the market:

 * **Merging**. We make master branch read-only in our projects,
   as [this article]() recommends. All changes into master we pass through
   a script that validates them and merges.

 * **Docker**. Every build should work in its own Docker container, in order
   to simplify configuration, isolate resources, and make errors
   easily reproduceable.

 * **Tell vs. Trigger**. We need to communicate with CI tool through
   commands, right from our issue tracking system (Github issues, in most
   projects). All existing CI systems trigger builds on certain
   conditions. We need our developers to be able to talk to the tool,
   through human-like commands in the tickets they are working with.

A combination of these three features is what differs [Rultor](http://www.rultor.com) from
all other existing systems.

## How Rultor Merges

Once Rultor finds a [merge command](http://doc.rultor.com/basics.html)
in one of your Github pull requests, it does exactly this:

 1. Reads [`.rultor.yml`](http://doc.rultor.com/reference.html) YAML config from the root directory of your repository

 2. Gets automated build execution command from it, for example `bundle test`

 3. Checks out your repository into a temporary directory at one of its servers

 4. Merges pull request into `master` branch

 5. Starts a new Docker container and runs `bundle test` in it

 6. If everything is fine, pushes modified `master` branch to Github

 7. Reports back to you, in Github pull request

You can see it in action, for example, in this pull request:
[jcabi/jcabi-github#878](https://github.com/jcabi/jcabi-github/pull/878).
