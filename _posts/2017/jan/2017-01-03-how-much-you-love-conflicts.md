---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "How Much Do You Love Conflict?"
date: 2017-01-03
place: Kyiv, Ukraine
tags: management
description: |
  Lose-lose, win-lose, and win-win are the three main exit
  strategies of conflicts, and each has its advantages
  and drawbacks.
keywords:
  - conflict
  - conflict vs consensus
  - win-win
  - win-lose
  - lose-lose
image: /images/2017/01/being-flynn.jpg
jb_picture:
  caption: Being Flynn (2012) by Paul Weitz
---

Conflict is what progress is made of. A professional and well-managed
team loves conflicts and creates them on a daily basis. A professional
project manager provokes conflicts and makes sure none of them end
in a consensus. Does that sound strange? It's not sarcasm. Read on.

<!--more-->

{% jb_picture_body %}

Have you ever heard the term "win-win?" Do you know what it means? My guess is that
most of my readers aren't exactly sure what this is about, even though
it's used very often. Let me explain. In any conflict,
there are three possible outcomes: lose-lose, win-lose, and win-win.
The first one is the worst, and the last one is the best. Here is an example.

Say your wife wants to watch a movie, and you want to watch a
baseball game. That's a conflict. It starts with a confrontation of _positions_.
Your position is, "I want this game," while her position is,
"I want this movie."

{% youtube GWLpAZqvqSc %}

The easiest way is to hold to these positions no matter what, but very soon
your conflict will turn into a fight and maybe eventually a divorce.

Project management offers a few
[conflict resolution techniques](https://en.wikipedia.org/wiki/Conflict_resolution)
that can help you and your wife get out of this confrontation without asking the police for help.
No matter which technique you use, the result will be either lose-lose,
win-lose, or win-win.

## Lose-Lose

[Compromise](https://en.wikipedia.org/wiki/Compromise)
is the worst outcome, and it's known as lose-lose. For example,
you both agree on watching the news---that's a compromise. Neither of you will
get what you wanted, a movie or a baseball game. You both lose.
Who gains in this case? You neighbors and the police, since there will be no
fight. Will the problem really be solved? No. You both will hate
each other even more, because neither of your desires were satisfied. The
divorce is still coming closer.

{% quote If we resolve conflicts through compromises, everybody suffers except those management monkeys. %}

The same happens in software team conflicts---if and when we resolve
them through compromises, everybody suffers except those
[management and HR monkeys]({% pst 2015/sep/2015-09-29-mayonnaise %})
who only care about a peaceful
[office]({% pst 2015/oct/2015-10-06-how-to-be-good-office-slave %}) environment. They don't
want to see us fighting over a piece of damn Java code. Moreover, they
don't really understand what the fight is about. They know nothing
about that [Singleton]({% pst 2016/jun/2016-06-27-singletons-must-die %})
design pattern and can't understand why these guys
are almost ready to kill each other just because one of them says
it's a pattern and the other one calls it an
[anti-pattern]({% pst 2016/feb/2016-02-03-design-patterns-and-anti-patterns %}), insists
that the project must not use it, and threatens everybody with an immediate
discharge if they don't listen.

Such a fight freaks everybody out. Everybody who sees positions and doesn't
see _interests_, that is. Remember, the position is, "I want to see the movie" and
"I want to use a singleton." The only thing a confrontation of
positions can produce is a fight, and the only solution is a compromise:
"You guys need a good [team-building party]({% pst 2015/mar/2015-03-02-team-morale-myths-and-reality %})
so you become friends and lose ~~balls~~ the desire to fight." That's what those
monkeys build: teams. They believe that when the team is "strong,"
there will be no fights, no conflicts, no arguments, no design patterns,
no anti-patterns, and ... no senior developers. There will be just one
permanent compromise over everything.

In a family, compromises lead to divorces. In a software team, the best talent
just leaves. They simply don't want to see their interests being disrespected
all the time, just for the sake of _avoiding_ fights. Stay away from compromises;
they are pure evil for both a family and a team.

## Win-Lose

The second option, which is a bit better than a compromise, is to use force:
"I'm a man, so you do what I say; we will watch the game!" or
"I feel sick; let me watch a movie." In either case, one of you will
get what he or she initially wanted. Even though this approach looks
less "democratic," it's way more effective, mostly because
it doesn't involve any third parties: There is no interest of
the police or neighbors involved, and the family resolves the conflict internally
and naturally.

{% youtube 4i-OK4IA4vA %}

Both of you understand exactly why you're watching that game now: because
the male part of the family is physically stronger. Even though it may sound
super annoying to you, my Californian readers, such a family would be way
farther from a divorce than the one that used to make compromises, especially
if the winning party is not always the same.

If your software team has a ~~moronic~~ experienced
[architect]({% pst 2014/oct/2014-10-12-who-is-software-architect %}), you will
most likely work in this conflict resolution model. He or she will make decisions,
and you will have to go along. I wrote about such an architect
[here]({% pst 2016/jul/2016-07-21-convince-me %})
and [here]({% pst 2014/oct/2014-10-12-who-is-software-architect %}).
I said there that an architect must be a dictator, making decisions and taking
full responsibility for them.

If the architect is super smart, respected by everybody, and immortal, this
force-based conflict resolution technique will work perfectly. The project
will move forward fast, because everybody will work instead of think. There
will be only one person who thinks---the architect.

The main drawback of this win-lose approach is the "lose" part: Someone
is always losing. And it's not about an offense, even though that's also important.
It's about us missing some valuable information. You will never know why
your wife wanted to watch that movie or why that junior developer
was suggesting you use NoSQL instead of SQL. You will just force them both
to shut up and follow your will. While they did, you still "lost" something. So
basically it's the team that is losing something, not just your wife or that
junior developer.

## Win-Win

The most difficult and yet most effective way to resolve a conflict is to
collaborate in order to discover the interests of all parties and find
a solution that satisfies them all. You start by asking, "Why do you want to
watch that movie?" to learn what exactly is behind that aggressive
"I want the movie" position. Again, there is a huge difference between
a position and an interest.

You may hear this back: "I'm just tired." So the real interest is to _relax_,
not to watch the movie. The movie was just one of the options to get rest.
Now, knowing her real interest, you may come up with, "How about I watch
the game and give you a massage at the same time?" This way, the divorce may never happen.

Thus, the first important step is to help everybody abandon their _positions_
and honestly expose their _interests_. When that's done, we can all start to work
not against each other but against the problem: With what solution will all our
interests be satisfied at the same time?

{% quote A truly professional software team is full of conflicts. %}

We will ask that junior developer: "Why do you think we need NoSQL?" It's
very likely that we will hear something like, "I just want to learn this new
concept." This is his real interest---to learn something new while
working on this project. Maybe we can offer him some other technology to
learn? Maybe we can move him to another project where NoSQL is used? There
are many options. But the first step is to understand what he really
wants. Not what position he took, but what was his real motivation for it.

A truly professional software team is full of conflicts, which are always
being resolved by collaboration. The team is not afraid of conflicts. Instead,
it _welcomes_ them, because they help reveal the real interests of all parties
involved and make a lot of information visible and available.

Truly professional team players always try to _provoke_ conflicts in order to gain
an opportunity to resolve them through collaboration, thereby exiting through the win-win door.
That's how the team grows---not by hiding conflicts and making compromises,
but by provoking them, making different interests visible, and finding the
most optimal solutions.

Be aware, though, that this is way more difficult than organizing
[team-building parties]({% pst 2016/dec/2016-12-06-how-to-pay-programmers-less %}).
