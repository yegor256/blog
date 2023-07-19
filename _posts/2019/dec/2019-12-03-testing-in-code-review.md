---
layout: post
title: "Does Code Review Involve Testing?"
date: 2019-12-03
place: Moscow, Russia
tags: management
description: |
  What should code reviewers do when they suspect that
  errors exist but can't be spotted by
  visual inspection of the code?
keywords:
  - code review vs testing
  - testing in code review
  - code review paid
  - how to code review
  - code review best practices
image: /images/2019/12/why-women-kill.jpg
jb_picture:
  caption: Why Women Kill (2019) by Marc Cherry
---

When you review a pull/merge request from someone, do you check out
the branch and run the build? I usually don't, but
[some people do](https://exceptionnotfound.net/should-code-review-include-manual-testing-depends-2/).
Their obvious reason is: running a build, or even testing the product manually,
helps find more important errors. Just looking at the source code may not
reveal all visual defects recently introduced to the HTML/CSS, for example.
It's better to check out the branch, start Apache, open the site in Chrome,
and see what's broken. Then, make a screenshot, attach it to the pull request,
and return it back to the author. But I disagree with this, and here is why.

<!--more-->

{% jb_picture_body %}

The discussion is not new, check
[this](https://softwareengineering.stackexchange.com/questions/344618/does-code-review-typically-involve-uat-qa-testing)
and [this](https://softwareengineering.stackexchange.com/questions/95363/should-code-reviewers-test-as-part-of-the-review)
on SO. However, it seems that all the answers there miss the key point.

As we all know, there are two _conflicting roles_ in any software project:
constructors and destructors, also known as programmers and testers.
Programmers add new features and fix bugs. Their result is the amount of
functionality created: the more, the better. While testers are breaking
the product and reporting bugs, doing anything they can to prove that it's
not yet ready to be shipped to the customer. At some point of time the
team (or the management) decides that the fight is over and the product can be
delivered.

Thanks to this essential conflict _quality_ is achieved.

Programmers finish their part of the fight when the code passes the
_merge pipeline_: the changes are made at their laptops, unit tests pass
locally, static analysis doesn't complain, the build is clean,
and the branch is merged to the trunk. This is where programmers stop
and get their bonuses.

Testers finish their part of the fight when they manage to find a new defect
in the product deployed to the staging or production environment: the
bug is found, reported, and accepted by the project. This is where
testers stop and get their bonuses.

This is obvious. If it's not, you may want to read
[_The Art of Software Testing_]({% pst 2014/aug/2014-08-22-art-of-software-testing %}) by Glenford Myers
or
[_Code Ahead_](/code-ahead.html) by Yegor Bugayenko. You may also want
to watch [this video](https://www.youtube.com/watch?v=jZitXMQaXvE).

Now, where is the place for a code reviewer in this conflict?

{% quote The objective of a merge pipeline is to protect the code repository from programmers. %}

I believe code review is part of the merge pipeline, together with unit
tests, static analyzers, linters, coverage control tools, mutation
testers, and everything else the project may want to put in there, in order
to make the life of programmers more difficult and the quality of
the source code higher. The objective of a merge pipeline is to protect
the code repository from programmers.

Code reviewers are no different than linters or static analyzers: They are
blocking the branches with bad code from getting into the trunk. When they
block, they give their reasons. Their job is done (similar to linters) when
they manage to find a problem in the branch and _explain_ it. A linter, when
it rejects a pull request, says exactly where the problem is, which line,
and how it can be fixed. This is what a good code reviewer must do:
find a problematic line, explain the problem, and suggest a solution.

This is what code reviewers must be paid for: completed reviews.

What is a completed review? Does "Everything is OK" sound like a completed
review? For a linter---yes; for a code reviewer---no. This one is much better:
"I found three problems, explained them, and they were either debated or fixed."
This is how the job description of a code reviewer may sound: Find the three
most critical problems, explain them, and make sure they are either fixed
or correctly argued.

How reviewers find these three problems---that's up to them. They may
do visual inspections of the code or run the build. However, they will still
be paid when they manage to find problems and make sure the author of the
code understands them and either fixes them or explains why they are not
fixable (or not problems). A visual inspection of the code is fast, while
checking the branch out and running the build is a much more time-consuming
operation. Moreover, a bug found after running the build locally is very
difficult to explain in the code review format. The discussion with the
author of the branch will take longer, which means more time to complete
the code review, which means lower effectiveness of the code reviewer.

{% quote An effective, responsible and greedy code reviewer doesn't explain to the author of the code what is wrong. %}

My point is that smart code reviewers don't do that, because it's not efficient.
Pay attention, not because they don't care, but because they know a better
way to contribute to the project. Let's face it, when the branch in front
of us is passing all automated checks like linters and unit tests, and yet still
has some bugs which we can reproduce only by executing the code, something
is not right with our automated tests. An effective, responsible and greedy
code reviewer will not explain to the author of the code what is wrong. Instead,
a new bug will be created, to blame the merge pipeline for being too weak.
And, of course, this new bug will be rewarded.

Thus, as a code reviewer, you can work with the branch locally, test it
and report your findings to the author. But this will be against your personal
interests and not beneficial for the project. Instead, you should complain
to the project about the low quality of the automated tests and put the
review on hold. When the complaint is resolved, the tests get stronger, you
get back to the review, which will be rejected by the merge pipeline, not by you.

In this case, everybody wins: the pipeline gets stronger, you earn an extra
bonus for the reported bug, and the review is rejected with a very specific
_reproducible_ reason.

P.S. The idea of this blog post was suggested by [Robert Sösemann](https://twitter.com/rsoesemann).

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">You review a pull request and suspect that it doesn&#39;t work, even though the CI status is green. What do you do?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1231476701806284800?ref_src=twsrc%5Etfw">February 23, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
