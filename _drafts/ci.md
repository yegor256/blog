---
layout: post
title: "Eight Maturity Levels of Continuous Integration"
date: 2016-07-20
place: Palo Alto, CA
tags: devops
description: |
  There are a number of levels a continuous integration
  pipeline can go through, until it reaches its highest
  maturity.
keywords:
  - continuous integration
  - continuous integration levels
  - continuous integration maturity
  - continuous integration definition
  - continuous integration example
---

There are a number of levels you will go through, until your
continuous integration pipeline becomes perfect. I found eight of
them and presented at [DevOpsDays](http://slcdevopsdays.org/cr3ativconference/continuous-integration-may-have-negative-effects/)
in Salt Lake City a few weeks ago
(watch the [video](https://www.youtube.com/watch?v=3dJP_LtUGgg)).
Now it's time to write them down and ask
you &mdash; which level are you at? Post your answer below.

<!--more-->

1. **Source Code**.
Here you just source code, on your computers and maybe somewhere on
the server. The best you can do here is to build it manually, say,
every day. Is it continuous integration? Well, to some extend, provided
you don't forget to compile and package everything regularly.

2. **Automated Build**.
At this level your build is automated, which means that you can compile,
test and package the entire product in just one line at the command line.
Pay attention, one line. You must be able to hit one button and either
get an error or a successful build.

3. **Git**.
At this level you keep your source code in Git. You can keep it in some
other source control system, but that would be strange &mdash; Git is a
_status quo_ at the moment. You should be able to get a new computer,
with nothing in it, check out the source code from Git repository and
run a full build.

4. **Pull Requests**.
Each and every change to your source code must be submitted through
a pull request, which means that you host your repository in GitHub. You
may host it somewhere else, but, again, that would be strange, since
GitHub is a _status quo_ at the moment. Again, nobody should be able to commit
anything directly to the
[master branch]({% pst 2014/jul/2014-07-21-read-only-master-branch %}),
only through forks and pull requests.

5. **Code Reviews**.
Every pull request must pass a mandatory
[code review]({% pst 2015/feb/2015-02-09-serious-code-reviewer %})
before it gets merged.
You must have some code review policy, which explains who does reviews,
what happens if the author doesn't agree with the reviewer, etc. But no
pull request may be merged unless it has been reviewed.

6. **Tests**.
At this level your code is covered by unit tests (and integration tests) and every change
comes with a new test. Your automated build runs all tests together and fails
if any of them fail.

7. **Static Analysis**.
Checking the [quality]({% pst 2014/aug/2014-08-13-strict-code-quality-control %})
of your code without running it is what static analysis
is about. At this level the quality of code is checked by the automated
build. If the quality is lower then the threshold, the build fails.

8. **Pre-Flight Builds**.
This idea is explained
[here]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %}).

By the way, at the [presentation]
I also mentioned what problems you may have at each maturity level.
