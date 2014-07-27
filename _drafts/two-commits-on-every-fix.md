---
layout: post
title: "Two Commits for Every Fix"
date: 2014-04-12
tags: cloud
description:
  I think that every bug fix should be done in two commits, if you're doing
  test driven development; this article explains why
keywords:
  - tdd
  - git
  - bug fix
  - tdd bug fix
  - commits in TDD
---

In short, I think that every bug fix in a source code repository
should be done in two commits (Git, SVN, Mercurial, doesn't matter). The
first one should reproduce the problem, the second one should fix it.

Obviously, the build after the first commit will be broken. And it
will be fixed after the second commit.

Why do I recommend this? A few reasons.

Traceability is the first reason. During code review it will be
clear
