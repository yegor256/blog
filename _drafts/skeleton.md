---
layout: post
title: "Nine Steps to Start a Software Project"
date: 2015-08-04
tags: architect
place: Kiev, Ukraine
description:
  A prototype is what any software project starts from;
  this article explains its nine key critical steps in its
  creating process.
keywords:
  - software prototyping
  - what is prototype
  - what is software prototype
  - how to create a prototype
  - software prototyping steps
---

Agile or not, a software project starts with requirements analysis
and definition. We basically define what needs to be done somehow, be it a
piece of napkin or a hundred-pages Word document. The next step is to
turn this into a working software, as fast as possible, spending as
little dollars as possible. Ideally, this prototyping takes a week
and is made by an architect working **solo**.
Once the "skeleton" is ready, we start putting software "meat" on it.
We recruit a team of programmers for that or outsource. I see nine important steps
in the skeleton creating part, let me show them one by one.

<!--more-->

Let's use some example, to make it more illustrative. Let's say I'm a
software architect and the project is a "Google killer". We're hired to
create a new search engine and my job is to turn requirements into
a prototype, a.k.a. a skeleton or a proof-of-concept. This is what I have
as an input (let's say it's a piece of napkin... What else for a Google killer,
right?):

{% highlight text %}
Each page is ranked by the amount of mentions in
social networks, like Twitter, LinkedIn, Facebook, etc.
The more mentions it has, the bigger the rank, the
higher its position in the search result page.
{% endhighlight %}

Seems like a doable project to me and requirements document is
clear enough. It doesn't say anything about performance, but I
can assume that it has to be as fast as Google. The same goes
without saying about scalability, stress resilience, etc.

I'm not going to discuss how the software is created, in a specific
technical stack. It's not important in this article. What's important now
is how my programming work will be "wrapped". In other words, what will
I hand off to the team of programmers, after a week of hard work &mdash;
what is my product or, more formally, my **deliverables**.

Thus, let's assume that I managed to create a piece of software and it works.

## Decisions and alternatives

First of all, I have to document my key technical decisions and their
alternatives. [We](http://www.teamed.io) are usually working in Github and the best documentation
media is `README.md` file in the root directory of the repo. I just
put my text there, in a plain Markdown format. That's enough for a good
technical documentation &mdash; it has to be short, that's important.

For each decision I made, there have to be at least one alternative,
which I considered and rejected. There are two first items in my list:

{% highlight text %}
Apache Lucene is a search engine. It is popular,
  mature enough, scalable and written in Java. Alternatives
  are Solr, Sphinx, Gigablast, and many others.
Java 8 is a programming language, JVM is a
  runtime platform. I know how they work, the team
  has enough experience. Alternatives are
  Ruby, Python, Go, Scala and tons of others.
{% endhighlight %}

These decisions are very high-level, but I still need to document them. As you
see, I'm not explaining in details why alternatives were rejected and it's
my choice. If someone will question my decisions in the future, they may
say that alternatives were not analyzed properly. It will be clear whose fault
it was &mdash; mine. So, I'm taking full responsibility for these two
choices I've made: Lucene and Java 8.

Yet another item to the list:

{% highlight text %}
Three modules consists the app: UI, scrapper
  and analyzer. They are fully decoupled and
  communicate strictly through Lucene. I don't
  see any alternatives.
{% endhighlight %}

Then, I attach a simple diagram to illustrate my decision:

{% plantuml %}
[Lucene] -down- [UI]
[Lucene] - [Scrapper]
[Analyzer] - [Lucene]
{% endplantuml %}

As you see, in this case I totally ingored all alternatives. I didn't even
mention them. Again, I took full responsibility for that, because I said
that "I don't see any alternatives". If later a better alternative will
be discovered, it will be ovious why we overlooked it and whose fault
it was. It's not only about punishment, but more about discipline and
traceability of decisions. Each decision must be traceable to the person
who made it. This helps us to avoid wrong decisions in the future and
make the entire project more maintainable and transparent.

Let's add one more decision to the list:

{% highlight text %}
Takes Framework is used for UI. It helps keeping our
  code truly object oriented, testable, fast and
  decoupled from data model. Alternatives:
  - Spring: it is big, complex and ugly
  - Play: similar to Spring, big and ugly
  - Spark: not as clear as Takes
{% endhighlight %}

In this case, I documented the alternatives and gave my reasons why
they are not good for us. As you see, the reasons are very biased, I
basically expressed my personal opinions about these three
frameworks and definitely gave my preference to my own open
source [Takes](http://www.takes.org) framework. Is it good? No, it's not.
But I'm the [architect]({% pst 2014/oct/2014-10-14-who-is-software-architect %})
and I do what I think is right for the project.

I'm trying to show that the point of this documenation is to let
me, the architect, to explain my way of thinking. No matter how bad,
biased or irrational it was. I have to write my decisions down and let the
project know them all.

I would suggest to keep the amount of decisions documented somewhere
between **four and twelve**. If there are less than four, I probably forgot
to document something important. Over twelve &mdash; I'm documenting
too many non-important decisions. I should use other media for that,
for example JavaDoc blocks or responsive classes.

## Concerns

The next chapter in the `README.md` file has to explain how exactly I
managed to address all concerns expressed in the initial requirements.
I mentioned above that it goes without saying that our system must
be as fast and scalable as Google. Thus, let's say there are two "concerns" &mdash;
performance and scalability.

I, as a software architect, must address them both. In other words, I have to
prove that my solution is fast and scalable. Maybe it's not, but if I believe
it is, I have to explain why I think so. I can't be quiet about hem. Here
is what I would say about performance:

{% highlight text %}
The system is as fast as Lucene search engine, while
Lucene is rather fast even with big amounts of data.
{% endhighlight %}

And this one is about scalability:

{% highlight text %}
The bottleneck is in Lucene and it is scalable
vertically. Not sure about horizontal scalability.
{% endhighlight %}

As you see, I'm trying to be honest and tell the truth. We'll be able to
review these statements later and decide whether I was right or wrong. But
we need to have my answers to all concerns expressed in the requirements.

## Assumptions

The next section is about assumptions I've made while working with the
prototype. We usually make assumptions when we don't have enough factual
information and we basically fill the gaps. There is nothing wrong about
it, but we have to document which gaps were felt and why.

How about these two assumptions:

{% highlight text %}
1. I assume that social platforms won't block our
   calls and will provide counters for all pages.
2. I assume that Lucene will be enough both for
   indexing and data storage, we won't need a
   database engine.
{% endhighlight %}

I made these assumptions without proper analysis of the situation. I don't
know whether Twitter will be happy to see millions of requests every hour
coming from our server or not. Maybe they will ban us, I don't know. I don't
have to evaluate this and find an exact answer. I just made an assumption
and documented it.

Will it be enough to have Lucene only, without any additional data persistence
layer? I don't know, but I _hope_ so. I don't have time to do a detailed
analysis of our entire data model and its potential future requirements. I just
make an assumption and call it a day.

If later, during the hand off, project sponsor will say that this assumption
exposes too much risk to a project, we'll do a better analysis. For now, my job
is to document what I see and move on. Remember, I have just a week of time.

## Risks

Now, I have to list all potential problems I forsee and estimate
their probability and impact. Let me show an example first:

{% highlight text %}
1. Lucene may not be able to handle billions of documents [6x9]
2. Social platforms will ban our requests [8x9]
{% endhighlight %}

The first number in square brackets is the probability, the second one
is the impact, on 0..9 scale. If both numbers are nine, it's not a risk
any more, it's a fact. If both numbers are zero, we can simply ignore this
risk.

I listed just two of them, but in a real system there should be somewhere
between four and twelve. Too many risks is a signal of dis-focus, while
too few is a lack of attention.

## Continuous Integration

Now, I have to make sure the product is "wrapped" in continuous integration,
which is a [critical component]({% pst 2015/jun/2015-06-08-deadly-sins-software-project %})
of any software package. I have to configure it, preferably
[in cloud]({% pst 2014/oct/2014-10-05-ten-hosted-continuous-integration-services %}),
and make sure the build is clean.

It is also important to make sure the continuous integration pipeline
does cover all critical areas, including:

 * building on multiple platforms, incl. Linux, Windows, Mac
 * running integration tests and unit tests
 * analysing statically
 * collecting test coverage
 * generating documentation

The stricter the pipeline, the better for the project. My job, as an architect,
on this stage, is to build a "guarding wall" around the product to protect
it in the future against **chaos**. The chaos will come from programmers, making
changes through pull requests. They will care much less about the entire
quality of the product than I do, that's why I have to incorporate tools
that keep the situation under control.

My goal is to make continuous integration pipeline as **fragile** as possible.
Any minor error should lead to a build failure. Of course, I'm talking about
reproducible failures. The build should fail in a predictable way, not
sporadically.

## Static analysis

This is yet another [critical component]({% pst 2015/jun/2015-06-08-deadly-sins-software-project %})
of any software project. You have to analyze the quality of code statically.
In the most primitive approach, a static analysis will check the formatting
of your source code and fail the build when formatting is broken. However,
in a more advanced variant, static analysis will catch many important bugs.

It is called "static" becuase it doesn't require the software to be running.
To the contrary, unit tests are validating the quality in runtime,
by running the app.

There are many static analysis tools, almost for each language and format.
I strongly recommend to use them. Moreover, I recommend to configure them
as strict as possible, in order to make the build as fragile as you can.
The fragility of the build is a key success factor in software development.

## Test coverage

Test coverage must be collected, on every build, and, at least, reported. In
an ideal scenario, lowering test coverage must fail the build. Let's say I set
the required percentage of coverage to 75% (it's a more complex metric, but
in a primitive approach just one number is enough). If someone introduces
a new class without a unit test, the coverage percentage goes down and
the build breaks.

My job, as an architect creating a prototype, is to make sure the coverage
is calculated on every build and it is under control &mdash; it can't go
lower than the threshold I set.

No matter how low is the threshold, what matters is whether it is under
control or not.

## Continuous delivery

This is the final step before the hand off. I have to configure a continuous
delivery pipeline to make sure the product is packaged and deployed in
one click. It is a very important, critically important, step. Without it,
everything done before and the piece of software itself is just a collection
of files. A piece of software is a product when it is packagable and
deployable, in one click.

"Pipeline" means that there are a number of elements chained consequentially,
for example, for a Java application:

 * run automated build (the same as in continuous integration)
 * package JAR file
 * upload JAR file to repository
 * build JavaDoc site
 * upload JavaDoc site to Amazon S3

I'm using [Rultor]({% pst 2014/jul/2014-07-24-rultor-automated-merging %}) to
automate the entire pipeline and simplify its start, stop, and logging. I just
post a "please release now" message to a Github ticket and the product
is packaged and deployed in a few minutes.

## Acceptance

The last step is the hand-off &mdash; I have to present my solution to the
project manager, the sponsor of the project and the team. Everybody has
to accept it. It doesn't mean they will like it, and it's not the goal. The
goal is to delivery a complete solution, with risks, assumptions, decisions
documented, continuous integration configured, static analysis enforced, etc.
If my solution won't be good enough for their criteria, they will change
the architect and try again.

My objective is **not** to satisfy them, but to do the best I can according
to the requirements and my professional understanding of problem and
business domains. I wrote about it some time ago:
[A Happy Boss Is a False Objective]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %}).
Again, my objective is not to make them happy. Instead, my objective is to make
a perfect prototype, the way I understand the word **perfect**. If I fail,
I fail. The project will get another architect and try again.

That's it. The skeleton is ready, my job is done.
