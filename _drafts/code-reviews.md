---
layout: post
title: Code Reviews
date: 2014-04-20
author:
  name: Yegor Bugayenko
  avatar: http://www.gravatar.com/avatar/70942ffdd8084b5a51e17e3c0996d53c?s=300
categories: blog
disqus: true
tags:
  - reviews
  - process
  - quality
description:
  ...
keywords:
  - code review
  - pre-flight builds
  - static quality control
  - java static analysis
---

When a pull request is assigned to you for a code review, the rules are simple:
when it is closed, for any reason, you get 15 minutes plus one minute per each
comment posted in pull request by anyone.

Pay attention to the following:

 * unit test reproduces the problem being solved
 * [typical mistakes](https://github.com/tpc2/qulice/wiki/mistakes) are avoided
 * changes made don’t break existing design/architecture principles
 * size of the branch is less than 100 lines

Feel free to reject the changes if you don’t like them.
