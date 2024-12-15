---
layout: post
title: "An Advice for Open Source First Time Contributors"
date: 2024-12-15
place: Moscow, Russia
tags: oss
description: |
  Making first steps in open source is hard. Submitting
  pull requests to big and popular repositories is very hard.
  These recommendations may help you simplify this task.
keywords:
  - open source advice
  - pull request merge
  - success in open source
  - github success
  - how to contribute to open source
image: /images/2024/12/...
jb_picture:
  caption:
---

My [first attempt][jersey] to contribute to an open source repository was a
miserable failure. I picked a Java repository I was already using
([Glassfish Jersey][jersey-wiki]), created a unit test for an existing class, submitted a
patch (there were no pull requests at that time), and... it was merged. I got
excited and submitted another unit test in a new patch. No surprise, the
repository owners asked me to stop fooling around: apparently, they didn't need
unit tests just for the sake of it. I quickly lost interest in making changes
to anyone else's code bases and started working on my own stuff instead.

Don't repeat my mistake! Becoming a contributor to an existing code base is a
much faster path into the open source world and is far more rewarding. Here are
some things to keep in mind to make your journey to success even
faster—especially if you are just a beginner making your first pull requests.

<!--more-->

{% jb_picture_body %}

**Study Existing Files**. Repository owners are usually proud of their code, no
  matter how ugly it might look. Don't try to impress them with your unique
  formatting or naming style; this will only annoy them. Instead, study a few
  files they wrote and try to emulate their style as closely as possible. It's
  safer. Once you've merged a few dozen pull requests, you can become more
  creative. But not now.

**Don't Ask, Submit Issues**. You are not the first contributor, nor will you be
  the last. Many people before you asked countless questions but wrote zero
  lines of code. Repository owners, especially in large projects, are not
  enthusiastic about teaching you or explaining how their code works. [Don't
  bother them]({% pst 2024/apr/2024-04-01-ping-me-please %})
  with questions in Telegram; this will only demonstrate a lack of
  discipline. Instead, formulate every question as a new issue, pointing out,
  for example: 1) lack of documentation, 2) inconsistent design, 3) high
  complexity, or anything else preventing you from quickly understanding the
  code and contributing. Such an issue is a valuable contribution in itself.

**Make Small Changes**. There is nothing more frustrating for a maintainer than
  a large pull request from a stranger. The reasons are simple: first,
  strangers usually write bad code; second, they often become disappointed when
  told their code is bad. Thus, investing time in reviewing a large pull
  request from a new contributor is risky. At the same time, it's sad to see
  potentially good code end up in the trash. Do everyone a favor and start
  small---less than 50 hits-of-code per pull request. This approach will lead to
  higher-quality reviews and faster merges.

**Pick Easiest Problems**. Not sure what to contribute? Scan their backlog of
  tickets and find the easiest ones to fix. Don't try to impress anyone with
  your first pull request by showing off how smart you are. Instead, impress
  them by quickly finding a low-hanging fruit, fixing it, and getting it
  merged. In large, high-quality projects, what really matters is your ability
  to get your code through the pipeline of checkers, linters, and reviewers.
  The simpler the problem you solve, the faster your solution will be
  accepted.

**Write Tests**. As simple as it sounds: every change you make should be
  motivated by a failing unit test that proves the code was broken before. If
  you, as a newcomer, modify code written by the owners, you must have a very
  good reason. When they review your contribution, their first question will
  be: “Why did you do this?” The strongest argument is a failing unit test. You
  might even consider submitting a pull request with only a failing test first
  (disabled), getting it merged, and then submitting another pull request that
  fixes the test.

**Look Like a Human**. Your pull request looks suspicious because you are a
  stranger. In the age of AI, some pull requests might be coming from bots, and
  this trend will only grow. You must prove you're a trustworthy human being:
  set a decent avatar, put your real name in your profile, fill in all the
  required fields, and so forth.

**Explain Your Changes**. When submitting a pull request, there is a text area
  for a description. If you leave it empty or write just a few words, it sounds
  like this: "_Hey guys, I wrote some code. Now it's your job to figure out what
  it does, why it matters, and how it works. I'm off to bed because I'm sick of
  your codebase. Cheers!_" Needless to say, this won't help your pull request
  get merged anytime soon.

**Aim for Quality**. Studies [show][czerwonka2015code]
  that most rejections of open source pull
  requests happen due to formatting and stylistic mistakes, not incorrect
  functionality. Keep this in mind. Pay attention to how you format your code,
  how you document your changes, and how many comments you add to every new
  method or class. This is what reviewers will look at first. It will form
  their initial impression of you.

**Be Polite and Persistent**. The people you submit code to [may be rude][raman2020stress]. Don't
  take it personally. They deal with hundreds of newcomers who write
  poor-quality code and assume it's beautiful. No matter how [aggressive][miller2022did] or
  resentful they sound, remain polite and professional. Don't walk away after
  the first [negative][ferreira2021shut] comment. Keep insisting that your pull request deserves a
  merge. Pay attention to what they say, not how they say it. In the end, you
  want to get your code through. You don't want to become their friend; you
  want your code to be merged.

<hr/>

You may also want to watch my course ["Open Source Best Practices"][osbp-github]
recently taught to BSc students of [Innopolis University][iu]:
[eight video lectures][osbp-youtube]. At the lectures,
most of the topics mentioned above are discussed in details.

[jersey]: https://github.com/eclipse-ee4j/jersey/blob/b2c7ba6d388cb9722f39073d7e82aa818fec49d5/core-common/src/test/java/org/glassfish/jersey/uri/internal/PathTemplateTest.java#L26
[osbp-github]: https://github.com/yegor256/osbp
[iu]: https://innopolis.university/
[osbp-youtube]: https://www.youtube.com/playlist?list=PLaIsQH4uc08zjutyoBOtoa6fnxzrCQK2Q
[jersey-wiki]: https://en.wikipedia.org/wiki/Eclipse_Jersey
[czerwonka2015code]: https://ieeexplore.ieee.org/document/7202946/
[raman2020stress]: https://dl.acm.org/doi/10.1145/3377816.3381732
[miller2022did]: https://dl.acm.org/doi/10.1145/3510003.3510111
[ferreira2021shut]: https://dl.acm.org/doi/10.1145/3479497
