---
layout: post
title: "Wikipedia Is Wrong With Its Definition Of A Software Bug"
date: 2015-06-11
tags: testing
description:
  Wikipedia defines a software bug in a functional
  and behavioral way, ignoring maintainability and
  reusability issues, which are very important too.
keywords:
  - software bug
  - software defect
  - what is software bug
  - bugs in software
  - software defects
---

Here is what [Wikipedia says](https://en.wikipedia.org/wiki/Software_bug)
at the time of writing this:

> A software bug is an error, flaw, failure, or fault
in a computer program or system that causes it
to produce an incorrect or unexpected result, or
to behave in unintended ways.

I think it's not complete. This definition entirely excludes "non-behavioral"
defects, related to, for example, **maintainability** and **reusability**.

<!--more-->

As you know, each software has [functional](https://en.wikipedia.org/wiki/Functional_requirement)
and [non-functional](https://en.wikipedia.org/wiki/Non-functional_requirement)
requirements.
Functional requirements tell us _what_ the software has to do and non-functional
document _how_ it has to do it. For example, here is a functional
requirement:

{% highlight text %}
The user can generate a PDF report.
{% endhighlight %}

If our software doesn't generate a PDF report and crashes instead &mdash;
it's a "functional" bug. If instead of PDF report it generates an empty
page or a plain text document &mdash; it's a functional bug. If there
is no "generate PDF report" button at all and the user simply can't start
the PDF generation process &mdash; it's a functional bug.

Here is an example of a non-functional requirement:

{% highlight text %}
PDF report generation must take less than 100ms.
{% endhighlight %}

If our software generates a perfectly correct PDF report, but it
takes a minute &mdash; it's a non-functional bug.

So far so good, since bug definition given by Wikipedia perfectly
covers both of them &mdash; if happened, they will cause our software
"to _produce_ an incorrect or unexpected result, or to _behave_ in unintended way."
The emphasize here is on words "produce" and "behave". They presume
that the software is doing something and we're observing its behavior.

However, that's not all of it.

What about maintainability? I may have this kind of non-functional requirement:

{% highlight text %}
The source code of PDF generator must be
easy to maintain and extend for an average
Java programmer.
{% endhighlight %}

It is a rather vague requirement, but you get the idea.

Maintainability and reusability are very critical non-functional components
of any modern software, especially taking into account a very high
cost of labor on the market. Very often, it's more important to make sure
the software is maintainable than fast. If it's maintainable and slow, we
can find new programmers and they will _improve_ the code. If it is fast
and unmaintainable, we won't be able to do anything with it later and will
have to _rewrite_ it from scratch if some new feature will be required.
More about this in
[Are You a Hacker or a Designer?]({% pst 2014/oct/2014-10-26-hacker-vs-programmer-mentality %}).

The definition of a software bug, given by Wikipedia, doesn't cover
maintainability and reusability flaws at all.
That's where a common confusion comes from &mdash;
an inconsistent code style is not a bug (see the discussion under
[this post]({% pst 2014/aug/2014-08-13-strict-code-quality-control %})).

That is wrong.

An incosistent code style **is** a software bug, as well as incomplete documentation,
lack of documentation, too high code complexity, lack of coding style guide,
etc.

I would rewrite the software bug definition paragraph in Wikipedia like this:

> A software bug is an error, flaw, failure, or fault
in a computer program or system that causes it
to violate at least one of its functional or
non-functional requirements.

This definition looks more correct to me.
