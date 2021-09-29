---
layout: post
title: "Two Instruments of a Software Architect"
date: 2015-05-13
tags: architect
description: |
  A software architect controls a software project through
  two fundamental instruments - bugs and reviews.
keywords:
  - software architect
  - software architect job description
  - software architect responsibilities
  - software architect vs developer
  - software architect vs engineer
image: /images/2015/05/rear-window.jpg
jb_picture:
  caption: Rear Window (1954) by Alfred Hitchcock
---

A [software architect]({% pst 2014/oct/2014-10-12-who-is-software-architect %})
is a key person in any software project, no matter how big or small it is.
An architect is personally responsible for the technical outcome of
the entire team. A good architect knows what needs to be done and how
it's going to be done, both architecturally and design-wise. In order to enforce
this idea in practice, an architect uses two instruments:
_bugs and reviews_.

<!--more-->

{% jb_picture_body %}

At [Zerocracy](https://www.zerocracy.com), we discourage any
[communication]({% pst 2016/aug/2016-08-23-communication-maturity %})
between developers unless they are formally attached to the tickets or tasks
we're working on. Read more details about this approach in
[this post]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %}).

{% youtube 0fuEgmibJc4 %}

The same principle applies to an architect. We don't use meetings,
stand-ups, Skype calls, IRC channels, or any other tools where information
flies in the air and stays in our heads. Instead, we put everything in writing and talk
only when we're being explicitly asked to and paid to---in tickets.

## Bugs

With this in mind, a reasonable question may be asked: How can
a software architect enforce his or her technical vision for the team
if he can't communicate with the team? Here is our answer:
the architect must use _bugs_.

{% quote Bugs reported by an architect serve as communication channels between him and the team. %}

A bug is a ticket that has a reporter, a problem, and a resolver, just
like [this post]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %}) explains.
Say an architect reviews an existing technical solution and finds
something that
[contradicts]({% pst 2015/jun/2015-06-22-valid-reasons-to-reject-bug-fix %})
his vision. When such a contradiction
is found, it is a good candidate for a bug. Sometimes there is just
not enough information in the code yet, and this is also a good candidate
for a bug.

Thus, bugs reported by an architect serve as
[communication channels]({% pst 2016/aug/2016-08-23-communication-maturity %})
between him and the team. An architect doesn't explain what needs to be done
but asks the team to fix the product in a way he thinks is right.
If the ticket resolver, a member of the team, disagrees with that approach,
a discussion starts right in the ticket.

{% youtube AvVQ5NjS_Nk %}

Sometimes an architect has doubts and needs to discuss a few possible solutions
with the team or simply collect opinions. Again, we use bugs for that.
But these bugs don't report problems in the source code; instead, they
complain about incomplete documentation. For example, say an architect
doesn't know which database to use, MongoDB or Cassandra, and needs more
information about their pros and cons. A bug will sound like "our design documentation
doesn't have a detailed comparison of existing NoSQL databases; please fix it."
Whoever is assigned to this ticket will perform the comparison
and update the documentation.

Bugs are a _proactive_ tool for an architect. Through reporting bugs,
an architect influences the project and "dictates his will."

## Reviews

In our projects, every ticket is implemented in its own branch. When
implementation is done, all tickets pass mandatory code peer review. In other
words, developers review each others' code. An architect is not involved
in this process.

{% quote Through strict and non-compromising code reviews, an architect enforces his design and architectural principles. %}

But when peer review is done, each ticket goes to an architect and he
has to give a final "OK" before the code goes to the `master` branch through
Rultor, our [merge bot]({% pst 2014/jul/2014-07-24-rultor-automated-merging %}).

This is an architect's opportunity for control. This is where he can
prevent his vision from being destroyed. When the code created by a developer
violates project design principles or any part of the entire technical idea,
the architect says "No" and the branch is rejected.

Reviews are a _reactive_ instrument for an architect. Through strict and
non-compromising code reviews, an architect enforces his design and architectural
principles.

PS. Here is how an architect is supposed to report to the
[project manager]({% pst 2015/sep/2015-09-22-micromanagement %}):
[Three Things I Expect From a Software Architect]({% pst 2015/may/2015-05-11-software-architect-responsibilities %})
