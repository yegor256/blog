---
layout: post
title: "Every Build in Its Own Docker Container"
date: 2014-07-29
tags: docker rultor devops
description: |
  Rultor.com runs every build in its own Docker container,
  perfectly isolating configurations and making them cacheable and reproducible.
keywords:
  - continuous integration
  - docker continuous integration
  - continuous delivery
  - docker continuous delivery
  - jenkins docker
  - docker builds ci
  - unit tests in docker
---

{% badge https://doc.rultor.com/images/docker-logo.png 100 https://www.docker.io %}

[Docker](https://www.docker.io) is a command line tool that
can run a shell command in a virtual Linux, inside an isolated file system.
Every time we build our projects, we want them to run in their own
Docker containers. Take this Maven project for example:

```bash
$ sudo docker run -i -t ubuntu mvn clean test
```

{% badge https://doc.rultor.com/images/logo.svg 100 https://www.rultor.com %}

This command will start a new Ubuntu system and execute
`mvn clean test` inside it. [Rultor.com](https://www.rultor.com), our
virtual assistant, does exactly that with our builds, when we
deploy, package, test and merge them.

<!--more-->

## Why Docker?

What benefits does it give us? And why
[Docker]({% pst 2014/aug/2014-08-29-docker-non-root %}),
when there are many [other virtualization technologies](https://en.wikipedia.org/wiki/Operating_system-level_virtualization),
like LXC, for example?

Well, there are a few very important benefits:

 * Image repository (hub.docker.com)

 * Versioning

 * Application-centric

Let's discuss them in details.

## Image Repository

Docker enables image sharing through its public repository at
[hub.docker.com](http://hub.docker.com). This means that after
I prepare a working environment for my application, I make
an image out of it and push it to the hub.

Let's say, I want my Maven build to be executed in a container
with a pre-installed `graphviz` package (in order to enable `dot` command line tool).
First, I would start a plain vanilla Ubuntu container, and install `graphviz` inside it:

```text
$ sudo docker run -i -t ubuntu /bin/bash
root@215d2696e8ad:/# sudo apt-get install -y graphviz
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following extra packages will be installed:
...
root@215d2696e8ad:/# exit
$ sudo docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS                     PORTS               NAMES
215d2696e8ad        ubuntu:14.04        /bin/bash           About a minute ago   Exited (0) 3 seconds ago                       high_mccarthy
```

I have a container that stopped a few seconds ago. Container's
ID is `215d2696e8ad`. Now, I want to make it reusable for all
further tests in Rultor.com. I have to create an image from it:

```bash
$ sudo docker commit 215d2696e8ad yegor256/beta
c5ad7718fc0e20fe4bf2c8a9bfade4db8617a25366ca5b64be2e1e8aa0de6e52
```

I just made my new commit to a new image `yegor256/beta`.
This image can be reused right now. I can create a new container
from this image and it will have `graphviz` installed inside!

Now it's time to share my image at Docker hub, in order to make it available for Rultor:

```text
$ sudo docker push yegor256/beta
The push refers to a repository [yegor256/beta] (len: 1)
Sending image list
Pushing repository yegor256/beta (1 tags)
511136ea3c5a: Image already pushed, skipping
d7ac5e4f1812: Image already pushed, skipping
2f4b4d6a4a06: Image already pushed, skipping
83ff768040a0: Image already pushed, skipping
6c37f792ddac: Image already pushed, skipping
e54ca5efa2e9: Image already pushed, skipping
c5ad7718fc0e: Image successfully pushed
Pushing tag for rev [c5ad7718fc0e] on {https://registry-1.docker.io/v1/repositories/yegor256/beta/tags/latest}
```

The last step is to configure Rultor to use this image in
all builds. To do this, I will edit [`.rultor.yml`](https://doc.rultor.com/reference.html)
in the root directory of my GitHub repository:

```text
docker:
  image: yegor256/beta
```

That's it. From now on, Rultor will use my custom Docker image with
pre-installed `graphviz`, in every build (merge, release, deploy, etc.)

Moreover, if and when I want to add something else to the image,
it's easy to do. Say, I want to install Ruby into my build image.
I start a container from the image and install it (pay attention,
I'm starting a container not from `ubuntu` image, as I did before, but from `yegor256/beta`):

```text
$ sudo docker run -i -t yegor256/beta /bin/bash
root@7e0fbd9806c9:/# sudo apt-get install -y ruby
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following extra packages will be installed:
...
root@7e0fbd9806c9:/# exit
$ sudo docker ps -a
CONTAINER ID        IMAGE                  COMMAND             CREATED             STATUS                     PORTS               NAMES
7e0fbd9806c9        yegor256/beta:latest   /bin/bash           28 seconds ago      Exited (0) 2 seconds ago                       pensive_pare
215d2696e8ad        ubuntu:14.04           /bin/bash           10 minutes ago      Exited (0) 8 minutes ago                       high_mccarthy
```

You can now see that I have two containers. The first one is the one
I am using right now; it contains Ruby. The second one is the one
I was using before and it contains `graphviz`.

Now I have to commit again and push:

```bash
$ sudo docker commit 7e0fbd9806c9 yegor256/beta
6cbfb7a6b18a2182f42171f6bb5aef67c4819b5c2795edffa6a63ba78aaada2d
$ sudo docker push yegor256/beta
...
```

Thus, this Docker hub is a very convenient feature for Rultor and similar systems.

## Versioning

As you saw in the example above, every change to a Docker image has
its own version (hash) and it's possible to track changes.
It is also possible to roll back to any particular change.

Rultor is not using this functionality itself, but Rultor users
are able to control their build configurations with much better precision.

## Application-Centric

Docker, unlike LXC or Vagrant, for example, is application-centric.
This means that when we start a container---we start an application.
With other virtualization technologies, when you get a virtual machine---you get a fully functional Unix environment, where you can login through
SSH and do whatever you want.

Docker makes things simpler. It doesn't give you SSH access to container,
but runs an application inside and shows you its output. This is
exactly what we need in Rultor. We need to run an automated build
(for example Maven or Bundler), see its output and get its exit code.
If the code is not zero, we fail the build and report to the user.

This is how we run Maven build:

```bash
$ sudo docker run --rm -i -t yegor256/rultor mvn clean test
[INFO] ------------------------------------------------------------------------
[INFO] Building jcabi-github 0.13
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ jcabi-github ---
[INFO]
...
```

As you can see, Maven starts immediately. We don't worry
about the internals of the container. We just start an application inside it.

Furthermore, thanks to the `--rm` option, the container gets
destroyed immediately after Maven execution is finished.

This is what application-centric is about.

Our overall impression of Docker is highly positive.

ps. A compact version of this article was published at
[devops.com](http://devops.com/blogs/build-docker-containers/)
