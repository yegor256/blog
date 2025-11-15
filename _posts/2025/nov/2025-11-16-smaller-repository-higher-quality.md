---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Repository Size Matters"
date: 2025-11-16
place: Moscow, Russia
tags: oss
description: |
  If you split your software into a series of small
  open source packages, the quality of the entire product
  may be higher.
keywords:
  - repository size
  - quality of code
  - github quality
  - quality of software
  - high quality
image: /images/2025/11/morphine.jpg
jb_picture:
  caption: Морфий (2008) by Алексей Балабанов
---

I don't like monolithic repositories.
They keep multiple projects together, often written in different languages, by different teams.
It's a shame Google, Facebook, and Yandex do like them.
Primarily, according to them, monoliths reduce integration overhead.
They do, but at cost of quality.
In smaller repositories we can develop better code.

<!--more-->

{% jb_picture_body %}

When a repository is smaller you can achive higher quality, for a number of reasons:

* **You can be stricter on style.**
It's easier to keep a thousand lines consistently formatted than a million.
On a thousand, you can configure ESLint to its maximum, enabling as many rules as you can find.
Stricter control over code stylistics leads to cleaner code.

* **You can write deeper tests.**
Integration (or deep) tests are inevitably slow.
In a smaller repository, a good integration test coverage doesn't mean a slow build.
In a larger repository---it does.
A slow build is something a team tries to avoid, thus jeopardizing the coverage.

* **You can review more pedantic.**
In a larger repository it may be harder to remember all the aspects of design.
A pull request that affects different seemingly unrelated code parts may be a challenge to review.
Even if you are the architect.

* **You can write a README.**
Maybe you have noticed already: large open source projects have short and sketchy README files.
They simply can't make them larger or they become as large as a book.
All they can do is redirecting the reader to the documentation website.
The inability to explain the entire scope in a single file leads to scope creep.
Contributors struggle to understand the borders of the project.
This leads, among other bad things, to code duplication.

* **You can release frequently.**
In a larger repository, frequent reintegration may be expensive, both time and money wise.
In a small repo, a build of a few seconds is not a dream of programmers, it's their reality.
Not only CI is cheap, but also CD.
After every small change you can publish a new release, with its own version.
In a monolith, we tend to wait until a portion of changes accumulate.

* **You can use AI agents effectively.**
It is no secret that modern LLMs have limited context windows.
A million lines of code can't fit into even the largest of them.
A million aside, even ten thousand lines is something an LLM can't digest.
By keeping a repository small we do a big favor to our little friends: AI agents.

* **You can on-board faster.**
Larger codebases are usually older and more chaotic, full of legacy code.
It takes longer to start making meaninful contribution to such a repository.
To the contrary, in a smaller repo, you can engage programmers faster.
Monoliths attract long-term office-based contributors who care about job security more than about code quality.

* **You can expect responsibility.**
In larger codebases, the very idea of code ownership is hard to maintain.
Programmers may hardly feel responsible for the code written and modified by others.
Smaller repositories, on the other hand, emotionally attach people to code.

* **You can go open source.**
No matter how much your boss loves open source, you can't put your entire enterprise monolith on GitHub.
However, if you extract a small part of it, you can.
The code that is open, visible and criticized by many people, is alegedly of a higher quality.

In summary, you should look for an opportunity to extract a piece of code as a standalone package.
Then, insist on making it open source.
Then, promote it in the community.
Then, quit your office job and become a freelancer.
