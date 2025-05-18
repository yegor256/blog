---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Convince Me!"
date: 2016-07-21
place: Palo Alto, CA
tags: management architect
description: |
  During a project, a software architect must be a technical dictator
  who doesn't convince anyone but rather
  does what he or she wants.
keywords:
  - role of software architect
  - who is software architect
  - responsibility of software architect
  - software project
  - roles in software
image: /images/2016/07/beasts-of-no-nation.jpg
jb_picture:
  caption: Beasts of No Nation (2015) by Cary Joji Fukunaga
---

I've already explained how I understand
the [role]({% pst 2014/oct/2014-10-12-who-is-software-architect %})
and [responsibilities]({% pst 2015/may/2015-05-11-software-architect-responsibilities %})
of a software architect.
But one question still remains unanswered, and it often turns into a problem
in our projects: What does a software architect do when the project
sponsor doesn't like his technical decisions? The architect implements
something in a certain way, and the sponsor (or its representative) says
that it's not exactly how things should work. What's next?

<!--more-->

{% jb_picture_body %}

In [our projects]({% pst 2016/jul/2016-07-10-software-project-roles %}),
a product owner (PO) is usually a representative of
a project sponsor (the paying customer). Since all our projects are rather
complex Java software packages, POs are very technical people. They
are programmers or used to be programmers. They understand the code
we write, and they want their opinion to be taken into account and
respected.

And I'm not talking about [stupid]({% pst 2015/jan/2015-01-05-how-to-be-honest-and-keep-customer %})
product owners---those guys are a separate story. I'm talking about a pretty
reasonable PO with his own technical opinion that needs to be heard.

Here is a practical example. Last week, I was
[starting]({% pst 2015/aug/2015-08-04-nine-steps-start-software-project %}) a project.
I was an architect. It was a Java server-side module. I decided to use
Maven as a build automation system.

I created some initial files, configured `pom.xml`, briefly explained the
project structure in `README.md`, and submitted a pull request. Chris, the product
owner, reviewed it and asked, "Why not Gradle?"

It was a reasonable question, right? Gradle is another popular build
automation system that I could have used, but I didn't. The question
is why. It was a pretty innocent question, and I explained the answer right there
in my comment to the pull request. I said Maven was more suitable in
this project because ... blah blah blah.

But Chris argued back. He was still thinking Gradle was the better choice.
He had his reasons. Meanwhile, I tried to _convince_ him of mine. I tried a few times
and then realized I was doing something wrong. It shouldn't work like that.

A software architect should not convince a product owner, a customer, or anybody
else. Instead, an architect must make his decisions and be responsible for the
entire success or failure of the product, just like I
[explained before]({% pst 2014/oct/2014-10-12-who-is-software-architect %}).

{% quote A good architect must collect different opinions before making his own decision. %}

There is a simple reason for that. Any attempt to convince anyone
causes a possibility of "responsibility leakage." What if I fail to convince?
I will have to change my plan and use Gradle, right? What if the product
has problems because of that decision? I will try to blame Chris for that,
right? I can't be _fully_ responsible for the product anymore, because I was
"forced" to make at least one decision.

Don't get me wrong; a good architect must collect different opinions before
making his own decision. But collecting Chris's opinion would look very
different. I would ask him first what he thinks about Maven and Gradle.
He would tell me that he doesn't like Maven because of this and that. And I
would take that into account. Or maybe not. But my decision would still be
mine, made by myself, under no compulsion by anybody. And Chris would still
be able to blame me for any negative consequences of that decision.

But what should Chris do if he really doesn't like my decision? It's his
money and his product, right? He does care. And he doesn't want to have
Maven in _his_ product. What does he do? How can he influence my
decision-making process?

It's easy. There are two documents in each software project. The first one is
_requirements_, and the second one is _architecture_. Chris should use them both
to correct me and point me in the right direction. Here's how.

First, if he really doesn't want to have Maven,
he should make changes to the requirements document. He should
add something like "the build system must be Gradle, because ..."
Or maybe even without the "because" part. It's up to him.
In that case, I will have to take that into account, and I will.
I know my design decisions are dictated by the requirements.
And not because Chris convinced me or I failed to convince him, but because
that's what the document says.

{% quote An architect must be an absolute technical dictator during the project and must not have to convince anyone. %}

Second, if he is not entirely sure that Gradle is the right choice
and just wants me to be more serious about my decisions, he should
complain (by submitting a bug) about the quality of my
[architecture document]({% pst 2015/aug/2015-08-04-nine-steps-start-software-project %}).
He should say: the choice to go with Maven is not explained
properly. I will then rethink my decision and will either change
it or explain it better. But again, I will do it not to please
Chris but to fix a reported bug.

To summarize, an architect must be an absolute technical _dictator_
during the project and must not have to convince anyone. If that's not the case,
the entire project faces big risks, simply because the responsibility
will be "leaking."

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">The <a href="https://twitter.com/hashtag/architect?src=hash&amp;ref_src=twsrc%5Etfw">#architect</a> tells you to rewrite the code his way. Your response is...</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1208813613152161794?ref_src=twsrc%5Etfw">December 22, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
