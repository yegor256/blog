---
layout: post
title: "Don't Commit to a Broken Master Branch"
date: 2025-04-19
place: Sochi, Russia
tags: github
description: |
  If the build is broken, don't send any pull requests until it's fixed.
  You're welcome to fix it yourself---just don't mix build-fixing changes with
  anything else.
keywords:
  - broken build
  - CI broken
  - fix CI jobs
  - CI discipline
  - CI pipeline
image: /images/2025/04/trainspotting.jpg
jb_picture:
  caption: ...
---

What do you think is the most typical reason for delays in pull request reviews?
A [study][sadowski2018modern] at Google confirms that it's the size---the more changes, the slower the review.
Another [study][ortu2020you] shows that it's the emotional tone---anger and dominance expressed in comments are linked to a lower likelihood of a pull request being merged.
A more recent [study][lenarduzzi2021does] finds that it's the author's reputation: we merge PRs faster if we know the author.
All of the above is true.
In our projects, though, what often slows down PR reviews is the message: **"CI failures are not related to my changes!"**

<!--more-->

{% jb_picture_body %}

Here's how it happens:
You fork a repo.
You make changes to fix a bug or introduce a new feature.
You commit them and push.
You submit a pull request.
You realize that some GitHub CI jobs fail.
You read the logs.
You don't see any relevance between the error messages and your edits.
You post a comment: "CI failures are not related to my changes!"
You expect us to merge your pull request.

Why shouldn't we?

We don’t merge them.
We ask you to step back---to the point before you started making changes.
Don't make them yet.
Instead, check the build status of the repository.
Pay attention to all CI jobs, not just the one running Maven.
They all must be green.
Only when all jobs are green should you start editing the code.
If any job is red, report a bug and wait until the team gets everything passing.

Why?
Because we try to reduce the effort required to fix the build.
The more changes we pile onto a broken build, the higher the cost of cleaning it up.
When the build is broken, we accept no new changes---except those that fix the build.

What if the team takes too long to fix it?
What if the build never becomes green?
Still---you wait.
You don’t submit a pull request to a repository with a broken build.

<hr/>

You may fix the build yourself.
If you do, submit it in a **separate** pull request.
Don't mix build-fixing changes with any other edits.


[sadowski2018modern]: https://doi.org/10.1145/3183519.3183525
[ortu2020you]: https://doi.org/10.1109/ACCESS.2020.3002663
[lenarduzzi2021does]: https://doi.org/10.1016/j.jss.2020.110806
