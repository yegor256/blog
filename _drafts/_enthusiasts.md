---
layout: post
title: "Hazardous Enthusiasm"
date: 2019-01-01
place: Moscow, Russia
tags: mood
description: |
  Being enthusiastic about the software project is not
  enough to be usefull and helpful; in some cases
  enthusiasm only hurts.
keywords:
  - enthusiasm
  - software enthusiasm
  - good will in software
  - good intention
  - risks in software
image: /images/2019/01/
jb_picture:
  caption:
---

On a daily basis I deal with many programmers that contribute to my
[open source]({% pst 2017/may/2017-05-30-why-contribute-to-open-source %})
projects, either voluntarily or for money via [Zerocracy](https://www.zerocracy.com)
(and my software projects are [all]({% pst 2015/dec/2015-12-22-why-dont-you-contribute-to-open-source %})
open source). Over the years I realized
that there is a pattern in their behavior, which I have to be <del>scared</del> aware of.
I call it "hazardous enthusiams." Here are the symptoms.

<!--more-->

{% jb_picture_body %}

A new developer joins the project. He is full of energy,
talks a lot, spends a lot of time for the project, submits
new tickets, and suggests improvements. He looks like a great candidate
and we all are happy to see him on board. He is a godsend!

Then, when things become clearer for him, he starts criticizing the architecture.
He [approaches]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %})
me in Telegram, asks me whether I realize the the architecture
is a total mess and that if we don't change it immediately the project will
be dead in a few <del>days</del> weeks. I attempt to assure him that I understand it,
but... He immediately suggests an improvement: We have to re-do it all from
scratch or at least get rid of that collection of objects and replace it with
a singleton and a very nice [ORM]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %})
library he's been using for a year and it
is just great, blah blah blah... OK? Let's do it? Why not?

{% youtube gMJNz9AWbQE %}

I have very little to say and ask him to submit a ticket. I try to assure him
that I will investigate the possibilities as soon as possible. I'm also trying
to remind him, in a very polite way, that I'm an
[architect]({% pst 2014/oct/2014-10-12-who-is-software-architect %}) here and, even though,
his ideas sound great, can't be accepted them all at once.
Then he goes: "Let me show you!"

In a few days I'm getting a giant pull request, with a lot of changes,
which look interesting, but go absolutely against almost every principle
I managed to embed into the existing architecture. What do I do? I feel sorry
for him. I have to reject the pull request and I'm trying to explain him why.
However, there is no reasonable explanation. I'm just a bad guy who doesn't like
innovative ideas.

What happens next? He disappears.

I've seen this happening many times, with different people. Were they all
incompetent programmers? I don't think so. They were great, technical wise.
But they all lacked the very important skill, which, I believe, distinguishes
a professional software engineer from a guy who learned how to write Java code:
[microtasking]({% pst 2017/nov/2017-11-28-microtasking %}).

They simply don't know how to break their changes, which in most cases are
not so useless, into smaller pieces and delivery them incrementally. They want to
push everything they have in mind in one large chunk. Of course,
they fail, because there is a bad guy in front of them: me, the architect.

What makes their cases fatal is the enthusiasm. If they would be less
agressive and eager to do the right thing, they would survive. But they can't
wait and they don't want to apply half-measures. They want to fix the world
in one huge pull request.

Why can't I just accept their changes and let them fix the code the way
they want, you may ask? Because I know that even though they may look like
good programmers, they would be lousy architects, exactly because they lack
the skill of [microtasking]({% pst 2017/nov/2017-11-28-microtasking %}).
If I accept what they suggest, I will simply transfer
my architect's [responsibilities]({% pst 2015/may/2015-05-11-software-architect-responsibilities %})
to them. It will be their architecture from
now on. What's wrong with that? Their lack of that skill. They won't be able
to be architects, because they can't manage changes, can't delivery them incrementally,
can't understand the dynamics of collaborative work with the source code.

They are [hackers]({% pst 2014/oct/2014-10-26-hacker-vs-programmer-mentality %}),
not designers or [architects]({% pst 2018/jun/2018-06-26-are-you-an-architect %}).

Honestly, I feel sorry when I lose them.


