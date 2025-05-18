---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "What Does a Software Architect Do?"
date: 2014-10-12
tags: architect
categories: jcg best
description: |
  The role of a software architect is mission critical
  and has to be explicitly set even for very small projects.
book: code-ahead-1 2
keywords:
  - software architect
  - role of software architect
  - hands-on software architect
  - what software architect is for
  - software architect salary
  - software architect job description
translated:
  - Japanese: http://tbd.kaitoy.xyz/2016/01/11/who-is-software-architect/
image: /images/2014/10/jackie-brown.jpg
jb_picture:
  caption: Jackie Brown (1997) by Quentin Tarantino
---

Do you have a software architect in your project? Do you need one?
Well, most [agile teams]({% pst 2015/nov/2015-11-21-ringelmann-effect-vs-agile %})
do not define such a role explicitly and
work in a _democratic_ mode. Every important technical decision
[is discussed]({% pst 2023/aug/2023-08-15-decision-making-process %})
with the entire team, and the most voted for solution wins.
When such a team eventually decides to put a "software architect" badge
on someone's t-shirt, the most _reputable_ programmer gets it.

<!--more-->

{% jb_picture_body %}

The badge rarely changes his responsibilities, though. After all,
the team stays the same and enjoys having technical discussions together,
involving everyone. In the end, a software architect is more of
a _status_ than a role with explicitly defined responsibilities. It is
a sign of respect, paid by other team players to the oldest and the
most authoritative one among them. Right?

{% youtube 0fuEgmibJc4 %}

Absolutely wrong!

Obviously, an architect is usually someone who
has the most knowledge, skills, experience, and authority. Of course,
an architect usually knows more than others and is able to communicate
his knowledge with diplomacy and pedagogy when required. An architect is usually
one of the smartest guys on the team.

{% quote An architect is the one who takes the blame for the quality %}

This is not, however, _what_ makes him/her an architect.

And this is not what the team needs. My definition of a software architect
is this:

An _architect_ is the one who takes the _blame_ for the _quality_.

{% youtube PNSezrlemsY %}

You can replace "blame" with accountability or responsibility. Although,
I prefer to use "blame," because it much better emphasizes the fact that
every quality issue in the product under development is a _personal_
fault of the architect. Of course, together with the blame he also
takes all the credit from
[happy customers]({% pst 2017/jan/2017-01-10-how-to-teach-customers %}),
when the [quality]({% pst 2017/dec/2017-12-26-software-quality-formula %}) is good.

This is what the team needs---someone personally responsible
for the [quality]({% pst 2017/apr/2017-04-11-flexibility-equates-lower-quality %}) of the software being developed.

{% quote The job of the PM is to make sure that every technical decision the architect makes is not doubted by anyone %}

How this guy will delegate this responsibility to others is his job. Whether
he will use his knowledge and skills, or quality control
[tools]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}), or
unit testing frameworks, or authority, or coaching, or
[corporal punishment]({% pst 2016/jan/2016-01-05-how-to-punish-employees %})---it's his business.
A project
[manager]({% pst 2015/sep/2015-09-22-micromanagement %}) delegates quality control to the software architect,
and [it is up to]({% pst 2015/feb/2015-02-23-haircut %})
the software architect how to delegate it further.

The role of a software architect is crucial for every project,
even if there are just two coders working at the same desk. One of
them has to be the architect.

An ideal architect has all the merits mentioned above. He listens
to everybody and takes their opinions into account. He is a good coach and a teacher,
with a lot of patience. He is an effective communicator
and negotiator. He is a diplomat. And he is an expert in the technical domain.

But, even if he doesn't have all these merits, his decision is always _final_.

And this is the job of the
[project manager]({% pst 2016/may/2016-05-24-who-is-project-manager %}),
to make sure that every
technical decision the architect makes is not doubted
[by anyone]({% pst 2015/oct/2015-10-13-competition-without-rules %}). This is
what delegation is all about---responsibility should always come with power.

{% youtube AvVQ5NjS_Nk %}

As a project manager, you should regularly evaluate
[the results]({% pst 2015/may/2015-05-11-software-architect-responsibilities %})
of your architect. Remember, the quality of the product your team
is working on is his personal (!) responsibility.
Any problems you see are his problems.
Don't be afraid to blame him and punish him. But, always remember that
in order to make your punishments productive you should give your
architect full _power_ in his actions. Let me reiterate: his decisions should be final.

If you, as a project manager, are not happy with the quality of the product
and the architect doesn't improve the situation,
[replace]({% pst 2015/sep/2015-09-16-how-to-fire-someone-right %})
him. Downgrade him
to a programmer and promote one of the programmers to an architect.
But always remember that there can only be one architect in the team,
and that his decisions are final.

That's the only way of having a chance of building a perfect product.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Does your team have an official role of a Software Architect, who has enough authority to make technical decisions alone? <a href="https://twitter.com/hashtag/codeahead?src=hash&amp;ref_src=twsrc%5Etfw">#codeahead</a></p>--- Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/995545586983161856?ref_src=twsrc%5Etfw">May 13, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
