---
layout: post
title: "PDD in Action"
date: 2017-04-05
place: Moscow, Russia
tags: management pdd
description: |
  0pdd.com is a free hosted service that helps
  you automate puzzle-driven development in your
  GitHub projects.
keywords:
  - puzzle-driven development
  - PDD puzzle-driven development
  - 0pdd
  - GitHub PDD
  - zerocracy pdd
image: /images/2017/04/0pdd-screenshot.jpg
---

{% badge https://avatars2.githubusercontent.com/u/24456188 64 https://www.0pdd.com %}

[Puzzle Driven development]({% pst 2010/mar/2010-03-04-pdd %})
(PDD) is a methodology we've been practicing on our teams
for more than seven years. Using PDD, we delegate the responsibility of
task decomposition to its performers, eliminating
the role of a project manager. We've been using our proprietary software
for that. A month ago, we made it public, open source, and free.
It is available as [0pdd](https://www.0pdd.com)---a GitHub-based chat bot.

<!--more-->

{% jb_picture_body %}

Here is how you configure it, in two steps. First, you
[grant](https://help.github.com/articles/inviting-collaborators-to-a-personal-repository/)
access to [@0pdd](https://github.com/0pdd) in GitHub
(if your repository is private).

Second, you add a [webhook](https://help.github.com/articles/about-webhooks/)
to your GitHub repository: `https://www.0pdd.com/hook/github` (with just `push` event
and any content type). I would actually recommend to send GitHub
notifications through [ReHTTP]({% pst 2017/sep/2017-09-05-rehttp-http-repeater %})
and use this URL for the webhook:
`http://p.rehttp.net/https://www.0pdd.com/hook/github`.

Now, your repository is being watched by [0pdd](https://www.0pdd.com). Every
time you `git push` something new, it does a `git pull` and retrieves your changes
from GitHub. Then it runs [pdd](https://github.com/yegor256/pdd), a command line tool
that scans the entire code base (only the [`master`](https://help.github.com/articles/setting-the-default-branch/)
branch) and finds all occurrences of `@todo`
markers.

For all newly found markers, [0pdd](https://www.0pdd.com) will submit new
issues to the GitHub issue-tracking section of your repository.

Also, when you remove markers from your code base,
[0pdd](https://www.0pdd.com) will immediately close issues it created.

{% youtube nsYGC2aUwfQ %}

Now, when an issue is assigned to a programmer, we allow him or her
to [cut corners]({% pst 2015/jan/2015-01-15-how-to-cut-corners %})
and return incomplete code back to the `master`. If and when the code is
not complete, we ask the programmer to leave `@todo` markers in the code, called
"puzzles." Later, these puzzles will be assigned to other programmers,
and so on. Eventually, the problem will be fixed when _most_ puzzles are
resolved.

[0pdd](https://www.0pdd.com) helps you automate this process and provides
a summary report of the current situation with all puzzles in the entire
code base. You can even add a nice badge to your GitHub repo:

[![PDD status](https://www.0pdd.com/svg?name=yegor256/0pdd)](https://www.0pdd.com/p?name=yegor256/0pdd)

If you click it, you will see the full report of all puzzles
currently present and previously seen.

This mechanism helps us in many projects. You can use it for free. It's
an open source Ruby product; feel free to [contribute](https://github.com/yegor256/0pdd).
