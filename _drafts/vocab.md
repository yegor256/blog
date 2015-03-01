---
layout: post
title: "Worst Technical Specifications Have No Glossaries"
date: 2015-03-06
tags: mgmt agile
description:
  A good technical specification is built around a good
  glossary that plays a role of a skeleton in the entire
  project documentation
keywords:
  - glossary
  - technical glossary
  - technical vocabulary
  - glossary of technical terms
  - how to write good specification
---

I'm reading a few technical specifications every week, coming
from our current of potential clients. I can't take this any more,
I have to write about it &mdash; 99% of the documents I'm reading don't
have glossaries and because of that are very difficult to read
and digest. And even when they have glossaries, their definition
of terms are very vague and ambiguous. Why it's happening? Don't we
understand the importance of a common vocabulary in any software project?
I'm not sure what are the causes, but this is what a software
architect should do when he or she starts a project &mdash; create
a Glossary.

<!--more-->

I'm trying to write something unique about this subject but
everything I can say is so obvious that I'm in doubt whether anyone
would be interested read this. Anyway, I will try.

So, a Glossary (aka vocabulary) is a list of terms used by the project
that usually stays at the beginning of the technical specification document.
Ideally, every technical term used in the document should be
briefly explained in the Glossary. The existence of Glossary helps
everybody who works with the document to understand each other faster
and avoid misconceptions. On top of this, a detailed and accurate Glossary
saves a lot of readers' time.

So, why glossaries are not written? I see a few possible causes
(usually, they are combined):

**We're Smarter Than This**.
Some people think that glossaries are for newbies. Of course,
why would I explain what is PDU? Any serious network engineer should
understand that it stands for "protocol data unit". If you don't understand it,
do your home work and then come back to work with us. Our team works only
with well educated engineers. You're supposed to understand what PDU,
ADC, TxR, IPv6, DPI, FIFO and USSR (a joke!) stand for. Otherwise,
you're not talented enough to be with us. Needless to say that this
attitude can come only from those who have no idea what they are doing.
A good engineer always remembers that if a receiver doesn't understand
a message, it's a fault of a sender.

**We Don't Need These Formalities**.
Seriously, why would we spend time on writing that Glossary if everybody
understands all our terms without it? We're working in the team for a few
years, we all know what is DPI and FIFO, we know what is "record" and what
is "timing data". Why bothering with the Glossary, which will give no
extra business value to us? I've seen many technical meetings, in very
mature and "well-organized" teams, burned hours of pointless discussions
simply because of different understandings of one and the same term.
Glossary is not a formality, it's a key instrument of a software architect
and all other team members.

**Working Software Over Comprehensive Documentation**.
This is what Agile Manifesto says. And it's true. But the key word here is
"comprehensive". We don't need a comprehensive documentation, but we need
a Glossary. It's a key element in any project and it simply can't
be replaced by a working software. No working software can help us
to understand what is "header" and what is a "data signal", unless there
is a simple and clear document about it.

**We Don't Have Time**.
We're developing too fast, we're brainstorming every day, the concept
is changing very frequently. We simply don't have time to document our
thoughts. We all understand each other and that is the beauty of agile.
No, this is not the beauty. Instead, it is a lack of discipline
and elementary management skills.
Lack of Glossary is a personal fault of a software architect and it
may not have any excuses.

**All Terms Are Well Known to Anyone**.
Seriously, do we need to document what is TCP/IP and what is FIFO? That's
what they teach us in schools. Anyone understands that, isn't it? Yes,
some of the terms are well-known. But what is the problem of adding them
to the glossary with a few words and a link to a Wikipedia article? This
will take a few minutes of an architect's time, but will make life easier
to everybody in the project, now and in a few years from now.

To conclude, there is no excuse for an absence of Glossary in any
software project. And it is a personal responsibility of a software
architect to keep this document (or a chapter) up to date.

Hope I wasn't too obvious above :)
