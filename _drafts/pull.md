---
layout: post
title: "A Few Valid Reasons to Reject a Bug Fix"
date: 2015-06-12
tags: agile mgmt
description:
  A bug fix is supposed to improve the quality of
  the software, but very often the effect of it
  is very negative; here is why and how to avoid it.
keywords:
  - bug fix
  - bug code review
  - review pull request
  - pull request rules
  - pull request code review
---

A bug is when something doesn't work as expected. A _bug
fix_ is basically a patch (a pull request) to the existing code base that
is supposed to solve the problem and make sure that "something"
works as expected. Very often, such a patch fixes one thing
and breaks many others. I believe that sometimes it's necessary to **reject**
a bug fix and ask its author to re-do the patch, in order to
protect the project against bigger problems. There are few
valid reasons for such a rejection, according to my experience.

<!--more-->

## It Degrades Code Coverage

This is a very common situation &mdash; after the changes made in one place,
unit tests fail in some other place. The bug is fixed, but some possibly
unrelated unit tests start to report failure. Under pressure or simply because
we're lazy, we don't fix them, but simply remove the tests or mark them
as temporarily "skipped". The problem is solved, the build is clean, let's
merge the patch and call it a day, right? Wrong!

Well, even though I'm in favor of [cutting corners]({% pst 2015/jan/2015-01-15-how-to-cut-corners %})
as much as possible, this is the corner I don't recommend to cut.

The unit tests are there exactly in order to prevent us from breaking the
product, exactly under pressure.

Obviously, there are situations when the unit tests are wrong too and
we have to delete them. In that case, don't forget to create new ones.

{% badge /images/2015/04/book-legacy.jpg 96 http://www.amazon.com/gp/product/0131177052/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0131177052&linkCode=as2&tag=yegor256com-20&linkId=D2WNVUW64RHDRGSC %}

Also, there are situations when the bug must be fixed in a few minutes,
to put the system back online and fixing all unit test will take an hour.
Such a situation is a strong indicator of a terrible situation with test
coverage in the product. No doubts here, we have to make a fix and
ask our tests to shut up for some time. But, in this case, make sure that
the next task your team is working on, after the bug fix is released, is
fixing that disabled unit tests. I would recommend
[Working Effectively With Legacy Code](http://www.amazon.com/gp/product/0131177052/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0131177052&linkCode=as2&tag=yegor256com-20&linkId=D2WNVUW64RHDRGSC)
by Michael Feathers, exactly about this very subject.

## It Doesn't Reproduce the Issue

Sometimes the entire system may be down simply because of a small
typo in one line of code. An obvious bug fix is to remove the typo, but
it's a not what a project is expecting from us, if we care about its
quality. The problem is not the typo, but the absence of unit tests,
which would catch the typo at the deployment phase.

The real problem is the lack of test code coverage in this particular
place of the code. By removing the typo we're not helping the project
anyhow. Moreover, we're doing it a bad favor &mdash; we're _concealing_
the real problem.

Thus, no matter how small and cosmetic the issue is, its bug fix
must contain an extra test that reproduces it first. Without such
a test, a bug fix is a waste of project's money.

Moreover, without a unit test reproducing the issue, there is no
guarantee that our bug fix doesn't introduce more bugs. I would even say that
the more bug fixes we have, the higher the
[entropy](http://en.wikipedia.org/wiki/Entropy_%28information_theory%29).
And the only way to lower this uncertainty is by covering the
code with unit tests. Without a test, a bug fix brings more disorder
to the code base.

## It Is Too Big

Bug fixes are _not features_, they must be small and focused. It's a very
typical mistake where programmers get carried away while fixing a
bug and introduce some refactoring together with a fix. A patch gets
rather big and difficult to understand. I'm not against refactoring, it's
a very important and positive thing for a project, but do it separately
_after_ the bug is fixed and merged.

No refactoring, while fixing a bug!

Create a new unit test, reproduce the bug, commit it. Fix the bug
in the existing code base, no matter how ugly it is. Create new
bugs, asking the team to improve the situation with the ugly code base.
If interested, assign that bugs to yourself. Or maybe somebody else
will be interested to fix them and refactor the code. But all that
will happen later, in other pull requests, with new code reviews
and new merges.

It's not about being lazy and not willing to fix what looks bad. It's about
a discipline, which is [much more important]({% pst 2015/jan/2015-01-15-how-to-cut-corners %})
than good intentions.

## It Solves More Than One Issue

Always fix one issue at a time &mdash; simple as that. No exceptions. When
a bug fix patch contains code changes that fix multiple issues, it is
very difficult to understand which issue is tested, which one is reproduced
and how they relate to each other. Combining several bug fixes into a single
pull request is a very bad practice.

No matter some simple is the fix, keep it separate from others.
Review, test and merge it individually. This will also increase the
traceability of changes. It will always be easy to understand who made
that fix, who reviewed the code and when was it merged (and deployed).
