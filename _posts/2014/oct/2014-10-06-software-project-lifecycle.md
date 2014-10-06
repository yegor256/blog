---
layout: post
title: Project Lifecycle in Teamed.io
date: 2014-10-06
tags: mgmt
description:
  There are four standard phases in
  a software development lifecycle for all projects
  developed by Teamed.io.
keywords:
  - project lifecycle
  - agile project steps
  - how to schedule an agile project
  - project milestones
  - project phases
---

{% badge http://img.teamed.io/logo.svg 160 http://www.teamed.io %}

In addition to being a hands-on programmer, I'm also co-founder and CTO of
[Teamed.io](http://www.teamed.io), a custom software development company.
I play the role of a technical and management leader in all projects
we work with.

I wrote this article for those who're interested in hiring me and/or
my team. This article will demonstrate what happens from day one until
the end of the project, when you choose to [work with us](mailto:hire@teamed.io).

You will see below that our methods of
software development [seriously differ]({% post_url 2014/apr/2014-04-17-how-xdsd-is-different %})
from what many other teams are using. I personally pay a lot of attention to quality
of code and quality of the internal processes that connect our team.

<!--more-->

There are four phases in every project I work with in
[Teamed.io](http://www.teamed.io):

 * **Thinking**.
   Here we're trying to understand: What is the problem that the product
   is going to solve? We're also investigating the product's boundaries &mdash;
   who will work with the software (actors) and how will they work with it (user stories).
   Deliverables: specification.
   Duration: from 2 days up to 3 weeks.
   Participants: product owner, analyst(s), architect, project manager.

 * **Building**.
   Here the software architect is creating a [proof-of-concept](https://en.wikipedia.org/wiki/Proof_of_concept)
   (aka an [MVP](https://en.wikipedia.org/wiki/Minimum_viable_product) or prototype or a skeleton).
   It is a one-man job that is done almost without any interaction
   with anyone else. The architect builds the product according to the
   specification in a very limited time frame. The result will have
   multiple bugs and open ends, but it will implement the main user story.
   The architect also configures continuous integration and delivery pipelines.
   Deliverables: working software.
   Duration: 2-5 days.
   Participants: architect.

 * **Fixing**.
   At this phase we are adding all the meat to the skeleton. This phase
   takes most of the time and budget and involves many participants.
   In some projects we invite up to 50 people to work, at the same time.
   Since we treat all inconsistencies as bugs, this phase is mostly about
   finding, reporting and fixing bugs, in order to stabilize the product
   and get it ready for market launch. We increment and
   release the software multiple times a day, preferably to its user
   champions.
   Deliverables: bug fixes via pull requests.
   Duration: from weeks to months.
   Participants: programmer(s), designer(s), tester(s), code reviewer(s), architect, project manager.

 * **Using**.
   At this final phase we are launching the product to its end-users,
   and collecting their feedback (both positive and negative). Everything
   they are reporting back to us is being registered as a bug. Then,
   we categorize the bugs and fix them. This phase may take years, but
   it never involves active implementation of new features.
   Deliverables: bug fixes via pull requests.
   Duration: months.
   Participants: programmer(s), code reviewer(s), project manager.

The biggest (i.e., longest and most expensive) phase is, of course, Fixing. It
usually takes the majority of time (over 70%). However, the most important
and risky phase is the first one &mdash; Thinking. A mistake made during Thinking
will cost much more than a mistake made later.

## Thinking

Thiking is the first and the most important phase.

First, we give a name to the project and create a [Github](https://github.com) repository. We
try to keep all our projects (both open source and commercial) in Github.
Mostly because the platform is very popular, very powerful, and really cheap
([$7/mo](https://github.com/pricing) for a set of 5 private projects).
We also keep all communication in the Github issue tracker.

Then, we create a simple half-page SRS document (Software Requirements Specification). Usually
this is done right inside the source code, but sometimes in the Github wiki. What's important
is that the document should be under version control. We will modify it
during the course of the project, very intensively. The SRS should briefly
identify main "actors" of the system and define the product scope.

Even though it is only half a page, the creation of this initial SRS document
is the most important and the most expensive task in the entire project.
We pay a lot of attention to this step. Usually this document is written
by myself in a direct communication with the project sponsor. We can't afford
a mistake at this step.

Then, we invite a few system analysts to the project. These guys
are responsible for turning our initial SRS into a more complete and detailed
specification. They start by asking questions, submitting them one by one
as Github issues. Every question is addressed to the product owner. Using
his answers, system analysts modify the SRS document.
This article explains how [Requs](http://www.requs.org) helps us in this process:
[Incremental Requirements With Requs]({% post_url 2014/apr/2014-04-26-incremental-requirements-with-requs %})

At the end of the Thinking phase we estimate the size of the project,
in lines of code. Using lines of code, we can roughly
[estimate a budget](http://www.teamed.io/calculator.html).

I stay personally involved in the project during
the entire Thinking phase.

## Building

This is a one-man job for an architect. Every project we work with
has an architect who is personally responsible for the quality and all
technical decisions made there. I try to play this role
in most projects.

The Building phase is rather straight forward. I have to implement the
solution according to the SRS, in a few working days. No matter
how big the idea and how massive the planning development, I
still have to create (build from scratch!) the product in, say, three days.

Besides building the software itself, I have to configure all
basic DevOps processes, including:
1) automated testing and quality control,
2) deploying and releasing pipelines,
3) repository of artifacts,
4) continuous integration service, etc.

The result of this phase is a working software package, deployable
to its destination and available for testers. Technical
[quality requirements]({% post_url 2014/aug/2014-08-13-strict-code-quality-control %})
are also defined at this phase.

## Fixing

Now it's time to build a distributed team of programmers. First, we
invite those who've worked in other projects before and have already
have proven their quality. Very often we invite new people,
finding them through StackOverflow, Github, oDesk, and other sources.
An average team size of an average project is 10-20 programmers.

At this phase, we understand any inconsistency as a bug. If something is not clear
in the documentation, or if something can be refactored for better
readability, or if a function can be improved for higher performance &mdash;
it is a bug to us.
And [bugs are welcome]({% post_url 2014/apr/2014-04-13-bugs-are-welcome %}) in our projects.
We encourage everybody to report as many bugs as possible. This is how
we achieve high quality.

That is why the phase is called Fixing, after all. We are reporting bugs and fixing
them. Hundreds of bugs. Sometimes thousands. The product
grows in front of our very eyes, because after every bug fix
we re-deploy the entire product to the production platform.

Every bug is reported, classified, discussed, and fixed in its
own Github ticket and its own Git branch. We never allow anyone
to just commit to the `master` branch &mdash; all changes must pass through
our [quality controls]({% post_url 2014/aug/2014-08-13-strict-code-quality-control %})
and be merged into `master` by [rultor.com](http://www.rultor.com),
our [merging bot]({% post_url 2014/jul/2014-07-24-rultor-automated-merging %}).

Also important to mention is that all communications with the product owner
and between programmers happen only through Github issues. We never use
any chats, Skype, emails or conferencing software. We communicate
only through tickets and comments in Github.

## Using

This is the final phase and it can take quite a long time. By now, the product is
ready and is launched to the market. But we still receive bug reports
and feature request from the product owner, and we still fix them through
the same process flow as in the Fixing phase.

We try to keep this phase as quiet as possible, in terms of
the amount of bugs reported and fixed. Thanks to our intensive and
pro-active bug finding and fixing in the previous phase, we usually
have very few problems at the Using phase.

And big feature requests? At this phase, we usually try to convert
them into new projects and develop them separately, starting again
from Thinking.
