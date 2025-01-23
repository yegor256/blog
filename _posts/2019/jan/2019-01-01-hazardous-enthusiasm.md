---
layout: post
title: "Hazardous Enthusiasm"
date: 2019-01-01
place: Moscow, Russia
tags: mood
description: |
  Being enthusiastic about a software project is not
  enough to be useful and helpful; in some cases
  enthusiasm only hurts.
keywords:
  - enthusiasm
  - software enthusiasm
  - good will in software
  - good intention
  - risks in software
image: /images/2019/01/the-thin-red-line.jpg
jb_picture:
  caption: The Thin Red Line (1998) by Terrence Malick
---

On a daily basis I deal with many programmers who contribute to my
[open source]({% pst 2017/may/2017-05-30-why-contribute-to-open-source %})
projects, either as volunteers or for money via [Zerocracy](https://www.zerocracy.com)
(and my software projects are [all]({% pst 2015/dec/2015-12-22-why-dont-you-contribute-to-open-source %})
open source). Over the years I have realized
that there is a pattern in their behavior, which I need to be ~~scared~~ aware of.
I call it "hazardous enthusiasm." Here are the symptoms.

<!--more-->

{% jb_picture_body %}

A new developer joins the project. He is full of energy,
talks a lot, spends a lot of time on the project, submits
new tickets, and suggests improvements. He looks like a great candidate
and we all are happy to see him on board. He is a godsend!

Then, when things become clearer for him, he starts criticizing the architecture.
He [approaches]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %})
me in Telegram and asks me whether I realize that the architecture
is a total mess and that if we don't change it immediately the project will
be dead in a few ~~days~~ weeks. I attempt to assure him that I understand,
but... He immediately suggests an improvement: We have to re-do it all from
scratch or at least get rid of that collection of objects and replace it with
a singleton and a very nice [ORM]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %})
library he's been using for a year, and it's
just great, blah blah blah... OK? Let's do it? Why not?

{% youtube gMJNz9AWbQE %}

I have very little to say and instead ask him to submit a ticket. I try to assure him
that I will investigate the possibilities as soon as I can. I also try
to remind him, in a very polite way, that I'm an
[architect]({% pst 2014/oct/2014-10-12-who-is-software-architect %}) here and, even though
his ideas sound great, I can't accept them all at once.
Then he goes: "Let me show you!"

In a few days I get a giant pull request with a lot of changes
that look interesting but that go completely against almost every principle
I've managed to embed into the existing architecture. What do I do? I feel sorry
for him. I have to reject the pull request and I try to explain why.
But there is no reasonable explanation. I'm just a bad guy who doesn't like
innovative ideas.

What happens next? Well, he disappears.

I've seen this happen many times, with various people. Were they all
incompetent programmers? I don't think so. They were great, from a technical point of view.
But they all lacked the very important skill which, I believe, distinguishes
a professional software engineer from a guy who merely learned how to write Java code:
[microtasking]({% pst 2017/nov/2017-11-28-microtasking %}).

{% quote They simply don’t know how to break their changes into smaller pieces and deliver them incrementally. %}

They simply don't know how to break their changes, which in most cases are
by no means useless, into smaller pieces and deliver them incrementally. They want to
push everything they have in mind in one large chunk. Of course,
they fail. Because there is a bad guy in front of them: me, the architect.

What makes their cases fatal is the enthusiasm. If they were less
aggressive and eager to do the right thing, they would survive. But they can't
wait and they don't want to apply half-measures. They want to fix the world
in one huge pull request.

Why can't I just accept their changes and let them fix the code the way
they want, you may ask? Because I know that even though they may look like
good programmers, they would be lousy architects, exactly because they lack
the skill of [microtasking]({% pst 2017/nov/2017-11-28-microtasking %}).
If I accept what they suggest, I will simply transfer
my architect's [responsibilities]({% pst 2015/may/2015-05-11-software-architect-responsibilities %})
to them. It will be their architecture from
now on. And what's wrong with that? Well, their lack of that skill. They won't be able
to be architects, because they can't manage changes, can't deliver them incrementally,
and can't understand the dynamics of collaborative work with the source code.

They are [hackers]({% pst 2014/oct/2014-10-26-hacker-vs-programmer-mentality %}),
not designers or [architects]({% pst 2018/jun/2018-06-26-are-you-an-architect %}).

Honestly, I feel sorry when I lose them.
