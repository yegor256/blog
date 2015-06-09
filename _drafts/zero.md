---
layout: post
title: "Good Programmers Write Bug-Free Code, Aren't They?"
date: 2015-06-12
tags: agile mgmt
description:
  It's a very common misconception that
keywords:
  - zero-bug
  - bug-free programmers
  - good programmers
  - bad programmers
  - zero-bug programmers
---

Good programmers make less bugs, while bad programmers make more. Sounds
logical, isn't it? However, there is a lot of criticism of this way of
thinking. For example this one &mdash; bugs are inevitable and
instead of expecting less bugs from us, let us focus on the right design
and let testers find and report bugs, we'll fix them. Or this one &mdash;
being afraid to make a mistake makes me write slower and experiment less,
which turns into lower quality of the entire software. More about it, for example,
[here](http://programmers.stackexchange.com/questions/41248) and
[here](http://www.joelonsoftware.com/articles/fog0000000067.html).
But let me look at this from a different perspective and claim
that, yes, indeed, good programmers make _less_ bugs.

<!--more-->

I think that it's all about how we define _quality_ and what is a _bug_.

If we look at a traditional and very "intuitive" definition of a bug,
it is something that causes our software to produce an incorrect
or unexpected result. However, if we think more about how the
software is actually used and by who, we'll see that there are many other
types of bugs, including scalability, reliability and even
maintainability ones.

If we put all those "-ilities" in a list and prioritize them by
their severity and importance for the business, we'll see that
functionality-related bugs are rather far from the top.
I would actually put [maintainabilty]({% pst 2014/oct/2014-10-26-hacker-vs-programmer-mentality %})
at the top.

My point is that mistakes are not all equal. If I'm writing a PDF report
generating piece of Java code and my reports miss the footer &mdash; it's one
type of bug and its fixing will cost X amount of dollars, for the business.
On the other hand, if my PDF generating code is so difficult to modify that
in order to change its format from [A4](http://en.wikipedia.org/wiki/Paper_size) to
[US Letter](http://en.wikipedia.org/wiki/Letter_%28paper_size%29) we have
to re-write it from scratch &mdash; it's a completely different type of bug.
Needless to say that its fixing will be many times more expensive.

So, yes, mistakes are inevitable. We should not be afraid of them and
be ready to make them. However, good programmers are making **cheaper** mistakes
in order not to make more expensive ones.

Good programmers understand that in a limited amount of time we usually
have to implement the software, we have to sacrifice functionality
in order to gain maintainability. Ideally, you want to gain both, but
in reality it's next to impossible.

We all work under pressure and we have time and money constraints. In these
constraints, good programmers prefer to make functionality buggy and incomplete,
but keep the design clean and easy to maintain. Of course, there are
exceptions, where the business prioritizes functionality above everything else,
but such situations happen very rarely (if the business is smart enough).

To summarize, I think that a good programmer is making more
functional bugs than a bad programmer, while bugs made by a bad programmer
are more expensive than bugs made by a good programmer.
