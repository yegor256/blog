---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Small Repo, High Quality"
date: 2025-11-16
place: Moscow, Russia
tags: oss
description: |
  By breaking your software into small open-source packages,
  you make the entire product easier
  to maintain—and significantly higher in quality.
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

I don't like [monolithic repositories]({% pst 2018/sep/2018-09-05-monolithic-repositories %}).
They keep multiple projects together, often written in different languages, by different teams.
Unfortunately, [Google], [Facebook], and [Yandex] favor them.
Primarily, according to them, [monorepos] reduce integration [overhead].
They do, but at the cost of quality.
In smaller repositories we can develop better code.

<!--more-->

{% jb_picture_body %}

When a repository is smaller you can achieve higher quality, for a number of reasons:

* **You can be stricter on style.**
It's easier to keep a thousand lines consistently formatted than a million.
With a thousand lines, you can configure [ESLint] to its maximum, enabling as many rules as you can find.
Stricter [control]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}) over code stylistics leads to cleaner code.

* **You can write deeper tests.**
Integration (or [deep]({% pst 2023/aug/2023-08-22-fast-vs-deep-testing %})) tests are inevitably slow.
In a smaller repository, a good integration test coverage doesn't mean a slow build.
In a larger repository---it does.
A slow build is something a team tries to avoid, thus jeopardizing the coverage.

* **You can review more pedantically.**
In a larger repository it may be harder to remember all the aspects of design.
A pull request that affects different seemingly unrelated code parts
  may be a challenge to [review]({% pst 2015/feb/2015-02-09-serious-code-reviewer %}).
Even if you are the [architect]({% pst 2014/oct/2014-10-12-who-is-software-architect %}).

* **You can write a README.**
Maybe you have noticed already: large open source projects have short and sketchy [README]({% pst 2019/apr/2019-04-23-elegant-readme %}) files.
They can't make them much longer without them becoming as large as a book.
All they can do is redirect the reader to the documentation website.
The inability to explain the entire scope in a single file leads to scope creep.
Contributors struggle to understand the borders of the project.
This leads, among other bad things, to code duplication.

* **You can release frequently.**
In a larger repository, frequent reintegration may be expensive, in both time and money.
In a small repo, a [build]({% pst 2025/apr/2025-04-12-four-builds %}) of a few seconds is not a dream of programmers, it's their reality.
Not only CI is cheap, but also CD.
After every small change you can publish a new release, with its own [version].
In a monorepo, we tend to wait until a portion of changes accumulate.

* **You can use AI agents effectively.**
It is no secret that modern LLMs have limited [context windows].
A million lines of code can't fit into even the largest of them.
Even ten thousand lines, let alone a million, is more than an LLM can digest.
By keeping a repository small we do a big favor to our little friends: AI agents.

* **You can on-board faster.**
Larger codebases are usually older and more [chaotic]({% pst 2018/sep/2018-09-12-clear-code %}), full of legacy code.
It takes longer to start making meaningful contribution to such a repository.
Monorepos attract
  [long-term]({% pst 2015/dec/2015-12-29-turnover-is-good-for-maintainability %})
  [office-based]({% pst 2017/may/2017-05-02-remote-slaves %})
  contributors
  who care about job security more than about code quality.

* **You can expect responsibility.**
In larger codebases, the very idea of code ownership is hard to maintain.
Programmers can hardly feel responsible for the code written and modified by others.
Smaller repositories, on the other hand, emotionally attach people to code.

* **You can go open source.**
No matter how much your boss [loves]({% pst 2020/may/2020-05-05-open-source-arms-race %})
  open source, you can't put your entire enterprise monorepo on GitHub.
However, if you extract a small part of it, you can.
The code that is open, visible and criticized by many people,
  is [allegedly]({% pst 2015/dec/2015-12-22-why-dont-you-contribute-to-open-source %}) of a higher quality.

In summary, you should look for an opportunity to extract a piece of code as a standalone package.
Then, insist on making it [open source]({% pst 2017/may/2017-05-30-why-contribute-to-open-source %}).
Then, promote it in the community.
Then, quit your office job and become a freelancer.

[Google]: https://dl.acm.org/doi/pdf/10.1145/2854146
[Facebook]: https://engineering.fb.com/2025/10/16/developer-tools/branching-in-a-sapling-monorepo/
[Yandex]: https://shiftmag.dev/mono-repo-infrastructure-yandex-1011/
[monorepos]: https://monorepo.tools/
[ESLint]: https://eslint.org/
[version]: https://semver.org/
[context windows]: https://docs.claude.com/en/docs/build-with-claude/context-windows
[overhead]: https://www.sonarsource.com/resources/library/monorepo/
