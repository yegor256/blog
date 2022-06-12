---
layout: post
title: "The Code and Its Tests in Different Pull Requests"
date: 2022-06-14
place: Moscow, Russia
tags: testing
description: |
  Always submit changes to the code in a separate pull request
  from the changes to its unit tests, in another pull request.
keywords:
  - test driven development
  - tests pull request
  - rules of pull requests
  - quality of testing
  - safety net
image: /images/2022/06/mafioso.jpg
jb_picture:
  caption: Mafioso (1962) by Alberto Lattuada
---

I suggested this idea a few weeks ago
[on Twitter](https://twitter.com/yegor256/status/1525758255225528320)
and got mostly negative reaction. That's why this blog post, to elaborate on this
subject in an attempt to convince you. Here is the rule I'm suggesting:
always submit changes to the code separately from the changes to
its unit tests. Simply put, in one pull request you modify the tests, maybe
marking some of them as "disabled." You merge this pull request and then
make the second one, modifying the code and most probably
removing the "disabled" markers from the tests. You don't touch the
body of the tests in the second pull request.

<!--more-->

{% jb_picture_body %}

It may look like a contradiction ot the principles of
[TDD]({% pst 2017/mar/2017-03-24-tdd-that-works %}).
However, to me this approach looks like an extreme application of TDD, not a violation
of it. First we merge the tests, which most probably would break the build, since
the functionaly that they test is not present yet. In order to avoid the broken
state of the build we disable the new tests that we added and the tests that we modified.
In [JUnit 5](https://junit.org/junit5/docs/current/user-guide/), for example, we do this with
[`@Disabled`](https://junit.org/junit5/docs/5.0.0-M2/api/org/junit/jupiter/api/Disabled.html) annotation.

Reviewers validate the changes you make, asking themselves these questions:
"Do we really need this new functionality?
Does it contradict with the existing functionality?
Does it make sense to test new functionality this particular way?"
They don't think about _how_ the functionality will be implemented, they
only care about the _requirements_ you impose in your tests against the
product. The reviewers act more or less as requirements engineers at this stage.
They validate the _intent_, not the _realization_ of it.

Then, in the second pull request, you modify the code without touching the tests.
Now, reviewers can rest assured that you don't change the requirements just to make
them more suitable for your implementation. In other words, they know that you don't _cheat_.
Since you don't touch the tests, it's a guarantee for reviewers that requirements
remain stable and you only modify the implementation. Speaking business language,
you don't change the _contract_ if/when you understand that you can't deliver
what was _promised_.

Moreover, when you modify the tests only, without touching the code, it's much
easier for the reviewers to understand whether your changes truly belong to the
problem you are supposed to solve. We programmers tend to make a typical mistake:
we make changes to the code, some tests fail, we fix the tests ... no matter whether
they are "our" tests or not. We simply make the tests pass no matter _why_ they fail.
Instead of _listening_ to them, we shut them up. Later, the reviewers may not understand
why some tests were modified. Especially, if a pull request is big. They most
probably will blindly trust you and merge the pull request.

That's why, separating tests from code is a solution. First, the tests get modified
and the reviewers will pay attention only to the scope of tests. They will easily
catch you if the changes are too broad and are not related to the problem you
are solving. Then, the code gets modified and reviewers don't need to worry about
tests at all. They don't pay attention to them, they only review the implementation.
They know that you can't break the tests, since the build pipeline
won't allow you to do this.

What do you think now? Does it make sense?

