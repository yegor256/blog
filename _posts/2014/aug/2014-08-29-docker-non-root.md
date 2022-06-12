---
layout: post
title: "How We Run as a Non-Root Inside Docker Container"
date: 2014-08-29
tags: docker rultor
description: |
  By default, docker container starts a process inside
  as a root user. In rultor.com we change it to a custom
  user, read how
keywords:
  - docker non-root
  - docker without sudo
  - docker non-root user
  - running app inside Docker as non-root user
  - running docker entirely as non-root
---

Docker starts a process inside its container as a "root" user. In some
cases, this is not convenient though. For example, `initdb` from PostgreSQL doesn't like to
be started as root and will fail. In [rultor.com](https://www.rultor.com),
a DevOps team assistant,
[we're using Docker]({% pst 2014/jul/2014-07-29-docker-in-rultor %})
as a virtualization technology for every build we run.

Here is how we change the user inside a running container, right
after it is started.

<!--more-->

First, this is how we start a new Docker container:

{% highlight bash %}
$ sudo docker run -i -t --rm -v "$(pwd):/main" \
  yegor256/rultor /main/entry.sh
{% endhighlight %}

There are two files in the current directory: `entry.sh` and `script.sh`.
`entry.sh` is the file being executed by Docker on start,
and it contains the following:

{% highlight bash %}
#!/bin/bash
adduser --disabled-password --gecos '' r
adduser r sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
su -m r -c /home/r/script.sh
{% endhighlight %}

`script.sh` will be executed as a user `r` inside the container. And this
`r` user will have `sudo` permissions. This is exactly what all projects,
managing their DevOps procedures with [rultor.com](https://www.rultor.com), need.
