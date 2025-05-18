---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Meetings Are Legalized Robbery"
date: 2015-07-13
tags: management
place: Washington, D.C.
description: |
  Meetings are very popular but very ineffective
  instruments of managing work time and creativity;
  here's why.
keywords:
  - meetings
  - meetings suck
  - why meetings suck
  - meetings in software team
  - how to organize meetings
translated:
  - Russian: https://habr.com/ru/post/445774/
image: /images/2015/07/heat.jpg
jb_picture:
  caption: Heat (1995) by Michael Mann
---

Software development is all about creativity, right? It's an art,
not a science. As software engineers, we solve complex problems,
and often our solutions are absolutely not obvious. We experiment,
innovate, research, and investigate.
To do all this, we _talk_.
We sit together in our meeting rooms, Skype conference calls, or Slack channels;
we discuss our solutions;
we ask our coworkers for their opinions;
and we argue about the best ideas. There's no doubt meetings are the key component of the modern
software design discipline ... and it's very _sad_ to see it.

<!--more-->

{% jb_picture_body %}

A good [software architect]({% pst 2014/oct/2014-10-12-who-is-software-architect %}),
as well as a [good project manager]({% pst 2015/sep/2015-09-22-micromanagement %}), doesn't need
[meetings]({% pst 2015/jan/2015-01-08-morning-standup-meetings %})
and _never_ organizes them.

{% youtube ibT5oKToMoQ %}

Meetings demotivate, waste time, burn money, and degrade quality. But more about
that later. For now, let's discuss a proposed alternative.

Say I'm an architect who needs to design the schema for a relational
database in a new project, and I have a team of five programmers whom I want
to help me with this design. That's a very logical and appropriate desire,
as a good architect always discusses all possible options with available
team members before making a [final decision]({% pst 2023/aug/2023-08-15-decision-making-process %}).
So I call a meeting? No!

## A Good Architect

I ask Jeff, one of our programmers, to create a draft of the DB schema, but I don't
actually talk to him about it. I value and respect his time---there's no need to bother him with this organizational noise, so I just create
a ticket and assign it to Jeff. When he has time, he creates a draft
and returns a pull request. I review it and make some comments before he updates
the branch, and finally
[I merge it]({% pst 2014/jul/2014-07-24-rultor-automated-merging %}).

{% youtube LB_YLWhGrco %}

Perfect; we have a draft.

At the end of the document, Jeff also listed assumptions, risks, and concerns.
For example, this is what I got back from him (it's Markdown, a very
convenient format for simple technical documents; I highly recommend it):

```text
## Tables
user (id INT, name VARCHAR, email VARCHAR);
payment (id INT, date DATETIME, amount INT);
order (id INT, details VARCHAR, user_id INT FK(user));

## Assumptions
- All payments will be in whole dollars, no cents.
- All users will have only one email.
- There will be no search feature required.

## Risks
- Order details may not fit into VARCHAR.
- Foreign keys may not be supported in the DBMS.

## Concerns
- Would NoSQL be more suitable?
- What is the DB server we'll use?
```

I don't know how much time Jeff would have spent on this document,
but I just created it in 10 minutes. Of course, it's a very simple schema
for a very simple project. But even if Jeff spent an hour
on it, every minute of that hour is valuable to the project. What I mean
is that every dollar I pay Jeff for his time is returned to me
in the form of a text document.

Now I have a draft and I'm taking the next step. I ask
Monica to take a look at it and suggest changes. Again, it's another
hour and I've got back a pull request with changes, corrections,
new assumptions, new risks, and new concerns. I'm not talking to Monica---there is no need for that. She has all the information she needs
to work with the DB schema. She is a good engineer, and I
[trust]({% pst 2017/nov/2017-11-21-trust-pay-lose %})
her ability to formulate her opinion in a written format.

There's no need to sit together in the same room or stand at a whiteboard.
Monica is smart enough to do this job by herself. She already has
all the ideas expressed by Jeff in front of her;
there is no need for her to talk to him either.

{% youtube dE0_j4Kk6jo %}

Once I merge her pull request (after a proper review and corrections),
I have a new version of my `schema.md` document.

Moreover, I have a Git history of this document, and I have a history
of pull requests with comments. This is way better than meeting notes
or even a meeting video. Anyone who joins the project later will be
able to understand how we came to the conclusion of using PostgreSQL
and storing monetary amounts without cents. It's all there in the Git history
and GitHub tickets, forever with us.

What if I need more opinions? Or if I'm still not sure the schema is good enough?
No problem; I ask someone else to review it one more time and
send me a pull request with changes.
I can even ask Jeff to do it again after a few iterations with
other programmers!

Moreover, I can add my own concerns to the document, and on the next iteration,
ask Jeff to pay attention to and resolve them.

{% quote Train and discipline yourself to work with documents and let juniors enjoy their meetings. %}

The more we circle this document, the better it becomes. And every minute
the project pays for turns into a tangible product: a _document_
with a change history!

That's how a professional architect collects opinions and
makes complex decisions. Now let's see what a bad architect would do.

## A Bad Architect

I first call a meeting. No, wait; I schedule it in Google Calendar.
No, wait, wait. First of all, I create an agenda:

```text
1. Introduction: 10 min
2. Problem: 15 min
  - We need a DB schema
  - Let's choose a server
3. Opinions: 15 min
  - Jeff and Monica have experience
  - Others?
4. Coffee break: 10 min
5. Discussion: 30 min
  - Let's not forget risks
  - Ask Joe about PostgreSQL
6. Conclusions: 10 min
```

I'm sure you know what I'm talking about and you've seen these
agendas from your "architects." Anyway, my first step is done. I've scheduled an
hour-and-a-half meeting where all programmers will be present. We'll have fun
and drink coffee. We'll discuss the problem, hear all opinions, and find
the best solution. We'll document it in that `schema.md` and
get back to our tasks.

Instead of circulating those _dry_ and _boring_ Git documents, we'll have a
real human communication with a nice coffee break where we'll share our
opinions about the last episode of The Bing Bang Theory. Isn't that what
we all like about our [office jobs]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %}) anyway?

{% youtube AwrMKTFyohg %}

I don't think so.

I think meetings demotivate, waste time, burn money, and degrade quality.
Those who organize them either have no idea what they are doing or
are silently _robbing_ the company they're working for.

We needed meetings 30 years ago when we didn't have laptops and GitHub.
But even then, we had a pen and paper.

I'm talking about meetings that are intended to collect or distribute information,
discuss or propose something, or find a solution in a _technical_ domain.
The only _valid purpose_ of meetings is to read _body language_ of the people
you are dealing with. Politicians, businessmen, poker players,
shrinks, physicians, etc.---they need meetings because they must
read our bodies, not just our thoughts.

Do we really care about Monica's body while we're designing a DB schema?
Well, that depends, right? But let's be serious; we're not paid for that.

## Meetings Demotivate

The best motivation for a creative person is to see the
[results]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %})
of his or her creativity. If I'm not mistaken, enjoying the process
of creativity without any results is an obvious
sign of mental illness. A healthy and creative person like a software
engineer, for example, wants to see how his or her efforts are turned
into something _valuable_ and, preferably, _tangible_.

Meetings almost never produce anything tangible and rarely something valuable.
Sometimes we have "minutes"
of our meetings, but they are just short pieces of paper with a brief
summary of what we were talking about. Not a real "_product_" for a
creative person.

Thus, they demotivate me because I simply don't see what
[two hours]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %})
of my life were turned into. We don't really _create_ anything there,
we just _discuss_. Pay attention here; I'm talking about meetings, not about
collaborative work on something, like in pair programming, for example.

{% quote Did Einstein invent his theory at a meeting with his colleagues? %}

You may say that some meetings actually produce great ideas, which
are very tangible results. You may say that only in a direct,
face-to-face setting could these ideas be born. You may also
say that many bright technical decisions were invented precisely due
to a magic synergy of _friends_ thinking in the same direction, at the
same time, and in the same room. This argument makes sense, but I'll address that later.

## Meetings Waste Time

I think it's obvious. For the first few minutes of the meeting, you're consentrated;
then you start checking your Twitter feed and doodling. Everybody is doing
the same---not because we're [lazy]({% pst 2018/apr/2018-04-17-how-to-be-lazy %})
but because there is _no demand_
for our full focus at the meeting.

{% youtube pt9uHp35fwM %}

While Monica is working with the document, making comments and suggestions, she is
[fully consentrated]({% pst 2015/nov/2015-11-21-ringelmann-effect-vs-agile %})
on the result---mostly because there is nobody
else to
[help]({% pst 2015/feb/2015-02-16-it-is-not-a-school %})
her. She has to deliver that pull request, and I'm waiting for her.
Her consentration is as high as it would be at the meeting, when someone
is asking her a direct question and she has to provide a detailed answer.

Her time is optimized for a suitable outcome while everybody else is doing
something else.

At the meeting, on the other hand, we're all consentrating sparingly at best. And the longer
the meeting, the slower we are. Also, the more people who are there,
the less we care and the more interested we become in our Facebook updates.
I reckon that's not much of a surprise to you if you've been in the software development
industry for at least a few months.

## Meetings Burn Money

This aligns closely with the previous conclusion. Meetings are among the biggest budget consumers
of any type of activity in a project, simply because they pay
_everybody_ who is sitting in that room or on that Skype conference while the
result they produce is almost equal to what a single person can deliver.
Or much less.

Even though this may sound extreme, I have to say that I consider meetings
a legalized way to _rob_ a project. Most meeting
organizers (architects, CTOs, CEOs, programmers, etc.) don't realize that.
They believe the more they talk, the better engineers they are. And their
bosses, by mistake, appreciate that sort of activity from their subordinates.

It's robbery!

I told you to create a draft of a DB schema. Now you're coming to me
and asking for a meeting because certain "aspects" are not clear?
Did you study software engineering anywhere? Do you know how to work
with technical documents? Are you capable of writing in a way that everybody
else can understand and respond to you, also in writing? No? Now you want
the project to not only pay you for the DB schema draft but to also
pay me for talking to you and for a few other guys to sit next to us and text
their friends? You basically want to rob the owner of this project.
No more, no less.

## Meetings Degrade Quality

Quality goes up when it is being
[controlled]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}).
When someone tells me every
day that my code is buggy and needs improvements, my quality goes up.
When nobody cares what I do or how good my results are, my quality
goes _down_, no matter how self-motivated I am.

{% youtube KUUzUb9arNg %}

Meetings promote group achievements and
[discourage]({% pst 2015/nov/2015-11-21-ringelmann-effect-vs-agile %})
individual ones. At the
end of a meeting, it's often not clear who exactly suggested a good idea
and who made the biggest effort. In other words, at the end of a meeting,
I don't know how good I am. Am I still the same as a month ago or am I a
[better]({% pst 2014/oct/2014-10-29-how-much-do-you-cost %})
engineer?

They smile more and ask me "what do you think?" more frequently than last summer;
that must mean something, right? I'm sure you understand this is
not the kind of feedback a serious engineer would expect.

A serious software developer wants to produce tangible results and receive
tangible feedback, like money or
[code reviews]({% pst 2015/feb/2015-02-09-serious-code-reviewer %}).
I want to know what
was wrong in my DB schema draft and what I missed. And I want this to be
documented somewhere. This is what makes me better, and this is how I _learn_
and _grow_.

## What About the A-ha! Moment?

Now, what about true creativity or that well-known "a-ha!" moment? Sometimes
it's necessary to "think out loud" in order to invent something, right?
We all know how important a face-to-face interaction could be when we're
researching and developing something new. Where would we be without meetings?
We can't simply work with documents; we need to talk to each other in order to let our
ideas out. Isn't it obvious?

I have only one argument for that. Did Einstein invent his theory
at a meeting with his colleagues? I don't think so. And he was solving a much
bigger problem than a DB schema design.

<hr/>

Let me summarize. Meetings are an activity that requires almost no skill,
while documenting ideas in text and diagrams is a way more difficult
job to do. So train and discipline yourself to work with documents
and let juniors enjoy their meetings.
