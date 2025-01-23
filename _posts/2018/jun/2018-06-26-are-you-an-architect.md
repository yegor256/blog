---
layout: post
title: "Are You an Architect?"
date: 2018-06-26
place: Moscow, Russia
tags: architect
description: |
  What makes a good architect? Is it the same as
  a senior programmer? Not really. Here is the list
  of traits a software architect must have.
book: code-ahead-1 2
keywords:
  - architect
  - software architect
  - architect traits
  - good architect
  - good software architect
image: /images/2018/06/no-country-for-old-men.jpg
jb_picture:
  caption: No Country for Old Men (2007) by Coen Brothers
---

Over twenty five years ago, in 1992, at an OOPSLA workshop in Vancouver,
Kent Beck, in answer to the question
"What is an architect?" said, according to [Philippe Kruchten](https://www.sciencedirect.com/science/article/pii/S0164121208002057),
that it is "a new pompous title that programmers demand to have on their business cards
to justify their sumptuous emoluments."
Not much has changed since then.
There is a big difference between a smart programmer and a project architect.
Here is a list of traits that, I believe, a good architect has.

<!--more-->

{% jb_picture_body %}

Disclaimer: Even though I haven't seen a single female software architect in my life,
I have to say for my leftist/feminist readers that in this blog post
I'm assuming an architect is a man only for the sake of convenience of speech.
There is no intention to offend anyone.

**He Is Loyal.**

Programmers come and go.
They are, as I [mentioned]({% pst 2018/jan/2018-01-09-micro-budgeting %})
many times before, egoists with a strong focus
on their personal profit. They change projects, they work on multiple
projects at the same time, they have
[no personal attachments]({% pst 2014/oct/2014-10-26-hacker-vs-programmer-mentality %})
to any piece of code. They worry only about their individual tasks and
feature branches. The branch is merged? All bets are off. Professional
developers are "polygamous" and disloyal.

An architect, however, is a different creature. He stays with the project
even after it runs out of funds, loses the last programmer, and
proves that the architecture is a total mess that can't handle even
a fraction of the traffic it was supposed to work under. The architect
stays and says "No worries, we'll get through, no matter what!"
How to find such a guy and how to motivate him are different questions,
maybe for another blog post.

**He Is Disciplined.**

Design patterns, quality of code, static analysis, unit testing,
high performance, reliability, security and even maintainability are all
very important things to worry about. However, a good architect knows that
all these can be resolved and achieved by programmers, if they are properly
hired, motivated, organized and controlled. How to hire, motivate, organize
and control them---that's what a good architect worries about.

He knows that process comes first, people next.

{% quote An architect puts discipline on top of everything else, constantly inventing new rules and enforcing them. %}

However, this is not what most software experts think. For example,
according to Alistair Cockburn's article [_Agile Software Development: The People Factor_](https://ieeexplore.ieee.org/document/963450/)
published in IEEE Computer in 2001:
"If the people on the project are good
enough, they can use almost any process
and accomplish their assignment. If they
are not good enough, no process will
repair their inadequacy---'people trump
process' is one way to say this." It is acceptable if a programmer
thinks like that, but not an architect.

An architect puts discipline on top of everything else, constantly inventing
new [rules]({% pst 2015/oct/2015-10-13-competition-without-rules %})
and enforcing them. Moreover, he is not only making others obey,
but also following the rules himself. Here, for example, are the rules to enforce:

  * No changes without a code review;
  * Every idea starts with a ticket;
  * The master branch is [read only]({% pst 2014/jul/2014-07-21-read-only-master-branch %});
  * Static analysis is [mandatory]({% pst 2018/jan/2018-01-16-educational-aspect-of-static-analysis %});
  * No [singletons]({% pst 2016/jun/2016-06-27-singletons-must-die %}),
    no [getter/setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}),
    and [so on]({% pst 2016/feb/2016-02-03-design-patterns-and-anti-patterns %});
  * Unit testing is mandatory for all new changes;
  * No [informal discussions]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %}) outside of tickets.

Each project has its own set of rules. The list above is a subset of what we
have on our projects at [Zerocracy](https://www.zerocracy.com). A good
architect thinks about the rules first and about the architecture second.

I totally agree with Len Bass that
"the architecture should be the product of a single architect,"
as he said in his book [_Software Architecture in Practice_](https://amzn.to/2MvHgFY).
The question, however, is how exactly the architect will create the
product: either in solo mode, making all technical decisions alone,
or letting the team contribute in an organized and disciplined manner.
The former is easy but less effective, the latter is way more difficult,
but leads to much stronger solutions and better team synergy (I hate this word,
but here it fits well).

**He Is Strong.**

Matthew McBride said in his article
[_The Software Architect_](https://cacm.acm.org/magazines/2007/5/5663-the-software-architect/abstract),
published in CACM in 2007, that
"Without strong supervision from the software architect,
projects and attempted solutions tend to fall apart due to the
weight of unmitigated complexity." The word _strong_ is what is important
to emphasize here.

{% quote The strength of an architect is in the ability to say "No" when it's difficult to do so. %}

What does strength mean in this context? An ability to stay in the office two days
straight with just pizza and cola? An ability to multiply six-digit numbers
in memory? An ability to memorize the purpose and design of all classes
and methods? An ability to stay in a meeting with investors for three hours
without checking Facebook even once? Not likely.

The strength of an architect is in the ability to say "No" when it's difficult to do so.
For example:

  * "No, I will [not merge]({% pst 2015/feb/2015-02-09-serious-code-reviewer %}) your pull request";
  * "No, we will not implement this feature";
  * "No, you do not deserve a promotion yet";
  * "No, your code is not as good as we expect";
  * "No, this build is not stable enough to be released";
  * "No, you will not go on vacation this month."

There are many other instances of "No" which can easily turn an architect into
a hated figure, but this is what his job is: to be the bad guy. This is why
he has to be strong---to handle it all calmly and continue leading
the project forward, toward his own well-defined technical goals.

**He Is Abstract.**

Abstract thinking is a very important positive trait of an architect.
Programmers may lack that, since they are mostly focused on their own
[isolated tasks]({% pst 2017/nov/2017-11-28-microtasking %}).
An architect must think globally and see the product
as a whole. Details are less important. He must rely on his people
when talking about details.

**He Is Social.**

Software is a product of people. No matter how great the architect is,
if he can't find the right people to implement his ideas and to bring
back new ideas, he is doomed to fail. The key quality of the architect
is the ability to work with people: recruit, motivate, and control their
results. [Social skills]({% pst 2018/jan/2018-01-23-sociotech-skills %})
are what an architect needs in order to be
successful in that, especially in finding new programmers and engaging
them on the project. What exactly does this mean? Well, here are some examples:

  * High visibility in social networks;
  * A long list of previous projects and teams;
  * Active membership in professional groups;
  * Publicity in the blogosphere.

In other words, a good architect is the one with a big group of
followers and supporters around him. I mentioned that in my recent
talk [_How Much Do You Cost?_](https://www.youtube.com/watch?v=GS45LzE3LPQ) at
[JEEConf 2017](http://jeeconf.com/speaker/yegor-bugayenko-2/).

**He Is Brave.**

A good architect says many times a day: "It is my fault."
If an architect doesn't have a habit of saying that frequently, he is not
a good architect. He is just a programmer who is afraid of responsibility
and authority.

The golden rule of a good manager is: "Success is yours, faults are mine."
This is the attitude a good architect has to express to his team.
When they win, he will always find a way to celebrate and reward them.
When they fail, he will take full responsibility for the failure.
Because it's his team, he found them, he motivated them, he controlled them,
and he didn't punish them properly. That's why they failed. First of all,
it's his fault.

{% quote He didn't punish them properly. That's why they failed. First of all, it's his fault. %}

What will he do with this fault is a separate question. Maybe he will
train and coach someone, maybe he'll enforce some rules more aggressively, maybe
he will even [give someone his card]({% pst 2015/sep/2015-09-16-how-to-fire-someone-right %}).
It's up to the architect. But for the
outside world he will always be the guilty one and the team must know that.
If they know that, they will do everything to not let the architect down.

**He Is Simple.**

"Simplicity is a great virtue," said Edsger Dijkstra in 1984.
For a programmer it's a virtue, for an architect it's a survival skill.
An architect who can't explain his ideas in simple words, easily
understood by other programmers, is not an architect. No matter how
smart he is, no matter how bright his ideas are. If they can't be
delivered in a simple form, they are worth nothing.

"If I don't understand you, it's your fault"
[said]({% pst 2015/jun/2015-06-29-simple-diagrams %}) Yegor Bugayenko in 2015.
A good architect remembers that.

**He Is Coding.**

Anthony Langsworth in his piece
[_Should Software Architects Write Code?_](https://goo.gl/vGN61n) argues
in favor of code-writing architects and in particular says that
"Understanding code means the architect can use his or her judgment
more effectively rather than rely on which developer is more persuasive."
Indeed, an architect that is only capable of talking and
[drawing]({% pst 2015/jun/2015-06-29-simple-diagrams %})
is a weak architect that will sooner or later let the team and the
project down.

How much code the architect has to write, depends on the age of the project.
When the project is young and is still in the phase of prototyping,
the architect produces the [majority of code]({% pst 2017/mar/2017-03-24-tdd-that-works %}). Then, later, when the product
matures, the architect steps away and mostly reviews the contribution
of programmers. Eventually, when the project migrates into the maintenance phase,
the architect may quit the project and transfer his responsibilities to
one of the programmers.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">A good software architect writes code every day! <a href="https://twitter.com/hashtag/codeahead?src=hash&amp;ref_src=twsrc%5Etfw">#codeahead</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1051357678138736640?ref_src=twsrc%5Etfw">October 14, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

**He Is Ambitious.**

An architect does want to get something in addition to money. He wants to
be the smartest guy in the room, he wants to solve complex tasks
nobody else has been able to solve before, he wants to save the world.
He wants all of that to be appreciated and rewarded. He wants to be number one.
In most cases he fails miserably. But he always gets back on his feet
and tries again. Look for the guy with ambitions if you want to hire
an architect, not just yet another programmer.

{% quote An architect wants to be a man of power, not just a smart technical engineer. %}

Michael Keeling, in his recent book
[_Design It!: From Programmer to Software Architect_](https://amzn.to/2tgR8uv) (worth reading), says:
"On some teams, architect is an official team role. On other teams,
there is no explicit role and teammates share the architect's
responsibilities. Some teams say they don't have an architect, but
if you look closely, someone is fulfilling the architect's
duties without realizing it. If your team doesn't have an architect, congratulations,
you've got the job!"

Michael's point is that the architect's position is rarely given to someone
voluntarily. Instead, an architect has to fight for it and
demand it. Sometimes even going straight ahead and saying "I want to be
the architect!"

What is important is that it will not sound like "I want to architect this."
That would be the voice of a programmer, not an architect.
An architect wants to be a man of power, not just a smart technical engineer.
So, it's way more about a title for him, rather that just his actual responsibilities.

**He Is Expensive**.

Yes, the money question [again]({% pst 2014/oct/2014-10-29-how-much-do-you-cost %}).
A good architect is expensive.
If he is not, he is not a good architect.
