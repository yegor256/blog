---
layout: post
title: "Convince Me!"
date: 2016-07-20
place: Palo Alto, CA
tags: management
description: |
  A software architect must be a technical dictator
  in the project, who doesn't convince anyone but
  does what he/she wants
keywords:
  - role of software architect
  - who is software architect
  - responsibility of software architect
  - software project
  - roles in software
---

I've already explained how I understand
the [role]({% pst 2014/oct/2014-10-12-who-is-software-architect %})
of a software architect and
the [responsibilities]({% pst 2015/may/2015-05-11-software-architect-responsibilities %}).
But one question still remains unanswered and it often turns into a problem
in our projects &mdash; what does a software architect do when project
sponsor doesn't like his technical decisions? The architect implements
something in a certain way and the sponsor (or their representative) says
that it's not exactly how things should work. What's next?

<!--more-->

In our projects a Product Owner (PO) is usually a representative of
a project sponsor (the paying customer). Since all our projects are rather
complex Java software packages, POs are very technical people. They
are programmers or used to be programmers. They understand the code
we write and they want their opinion to be taken into account and
respected.

And I'm not talking about [stupid]({% pst 2015/jan/2015-01-05-how-to-be-honest-and-keep-customer %})
product owners &mdash; that guys are a separate story. I'm talking about a pretty
reasonable PO, with his own technical opinion that needs to be heard.

Here is a practical example. Last week I was
[starting]({% pst 2015/aug/2015-08-04-nine-steps-start-software-project %}) a project.
I was an architect. It was a Java server-side module. I decided to use
Maven as a build automation system.

I created some initial files, configured `pom.xml`, briefly explained
project structure in `README.md` and submitted a pull request. Chris, the product
owner, reviewed it and said &mdash; "why not Gradle?"

It was a reasonable question, right? Gradle is another popular build
automation system, which I could have been used, but I haven't. The question
is why. The question was pretty innocent and I explained right there,
in my comment to the pull request. I said that Maven was more suitable in
this project, because... blah-blah-blah.

But Chris argued back. He was still thinking that Gradle is a better choice.
He had his reasons. I tried to **convience** him. Tried a few times
and then realized that I'm doing something wrong. It shouldn't work like that.

A software architect should not convince a product owner, a customer or anybody
else. Instead, an architect must make his decisions and be responsible for the
entire success or failure of the product, just like I
[explained before]({% pst 2014/oct/2014-10-12-who-is-software-architect %}).

There is a simple reason for that. Any attempt to convince anyone
causes a possibility of "responsibility leakage". What if I fail to convince?
I will have to change my decision and use Gradle, right? What if the product
will have problems because of that decision. I will try to blame Chris for that,
right? I can't be **fully** responsible for the product any more, since I was
"forced" to make at least one decision.

Don't get me wrong, a good architect must collect different opinions before
making his own decision. But collecting Chris's opinion would look very
different. I would ask him first what does he think about Maven and Gradle.
He would tell me that he doesn't like Maven because of this and that. And I
would take that into account. Or maybe not. But my decision would still be
mine, made by myself, under no influence of anybody. And Chris would still
be able to blame me for all negative consequences of that decision.

But what Chris should do if he really doesn't like my decision? It's his
money and his product, right? He does care. And he doesn't want to have
Maven in **his** product. What does he do? How can he influence my
decision making process?

It's easy. There are two documents in each software project. The first one is
**requirements**, the second one is **architecture**. Chris should use them both
to correct me and point me to the right direction. Here is how.

First, if he really doesn't want to have Maven,
he should make changes to the requirements document. He should
add something like "the build system must be Gradle, because..."
Or maybe even without the "because" part. It's up to him.
But in that case, I will have to take that into account and I will.
I will know that my design decisions are dictated by the requirement.
Not because Chris convinced me or I failed to convince him, but because
that's what the document says.

Second, if he is not entirely sure that Gradle is the right choice
and just wants me to be more serious about my decisions, he should
complain (by submitting a bug) about the quality of my
[architecture document]({% pst 2015/aug/2015-08-04-nine-steps-start-software-project %}).
He should say that the choice of Maven is not explained
properly. I will re-think my decision and will either change
it or expain better. But, again, I will do it not in order to please
Chris, but in order to fix a reported bug.

To summarize, an architect must be an absolute technical **dictator**
in the project and must not convince anyone. If that's not the case,
the entire project is at a big risk. Simply because the responsibility
will is "leaking".
