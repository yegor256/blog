---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "How AppVeyor Helps Me to Validate Pull Requests Before Rultor Merges Them"
date: 2015-03-29
tags: devops rultor
description: |
  AppVeyor is a continuous integration platform for Windows
  projects; Rultor is a Docker based DevOps assistant for merge, release and deploy operations;
  they can work together.
keywords:
  - appveyor
  - appveyor merge pull request
  - appveyor and rultor
  - appveyor devops
  - windows builds with docker
---

{% badge /images/2014/10/appveyor.png 100 https://www.appveyor.com %}

[AppVeyor](https://www.appveyor.com) is a great cloud
[continuous integration]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %}) service that builds
Windows projects. [Rultor](https://www.rultor.com) is a DevOps assistant, which automates
release, merge and deploy operations, using Docker containers. These posts
explain how Rultor works and what it's for:
[Rultor.com, a Merging Bot]({% pst 2014/jul/2014-07-24-rultor-automated-merging %})
and [Master Branch Must Be Read-Only]({% pst 2014/jul/2014-07-21-read-only-master-branch %}).

{% badge https://doc.rultor.com/images/logo.svg 100 https://www.rultor.com %}

The problem is that Rultor is running all scripts inside Docker containers
and Docker can't build Windows projects. The only and the best logical solution
is to trigger AppVeyor before running all other scripts in Docker. If AppVeyor
gives a green light, we continue with our usual in-Docker script. Otherwise,
we fail the entire build. Below I explain how this automation was configured
in [Takes framework](https://www.takes.org).

<!--more-->

First, I got a token from my AppVeyor account (at the time
of writing it was [here](https://ci.appveyor.com/api-token)). I created
a text file `curl-appveyor.cfg` with this content (it's not my real token inside,
just an example):

```text
--silent
--header "Authorization: Bearer 1hdmsfbs7xccb9x6g1y4"
--header "Content-Type: application/json"
--header "Accept: application/json"
```

Then, I encrypted this file, using [`rultor`](https://github.com/yegor256/rultor-remote)
command line tool:

```bash
$ rultor encrypt -p yegor256/takes curl-appveyor.cfg
```

The file I created was called
`curl-appveyor.cfg.asc`.
I committed and pushed into [yegor256/takes](https://github.com/yegor256/takes)
GitHub repository.

```bash
$ git add curl-appveyor.cfg.asc
$ git commit -am 'CURL config for Appveyor'
$ git push origin master
```

Then, I configured AppVeyor "pinging" from Docker script.
This is what I did in [`.rultor.yml`](https://github.com/yegor256/takes/blob/master/.rultor.yml):

```text
decrypt:
  curl-appveyor.cfg: "repo/curl-appveyor.cfg.asc"
merge:
  script: |-
    ver=$(curl -K ../curl-appveyor.cfg \
      --data "{accountName: 'yegor256',
        projectSlug: 'takes',
        pullRequestId: '${pull_id}'}" \
      https://ci.appveyor.com/api/builds | jq -r '.version')
    while true; do
      status=$(curl -K ../curl-appveyor.cfg \
        https://ci.appveyor.com/api/projects/yegor256/takes/build/${ver} \
        | jq -r '.build.status')
      if [ "${status}" == "success" ]; then break; fi
      if [ "${status}" == "failed" ]; then
        echo "see https://ci.appveyor.com/project/yegor256/takes/build/${ver}"
        exit 1
      fi
      echo "waiting for AppVeyor build ${ver}: ${status}"
      sleep 5s
    done
    mvn clean install
```

There is no magic here, it's very simple. First, I start a new build
using `/api/builds` end-point of
[AppVeyor REST API](https://www.appveyor.com/docs/api/projects-builds#start-build-of-pull-request-github-only).
`${pull_id}` is an environment variable that is coming from Rultor,
it contains an integer number of current pull request.

I'm using [jq](http://stedolan.github.io/jq/)
in order to parse AppVeyor JSON output.

Once the build is started, I'm getting its unique `version` and start
looping to check its status. I'm waiting for `success` or `failed`. Anything
else will mean that the build is still in progress and I should keep looping.

You can see how it works in this pull request, for example:
[yegor256/takes#93](https://github.com/yegor256/takes/pull/93).
