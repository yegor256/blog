---
layout: post
title: Code Reviews
date: 2014-04-20
tags: xdsd
description:
  The article explains XDSD requirements to code reviews
  done by one programmer for the code written by another
  programmer
keywords:
  - code review
  - quality review
  - peer review of source code
  - code review done right
  - how to do code review
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
