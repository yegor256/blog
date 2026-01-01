---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Wikipedia's Definition of a Software Bug Is Wrong"
date: 2015-06-11
tags: testing
categories: jcg
description: |
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
at the time of this writing:

> A software bug is an error, flaw, failure, or fault
in a computer program or system that causes it
to produce an incorrect or unexpected result or
to behave in unintended ways.

I think that's incomplete. The definition entirely excludes "non-behavioral"
defects related to, for example, _maintainability_ and _reusability_.

<!--more-->

As you know, every piece of software has [functional](https://en.wikipedia.org/wiki/Functional_requirement)
and [non-functional](https://en.wikipedia.org/wiki/Non-functional_requirement)
requirements.
Functional requirements tell us _what_ the software has to do, and non-functional
requirements document _how_ it has to do it. For example, here is a functional
requirement:

```text
The user can generate a PDF report.
```

If our software doesn't generate a PDF report and crashes instead,
that's a functional bug. If instead of a PDF report, it generates an empty
page or a plain text document, that's a functional bug. If there
is no "generate PDF report" button at all and the user simply can't start
the PDF generation process, that's a functional bug.

Here is an example of a non-functional requirement:

```text
PDF report generation must take less than 100ms.
```

If our software generates a perfectly correct PDF report but it
takes a minute, that's a non-functional bug.

So far so good, since the bug definition given by Wikipedia perfectly
covers both of them---if they happen, they will cause our software
"to _produce_ an incorrect or unexpected result or to _behave_ in an unintended way."
The emphasis here is on the words "produce" and "behave." They presume
the software is doing something and we're observing its behavior.

However, that's not all of it.

What about maintainability? I may have this kind of non-functional requirement:

```text
The source code of the PDF generator must be
easy to maintain and extend for an average
Java programmer.
```

It's a rather vague requirement, but you get the idea.

Maintainability and reusability are very critical non-functional components
of any modern software program, especially taking into account a very high
cost of labor in the market. Very often, it's more important to make sure
the software is maintainable than fast. If it's maintainable and slow, we
can find new programmers to _improve_ the code. If it is fast
but unmaintainable, we won't be able to do anything with it later and will
have to _rewrite_ it from scratch if some new feature is required.
Read more about this in
[Are You a Hacker or a Designer?]({% pst 2014/oct/2014-10-26-hacker-vs-programmer-mentality %}).

The definition of a software bug given by Wikipedia doesn't cover
maintainability and reusability flaws at all.
That makes for a common source of confusion---an inconsistent code style is not a bug (see the discussion under
[this post]({% pst 2014/aug/2014-08-13-strict-code-quality-control %})).

That is wrong.

An inconsistent code style _is_ a software bug, as is incomplete documentation,
lack of documentation, code that's too complex, the lack of a coding style guide,
etc.

I would rewrite the software bug definition paragraph in Wikipedia like this:

> A software bug is an error, flaw, failure, or fault
in a computer program or system that causes it
to violate at least one of its functional or
non-functional requirements.

This definition looks more accurate to me.
