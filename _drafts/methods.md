---
layout: post
title: "Method Names for Builders and Manipulators"
date: 2015-10-08
tags: oop java
place: Palo Alto, CA
description: |
  Giving good names to methods in object-oriented programming
  is a tough job, which can be done right if you follow this
  simple principle.
keywords:
  - good name for a method
  - java method name
  - method name in oop
  - method naming best practices
  - method naming
---

Here is a simple principle of giving names to methods in OOP,
which I'm trying follow in my code:
it's a **verb** if it **manipulates**, it's a **noun** if it **builds**.
That's it. Nothing in between. Methods like
`saveFile()` or `getTitle()` don't fit and must be renamed and refactored.
Moreover, methods that "manipulate" must always return `void`,
for example `print()` or `save()`.

<!--more-->

The idea behind this principle is rather philosophical.
