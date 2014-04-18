---
layout: post
title: "Mocking Is Evil"
date: 2014-04-18
tags: mocking design
description:
  Mocking is an evil practice, which you should
  use as a last resort
keywords:
  - mocking is evil
  - best practices of mocking
  - java mocking
  - java mock framework
  - why mocking is evil
---

There were many discussions on this subject, however
I have say my few words. First, let's clarify the definitions.
I understand "mocking" as a mechanism of breaking dependencies
between classes for the time of testing. It enables creation
of fake objects, also known as "mocks", which are used as
dependencies of the component under test.

Let's say, we have a class Picture that can generate
an GIF
