---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Seven Deadly Sins of a Software Project"
date: 2015-06-08
tags: management agile
categories: best
description: |
  Here is a list of criteria I apply to software projects
  submitted for the Software Quality Award; they can
  be applied equally to any other projects.
keywords:
  - software project
  - software project deliverables
  - software project plan
  - software project management
  - software project lifecycle
  - software maintainability
translated:
  - Russian: https://habrahabr.ru/post/260241/
  - Japanese: http://tbd.kaitoy.xyz/2016/06/25/seven-deadly-sins-of-a-software-project/
social:
  - reddit: https://www.reddit.com/r/programming/comments/396q18/seven_deadly_sins_of_a_software_project/
---

_Maintainability_ is the [most valuable virtue]({% pst 2014/oct/2014-10-26-hacker-vs-programmer-mentality %})
of modern software development.
[Maintainability](https://en.wikipedia.org/wiki/Maintainability)
can basically be measured as the working time required for
a new developer to learn the software before he or she can start making
serious changes in it. The longer the time, the lower the maintainability.
In some projects, this time requirement is close to infinity, which means it is
literally unmaintainable. I believe there are seven fundamental and fatal
**sins** that make our software unmaintainable. Here they are.

<!--more-->

## Anti-Patterns

{% badge /images/2015/06/software-project-sins-1.gif 250 %}

Unfortunately, the programming languages we're using are too _flexible_.
They allow too much and forbid too little. For example, Java has nothing
against you placing the entire application in one single "class"
with a few thousand methods. Technically, the application will compile
and run. But it's a well-known anti-pattern called a
[God object](https://en.wikipedia.org/wiki/God_object).

Thus, an [anti-pattern](https://en.wikipedia.org/wiki/Anti-pattern)
is a technically acceptable way of designing things that is
commonly agreed to be wrong. There are many anti-patterns in each
language. Their presence in your product is similar to a tumor in
a living organism. Once it starts to grow, it's very difficult to stop.
Eventually, the entire body dies. Eventually, the entire software becomes
unmaintainable and has to be re-written.

Once you let a few anti-patterns in, you will eventually get more of them,
and the "tumor" will only grow.

{% youtube ZtWmlKi3ivc %}

This is especially true for object-oriented languages (Java, C++, Ruby, and Python),
mostly because they inherit so much from procedural languages (C, Fortran, and COBOL).
And because [OOP]({% pst 2016/aug/2016-08-15-what-is-wrong-object-oriented-programming %})
developers tend to think in a procedural and imperative way.
Unfortunately.

By the way, in addition to an existing [list of well-known anti-patterns](https://en.wikipedia.org/wiki/Anti-pattern),
I also consider [these few things]({% pst 2014/sep/2014-09-10-anti-patterns-in-oop %})
as rather bad coding approaches.

My only practical suggestion here is to read and learn. Maybe
[these books]({% pst 2015/apr/2015-04-22-favorite-software-books %}) will help you
or my book "[Elegant Objects](/elegant-objects.html)."
Always try to be skeptical about the quality of your software, and don't relax
when it "just works." Like with cancer, the earlier you diagnose it, greater is
the chance to survive.

## Untraceable Changes

{% badge /images/2015/06/software-project-sins-2.gif 250 %}

When I look at the commit history, I should be able to tell
for every single change _what_ was changed, _who_ made a change, and
_why_ the change was made. Moreover, the time required to get those three
answers must be measured in seconds. In most projects, this is not the
case. Here are a few practical recommendations:

**Always Use Tickets**.
No matter how small the project or its team is, even if it's just yourself,
create tickets (GitHub issues) for every problem you're solving. Explain
the problem briefly in the ticket and document your thinking there. Use
the ticket as temporary storage for all information related to the problem.
Post everything that could make any sense in the future, when
someone else will try to understand what those "few strange commits" were about.

**Reference Tickets in Commits**.
Needless to say, every commit must have a message. Commits without
messages are a very dirty practice; I won't even discuss why. But just a message
is not enough. Every message must start with the number of the ticket you're working
with. GitHub (I'm sure you are using it) will automatically link commits
and tickets, increasing _traceability_ of changes.

**Don't Delete Anything**.
Git allows us to do a "forced" push, which overwrites the entire branch that
previously existed on the server. This is just one example of how
you can destroy the history of development. Many times I've also seen
people delete their comments in GitHub discussions to make tickets look
more "clean." That's just wrong. Never delete anything; let your history
stay with you, no matter how bad (or messy) it may look to you now.

## Ad Hoc Releases

{% badge /images/2015/06/software-project-sins-3.gif 250 %}

Every piece of software must be packaged before it can
be delivered to the end user. If it's a Java library, it has to be
packaged as a `.jar` file and released to some repository; if it's a web
app, it has to be deployed to some platform, etc. No matter how small
or big the product is, there is always a standard procedure that
tests, packages, and deploys.

An ideal solution would be to automate this procedure so
it is possible to execute it from a command line with a single command:

```bash
$ ./release.sh
...
DONE (took 98.7s)
```

Most projects are far from that. Their release process always
involves some magic, where the person responsible for it
(also known as a DevOp) has to click some buttons here and there, login
somewhere, check some metrics, etc. Such an _ad hoc_ release process
is still a very typical sin of the entire software engineering industry.

I can give only one practical piece of advice here: Automate it. I use
[rultor.com]({% pst 2014/sep/2014-09-11-deployment-script-vs-rultor %}) for that,
but you can use whatever tools you like. What is important is that the entire
procedure is fully automated and can be executed from the command line.

## Volunteer Static Analysis

{% badge /images/2015/06/software-project-sins-4.gif 250 %}

[Static analysis](https://en.wikipedia.org/wiki/Static_program_analysis)
is what makes our code _look_ better. And by making it
look better, we are inevitably making it _work_ better. But this happens
only when the entire team is forced (!) to follow the rules dictated by the
static analyzer(s). I've written about this in
[Strict Control of Java Code Quality]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}).
I use [qulice.com](https://www.qulice.com) in Java projects
and [rubocop](https://github.com/bbatsov/rubocop) in Ruby, but there
are many similar tools for nearly every language.

You can use any of them, but make it mandatory! In most projects
where static analysis is used, developers just build nicely-looking
reports and continue to write code the way they did before. Such a "volunteer"
approach is not doing any favors for the project. Moreover, it
creates an illusion of quality.

{% youtube hkXLOxZ6Fs4 %}

What I'm saying is that static analysis must be a mandatory step in
your deployment pipeline. The build can't pass if any static analysis
rule is violated.

## Unknown Test Coverage

{% badge /images/2015/06/software-project-sins-5.gif 250 %}

Simply put, [test coverage](https://en.wikipedia.org/wiki/Code_coverage)
is the degree to which the software has been
[tested]({% pst 2015/jul/2015-07-16-fools-dont-write-unit-tests %})
by unit or integration tests. The
higher the coverage, the greater "amount" of code was executed while
tests were running. Obviously, higher coverage is a good thing.

However, many project developers simply don't know their coverage. They just don't measure
this metric. They may have some tests, but nobody knows how deeply they
penetrate the software and what parts of it are not tested at all.
This situation is much worse than low test coverage that is measured and
reported to everyone.

High coverage is not a guarantee of high quality. That's obvious. But unknown
coverage is a clear indicator of maintainability problems. When a new
developer enters the project, he or she should be able to make some
changes and see how coverage is affected by them. Ideally, test coverage
should be checked the same way as static analysis, and the build should
fail if it comes out lower than a certain pre-defined threshold
(usually somewhere around 80 percent).

## Nonstop Development

{% badge /images/2015/06/software-project-sins-6.gif 250 %}

What I mean by nonstop is without milestones and releases. No matter what kind of
software you're writing, you must release and [versionalize](http://semver.org/) it frequently.
A project without a clear release history is an unmaintainable mess.

This is mostly because maintainability is all about me being able to understand you
by reading your code.

When I look into the source code and its commit and release history, I have
to be able to tell what the intention of its author(s) was, what the project
was doing a year ago, where it is going now, what its roadmap is, etc. All
this information must be in the source code and, more importantly,
in Git history.

[Git tags](https://git-scm.com/book/en/v2/Git-Basics-Tagging) and
GitHub [release notes](https://github.com/blog/1547-release-your-software)
are two powerful instruments that provide
me such information. Use them to their full extent. Also, don't forget that
each binary version of the product must be available for immediate download.
I have to be able to download version 0.1.3 and test it right now, even
if the project is working on 3.4 at the moment.

## Undocumented Interfaces

{% badge /images/2015/06/software-project-sins-7.gif 250 %}

Every piece of software has interfaces through which it is supposed to be used.
If it's a Ruby gem, there are classes and methods that I'm going to
use as an end user of it. If it's a web app, there are web pages
that an end user will see and control in order to use the app. Every software
project has interfaces, and they must be carefully documented.

Like everything above, this is also about maintainability. As a new programmer
on a project, I will start to learn about it from its interfaces. I should be able
to understand what it does and try to use it myself.

I'm talking here about documentation for users, not for developers. In
general, I'm against documentation inside the software. Here I totally agree with
the [Agile Manifesto](http://agilemanifesto.org/)---working software is
much more important than comprehensive documentation. But that's not referring to
"external" documentation, which is supposed to be read by users, not developers.

So end-user interaction with the software must be clearly documented.

If your software is a library, then its end users are software developers
who are going to use it---not contribute to it but simply use it as a
"black box."

<hr/>

These are the criteria being used to evaluate the open source projects
entered in our
[award]({% pst 2015/apr/2015-04-16-award %}) competition.
