---
layout: post
title: "Four No's of a Serious Code Reviewer"
date: 2015-01-10
tags: mgmt agile
description:
  It's very important to do regular code reviews in every
  software team, but it's not so easy to do them right; there
  are a few typical pitfalls.
keywords:
  - code review
  - code review tools
  - code review checklist
  - code review process
  - code review best practices
---

[Code reviews](http://en.wikipedia.org/wiki/Code_review)
(a.k.a. peer reviews) must be a mandatory practice in every
serious software development team. I hope there is no doubt about this. Some
do pre-merge code reviews, protecting their master/development branch from
accidental mistakes. Others do post-merge
[regular reviews]({% pst 2014/dec/2014-12-18-independent-technical-reviews %}),
to discover bugs and inconsistencies after they are introduced by their
authors. Some even review both before merges and regularly after. Code reviews
is very similar to a [white-box testing](http://en.wikipedia.org/wiki/White-box_testing)
technique, where a tester is
looking for defects, having full access to the sources of the software.
In either case, code review is a great instrument of increasing quality and
boosting team motivation.

However, it's not so simple to do them right. I would even say, it's
very easy and comfortable to do them wrong. Most code reviews
and reviewers I've seen make similar mistakes. That's why I decided
to summarize four basic principles of a good reviewer, as I see them. Hope
you find them helpful.

<!--more-->

## No Fear

There are a few different fears a serious code reviewer should renounce.
The first and the most popular is a fear to offend an author of the code.
"_I better close my eyes for her bugs today and tomorrow she will ignore my mistakes_" &mdash;
is the kind of attitude this fear produces. No need to say that it's
counter productive and degrades code quality and team morale. Here is my advice &mdash;
be direct, honest and straight-forward. If you don't like the code, you don't like it.
You shouldn't care how your opinion will be taken by the author of the code.

If you do have such feelings towards your colleagues, there is something
wrong in the management model. You're afraid of being rejected from the
team for "not being a team player", which is a label attached to you by
the weakest members of the team, not by the project sponsor. The sponsor
pays you for producing high quality software. The sponsor doesn't care how much your
intention to increase quality offends others, who care less. The sponsor
wants his money to produce deliverables that can be sold to customers and
returned back in profit. The sponsor is not paying you to make friends in
the office.

Next type of fear is about "_If I reject this code, I will delay the release_"
Again, needless to say that such attitude does a very bad favor to the entire project.
You will accept the code and will close your eyes to what you don't like
in it. The code will go into the next release and we'll ship it sooner.
You won't be a bottleneck and nobody will say that because of that
dogmatic code reviewer we delayed the release and lost some cash. You will
be a good team player, right? Wrong!

As I've [mentioned before]({% pst 2015/jan/2015-01-15-how-to-cut-corners %}), a professional
team player understands his or her personal role in a project and doesn't cover
anyone's ass. If the rejection of a bad code delays the release &mdash; it's
a fault of its author. Your professional responsibility is to make this fault visible.
That's how you help the team to learn and improve.

I think it's obvious, that learning and improving of a team means, first of all,
getting rid of bad programmers and promoting good ones. Honest and fearless
code reviewers help the team to learn and improve.

Yet another fear sound like "_I may be wrong and they will laugh me out_"
Even worse, they may spot my lack of knowledge. They may
see that I don't know what I'm doing. I would better stay quiet and pretend
that there are no bugs in the code. At least I won't embarass myself
with stupid comments. You know, it's much easier to look smart if you keep
your mouth shot, right? Wrong!

The project is not paying you to look good. You're getting your paychecks
not because the team loves you, but because you produce deliverables, on
a daily basis. Your professional responsibility is to do what's best
for the project and ignore everyone's opinions, including the opinion of your
boss. Similar to ["happy boss is a false objective"]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %})
I would say that a respect in a team is a false goal. Don't try to earn respect.
Instead, earn clean code and respect will come automatically.

Let me reiterate, don't be afraid to embarass yourself by making incorrect and stupid comments
about someone's code. Be loyal to the project, not to the expectations of
people around you. They expect you to be smart and bright, but the project
expect you to say what you think about the code. So, screw their opinions,
do the right thing and say what you really think.

## No Compromise

OK, you fearlessly said what you thought about the code and simply rejected it.
The branch you were reviewing is not good and you explained why. You asked
it's author to refactor here and re-write there. What's next?

Next, he of she will try to make a deal with you. It's natural and it's
happening almost in every branch I'm seeing in our teams. The author of the
code is also a professional developer and he also has no fear. So, he insists
that his implementation approach is right and your ideas are wrong. What
a professional code reviewer should do in this case?

The worst thing (as in any conflict resolution) is a compromise. This is what
ruins the quality faster than bad code &mdash; compromises. A compromise
is a conflict resolution technique where both parties agree to get not
what they wanted just for sake of ceasing the conflict. In other words,
"_Let's make peace just to stop fighting_" It's the worst approach ever.

Instead of a louzy compromise, there are three professional exits from a fight
over a piece of code:

 * "_You're right, I take my comments back!_" This may happen and this should
 happen very often. You should be ready to admit your mistakes. You didn't like
 the code, but its author explained to you its benefits and you accepted
 the logic. Not because you want to stop fighting with him, but because
 you really understood the logic and accepted it. Willingness to say "I'm wrong"
 is the first sign of a mature and serious developer.

 * "_I will never accept this, period!_" Some code deserves that and there
 is nothing wrong in resolving a conflict this way. The opponent may accept
 this situation and re-write everything. And learn something, too.

 * "_Let's do what the architect says!_" In every project there is
 a [software architect]({% pst 2014/oct/2014-10-14-who-is-software-architect %}),
 who makes final decisions. Appeal to his opinion and get his final decision.
 Invite him to the discussion and ask to take one side in the conflict. Once
 he tells you that you're wrong, accept the decision and try to learn from it.

Thus, either keep your position strong and fight for it or admit that you're
wrong. One way or the other. But don't make a compromise!

Don't get me wrong, it's not about being stubborn and holding your cards
no matter how bad they are. Be flexible and learn on the spot. You position
may and should change during the negotiation. But don't accept anything that
you don't like. You can exit the conflict either being fully convinced that the
opponent is right or when the architect says so. Nothing in between.

## No Bullshit

Again, you fearlessly said that a method should be designed differently.
Your opponent, the author of the code, replies that he doesn't think so.
You take a look again and decide to keep your position. You still think
that you're right and you're not going to make a compromise. Now what?
It's too early to call an architect, try to convince you opponent.

In most cases convincing is teaching. You know something that he doesn't know.
That's why he created that method the way you don't like. One of you needs
some additional education. Here is an opportunity for you to be a teacher
of your colleague. To be an effective teacher you need to show proofs. You
need to ground your logic and make sure he understands and accepts it.

Be ready to show links, articles, books, reports, examples, etc. Just
"_I know this because I'm writing Java for 15 years_" is not enough. Moreover,
this type of argument only makes you less convincing.

If you don't have enough convincing proofs, think again &mdash; maybe you are wrong?

Also, remember that it's your job to prove that the code you're reviewing
is bad. The author of the code should not prove anything. His code is great
by default. The job of the reviewer is to show why and how it's not the case.
In other words, you're the offender and he is the deffender. Not the other way around.

## No Offense

This is the last and the most difficult to follow principle. No matter how bad is the
code and how stubborn is your opponent, you must stay professional. To be honest,
I find this very difficult sometimes. In [teamed.io](http://www.teamed.io)
we're working in distributed teams and hire a few new people every week. Some
of them, despite our [screening criteria]({% pst 2014/oct/2014-10-29-how-much-do-you-cost %}),
appear to be rather <span class="strike">stupid</strike> difficult to deal with.

I had a funny situation about a year ago when a new guy. He was supposed to
create a small (20-30 lines of code) new feature in an existing Java library. He sent me a pull
request (I was a code reviewer) where he put a few hundreds lines of code.
That code was absolute garbage, obviously not written by himself. I immediately
understood that he found it somewhere and copied here. But what could I do?
How could I reject that without saying that this attitude is unacceptable
for a professional developer? I had to spend some time objectively blaming
his code for its style, its design, etc. I had to make many serious
comments in order to show him that in order to fix them all he should
delete this garbage and re-write it from scratch. I've never saw him again
after that task.

My point is that it's easy to be professional when you're dealing with
professionals. Unfortunately, it's not always the case. But no matter how
bad is the code in front of you, be patient and convincing.
