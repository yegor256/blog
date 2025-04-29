---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "8+2 Maturity Levels of Continuous Integration"
date: 2016-08-01
place: Palo Alto, CA
tags: devops
description: |
  There are a number of levels a continuous integration
  pipeline can go through until it reaches its greatest
  maturity.
keywords:
  - continuous integration
  - continuous integration levels
  - continuous integration maturity
  - continuous integration definition
  - continuous integration example
image: /images/2016/08/twins.jpg
jb_picture:
  caption: Twins (1988) by Ivan Reitman
---

There are a number of levels you have to go through before your
continuous integration pipeline becomes perfect. I found eight of
them and presented my findings at DevOpsDays
in Salt Lake City a few weeks ago
(watch the [video](https://www.youtube.com/watch?v=3dJP_LtUGgg)).
Now it's time to write them down and ask
you---Which level are you at? Post your answer below.

<!--more-->

{% jb_picture_body %}

1. **Source Code**.
Here you just write source code on your computers and maybe somewhere on
the server. The best you can do here is to build it manually, say,
every day. Is it continuous integration? Well, to some extent, provided
you don't forget to compile and package everything regularly.

2. **Automated Build**.
At this level, your build is automated, which means you can compile,
test, and package the entire product with just one line at the command line.
Pay attention; one line. You must be able to hit one button and either
get an error or a successful build.

3. **Git**.
At this level, you keep your source code in Git. You can keep it in some
other source control system, but that would be strange---Git is the
_status quo_ at the moment. You should be able to get a new computer,
with nothing in it, check out the source code from a Git repository, and
run a full build.

4. **Pull Requests**.
Each and every change to your source code must be submitted through
a pull request, which means that you host your repository on GitHub. You
may host it somewhere else, but again, that would be strange because
GitHub is the _status quo_ at the moment. Again, nobody should be able to commit
anything directly to the
[master branch]({% pst 2014/jul/2014-07-21-read-only-master-branch %})
except through forks and pull requests.

5. **Code Reviews**.
Every pull request must pass a mandatory
[code review]({% pst 2015/feb/2015-02-09-serious-code-reviewer %})
before it gets merged.
You must have some code review policy that explains who does reviews,
what happens if the author doesn't agree with the reviewer, etc. But no
pull request may be merged unless it has been reviewed.

6. **Tests**.
At this level, your code is covered by unit tests (and integration tests), and every change
comes with a new test. Your automated build runs all tests together and fails
if any of them fail.

7. **Static Analysis**.
Checking the [quality]({% pst 2014/aug/2014-08-13-strict-code-quality-control %})
of your code without running it is what static analysis
is about. At this level, the quality of your code is checked by the automated
build. If the quality is lower than the threshold, the build fails.

8. **Pre-Flight Builds**.
This idea is explained
[here]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %}).

9. **Production Simulation**. The build is run in a container, which
simulates production environment and data.

10. **Stress Tests**. Performance and stress tests are automated and executed
on every build.

By the way, at the [presentation](https://www.youtube.com/watch?v=3dJP_LtUGgg),
I also mentioned what problems you may encounter at each maturity level.
