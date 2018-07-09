---
layout: post
title: "Bad Programmers Don't Understand Encapsulation and Procedural Programming and ... Monolithic Repos"
date: 2018-07-20
place: Moscow, Russia
tags: devops
description: |
  ...
keywords:
  - mono stack repo
  - monolithic repository
  - mono repo
  - monorepo
  - git monorepo
image: /images/2018/07/
jb_picture:
  caption:
---

We all keep our code in <del>Git</del>
[version control](https://en.wikipedia.org/wiki/Version_control) repositories.
The question is whether we should create a new repository for each
new module or try to keep as much as possible in a single so called "monothilic" repo.
Market makers, like [Facebook](https://code.fb.com/core-data/scaling-mercurial-at-facebook/)
and [Google](https://www.infoq.com/presentations/Development-at-Google), advocate the second approach.
I believe, they are <del>stupid</del> wrong. Here is why.

The problem is very

Monolithic repositories

fine-grained modularity

<!--more-->

{% jb_picture_body %}

Let's start with an analogy. Look at this code:

{% highlight java %}
for (String name : names) {
}
{% endhighlight %}


Encapsulation.

Faster deployment.

Faster builds/CI.

Metrics accuracy.

Homogeneous tasks.

Less environment dependencies. More intensive testing, since devs are coming from different envs.

Single coding standard.

Shorter names.

Microservices.

Problems:

Dependencies.

Search between repos.

