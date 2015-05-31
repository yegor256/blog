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
  - software maintainability
---

_Maintainability_ is the [most valuable virtue]({% pst 2014/oct/2014-10-26-hacker-vs-programmer-mentality %})
of a modern software development.
[Maintainability](https://en.wikipedia.org/wiki/Maintainability)
can basically be measured as a working time required for
a new developer to learn the software before he or she can start making
serious changes in it. The longer the time, the lower the maintainability.
In some projects, this time is close to infinity, which means that it is
literally unmaintainable. I believe there are seven fundamental and fatal
sins that make our software unmaintainable. Here they are.

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

My only practical suggestion here is to read and learn. Maybe
[these books]({% pst 2015/apr/2015-04-22-favorite-software-books %}) will help you.
Try always to be skeptical about the quality of your software and don't relax
when it "just works". Like with cancer, the earlier you diagnose it, the
higher the chances to survive.

## Untraceable Changes

When I look at the commit history, I should be able to tell,
for every single change, _what_ was changed, _who_ made a change, and
_why_ this change was made. Moreover, the time required to get those three
answers must be measured in seconds. In most projects this is not the
case. Here are a few practical recommendations.

**Always Use Tickets**.
No matter how small is the project or its team, even if it's just yourself,
create tickets (Github issues) for every problem you're solving. Explain
the problem briefly in the ticket and document your thinking there. Use
the ticket as a temporary storage of all information related to the problem.
Post there everything that could make any sense in the future, when
someone else will try to understand what that "few strange commits" were about.

**Reference Tickets in Commits**.
No need to say that every commit must have a message. Commits without
messages is a very dirty practice, I won't even discuss why. But just a message
is not enough. Every message must start with a number of ticket you're working
with. Github (I'm sure you are using it) will automatically link commits
and tickets, increasing _traceability_ of changes.

**Don't Delete Anything**.
Git allows us to do "forced" push, which overwrites the entire branch,
previously existed on the server. This is just one of the examples when
you can destroy the history of development. I've also seen, many times,
people deleting their comments in Github discussions, to make tickets look
more "clean". That's just wrong. Never delete anything, let your history
stay with you, no matter how bad (or messy) it may look to you now.

## Ad Hoc Releases

Every piece of software must be packaged, before it can
be delivered to the end user. If it's Java library, it has to be
packaged as `.jar` file and released to some repository; if it's a web
app, it has to be deployed to some platform, etc. No matter how small
or big is the product, there is always a certain procedure that
tests, packages and deploys.

An ideal solution would be to automate this procedure the way that
it is possible to execute it from a command line with a single command:

{% highlight bash %}
$ ./release.sh
...
DONE (took 98.7s)
{% endhighlight %}

Most projects are far from that. In most projects, the release process always
involves some magic, where the person responsible for it
(also known as a DevOp) has to click some buttons here and there, login
somewhere, check some metrics, etc. Such an _ad hoc_ release process
still is a very typical sin of the entire software engineering industry.

I can give only one practical advice here &mdash; automate it. I'm using
[rultor.com]({% pst 2014/sep/2014-09-11-deployment-script-vs-rultor %}) for it,
but you can use whatever tools you like. What is important is that the entire
procedure is fully automated and can be executed from the command line.

## Volunteer Static Analysis

[Static analysis](https://en.wikipedia.org/wiki/Static_program_analysis)
is what makes our code _look_ better. And by making it
look better we are inevitably making it _work_ better. But this happens
only when the entire team is forced (!) to follow the rules dictated by the
static analyzer(s). I've written about it in
[Strict Control of Java Code Quality]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}).
I'm using [qulice.com](http://www.qulice.com) in Java projects
and [rubocop](https://github.com/bbatsov/rubocop) in Ruby, but there
are many similar tools almost for every language.

You can use any of them, but make it mandatory! In most projects,
where static analysis is used, developers are just building nicely looking
reports and continue to write code the way they did before. Such a "volunteer"
approach is not doing anything good to the project. Moreover, it
creates an illusion of quality.

What I'm saying is that static analysis must be a mandatory step in
your deployment pipeline. The build can't pass if any of static analysis
rules is violated.

## Unknown Test Coverage

Simply put, [test coverage](https://en.wikipedia.org/wiki/Code_coverage)
is a degree to which the software was tested by unit or integration tests. The
higher the coverage, the bigger "amount" of code was executed while
tests were running. Obviously, higher coverage is a good thing.

However, many projects simply don't know their coverage. They just don't measure
this metric. They may have some tests, but nobody knows how deeply they
penetrate the software and what parts of it are not tested at all.
This situation is much worse than a low coverage that is measured and
reported to everybody.

High coverage is not a guarantee of high quality. Obviously not. But unknown
coverage is a clear indicator of maintainability problems. When a new
developer enters the project, he or she should be able to make some
changes and see how coverage is affected by them. Ideally, test coverage
should be checked the same way as static analysis and the build should
fail if it goes lower than a certain pre-defined threshold
(usually, somewhere around 80%).

## Non-Stop Development

I mean &mdash; without milestones and releases. No matter what kind of
software you're writing, you must release and versionalize it frequently.
A project without a clear release history is an unmaintainable mess.

Mostly because maintainability is all about me being able to understand you
by reading your code.

When I look into the source code and its commit and release history I have
to be able to tell what was the intention of its author(s), what the project
was doing a year ago, where is it going now, what is the roadmap, etc. All
this information must be in the source code and, what is more importantly,
in Git history.

Git tags and Github release notes are two powerful instruments to give
me that information. Use them to their full extend. Also, don't forget that
each binary version of the product must be available for immediate download.
I have to be able to download version 0.1.3 and test it right now, even
if the project is working on 3.4 at the moment.

## Undocumented Interfaces

Every software has interfaces through which it is supposed to be used.
If it's a Ruby gem &mdash; there are classes and methods that I'm going to
use as an end-user of it. If it's a web app &mdash; there are web pages
that an end-user will see and control in order to use the app. Every software
has interfaces and they must be carefuly documented.

As everything above, this is also about maintainability. As as a new programmer
in a project, I will start to learn it from its interfaces. I should be able
to understand what is does and try to use it myself.

I'm talking here about documentation for users, not for developers. I'm in
general against documentation inside the software. Here I totally agree with
[Agile Manifesto](http://agilemanifesto.org/) &mdash; working software is
much more important than a comprehensive documentation. But it's not about
"external" documentation, which is supposed to be read by users, not developers.

So, end-user interaction with the software must be clearly documented.

If your software is a library than its end-users are software developers
that are going to use it. Not contribute to it, but simply use it as a
"black box."

<hr/>

These criteria are used to evalute open source projects that
are taking participation in the
[Award]({% pst 2015/apr/2015-04-16-award %}).
