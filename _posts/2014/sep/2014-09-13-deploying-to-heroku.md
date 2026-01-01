---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Deploying to Heroku, in One Click"
date: 2014-09-13
tags: rultor devops java
description: |
  This tutorial explains how a Java project can be
  deployed to Heroku in just one click and
  zero maintenance efforts, using Rultor.com, DevOps assistant
keywords:
  - release to heroku
  - how to release to heroku
  - deploy java app to heroku
  - how to deploy to heroku
  - heroku java release
  - fast release to heroku
---

There were a few articles already about our usage of Rultor
for automating continuous delivery cycles of Java and Ruby projects,
including [RubyGems](https://www.yegor256.com/2014/08/26/publish-to-rubygems.html),
[CloudBees](https://www.yegor256.com/2014/08/25/deploy-to-cloudbees.html)
and [Maven Central](https://www.yegor256.com/2014/08/19/how-to-release-to-maven-central.html).

{% badge /images/2014/09/heroku-logo.svg 100 https://www.heroku.com %}

This one describes how Heroku deployment can be automated. When I
need to deploy a new version of an Aintshy web application,
all I do is create one message in a GitHub ticket. I just say
`@rultor release 0.1.4` and version 0.1.4 gets deployed
to Heroku. See GitHub ticket [#5](https://github.com/aintshy/hub/issues/5).

You can do the same, with the help of [Rultor.com](https://www.rultor.com),
a free hosted DevOps assistant.

<!--more-->

Create a new project at [Heroku.com](https://www.heroku.com).

Then install their [command line tool-belt](https://toolbelt.heroku.com/).

You should authenticate your public SSH key at Heroku, using
their command line tool-belt. The process is explained
[here](https://devcenter.heroku.com/articles/authentication),
but it is not much of a process. You just run `heroku login`
and enter your login credentials. As a result, you will get
your existing key (located at `~/.ssh/id_rsa.pub`) authenticated by Heroku.

If you didn't have the key before, it will be created automatically.

Now, encrypt `id_rsa` and `id_rsa.pub` (they are in the `~/.ssh` directory)
with a [rultor remote](https://github.com/yegor256/rultor-remote):

```xml
$ gem install rultor
$ rultor encrypt -p me/test id_rsa
$ rultor encrypt -p me/test id_rsa.pub
```

Instead of `me/test` use the name of your GitHub project.

You will get two new files `id_rsa.asc` and `id_rsa.pub.asc`.
Add them to the root directory of your project,
commit and push. These files contain your secret information,
but only the Rultor server can decrypt them.

Create a `.rultor.yml` file in the root directory of your project
([reference page](https://doc.rultor.com/reference.html)
explains this format in detail):

```text
decrypt:
  id_rsa: "repo/id_rsa.asc"
  id_rsa.pub: "repo/id_rsa.pub.asc"
release:
  script: |
    mvn versions:set "-DnewVersion=${tag}"
    git commit -am "${tag}"
    mvn clean install -Pqulice --errors
    git remote add heroku git@heroku.com:aintshy.git
    mkdir ~/.ssh
    mv ../id_rsa ../id_rsa.pub ~/.ssh
    chmod -R 600 ~/.ssh/*
    echo -e \
      "Host *\n  StrictHostKeyChecking no\n  UserKnownHostsFile=/dev/null" \
      > ~/.ssh/config
    git push -f heroku $(git symbolic-ref --short HEAD):master
```

You can compare your file with live Rultor
[configuration of aintshy/hub](https://github.com/aintshy/hub/blob/master/.rultor.yml).

{% badge https://doc.rultor.com/images/logo.svg 100 https://www.rultor.com %}

Now it's time to see how it all works. Create a new ticket in the
GitHub issue tracker, and post something like this into it
(read more about [Rultor commands](https://doc.rultor.com/basics.html)):

```text
@rultor release, tag is `0.1`
```

You will get a response in a few seconds. The rest will be done by Rultor.

Enjoy!

BTW, if something doesn't work as I've explained, don't hesitate to
submit a ticket to the
[Rultor issue tracker](https://github.com/yegor256/rultor/issues).
I will try to help you.

PS. I would also recommend to versionalize artifacts
through `MANIFEST.MF` and use
[jcabi-manifests]({% pst 2014/jul/2014-07-03-how-to-read-manifest-mf %})
to read them later.
