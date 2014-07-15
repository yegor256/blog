---
layout: post
title: "Master Branch Must Be Read-Only"
date: 2014-07-16
tags: ci
description:
  Continuous integration doesn't work while
  programmers can commit into master branch; the article explains why
  and proposes a solution
keywords:
  - continuous integration
  - continous delivery
  - continous deployment
  - pre-flight builds
  - preflight builds
  - broken builds
  - jenkins broken builds
  - how to fix broken builds
  - managing broken builds
  - continuous integration pre-flight builds
  - continuous integration preflight builds
  - continuous delivery pre-flight builds
  - continuous delivery preflight builds
---

Continuous integration is easy. Download Jenkins, install, create
a job, click the button, and get a nice email saying that your build
is broken (I assume your build is automated). Then, fix broken tests
(I assume you have tests), and get a much better looking email,
saying that your build is clean.

Then, tweet about it, claiming that your team is using continuous
integration.

Then, in a few weeks, start filtering out Jenkins alerts, into their own
folder, so that they don't bother you any more. Anyway, your team doesn't have
time or desire to fix all unit tests every time someone breaks them.
After all, we all know that unit testing is not for a team working with deadlines, right?

Wrong. Continuous integration can work and must work.

<!--more-->

## What is Continuous Integration?

Software development nowadays is done in teams. We develop in feature branches,
isolating changes while they are in development. Then, we merge branches into
`master`. After every merge, we
test the entire product, executing all available unit and integration tests.
This is called
[continuous integration](https://en.wikipedia.org/wiki/Continuous_integration) (aka "CI").

Sometimes some tests fail.
When this happens, we say that our "build is broken".
Such a failure is a positive side effect of quality control,
because it raises a red flag immediately after an error gets into `master`.
It is a well-known practice, when fixing that error becomes a top
priority for its author and the entire team. The error should be fixed right after
a red flag is raised by the continuous integration server.

{% badge http://img.yegor256.com/continuous-delivery-by-jez-humble.jpg 64 %}

[Continuous Delivery by Jez Humble et. al.](http://www.amazon.com/gp/product/0321601912/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0321601912&linkCode=as2&tag=yegor256com-20&linkId=GKWBKGZUJGJLFMHE)
explains this approach perfectly in chapter5, pages 45&ndash;45;

There are a few good tools on the market, which automate CI.
Some of them are open source, you can download and install them on your
own servers, for example
[Jenkins](http://www.jenkins-ci.org),
[Go](http://www.thoughtworks.com/products/go-continuous-delivery), and
[CruiseControl](http://cruisecontrol.sourceforge.net/). Some of them
are available as a service in cloud, for example
[Travis](http://www.travis-ci.org),
[Drone](http://www.drone.io),
[Wercker](http://wercker.com/), and many others.

## Why CI Doesn't Work?

CI is great, but the bigger the team (and the code base),
the more often the builds get broken. And the longer it takes to fix them. I've
seen many examples where a hard working team starts
to ignore that red flags, raised by Jenkins, after a few weeks
or trying to keep up.

The team simply becomes not capable of fixing all errors in time.
Mostly because the business has other priorities. Product owners
do not understand the importance of a "clean build" and technical leaders
can't buy time for fixing unit tests. Moreover, the code that broke them
is already in `master` and, in most cases, already deployed to production
and delivered to end-users. What's the urgency of fixing some tests
if business value is already delivered?

In the end, most development teams don't take continuos integration alerts
seriously. Jenkins of Travis are just fancy tools for them. They play no
role in the entire development and delivery pipeline. No matter what
continuous integration server says, we still deliver new features
to our end-users. We'll fix our build later. And it's only logical.

## What Is a Solution?

Four years ago I published an article in [php|Architect](http://www.phparch.com/magazine/2010-2/august/),
called "Prevent Conflicts in Distribued Agile PHP Projects",
where a solution was proposed
(full article in [PDF](http://img.rultor.com/guard-article.pdf)) for Subversion and PHP.

Since that time I experimentally used
that approach in multiple open source and a few commercial projects,
with PHP, Java, Ruby and JavaScript, with Git and Subversion.
In all cases, my experience was only positive, and that's why
[rultor.com](http://www.rultor.com) (later about it).

So, the solution is simple &mdash; prohibit anyone to merge anything into `master`,
and create script which anyone can call. The script will merge, test, and commit.
The script will not make any exceptions. If any branch is breaking at least
one unit test, it will be rejected.

In other words, we should raise that red flag before the code gets
into `master`. We should put the blame for broken tests to the
shoulders of its author.

I'm developing a feature in my own branch. I finished the development
and broken a few tests, accidentally. It happens, we all make mistakes.
I can't merge my changes into `master`. Git simply will reject my
`push`, because I don't have permissions. All I can do is call a script,
asking it to merge my branch. The script will try, but before pushing
into `master` it will execute all tests. And if any of them break, I will
get a rejection. My changes won't be merged. Now it's my responsibility &mdash;
to fix them and try to merge again.

In the beginning, this approach slows down the development, because
everybody has to start writing cleaner code. At the end, this method
pays off, big time.

## Pre-flight Builds

Some CI servers offer pre-flight builds feature, which means
testing branches before they get merged into `master`. Travis, for example,
has this feature and it is very helpful. When you make a new commit
to a branch, Travis immediately tries to build it, and reports
in Github pull request, if there are problems.

Pay attention, pre-flight builds don't merge. They just check whether
your individual branch is clean. After merge it can easily break `master`.

And, of course, they don't guarantee that one of project collaborators
commit directly to `master`, breaking it.

## Rultor.com

In order to start working as explained above, all you have to do
is to revoke write permissions to `master` branch (or `/trunk`, in Subversion).

Unfortunately, it's [not possible](http://stackoverflow.com/questions/10381672) in Github.
The only solution is to work through forks and pull requests only. Simply,
remove everybody from the list of "collaborators" and they will have to
submit changes through pull requests.

{% badge http://img.rultor.com/logo.svg 64 %}

Then, start using [Rultor.com](http://www.rultor.com),
which will help you to test, merge and push
every pull request. Basically, Rultor is that script we were talking about above,
available as a service, in cloud, for free.
