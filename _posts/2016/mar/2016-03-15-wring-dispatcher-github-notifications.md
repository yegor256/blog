---
layout: post
title: "Wring.io, a Dispatcher of GitHub Notifications"
date: 2016-03-15
place: Frankfurt, Germany
tags: github pets
description: |
  Too many notifications from GitHub? Try wring.io,
  a free hosted dispatcher of incoming notification traffic.
keywords:
  - github notifications
  - github spam
  - monitor github notifications
  - github gateway
  - read github notifications
---

{% badge http://www.wring.io/images/logo.svg 92 http://www.wring.io %}

I'm taking participation in over 50 repositories in GitHub. [We](https://www.zerocracy.com)
manage all of our projects there. GitHub is sending me hundreds of emails
every day. I'm serious. Hundreds! I tried to filter them somehow in Gmail,
but it's not really possible. Gmail filters are not powerful enough to
understand the difference between different types of notifications, and there
are many other problems.
I decided to create my own simple filtering machine. It's called
[wring.io](http://www.wring.io).

<!--more-->

The idea of wring.io is simple. First, I'm registering my sources
of notifications (called "pipes"), such as GitHub. Then I'm giving
[wring.io](http://www.wring.io) permission
to connect to GitHub on my behalf and fetch whatever is new there.

Then I'm configuring what should be filtered out, using text matching and/or
regular expressions. Right after a new pipe is created,
[wring.io](http://www.wring.io) starts pulling all my sources and updating my inbox.
All I need to do is delete new messages from my inbox when I'm done with them.
That's it.

Let's see an example. First I'm creating a new pipe:

{% figure /images/2016/03/wring-1.png 600 %}

It's a JSON object. Property `class` must be set to
`io.wring.agents.github.AgGithub`. This is the name of the Java
class that will be pulling my notifications from GitHub. The project is
open source, so you can see how the class actually works:
[`AgGithub`](https://github.com/yegor256/wring/blob/0.8.5/src/main/java/io/wring/agents/github/AgGithub.java).

Property `token` must be set to the [personal access token](https://github.com/settings/tokens/new)
that I should create first in GitHub. The server will connect to GitHub
on my behalf and under my credentials:

{% figure /images/2016/03/wring-2.png 600 %}

Property `ignore` must have an array of strings. Each item is a matching
pattern. I can use a text or a regular expression. By default, it's
a text. If exactly the same text is found in a notification, it
will be ignored. To use a regular expression, I need to wrap it in slashes (for example `/[a-z]+/`).
You may skip that property and just specify this JSON:

```json
{
  "class": "io.wring.agents.github.AgGithub",
  "token": "your-personal-access-token"
}
```

Then I go to my inbox and read what's there.

This solution literally saves me hours of time now. Feel free to use
it, it's absolutely free. Moreover, it's open source, so feel free to
contribute.
