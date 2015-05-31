---
layout: post
title: "Seven Deadly Sins of a Software Project"
date: 2015-06-03
tags: mgmt agile
description:
  Here is a list of criteria I apply to software projects
  submitted to the Sofware Quality Award; they can
  equally be applied to any other projects.
keywords:
  - software project
  - software project deliverables
  - software project plan
  - software project management
  - software project lifecycle
---

_Maintainability_ is the most valuable virtue of a modern software development.
Maintainability can basically be measured as a working time required for
a new developer to learn the software before he or she can start making
serious changes in it. The longer the time, the lower the maintainability.
In some projects, this time is close to infinity, which means that it is
literally unmaintainable.

<!--more-->

## Anti-Patterns

Unfortunately, the programming languages we're using are too _flexible_.
They allow too much and forbid too little. For example, Java has technically nothing
against you placing the entire application in one single "class"
with a few thousand methods. Technically, the application will compile
and run. But it's a well known anti-pattern known as
[God Object](https://en.wikipedia.org/wiki/God_object).

Thus, an [anti-pattern](https://en.wikipedia.org/wiki/Anti-pattern)
is a technically acceptable way of designing things, which is
commonly agreed to be wrong. There are many anti-patterns in each
language. Their presence in your product is similar to a tumor in
a living organizm. Once it starts to grow, it's very difficult to stop it.
Eventually, the entire body dies. Eventually, the entire software becomes
unmaintainable and has to be re-written.

Once you let a few anti-pattern in, you will get more of them eventually
and the "tumor" will only grow.
This is especially true for object-oriented languages (Java, C++, Ruby, Python),
mostly because they inherit so much from procedural languages (C, Fortran, COBOL).
Also because OOP developers tend to think in a procedural and imperative way.
Unfortunately.

BTW, besides an existing [list of well-known anti-patterns](https://en.wikipedia.org/wiki/Anti-pattern)
I also consider [these few things]({% pst 2014/sep/2014-09-10-anti-patterns-in-oop %})
as rather bad coding approaches.

## Untraceable Changes

When I look at the commit history, I should be able to tell,
in every single change, _what_ was changed, _who_ made a change, and
_why_ this change was made. And the time required to get those three
answers must be measured in seconds. In most projects this is not the
case. Here are a few practical recommendations.

**Always Use Tickets**.
No matter how small is the project or its team, even if it's just yourself,
create tickets (Github issues) for every problem you're solving. Explain
the problem briefly in the ticket and document your thinking there. Use
the ticket as a temporary storage of all information related to the problem.
Post there whatever you have that could make any sense in the future, when
someone else will try to understand what that few strange commits were about.

**Reference Tickets in Commits**.
No need to say that every commit must have a message. Commits without
messages is a very dirty practice, I won't even discuss why. But just a message
is not enough. Every message must start with a number of ticket you're working
with. Github (I'm sure you are using it) will automatically link commits
and tickets, increasing traceability of changes.

**Don't Delete Anything**.
Git allows us to do "forced" push, which overwrites the entire branch,
previously existed on the server. This is just one of the examples when
you can destroy the history of development. I've also seen, many times,
people deleting their comments in Github discussions, to make tickets look
more "clean". That's just wrong. Never delete anything, let your history
stay with you, no matter how bad it may look.

?? links in docs to other projects

## Ad Hoc Releases

Every piece of software must be packaged software, before it can
be delivered to the end user. If it's Java library, it has to be
packaged as `.jar` file and release to some repository; if it's a web
app, it has to be deployed to some platform, etc. No matter how small
or big is the product, there is always a certain procedure that
tests, packages and deploys.

An ideal solution would be to automate this procedure the way that
it is possible to execute it from a command line with a single command:

{% highlight bash %}
$ ./release.sh
...
DONE
{% endhighlight %}

In most projects this is not the case. This release process always
involves some magic, where the person responsible for it
(also known as DevOp) has to click some buttons here and there, login
somewhere, check some metrics, etc. Such an _ad hoc_ release process
still is a very typical sin of the entire software engineering industry.

I can give only one practical advice here &mdash; automate it. I'm using
[rultor.com]({% pst 2014/sep/2014-09-11-deployment-script-vs-rultor %}) for it.

## Volunteer Static Analysis

Static analysis is what makes our code _look_ better. And by making it
look better we are inevitably making it _work_ better. But this happens
only when the entire team is forced to follow the rules dictated by the
static analyzer(s). I've written about it in
[Strict Control of Java Code Quality]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}).
I'm using [qulice.com](http://www.qulice.com) in Java projects
and [rubocop](...) in Ruby.

You can use something else, but make it mandatory! In most projects,
where static analysis is used, developers are just building nicely looking
reports and continue to write code the way they did before. This "volunteer"
approach is not doing anything good to the project. Moreover, it
creates an illusion of quality.

## Unknown Test Coverage

no test coverage report/control

## Non-Stop Development

I mean &mdash; without milestones and releases. No matter what kind of
software you're writing, you must release it frequently and versionalize
that releases.

