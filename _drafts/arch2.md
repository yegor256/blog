---
layout: post
title: "Two Instruments Of a Software Architect"
date: 2015-05-15
tags: mgmt agile
description:
  A software architect controls a software project through
  two fundamental instruments: bugs and reviews.
keywords:
  - software architect
  - software architect job description
  - software architect responsibilities
  - software architect vs developer
  - software architect vs engineer
---

A [software architect]({% pst 2014/oct/2014-10-14-who-is-software-architect %})
is a key person in any software project, no matter how big or small it is.
An architect is personally responsible for the technical outcome of
the entire team. A good architect knows what needs to be done and how
it's going to be done, architecture and design wise. In order to enforce
this idea in practice, an architect uses two instruments &mdash;
**bugs and reviews**.

<!--more-->

In [Teamed.io](http://www.teamed.io) we discourage any communications
between developers, unless they are formally attached to the tickets/tasks
we're working on. Read more details about this approach in
[this post]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %}).

The same principle applies to an architect. We don't use meetings,
stand-ups, Skype calls, IRC channels, or any other tools where information
fly in the air and stays in our heads. Instead, we put everything in writing and talk
only when we're being explicitly asked to and paid for &mdash; in tickets.

## Bugs

Having this in mind, a reasonable question may be asked &mdash; how can
a software architect enforce his or her technical vision to the team
if he can't communicate with the team? Here is our answer &mdash;
the architect must use **bugs**.

A bug is a ticket that has a reporter, a problem and a resolver, just
like [this post]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %}) explains.
An architect reviews an existing technical solution and finds
something that contradicts with his vision. When such a contradiction
is found, it is a good candidate for a bug. Sometimes there is just
not enough information in the code yet and this is also a good candidate
for a bug.

Thus, bugs reported by an architect serve as communication channels
between him and the team. An architect doesn't explain what needs to be done,
but asks the team to fix the product in a way he thinks is right.
If ticket resolver, a member of the team, disagrees with that approach,
a discussion starts right in the ticket.

Sometimes an architect have doubts and needs to discuss a few possible solutions
with the team or simply collect opinions. Again, we use bugs for that.
But these bugs don't report problems in the source code, but instead
complain about incomplete documentation. For example, an architect
doesn't know which database to use, MongoDB or Cassandra, and needs more
information about their pros and cons. A bug will sound like "our design documentation
doesn't have a detailed comparison of existing NoSQL databases, please fix it".
Whoever will be assigned to this ticket will perform the comparison
analysis and update the documentation.

Bugs is a _pro-active_ tool of an architect. Through reporting bugs
an architect influences the project and "dictates his will".

## Reviews

In our projects every ticket is implemented in its own branch. When
implementation is done, all tickets pass mandatory code peer review. In other
words, developers review each others code. An architect is not involved
in this process.

But, when peer review is done, each ticket comes to an architect and he
has to give a final "OK" before the code goes to `master` branch, through
Rultor, our [merge bot]({% pst 2014/jul/2014-07-24-rultor-automated-merging %}).

This is the moment of control for an architect. This is where he can
prevent his vision from being destroyed. When the code created by a developer
violates project design principles or any part of the entire technical idea &mdash;
the architect says "No" and the branch is rejected.

Reviews is a _re-active_ instrument of an architect. Through strict and
non-compromise code reviews an architect enforces his design and architecture
principles.
