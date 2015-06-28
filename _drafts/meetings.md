---
layout: post
title: "Meetings? Forget it"
date: 2015-07-03
tags: mgmt
description:
  ...
keywords:
  - meetings suck
  - ...
  - ...
  - ...
  - ...
---

Software development is all about creativity, right? It's an art,
not a craftmanship. We, software engineers, are solving complex problems
and very often our solutions are absolutely not obvious. We experiment,
we innovate, we research, and we investigate.
And, to do all this &mdash; we _talk_.
We sit together in our fancy meeting rooms or Slack channels, we discuss
our solutions, we ask our co-workers for their opinions, we argue to
find best ideas. No doubts, meetings are the key component of a modern
process of software design... It's very _sad_ to see this.

<!--more-->

A good software architect doesn't need meetings and **never** does them.

Meetings de-motivate, waste time, burn money and degrade quality. But about
it later. Now let's discuss the alternative.

Say, I'm an architect and I need to design a schema for the relational
database in a new project. I have a team of five programmers. I want them
to help me in this design and it's a very logical and correct desire.
A good architect always discusses all possible options with available
team members before making a final decision. So, I call a meeting? No.

## A Good Architect

I ask Jeff, one of our programmers, to create a draft of a DB schema. I don't
even need to talk to him about it. I value and respect his time &mdash;
no need to bother with this organizational noise. I just create
a ticket and assign it to Jeff. When he has time, he creates a draft
and returns a pull request. I review it, make some comments, he updates
the branch and finally I merge.

Perfect, we have a draft.

At the end of the document Jeff also listed assumptions, risks, and concerns.
For example, this is what I got back from him (it's Markdown, a very
convenient format for simple technical documents):

{% highlight text %}
## Tables
user (id INT, name VARCHAR, email VARCHAR);
payment (id INT, date DATETIME, amount INT);
order (id INT, details VARCHAR, user_id INT FK(user));

## Assumptions
- all payments will be in dollars (no cents)
- all users will have only one email
- there will be no search feature required

## Risks
- order details may not fit into VARCHAR
- foreign keys may not be supported

## Concerns
- maybe NoSQL will be more suitable?
- what is the DB server we'll use?
{% endhighlight %}

I don't know how much time Jeff would spend on this document,
but I created it in 10 minutes. Of course, it's a very simple schema
for a very simple project. But even if Jeff would spend an hour
for it, every minute of this hour is valuable for the project. What I mean
is that every dollar I pay to Jeff for his time is returned to me
in a form of a text document.

Now, I have a draft and I'm making the next step. I'm asking
Monica to take a look at it and suggest changes. Again, another
hour and I'm getting back a pull request with changes, corrections,
new assumptions, new risks and new concerns. I'm not talking to Monica &mdash;
there is no need for that. She has all the information that she needs
to work with the DB schema. She is a good engineer and I trust
her ability to formulate the opinion in a written format.

No need to sit together at the same room or stand at a white board.
Monica is smart enough to do this job by herself. She already has
all the ideas expressed by Jeff. There is no need for her to talk
to him either.

Once I merge her pull request (after a proper review and corrections)
I have a new version of my `schema.md` document.

Moreover, I have a Git history of this document and I have a history
of pull requests with comments. This is way better than meeting notes
and even than a meeting video. Anyone who joins the project later will be
able to understand how did we come up to a conclusion to use PostgreSQL
and store monetary amounts without cents. It's all there, in Git history
and Github tickets, forever with us.

I need more opinions? I'm still not sure that the schema is good enough?
I ask someone else to review it and send me a pull request with changes.
I can even ask Jeff to do it again, after a few iterations with
other programmers!

I can add my own concerns to the document and on the next iteration
ask Jeff to pay attention and resolve them.

The more we circle this document, the better it becomes. And every minute
the project pays for turns into a tangible product &mdash; a **document**!

That's how a professional architect is collecting opinions and
making complex decisions. Now let's see what I would do being a bad architect.

## A Bad Architect

First, I will call a meeting. No, wait, I will schedule it in Google Calendar.
No, wait, wait. First of all, I will create an agenda:

{% highlight text %}
1. Introduction: 10 min
2. Problem: 15 min
  - we need a DB schema
  - let's choose a server
3. Opinions: 15 min
  - Jeff and Monica have experience
  - others?
4. Coffee break: 10 min
4. Discussion: 30 min
  - let's not forget risks
5. Conclusions: 10 min
  - DB schema document needed
{% endhighlight %}

I'm sure you know what I'm talking about and you've seen these
agendas from your "architects". Anyway, first step is done. I've scheduled an
hour-and-a-half meeting where all programmers will be present. We'll have fun
and drink coffee. We'll discuss the problem, hear all opinions and find
the best solution. We'll document it in that `schema.md` and will
get back to our tasks.

Instead of circulating that _dry_ and _boring_ Git documents we'll have a
real human communication with a nice coffee break where we'll share our
opinions about the last episode of The Bing Bang Theory. Isn't what
we like about our office jobs anyway?

I don't think so.

I think that meetings de-motivate, waste time, burn money and degrade quality.
Those who organize them either have no idea what he or she is doing or
is simply silently robbing the company he or she is working in.

We needed meetings thirty years ago, when we didn't have laptops and Git.
But even then, we had a pen and a paper.

I'm talking about meetings that are intended to collect or distribute information,
discuss or propose something or find a solution in a _technical_ domain.
The only valid purpose of meetings is to read **body language** of people
you are dealing with. Politians, business men, poker players,
shrinks, physicians, etc. &mdash; they need meetings because they need
to read our bodies, not just our thoughts.

Do we really care about Monica's body while designing a DB schema?
Well, depends, right? But let's be serious, we're not paid for that.

## Meetings De-motivate

The best motivation for a creative person is to see the results of
his or her creativity. If I'm not mistaken, enjoying the process
of creativity without a necessity to see the result is an obvious
sign of mental illness. A healthy and creative person, a software
engineer, for example, wants to see how his or her efforts are turned
into something valuable.

Meetings never produce anything valuable. Sometimes we have "minutes"
of our meetings, but they are just short pieces of paper with a brief
summary of what we were talking about. Not a real "product" for a
creative person.

Thus, they de-motivate me because I don't see what two hours
of my time were turned into.

You may say that some meetings actually produce great ideas, which
are a very tangible result. You may say that only in a direct
face-to-face communication these ideas could be born. You may also
say that many bright technical decisions were invented exactly due
to a magic synergy of friends thinking at the same direction, at the
same time, and in the same room. That's true, but about it later.

## Meetings Waste Time



## Meetings Burn Money

## Meetings Degrade Quality

## What About the "A-ha!" Moment?

