---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Repo Size Determines Quality"
date: 2025-11-16
place: Moscow, Russia
tags: oss
description: |
  ...
keywords:
  - repository size
  - quality of code
  - github quality
  - quality of software
  - high quality
image: /images/2025/11/...
jb_picture:
  caption: ..
---

I don't like monolithic repositories.
They keep multiple projects together, often written in different languages, by different teams.
It's a shame Google, Facebook, and Yandex do like them.
Monoliths reduce the integration overhead sacrifising the quality.
If you can extract a piece of a big repo into a small component, do it.
If you can make it open source, even better.

<!--more-->

{% jb_picture_body %}

When a repository is smaller you can achive higher quality.

* **You can be stricter on style.**
It's easier to keep a thousand lines consistently formatted than a million.
On a thousand, you can configure ESLint to its maximum, enabling as many rules as you can find.
Stricter control over code stylistics leads to cleaner code.
Cleaner code means less bugs.

* **You can write deeper tests.**
Integration (or deep) tests are inevitably slow.
In a smaller repository, a good integration test coverage doesn't mean a slow build.
In a larger repository---it does.
A slow build is something a team tries to avoid, thus jeopardizing the coverage.
Lower coverage means more bugs.

* **You can review more pedantic.**
In a larger repository it may be harder to remember all the aspects of design.
A pull request that affects different seemingly unrelated code parts may be a challenge to review.
Even if you are the architect.
Less pedantic reviews lead to more bugs.

* **You can write a better README.**

You can document better.
You can release frequently.
You can use AI agents effectively.
You can on-board new contributors faster.
You can demand reponsibility.
You can go open source.

All of the about is harder to achive in larger repositories.
