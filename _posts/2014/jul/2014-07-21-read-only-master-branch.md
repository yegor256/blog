---
layout: post
title: "Master Branch Must Be Read-Only"
date: 2014-07-21
tags: rultor devops
description: |
  Continuous integration doesn't work while programmers
  are able to commit into the master branch. This article
  explains why and proposes a solution.
book: code-ahead-1 3
keywords:
  - broken builds
  - continuous integration doesn't work
  - commits to master branch
  - continous delivery
  - continous deployment
  - continuous delivery preflight builds
  - continuous integration
---

Continuous integration is easy. Download Jenkins, install,  create a job, click
the button, and get a nice email saying that your build is broken (I assume your
build is automated). Then, fix broken tests (I assume you have tests), and get a
much better looking email saying that your build is clean.

Then, tweet about it, claiming that your team is using
[continuous integration]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %}).

Then, in a few weeks, start filtering out Jenkins alerts, into their own folder,
so that they don't bother you anymore. Anyway, your team doesn't have the time
or desire to fix all unit tests every time someone breaks them.

After all, we all know that unit testing is not for
a team working with deadlines, right?

Wrong. Continuous integration can and must work.

<!--more-->

## What is Continuous Integration?

Nowadays, software development is done in teams.
We develop in feature branches and isolate changes while
they are in development. Then, we merge branches into `master`.
After every merge, we test the entire product, executing all
available unit and integration tests.
This is called [continuous integration](https://en.wikipedia.org/wiki/Continuous_integration) (aka "CI").

{% youtube 2a2nWELIk-Y %}

Sometimes, some tests fail. When this happens, we say that our
"build is broken." Such a failure is a positive
side effect of quality control because it raises a red
flag immediately after an error gets into `master`.

It is a well-known practice, when fixing that error becomes
a top priority for its author and the entire team. The error
should be fixed right after a red flag is raised by the
[continuous integration]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %}) server.

{% badge /images/2014/07/continuous-delivery-book.png 100 http://amzn.to/2bQVmlb %}

[Continuous Delivery by Jez Humble et. al.](http://amzn.to/2bQVmlb)
explains this approach perfectly in Chapter 7, pages 169&ndash;186.

There are a few good tools on the market, which automate DevOps procedures.
Some of them are open source, you can download
and install them on your own servers. For example:
[Jenkins](http://jenkins-ci.org/),
[Go](http://www.thoughtworks.com/products/go-continuous-delivery), and
[CruiseControl](http://cruisecontrol.sourceforge.net/).
Some of them are available as a service in cloud, such as:
[Travis](http://www.travis-ci.org),
[Shippable](http://www.shippable.com),
[Wercker](http://wercker.com/), and
[many others]({% pst 2014/oct/2014-10-05-ten-hosted-continuous-integration-services %}).

## Why Continuous Integration Doesn't Work?

CI is great, but the bigger the team (and the code base), the more often builds
get broken. And, the longer it takes to fix them. I've seen many examples where
a hard working team starts to ignore red flags, raised by Jenkins, after a few
weeks or trying to keep up.

{% quote Product owners do not understand the importance of a "clean build" and devs can't buy time for fixing unit tests %}

The team simply becomes incapable of fixing all errors in time. Mostly because
the business has other priorities. Product owners do not understand the
importance of a "clean build" and technical leaders can't buy time for fixing
unit tests. Moreover, the code that broke them was already in `master` and, in
most cases, has been already deployed to production and delivered to end-users.
What's the urgency of fixing some tests if business value was already delivered?

{% youtube gL4XwP-EBOg %}

In the end, most development teams don't take continuous integration alerts
seriously. Jenkins or Travis are just fancy tools for them that play no role in
the entire development and delivery pipeline. No matter what continuous
integration server says, we still deliver new features to our end-users. We'll
fix our build later. And [it's only logical]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %}).

## What Is a Solution?

<a href="/pdf/2014/guard-article.pdf" class="em2"
  title="Prevent Conflicts in Distributed Agile PHP Projects"><i class="icon icon-pdf"></i></a>

Four years ago, in 2010, I published an article in [php|Architect](http://www.phparch.com/magazine/2010-2/august/)
called "Prevent Conflicts in Distributed Agile PHP Projects." In the article,
a solution was proposed (full article in [PDF](/pdf/2014/guard-article.pdf))
for Subversion and PHP.

Since that time, I used experimentally that approach in multiple
[open source]({% pst 2015/dec/2015-12-22-why-dont-you-contribute-to-open-source %})
projects and a few commercial ones with PHP, Java, Ruby and JavaScript, Git and
Subversion. In all cases, my experience was only positive, and that's why
[rultor.com](https://www.rultor.com) was born (later about that though).

So, the solution is simple---prohibit anyone from merging anything
into `master` and create a script that anyone can call. The script will
merge, test, and commit. The script will not make any exceptions.
If any branch is breaking at even one unit test, the entire branch will be rejected.

In other words, we should raise that red flag **before** the code
gets into `master`. We should put the blame for broken tests on
the shoulders of its author.

Say, I'm developing a feature in my own branch. I finished the development and
broke a few tests, accidentally. It happens, we all make mistakes. I can't merge
my changes into `master`. Git simply rejects my `push`, because I don't have the
appropriate permissions. All I can do is call a magic script, asking it to merge
my branch. The script will try to merge, but before pushing into `master`, it
will run all tests. And if any of them break, my branch will be rejected. My
changes won't be merged. Now it's my responsibility---to fix them and call
the script again.

In the beginning, this approach slows down the development, because everybody
has to start writing cleaner code. At the end, though, this method pays off big
time.

## Pre-flight Builds

Some CI servers offer pre-flight builds feature, which means testing branches
before they get merged into `master`. Travis, for example, has this feature and
it is very helpful. When you make a new commit to a branch, Travis immediately
tries to build it, and reports in GitHub pull request, if there are problems.

{% youtube Ht0JI41kA4I %}

Pay attention, pre-flight builds don't merge. They just check whether your
individual branch is clean. After merge, it can easily break `master`. And, of
course, this mechanism doesn't guarantee that no collaborators can commit
directly to `master`, breaking it accidentally. Pre-flight builds are a
preventive measure, but do not solve the problem entirely.

## Rultor.com

In order to start working as explained above, all you have to do is to revoke
write permissions to `master` branch (or `/trunk`, in Subversion).

Unfortunately, this is [not possible](http://stackoverflow.com/questions/10381672)
in GitHub. The only solution is to work through forks and pull requests only.
Simply remove everybody from the list of "collaborators" and they will
have to submit changes through pull requests.

{% badge https://doc.rultor.com/images/logo.svg 100 https://www.rultor.com %}

Then, start using [Rultor.com](https://www.rultor.com), which will help
you to test, merge and push every pull request. Basically, Rultor is
the script we were talking about above. It is available as a free cloud service.

ps. A short version of this article is also published at
[devops.com](http://devops.com/blogs/continuous-integration-doesnt-work/)

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Are you allowed to PUSH to the master/develop/trunk of your Version Control System (VCS)? <a href="https://twitter.com/hashtag/devops?src=hash&amp;ref_src=twsrc%5Etfw">#devops</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1142730754167889920?ref_src=twsrc%5Etfw">June 23, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
