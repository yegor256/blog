---
layout: post
title: "Nine Steps to Start a Software Project"
date: 2015-08-04
tags: architect
place: Kyiv, Ukraine
description: |
  A prototype is what a software project starts from;
  this article explains the nine critical steps in the
  process of its creation.
keywords:
  - software prototyping
  - what is a prototype
  - what is a software prototype
  - how to create a prototype
  - software prototyping steps
image: /images/2015/08/ying-xiong.jpg
jb_picture:
  caption: Ying xiong (2002) by Yimou Zhang
---

[Agile]({% pst 2016/jul/2016-07-11-mistakes-in-agile-manifesto %})
or not, a software project starts with a requirements analysis
and definition. We basically define what needs to be done somehow, be it on a
piece of napkin or a 100-page Word document. The next step is to
turn this into a working piece of software as fast as possible and by spending as
few dollars as possible. Ideally, this prototyping takes a week
and is made by an architect working _solo_.
Once the "skeleton" is ready, we start putting software "meat" on it.
We recruit a team of programmers for that or
[outsource]({% pst 2015/oct/2015-10-27-outsourcing-doesnt-work %})
it. I see nine important steps
in the skeleton creation part; let me show you them one by one.

<!--more-->

{% jb_picture_body %}

Let's use some examples to make this more illustrative. Let's say I'm a
software architect and the project is a "Google killer." We're hired to
create a new search engine, and my job is to turn requirements into
a prototype, a.k.a. a skeleton or a proof of concept. This is what I have
as an input (let's say it's a piece of napkin... what else would it be
for a Google killer, right?):

```text
Each page is ranked by the number of mentions in
social networks like Twitter, LinkedIn, Facebook, etc.
The more mentions it has, the higher the rank and the
higher its position in the search results page.
```

Seems like a doable project to me, and the requirements document is
clear enough. It doesn't say anything about performance, but I
can assume that it has to be as fast as Google. The same goes
for scalability, stress resilience, etc.

{% quote For each decision I made, there has to be at least one alternative that I considered and rejected. %}

I'm not going to discuss how the software is created in a specific
technical stack. That's not important for this article. What's important now
is how my programming work will be "wrapped." In other words, what will
I hand off to the team of programmers after a week of hard work---what is my product, or more formally, my _deliverables_.

Thus, let's assume I managed to create a piece of software and it works.

## Decisions and Alternatives

First of all, I have to document my key [technical decisions]({% pst 2023/aug/2023-08-15-decision-making-process %}) 
and their alternatives. [We](https://www.zerocracy.com) usually work in GitHub, and the best documentation
media is the `README.md` file in the root directory of the repo. I just
put my text there in a plain [Markdown](https://daringfireball.net/projects/markdown/)
format. That's enough for a good
technical document---it has to be short; that's important.

For each decision I made, there has to be at least one alternative
that I considered and rejected. There are two items at the top of my list:

```text
Apache Lucene is a search engine. It is popular,
  mature enough, scalable, and written in Java. Alternatives
  are Solr, Sphinx, Gigablast, and many others.
Java 8 is a programming language, and JVM is a
  runtime platform. I know how they work, and the team
  has enough experience with them. Alternatives are
  Ruby, Python, Go, Scala, and tons of others.
```

{% quote Each decision must be traceable to the person who made it. %}

These decisions are very high-level, but I still need to document them. As you
see, I'm not explaining
[in details]({% pst 2015/jun/2015-06-29-simple-diagrams %})
why the alternatives were rejected, and it's
my choice. If someone questions my decisions in the future, they may
say that the alternatives were not analyzed properly. It will be clear whose
[fault]({% pst 2014/oct/2014-10-12-who-is-software-architect %})
it was---mine. So I'm taking full responsibility for these two
choices I've made: Lucene and Java&nbsp;8.

Yet another item to the list:

```text
Three modules make up the app: UI, scraper,
  and analyzer. They are fully decoupled and
  communicate strictly through Lucene. I don't
  see any alternatives.
```

Then, I attach a simple diagram to illustrate my decision:

{% plantuml style="width:75%" %}
[Lucene] -down- [UI]
[Lucene] - [Scraper]
[Analyzer] - [Lucene]
{% endplantuml %}

As you see, in this case, I totally _ignored_ all alternatives. I didn't even
mention them. Again, I take full responsibility for that; I said,
"I don't see any alternatives." If, later, a better alternative is
discovered, it will be obvious why we overlooked it and whose fault
it was. It's not only about
[punishment]({% pst 2016/jan/2016-01-05-how-to-punish-employees %}) but about discipline and
traceability of decisions. Each decision must be
[traceable]({% pst 2015/jun/2015-06-08-deadly-sins-software-project %})
to the person
who made it. This helps us avoid bad decisions in the future and
makes the entire project more maintainable and transparent.

Let's add one more decision to the list:

```text
Takes Framework is used for UI. It helps keep our
  code truly object-oriented, testable, fast, and
  decoupled from the data model. Alternatives:
  - Spring: It is big, complex, and ugly
  - Play: Similar to Spring, big and ugly
  - Spark: Not as clear as Takes
```

In this case, I documented the alternatives and gave my reasons why
they are not good for us. As you see, the reasons are very biased; I
basically expressed my personal opinions about these three
frameworks and definitely gave preference to my own open
source [Takes](http://www.takes.org) framework. Is it good? No, it's not.
But I'm the [architect]({% pst 2014/oct/2014-10-12-who-is-software-architect %}),
and I do what I think is right for the project.

I'm trying to show that the point of this documentation is for
me, the architect, to explain my way of thinking---no matter how bad,
biased, or _irrational_ it was. I have to write my decisions down and let the project
[know]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %})
them all.

I would suggest you keep the number of documented decisions somewhere
between _four and twelve_. If there are fewer than four, I probably forgot
to document something important. More than 12---I'm documenting
too many non-important decisions. I should use other media for that,
like JavaDoc blocks or responsive classes.

## Concerns

The next chapter in the `README.md` file has to explain how exactly I
managed to address all concerns expressed in the initial
[requirements]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %}).
I mentioned above that it goes without saying that our system must
be as fast and scalable as Google. Thus, let's say there are two "concerns"---performance and scalability.

As a software architect, I must address them both. In other words, I have to
prove that my solution is fast and scalable. Maybe it's not, but if I believe
it is, I have to explain why I think so. I can't be quiet about the concerns. Here
is what I would say about performance:

```text
The system is as fast as the Lucene search engine, while
Lucene is rather fast even with large amounts of data.
```

And this one is about scalability:

```text
The bottleneck is in Lucene, and it is scalable
vertically. Not sure about horizontal scalability.
```

As you see, I'm trying to be _honest_ and tell the truth. We'll be able to
review these statements later and decide whether I was right or wrong. But
we need to have my answers to all concerns expressed in the requirements.

## Assumptions

The next section is about assumptions I've made while working with the
prototype. We usually make assumptions when we don't have enough factual
information, and we basically fill the gaps. There is nothing wrong with
it, but we have to document which _gaps_ were filled and why.

How about these two assumptions:

```text
1. I assume that social platforms won't block our
   calls and will provide counters for all pages.
2. I assume that Lucene will be enough for both
   indexing and data storage, so we won't need a
   database engine.
```

I made these assumptions without proper analysis of the situation. I don't
know whether Twitter will be happy to see millions of requests every hour
coming from our server or not. Maybe it will ban us; I don't know. I don't
have to evaluate this and find an exact answer. I just made an _assumption_
and documented it.

{% quote I just make an assumption and call it a day. %}

Will it be enough to have Lucene only, without any additional data persistence
layer? I don't know, but I _hope_ so. I don't have time to do a detailed
analysis of our entire data model and its potential future requirements. I just
make an assumption and call it a day.

If later, during the handoff, the
[project sponsor]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %})
says this assumption
exposes too much risk for the project, we'll do a better analysis. For now, my job
is to document what I see and move on. Remember, I have just a week of time.

## Risks

Now I list all potential problems I foresee and estimate
their probability and impact. Let me show you an example first:

```text
1. Lucene may not be able to handle billions of documents [6x9]
2. Social platforms will ban our requests [8x9]
```

The first number in square brackets is the probability and the second one
is the impact, on a 0 to 9 scale. If both numbers are nine, it's not a risk
anymore; it's a _fact_. If both numbers are zero, we can simply ignore this
risk.

I listed just two, but in a real system there should be somewhere
between _four and twelve_ risks. Too many risks is a sign that the prototype is
not focused enough, while too few is due to a lack of attention.

## Continuous Integration

Now I have to make sure the product is "wrapped" in
[continuous integration]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %}),
which is a [critical component]({% pst 2015/jun/2015-06-08-deadly-sins-software-project %})
of any software package. I have to configure it, preferably
[in the cloud]({% pst 2014/oct/2014-10-05-ten-hosted-continuous-integration-services %}),
and make sure the build is clean.

It is also important to make sure the continuous integration pipeline
covers all critical areas, including:

 * Building on multiple platforms, such as Linux, Windows, and Mac.
 * Running integration tests and unit tests.
 * Analyzing [statically]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}).
 * Collecting test coverage.
 * Generating documentation.

{% quote The goal is to make the continuous integration pipeline as fragile as possible. %}

The stricter the pipeline, the better it is for the project. At this stage, my job,
as an architect, is to build a "guard wall" around the product to protect
it against future _chaos_. The chaos will come from programmers making
changes through pull requests. They will care much less about the entire
quality of the product than I do, and that's why I have to incorporate tools
that keep the situation under control.

My goal is to make the continuous integration pipeline as _fragile_ as possible.
Any minor error should lead to a build failure. Of course, I'm talking about
reproducible failures. The build should fail in a predictable way, not
sporadically.

## Static Analysis

This is yet another [critical component]({% pst 2015/jun/2015-06-08-deadly-sins-software-project %})
of any software project. You have to analyze the quality of code
[statically]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}).
In the most primitive approach, a static analysis will check the formatting
of your source code and fail the build when that formatting is broken. However,
in a more advanced variant, static analysis will catch many important bugs.

{% quote The fragility of the build is a key success factor in software development. %}

It is called "static" because it doesn't require the software to be running.
To the contrary, unit tests validate software quality in runtime
by running the app.

There are many static analysis tools, for almost every language and format.
I strongly recommend you use them. Moreover, I recommend you configure them
as strictly as possible in order to make the build as
[fragile]({% pst 2015/aug/2015-08-25-fail-fast %}) as you can.
The fragility of the build is a key success factor in software development.

## Test Coverage

Test coverage must be collected on every build and, at the very least, reported. In
an ideal scenario, low test coverage must fail the build. Let's say I set
the required percentage of coverage to 75 percent (it's actually a more complex metric, but
in a primitive approach just one number is enough). If someone introduces
a new class without a unit test, the coverage percentage goes down and
the build breaks.

My job, as an architect creating a prototype, is to make sure the coverage
is calculated on every build and is under control---it can't go
lower than the _threshold_ I set.

No matter how low the threshold is, what matters is whether it is under
control or not.

## Continuous Delivery

This is the final step before the handoff. I have to configure a continuous
delivery pipeline to make sure the product is packaged and deployed in
[one click]({% pst 2015/jun/2015-06-08-deadly-sins-software-project %}).
This is a very important---critically important---step. Without it,
everything done before and the piece of software itself is just a collection
of files. A piece of software is a product when it is packagable and
deployable in one click.

"Pipeline" means that there are a number of elements chained sequentially;
for a Java application, for example:

 * Run automated build (the same as in [continuous integration]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %}))
 * Package JAR file
 * Upload JAR file to repository
 * Build JavaDoc site
 * Upload JavaDoc site to Amazon S3

I'm using [Rultor]({% pst 2014/jul/2014-07-24-rultor-automated-merging %}) to
automate the entire pipeline and simplify its start, stop, and logging. I just
[post]({% pst 2015/nov/2015-11-03-chatbot-better-than-ui-for-microservice %})
a "please release now" message to a GitHub ticket, and the product
is packaged and deployed in a few minutes.

## Acceptance

The last step is the handoff---I have to present my solution to the
[project manager]({% pst 2015/sep/2015-09-22-micromanagement %}),
the sponsor of the project, and the team. Everybody has
to accept it. It doesn't mean they will like it, and that's not the goal. The
goal is to deliver a complete solution, with risks, assumptions, decisions
documented, continuous integration configured, static analysis enforced, etc.
If my solution won't be good enough for their criteria, they will
[change]({% pst 2015/sep/2015-09-16-how-to-fire-someone-right %})
the architect and try again.

My objective is _not_ to satisfy them but to do the best I can according
to the requirements and my professional understanding of the problem and
business domains. I wrote about this some time ago:
[A Happy Boss Is a False Objective]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %}).
Again, my objective is not to make them happy. Instead, my objective is to make
a perfect prototype, the way I understand the word _perfect_. If I fail,
I fail. The project will get another architect and try again.

That's it. The skeleton is ready, and my job is done.
