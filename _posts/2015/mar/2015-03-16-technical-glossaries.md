---
layout: post
title: "Worst Technical Specifications Have No Glossaries"
date: 2015-03-16
tags: requirements
description: |
  A good technical specification is built around a good
  glossary that plays the role of skeleton for the entire
  project documentation.
keywords:
  - glossary
  - technical glossary
  - technical vocabulary
  - glossary of technical terms
  - how to write good specification
image: /images/2015/03/pulp-fiction.jpg
jb_picture:
  caption: Pulp Fiction (1994) by Quentin Tarantino
---

I read a few technical
[specifications]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %}) every week from our current
and potential
[clients]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %}),
and there's one thing I can't take anymore;
I have to write about it: 99 percent of the documents I'm reading don't
have glossaries, and because of that, they are very difficult to read
and digest. Even when they do have glossaries, their definitions
of terms are very vague and ambiguous. Why is this happening? Don't we
understand the importance of a common vocabulary for any software project?
I'm not sure what the causes are, but this is what a software
architect should do when he or she starts a project---create
a glossary.

<!--more-->

{% jb_picture_body %}

I'm trying to write something unique about this subject, but
everything I can say is so obvious that I doubt anyone
would be interested in reading it. Anyway, I will try.

{% quote A detailed and accurate glossary saves a reader a lot of time %}

A glossary (a.k.a. vocabulary) is a list of terms used by the project
that is usually included at the beginning of the technical specification document.
Ideally, every technical term used in the document should be
briefly explained in the glossary. The existence of a glossary helps
everyone who works with the document quickly understand each other
and avoid misconceptions. On top of this, a detailed and accurate glossary
saves a reader a lot of time.

So why are glossaries not written? I see a few possible causes
(usually, they are combined):

**We're Smarter Than This**.
Some people think glossaries are for newbies. After all, why would I
explain what a PDU is? Any serious network engineer should
understand that it stands for "protocol data unit." If you don't understand it,
do your homework and then come back to work with us. Our team only works
with well-educated engineers. You're supposed to understand what PDU,
ADC, TxR, IPv6, DPI, FIFO, and USSR (joking!) stand for. Otherwise,
you're not talented enough to be with us. Needless to say, this
attitude can only come from those who have no idea what they are doing.
A good engineer always remembers that if the receiver doesn't understand
a message, it's the sender's fault.

**We Don't Need These Formalities**.
Seriously, why would we spend time on writing a glossary if everybody
understands all our terms without it? We've been working as a team for a few
years, so we all know what DPI and FIFO are, and we know what "record" and
"timing data" are. Why bother with the glossary, which will provide no
additional business value for us? I've seen many technical meetings of very
mature and "well-organized" teams burn hours of time on pointless discussions
simply because of different understandings the same term.
A glossary is not a formality; it's a key instrument of a software architect
and all other team members.

{% quote A good engineer always remembers that if the receiver doesn't understand a message, it's the sender's fault. %}

**We Prefer Working Software Over Comprehensive Documentation**.
This is what the [Agile Manifesto]({% pst 2016/jul/2016-07-11-mistakes-in-agile-manifesto %})
says, and it's true. But the key word here is
"comprehensive." We don't need comprehensive documentation, but we need
a glossary. It's a key element in any project, and it simply can't
be replaced by working software. No working software can help us
understand what "header" and "data signal" are unless there
is a simple and clear statement about it.

**We Don't Have Time**.
We're developing too fast and brainstorming every day, so the concept
is frequently changing. We simply don't have time to document our
thoughts. We all understand each other, and that is the beauty of being agile.
No, that is not a beauty. Instead, it is a lack of discipline
and elementary management skill.
A lack of a glossary is a personal fault of the software architect, and there
are no excuses for it.

**All Our Terms Are Well-Known to Everyone**.
Seriously, do we need to document what TCP/IP and FIFO are? That's
what they teach us in school. Everyone understands that, don't they? Yes,
some of the terms are well-known. But what is the problem of adding them
to the glossary with a few words and a link to a Wikipedia article? This
will only take a few minutes of an architect's time, but it will make life easier
for everybody in the project, both now and in a few years from now.

To conclude, there is no excuse for the absence of a glossary in any
software project. And it is the personal responsibility of a software
architect to keep this document (or a chapter) up to date.

Hope I wasn't too obvious above :)
