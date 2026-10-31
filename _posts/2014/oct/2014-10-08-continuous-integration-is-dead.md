---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Continuous Integration is Dead"
date: 2014-10-08
tags: devops
categories: jcg best
description: |
  Continuous integration is an awesome idea that
  doesn't work and can't work because of its
  natural conflict with business and technical objectives.
keywords:
  - continuous integration
  - how continuous integration works
  - jenkins doesn't work
  - how to configure continuous integration
  - continuous integration problems
  - continuous integration pitfalls
  - alternative to continuous integration
social:
  - reddit: https://www.reddit.com/r/programming/comments/2j9vt0/continuous_integration_is_dead/
---

A few days ago, my article
[Why Continuous Integration Doesn't Work](http://devops.com/blogs/continuous-integration-doesnt-work/)
was published at [DevOps.com](https://www.devops.com). Almost the same
day I received a few strongly negative critiques on Twitter.

Here is my response to the un-asked question:

> Why the hell shouldn't continuous integration work, being such a brilliant and popular idea?

Even though I have some experience in this area, I won't use it as an argument.
I'll try to rely only on logic instead.

<!--more-->

BTW, my experience includes five years of using
Apache Continuum, Hudson, CruiseControl, and Jenkins in over 50 open
source and commercial projects. Besides that,
a few years ago I created a hosted
[continuous integration]({% pst 2016/aug/2016-08-01-continuous-integration-maturity %}) service called
[fazend.com](https://www.fazend.com),
renamed to [rultor.com](https://www.rultor.com) in 2013.
Currently, I'm also an active user of [Travis](https://www.travis-ci.org)
and [AppVeyor](https://www.appveyor.com).

## How Continuous Integration Should Work

{% youtube 3IXk5yEJMIs %}

The idea is simple and obvious. Every time you make a new commit
to the `master` branch (or `/trunk` in Subversion), a continuous integration
server (or service) attempts to build the entire product. "Build" means
compile, unit test, integration test, quality analysis,
[etc.]({% pst 2014/jun/2014-06-21-casperjs-with-maven %})

The result is either "success" or "failure." If it is a success, we
say that "the build is clean." If it is a failure, we say that "the build is broken."
The build usually gets broken because someone breaks it by
committing new code that turns previously passing unit tests
into failing ones.

This is the technical side of the problem. It always works. Well,
it may have its problems, like hard-coded dependencies, lack of isolation between
environments or parallel build collisions, but this article is not about those.
If the application is well written and its unit tests are stable,
continuous integration is easy. Technically.

{% youtube gL4XwP-EBOg %}

Let's see the organizational side.

Continuous integration is not only a server that builds, but a
management/organizational process that should "work." Being a process
that works means exactly what Jez Humble said in
[Continuous Delivery: Reliable Software Releases through Build, Test, and Deployment Automation](https://amzn.to/2c7sR4V),
on page 55:

> Crucially, if the build fails, the development team
stops whatever they are doing and fixes the problem immediately.

This is what doesn't work and can't work.

## Who Needs This?

As we see, continuous integration is about setting the entire
development team on pause and fixing the broken build. Let me
reiterate. Once the build is broken, everybody should focus
on fixing it and making a commit that returns the build to
the stable state.

Now, my question is---who, in an actively working team, may need this?

A product owner, who is interested in launching new features to the market
as soon as possible? Or maybe a
[project manager]({% pst 2015/sep/2015-09-22-micromanagement %}), who is responsible for
the deadlines? Or maybe programmers, who hate to fix bugs made by someone else,
especially under pressure?

Who likes this continuous integration and who needs it?

Nobody.

## What Happens In Reality?

I can tell you. I've seen it multiple times. The scenario is always
the same. We just start to ignore that continuous integration
build status. Either the build is clean or it is broken, and we continue
to do what we were doing before.

We don't stop and fix it, as Jez Humble recommends.

Instead, we ignore the information that's
coming from the continuous integration server.

Eventually, maybe tomorrow or on Monday, we'll try to find some spare time
and will try to fix the build. Only because we don't like that red button
on the dashboard and want to turn it into a green one.

## What About Discipline?

{% youtube Ht0JI41kA4I %}

Yes, there is another side of this coin. We can try to enforce
discipline in the team. We can make it a strict rule, that our
build is always clean and whoever breaks it gets some sort of
a [punishment]({% pst 2016/jan/2016-01-05-how-to-punish-employees %}).

Try doing this and you will get a
[_fear driven development_](https://wiki.c2.com/?FearDrivenDevelopment). Programmers
will be afraid of committing anything to the repository because
they will know that if they cause a build failure they will have to
[apologize](http://programmers.stackexchange.com/questions/79041), at least.

A strict discipline (which I'm a big fan of) in this case only
makes the situation worse. The entire development process slows
down and programmers keep their code to themselves for as long as
possible, to avoid possibly broken builds. When it's time to commit,
their changes are so massive that merging becomes very difficult and
sometimes impossible.

As a result you get a lot of throw-away code, written by someone
but never committed to `master`, because of that fear factor.

## OK, What Is The Solution?

I wrote about it before; it is called
[read-only master branch]({% pst 2014/jul/2014-07-21-read-only-master-branch %}).

It is simple---prohibit anyone from merging anything
into `master` and create a script that anyone can call. The script will
merge, test, and commit. The script will not make any exceptions.
If any branch breaks at even one unit test, the entire branch will be rejected.

In other words: raise the red flag **before** the code
gets into `master`.

This solves all problems.

First, the build is always clean. We simply can't break it because
nobody can commit unless his code keeps the build clean.

Second, there is no fear of breaking anything. Simply because you technically can't
do it. All you can do is get a negative response from a merging script. Then
you fix your errors and tell the script to try again. Nobody sees these
attempts, and you don't need to apologize. Fear factor is gone.

BTW, try to use [rultor.com](https://www.rultor.com) to enforce this
[read-only master branch]({% pst 2014/jul/2014-07-21-read-only-master-branch %})
principle in your project.
