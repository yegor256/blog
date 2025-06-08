---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Write Unit Tests, Don't Waste Our Money!"
date: 2025-06-08
place: Moscow, Russia
tags: etiquette testing
description: |
  If you write code without tests, you're probably wasting
  your employer's money---because it'll break again right where you
  "fixed" it.
keywords:
  - unit testing
  - TDD github
  - test in pull requests
  - TDD in pull request
  - test driven development
image: /images/2025/06/la-femme-nikita.jpg
jb_picture:
  caption: La Femme Nikita (1990) by Luc Besson
---

Automated tests help us write code [faster](/angry-tests.html).
Unit tests immediately tell us when we break something.
Integration tests calm us down, reducing the fear of shipping a failure to a user.
But who are "us"?
Programmers.
What about our employers?
How do automated tests help them?
Automated tests protect their investments.

<!--more-->

{% jb_picture_body %}

Every change we make to a codebase costs our employer money.
Whether they pay us monthly or per line of code, the bottom line is the same:
  it's the code that reaches the repository and is eventually released to the end user.

That's what the business is investing in---new features or bug fixes.
The code that's written and shipped is what matters to them.

Even when they say they're investing in people, what they really want is the code.
People are merely an intermediate by-product.
The ultimate asset is the codebase.

They want to **protect** that **asset**.

A loss of investment could be a hundred lines written today not working tomorrow.
Think about it this way: we expect a car to work after paying the body shop to fix it.
We don't mind paying again if something else breaks---but not if it's the exact same part they fixed yesterday.
We expect the repaired part to function properly while driving.
We want a warranty on what's already been fixed.

Similarly, our employers expect our code to work once we've committed it and collected our paycheck.
They want a warranty that the code won't break again once it's been fixed.
Automated tests can offer that **warranty**.

Continuing the metaphor: "driving" a codebase means actively modifying its parts---refactoring or extending.
The more aggressively we drive it, the higher the risk of breaking something.
The parts of the code not covered by tests are the first to break.

Test coverage guarantees that what worked before---and was already paid for---continues to work even under the stress of refactoring.

So, any contribution to a codebase without a **supporting** test is a waste of the employer's money.
