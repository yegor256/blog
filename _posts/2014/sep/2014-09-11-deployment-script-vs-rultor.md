---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Deployment Script vs. Rultor"
date: 2014-09-11
tags: rultor devops
description: |
  Many of us have our own custom release/deployment scripts
  which work just fine. What value can Rultor add to them?
keywords:
  - deployment script
  - release script
  - automate deployment
  - fully automated deployment
  - how to automate deployment process
categories: jcg
image: /images/2014/09/charlie-and-chocolate-factory-father.png
jb_picture:
  caption: Charlie and the Chocolate Factory (2005) by Tim Burton
---

{% badge https://doc.rultor.com/images/logo.svg 100 https://www.rultor.com %}

When I explain how [Rultor](https://www.rultor.com) automates deployment/release processes,
very often I hear something like:

> But I already have a script that deploys everything automatically.

This response is very common, so I decided to summarize my three main arguments for
automated Rultor deployment/release processes in one article: 1) isolated docker containers,
2) visibility of logs and 3) security of credentials.

Read about them and see what Rultor gives you on top of **your existing**
deployment script(s).

<!--more-->

{% jb_picture_body %}

Before we start with the arguments, let me emphasize that Rultor
is a useful interface to your custom scripts. When you decide
to automate deployment with Rultor, you don't throw away any of your
existing scripts. You just teach Rultor how to call them.

## Isolated Docker Containers

{% youtube NflR7DKwxDY %}

The first advantage you get once you start calling your deployment
scripts from Rultor is the [usage of Docker]({% pst 2014/jul/2014-07-29-docker-in-rultor %}).
I'm sure you know what [Docker](https://www.docker.io) is, but for those who don't---it is a
manager of virtual Linux "machines." It's a command line script
that you call when you need to run some script in a new virtual machine (aka "container").
Docker starts the container almost immediately and runs your script. The beauty
of Docker is that every container is a perfectly isolated Linux environment, with its
own file system, memory, processes, etc.

When you tell Rultor to run your deployment script, it starts a new Docker
container and runs your script there. But what benefit does this give me, you ask?

The main benefit is that the container gets destroyed right after your script
is done. This means that you can do all pre-configuration inside the
container without any fear of conflict with your main working
platform. Let me give an example.

I'm developing on MacBook, where I install and remove packages which I need for development.
At the same time, I have a project that, in order to be deployed, requires PHP 5.3, MySQL 5.6, Phing,
PHPUnit, PHPCS and xdebug. Every MacOS version needs to be configured specifically
to get these applications up and running, and it's a time-consuming job.

I can change laptops, and I can change MacOS versions, but the project stays the same. It
still requires the same set of packages in order to run its deployment script
successfully. And the project is not in active development any more. I simply
don't need these packages for my day-to-day work, since I'm working with Java more now.
But, when I need to make a minor fix to that PHP project and deploy it,
I have to install all the required PHP packages and configure them.
Only after that can I deploy that minor fix.

It is annoying, to say the least.

Docker gives me the ability to automate all of this together. My **existing** deployment
script will get a preamble, which will install and configure all necessary
PHP-related packages in a clean Ubuntu container. This preamble will be executed
on every run of my deployment script, **inside** a Docker container. For example,
it may look like this:

My deployment script looked like this before I started to use Rultor:

```bash
#!/usr/bin/env bash
phing test
git ftp push --user ".." \
  --passwd ".." \
  --syncroot php/src \
  ftp://ftp.example.com/
```

Just two lines. The first one is a full run of unit tests. The second one
is an FTP deployment to the production server. Very simple. But this script
will only work if PHP 5.3, MySQL, Phing, xdebug, PHPCS and PHPUnit are installed.
Again, it's a lot of work to install and configure them every time I upgrade
my MacOS or change a laptop.

{% youtube _61CuGhyv-o %}

Needless to say, that if/when someone joins the project and
tries to run my scripts, he/she will have to do this pre-installation
work again.

So, here is a new script, which I'm using now.
It is being executed inside a new Docker container, every time:

```bash
#!/usr/bin/env bash
# First, we install all prerequisites
sudo apt-get install -y php5 php5-mysql mysql
sudo apt-get install php-pear
sudo pear channel-discover pear.phpunit.de
sudo pear install phpunit/PHPUnit
sudo pear install PHP_CodeSniffer
sudo pecl install xdebug
sudo pear channel-discover pear.phing.info
sudo pear install phing/phing
# And now the same script I had before
phing test
git ftp push --user ".." \
  --passwd ".." \
  --syncroot php/src \
  ftp://ftp.example.com/
```

Obviously, running this script on my MacBook (without virtualization) would
cause a lot of trouble. Well, I don't even have `apt-get` here.

Thus, the first benefit that Rultor gives you is an isolation
of your deployment script in its own virtual environment. We have this
mostly thanks to Docker.

## Visibility of Logs

Traditionally, we keep deployment scripts in some `~/deploy` directory
and run them with a magic set of parameters. In a small project, you
do this yourself and this directory is on your own laptop. In a bigger
project, there is a "deployment" server, that has that magic directory
with a set of scripts that can be executed only by a few trusted
senior developers. I've seen this setup many times.

The biggest issue here is traceability. It's almost impossible to find
out who deployed what and why some particular deployment failed. The senior
deployment gurus simply SSH to the server and run those magic scripts
with magic parameters. Logs are usually lost and problem tracking
is very difficult or impossible.

Rultor offers something different. With Rultor, there is no SSH access
to deployment scripts any more. All scripts stay in the `.rultor.yml` configuration
file, and you start them by posting messages in your issue tracking system
(for example GitHub, JIRA or Trac). Rultor runs the script and publishes
its full log right to your ticket. The log stays with your project forever.
You can always get back to the ticket you were working with and check
why deployment failed and what instructions were actually executed.

For example, check out this GitHub issue, where I was deploying a new
version of Rultor itself, and failed a few times:
[yegor256/rultor#563](https://github.com/yegor256/rultor/issues/563). All
my failed attempts are protocolled. I can always get back to them and
investigate. For a big project this information is vital.

Thus, the second benefit of Rultor versus a standalone deployment
script is visibility of every single operation.

## Security of Credentials

When you have a custom script sitting in your laptop or in that
secret team deployment server, your production credentials stay
close to it. There is just no other way. If your software works with
a database, it has to know login credentials (user name, password, DB name,
port number, etc.). Well, in the worst case, some people just hard
code that information right into the source code.
We aren't even going to discuss this case, that's how bad it is.

But let's say you separate your DB credentials from the source code. You will
have something like a `db.properties` or `db.ini` file, which will be attached
to the application right before deployment. You can also keep that file
directly in the production server, which is even better, but not always
possible, especially with PaaS deployments, for example.

A similar problem exists with deployments of artifacts to repositories. Say,
you're regularly deploying to RubyGems.org. Your `~/.gem/credentials` will
contain your secret API key.

So, very often, your deployment scripts are accompanied by some files
with sensitive and secure information. And these files have this information
in a plain, open format. No encryption, no protection. Just user names, passwords,
codes and tokens in plain text.

Why is this bad? Well, for a single developer with a single laptop this doesn't
sound like a problem. Although, I don't like the idea of losing a laptop somewhere
in an airport with all credentials open and ready to be used. You may
argue that there are disc protection tools, like FileVault for MacOS or
BestCrypt for Windows. Yes, maybe.

But let's see what happens when we have a team of developers, working together
and sharing those deployment scripts **and** files with credentials. Once you
give access to your deployment scripts to a new member of the team, you have
to share all that sensitive data. There is just no way around it. In order
to use the scripts he/she has to be able to open files with credentials.

This is a problem, if you care about the security of your data.

Rultor solves this problem by offering an on-the-fly GPG decryption of your
sensitive data, right before they are used by your deployment scripts. In
the `.rultor.yml` configuration file you just say:

```text
decrypt:
  db.ini: "repo/db.ini.asc"
deploy:
  script:
    ftp put db.ini production
```

Then, you encrypt your `db.ini` using a Rultor GPG key, and fearlessly
commit `db.ini.asc` to the repository. Nobody will be able to open and read
that file, except the Rultor server itself, right before running the
deployment script.

Thus, the third benefit of Rultor versus a standalone deployment script
is proper security of sensitive data.
