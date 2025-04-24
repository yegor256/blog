---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Four NOs of a Serious Code Reviewer"
date: 2015-02-09
tags: management agile
description: |
  It is very important to conduct regular code reviews within every
  software team, but it is not so easy to do them right; here
  are a few typical pitfalls.
keywords:
  - code review
  - code review tools
  - code review checklist
  - code review process
  - code review best practices
translated:
  - Korean: https://emaren84.github.io/blog/archivers/four-nos-of-serious-code-reviewer-kor
image: /images/2015/02/kim-jong-un-doing-code-review.png
---

[Code reviews](https://en.wikipedia.org/wiki/Code_review)
(a.k.a. peer reviews) must be a mandatory practice for every
serious software development team. I hope there is no debate about this. Some
do pre-merge code reviews, [protecting]({% pst 2014/jul/2014-07-21-read-only-master-branch %})
their master/development branch from
accidental mistakes. Others do post-merge
[regular reviews]({% pst 2014/dec/2014-12-18-independent-technical-reviews %})
to discover bugs and inconsistencies after they are introduced by their
authors. Some even do both, reviewing before merges and regularly after. Code reviews
are very similar to a [white-box testing](https://en.wikipedia.org/wiki/White-box_testing)
technique where a tester looks for defects with full access to the sources of the software.
In either case, a code review is a great instrument to increase quality and
boost team motivation.

<!--more-->

{% jb_picture_body %}

However, it's not so simple to do them right. I would even say it's
very easy and comfortable to do them wrong. Most code reviews
and reviewers I've seen make similar mistakes. That's why I decided
to summarize the four basic principles of a good reviewer as I see them.
Hopefully you find them helpful.

## No Fear

There are a few different fears a serious code reviewer should renounce.
The first and most popular is the fear of offending an author of the code.
"_I'd better close my eyes and pretend I didn't see her bugs today so tomorrow she will ignore
my mistakes_"---This is the kind of attitude this fear produces. Needless to say, it's
counterproductive and degrades
[code quality]({% pst 2017/apr/2017-04-11-flexibility-equates-lower-quality %}) and team morale. Here is my advice:
be direct, honest, and straight-forward. If you don't like the code, you don't like it.
You shouldn't care how your opinion will be taken by the author of the code.

If you do have such feelings toward your colleagues, there is something
wrong with the management model. You're afraid of being rejected by the
team for "not being a team player," which is a label attached to you by
the weakest members of the team, not by the project sponsor. The sponsor
pays you to produce high-quality software. The sponsor doesn't care how much your
intention to increase quality offends others, who care less. The sponsor
wants his money to produce deliverables that can be sold to customers and
returned back in profit. The sponsor is not paying you to make friends in
the [office]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %}).

The next type of fear sounds like this: "_If I reject this code, I will delay the release_"
Again, it goes without saying that such an attitude does a significant disservice to the entire project.
You will accept the code and close your eyes to what you don't like
in it. The code will go into the next release, and we'll ship it sooner.
You won't be a bottleneck, and nobody will say that because of that
dogmatic code reviewer, we delayed the release and lost some cash. You will
be a good team player, right? Wrong!

As I've [mentioned before]({% pst 2015/jan/2015-01-15-how-to-cut-corners %}), a professional
team player understands his or her personal role in a project and doesn't cover
anyone's ass. If the rejection of
[bad code]({% pst 2015/nov/2015-11-24-imprisonment-for-irresponsible-coding %}) delays the release, that's
the fault of its author. Your professional responsibility is to make this fault visible.
That's how you help the team learn and improve.

I think it's obvious that the education and improvement of a team first requires
getting rid of bad programmers and promoting good ones. Honest and fearless
code reviewers help the team learn and improve.

Yet another fear is expressed like this: "_I may be wrong and they will laugh me out_"
Even worse, they may spot my lack of knowledge. They may
see that I don't know what I'm doing. It would be better to stay quiet and pretend
there are no bugs in the code. At least then I wouldn't embarrass myself
with stupid comments. You know that it's much easier to look smart if you keep
your mouth shut, right? Wrong!

The project is not paying you to look good. You're getting your paychecks
not because the team loves you but because you produce deliverables on
a daily basis. Your professional responsibility is to do what's best
for the project and ignore everyone's opinions, including the opinion of your
boss. Similar to [A Happy Boss Is a False Objective]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %}),
I would say that the respect of the team is a false goal. Don't try to earn respect.
Instead, create clean code and respect will come automatically.

Let me reiterate: Don't be afraid to embarrass yourself by making incorrect and stupid comments
about someone's code. Be loyal to the project, not to the expectations of
people around you. They expect you to be smart and bright, but the project
expects you to say what you think about the code. So screw their opinions;
do the right thing and say what you really think.

## No Compromise

Okay, you've fearlessly said what you thought about the code and simply rejected it.
The branch you were reviewing is not good, and you explained why. You asked
its author to refactor here and re-write there. What's next?

He or she will try to make a deal with you. It's natural and it's
happening in almost every branch I'm seeing in our teams. The author of the
code is also a professional developer, and he also has no fear. So he insists
that his implementation approach is right and your ideas are wrong. What
should a professional code reviewer do in this case?

{% quote The worst thing is a compromise, it ruins quality faster than bad code. %}

The worst thing (as in any conflict resolution) is a compromise. This is what
ruins quality faster than bad code. A compromise
is a conflict resolution technique for which both parties agree not to get
what they wanted just for the sake of ceasing the conflict. In other words,
"_Let's make peace just to stop fighting_" It's the worst approach ever.

Instead of a lousy compromise, there are three professional exits from a fight
over a piece of code:

 * "_You're right; I take my comments back!_" This may happen, and it should
 happen very often. You should be ready to admit your mistakes. You didn't like
 the code, but its author explained to you its benefits, and you accepted
 the logic---not because you want to stop fighting with him but because
 you really understood the logic and accepted it. Willingness to say, "I'm wrong,"
 is the first sign of a mature and serious developer.

 * "_I will never accept this, period!_" Some code deserves that, and there
 is nothing wrong with resolving a conflict this way. The opponent may accept
 the situation and re-write everything. And learn something too.

 * "_Let's do what the architect says!_" In every project, there is
 a [software architect]({% pst 2014/oct/2014-10-12-who-is-software-architect %})
 who makes final decisions. Appeal to his opinion and get his final decision.
 Invite him into the discussion, and ask him to take one side in the conflict. Once
 he tells you that you're wrong, accept the decision and try to learn from it.

Thus, either stand strong on your position and fight for it or admit that you're
wrong. One way or the other. But don't make a compromise!

Don't get me wrong; it's not about being stubborn and holding your cards
no matter how bad they are. Be flexible and learn on the spot. Your position
may and should change during the negotiation, but don't accept anything that
you don't like. You can exit the conflict either by being fully convinced that the
opponent is right or when the architect says so. Nothing in between.

## No Bullshit

Again, you fearlessly said that a method should be designed differently.
Your opponent, the author of the code, replies that he doesn't think so.
You take a look again and decide to stand behind your position. You still think
you're right, and you're not going to make a compromise. Now what?
It's too early to call an architect, so try to convince your opponent.

In most cases, convincing is teaching. You know something that he doesn't know.
That's why he created that method the way you don't like. One of you needs
some additional education. Here is an opportunity for you to be a teacher
of your colleague. To be an effective teacher, you need to show proof. You
need to ground your logic and make sure he understands and accepts it.

{% quote Remember that it's your job to prove that the code you're reviewing is bad. %}

Be ready to show links, articles, books, reports, examples, etc. Just
"_I know this because I've been writing Java for 15 years_" is not enough. Moreover,
this type of argument only makes you less convincing.

If you don't have enough convincing proof, think again---maybe you are wrong.

Also, remember that it's your job to prove that the code you're reviewing
is bad. The author of the code should not prove anything. His code is great
by default. The job of the reviewer is to show why and how that's actually not the case.
In other words, you're the plaintiff and he is the defender. Not the other way around.

## No Offense

This is the last and most difficult principle to follow. No matter how bad the
code is and how stubborn your opponent is, you must remain professional. To be honest,
I find this very difficult sometimes. At [Zerocracy](https://www.zerocracy.com),
we're working in distributed teams and hire a few new people every week. Some
of them, despite our [screening criteria]({% pst 2014/oct/2014-10-29-how-much-do-you-cost %}),
appear to be rather <span class="strike">stupid</span> difficult to deal with.

I encountered a funny situation about a year ago when a new guy was supposed to
create a small (20 to 30 lines of code) new feature in an existing Java library. He sent me a pull
request (I was a code reviewer) after he put in a few hundred lines of code.
That code was absolute garbage and obviously not written by him. I immediately
understood that he found it somewhere and copied it. But what could I do?
How could I reject it without saying his attitude was unacceptable
for a professional developer? I had to spend some time objectively blaming
his code for its style, its design, etc. I had to make many serious
comments in order to show him that to fix it all, he should
delete the garbage and re-write it from scratch. I never saw him again
after that task.

My point is that it's easy to be professional when you're dealing with
professionals. Unfortunately, that's not always the case. But no matter how
bad the code in front of you is, be patient and convincing.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">What do you feel when your pull request is rejected and a lot of &quot;re-work&quot; is required? <a href="https://twitter.com/hashtag/sociotech?src=hash&amp;ref_src=twsrc%5Etfw">#sociotech</a></p>--- Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1013385039701250048?ref_src=twsrc%5Etfw">July 1, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
