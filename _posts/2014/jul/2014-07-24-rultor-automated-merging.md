---
layout: post
title: "Rultor.com, a Merging Bot"
date: 2014-07-24
tags: rultor devops
description: |
  Rultor.com is a bot that talks to you via GitHub
  issue tracking and helps you merge pull requests by
  passing them through a full testing cycle
keywords:
  - docker continuous integration
  - pre-flight builds
  - pre-flight builds docker
  - preflight builds
  - preflight builds docker
  - continuous integration pre-flight builds
  - continuous integration preflight builds
  - continuous delivery pre-flight builds
---

{% badge https://doc.rultor.com/images/logo.svg 100 https://www.rultor.com %}

You get a GitHub pull request. You review it. It looks correct---it's time
to merge it into `master`. You post a comment in it, asking
[@rultor](https://github.com/rultor) to test and merge. Rultor starts a new
[Docker](http://www.docker.io) container, merges the pull request into `master`, runs all tests and, if
everything looks clean---merges, pushes, and closes the request.

Then, you ask [@rultor](https://github.com/rultor) to deploy the current version
to production environment. It checks out your repository, starts a new Docker
container, executes your deployment scripts and reports to you right there in
the GitHub issue.

<!--more-->

## Why not Jenkins or Travis?

There are many tools on the market, which automate
[continuous integration]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %}) and
continuous delivery (let's call them DevOps).
For example, downloadable open source
[Jenkins](http://jenkins-ci.org/) and hosted
[Travis]({% pst 2014/jul/2014-07-31-travis-and-rultor %})
both perform these tasks. So, why do we need one more?

{% youtube NflR7DKwxDY %}

Well, there are three very important features that we need for our projects, but
we can't find all of them in any of the DevOps tools currently available on the
market:

 * **Merging**. We make master branch read-only in our projects,
   as [this article]({% pst 2014/jul/2014-07-21-read-only-master-branch %})
   recommends. All changes into master we pass through
   a script that validates them and merges.

 * **Docker**. Every build should work in its own
   Docker container, in order to simplify configuration, isolate
   resources and make errors easily reproducible.

 * **Tell vs. Trigger**. We need to communicate with DevOps tool
   through commands, right from our issue tracking system (GitHub
   issues, in most projects). All existing DevOps systems trigger
   builds on certain conditions. We need our developers to be able
   to talk to the tool, through human-like commands in the tickets they are working with.

A combination of these three features is what differs
[Rultor](https://www.rultor.com) from all other existing systems.

## How Rultor Merges

Once Rultor finds a [merge command](https://doc.rultor.com/basics.html)
in one of your GitHub pull requests, it does exactly this:

 1. Reads the [`.rultor.yml`](https://doc.rultor.com/reference.html)
    YAML configuration file from the root directory of your repository.

 2. Gets automated build execution command from it, for example `bundle test`.

 3. Checks out your repository into a temporary directory on one of its servers.

 4. Merges pull request into `master` branch.

 5. Starts a new Docker container and runs `bundle test` in it.

 6. If everything is fine, pushes modified `master` branch to GitHub.

 7. Reports back to you, in the GitHub pull request.

You can see it in action, for example, in this pull request:
[jcabi/jcabi-github#878](https://github.com/jcabi/jcabi-github/pull/878).
