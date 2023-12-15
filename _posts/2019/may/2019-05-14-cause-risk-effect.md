---
layout: post
title: "0rsk.com: Cause + Risk + Effect"
date: 2019-05-14
place: Moscow, Russia
tags: management
description: |
  Risk-driven development means regularly and pro-actively
  identifying risks and building plans according to their
  probabilities and possible impacts; 0rsk automates it fully.
keywords:
  - cause-risk-effect
  - risk management
  - risk driven development
  - software risks
  - risk analysis
image: /images/2019/05/the-departed.jpg
jb_picture:
  caption: The Departed (2006) by Martin Scorsese
---

{% badge https://www.0rsk.com/logo.svg 64 https://www.0rsk.com %}

"A project manager's work should not focus on dealing with problems;
it should focus on preventing them,"---this is how
[Rita Mulcahy](https://en.wikipedia.org/wiki/Rita_Mulcahy) started
a chapter about Risk Management in her great book
[_PMP Exam Prep_](https://amzn.to/266pAYB). Sounds smart, but how does
a project manager know about the problems which are supposed to be
prevented? This is what that chapter and
[_Risk Management Tricks of the Trade for Project Managers_](https://amzn.to/2V5b0wp)
(yet another great book by the same author) are dedicated to. What I learned
from these books, and from my multi-year [experience](https://www.technoparkcorp.com/process/risk/risk/)
of identifying, analyzing and dealing with risks, is that the best
format for specifying them consists of three parts: cause, risk, and effect.

<!--more-->

{% jb_picture_body %}

Let's start with a simple example. I developed [Sibit](https://github.com/yegor256/sibit),
a simple Ruby gem, just [a few weeks ago](https://youtu.be/jeflGHMpfDc),
which is a command line [Bitcoin client](https://bitcointalk.org/index.php?topic=5130324).
You can check your Bitcoin address balance with it, and send a payment to another address, in just
a single command line call. It works just fine, but it does all its operations
via the [Blockchain API](https://www.blockchain.com/api) over HTTP.

This means that if one day the API gets changed, the gem will stop working. It's
a _risk_. It not yet an _issue_, since now the API works exactly as the gem expects it
to work, but it's a very much _anticipated_ problem. When it happens, the
gem will stop working, its users will not understand why and will simply
stop using it. They will also think of me as the creator of some garbage that
is not maintained well and doesn't work. Not really good for my reputation, right?

{% youtube WlI6IZ6M7vY %}

Just like Rita Mulcahy suggested above, I shouldn't just wait until
a very disappointed user emails me. I should _pro-actively_ deal with this risk somehow.
How? Well, I can do a few things. First, I can create a few integration tests
to check whether the API still supports the protocol I'm expecting, and
make sure my CI runs the build, say, once a day. Once the build goes
red, I should get an email and react accordingly by fixing the gem before
its users notice the problem. Second, I can manually check the repo every
week, for example, to make sure it's still in a good shape and works against
the API.

Now, let's turn this story into formal risk management. I took the titles
of the subsections below from the
[PMBOK](https://www.pmi.org/pmbok-guide-standards)
Risk Management chapter.

## Identify Risks

First, we _identify_ the risk. It will consist of _three_ parts:

```text
Cause #1: Sibit works by using the Blockchain API
Risk #1: The API may be changed without notice
Effect #1: Users will be disappointed
```

The _cause_ is something that we have and which is a fact. The _risk_ is the
anticipated _event_, which may happen or may not. The _effect_ is
what will happen if the risk occurs. Why do we need to split it in
three parts? Technically, if we put them together, here is how it will sound:
"Since Sibit uses the Blockchain API and the API may be changed without notice
users will be disappointed." But it's better to clearly
define cause/risk/effect components, because, guess what ... we may
have different combinations of risks, effects and causes.
For example, how about identifying an additional risk for an existing cause:

```text
Risk #2: The API may go out of the market
```

It's a different risk from the one we had before. The API will not change,
but will disappear entirely from the market. Is it possible? Pretty much.
What will be the effect of this risk? The same---users will be disappointed,
since Sibit, my Ruby gem, will stop working. Maybe there will be some
other effects? Well, let's think. If the entire API is shut down, I will
have to spend a decent amount of time on finding a new one, studying it,
understanding how it works, and making a lot of changes in my gem in order
to make it understand the new API. I may even fail to do so, if the new API
has a significantly different design. In other words, the effect of
risk #2 will be something like:

```text
Effect #2: It will take time to connect to a new API
```

On the other hand, the moment the API gets out of the market,
there will be an _opportunity_ on the market for a similar API. If we know
about it at the right moment of time, we could _exploit_ that opportunity
and create a similar API for other users, right? Thus, risk #2 has
an additional effect:

```text
Effect #3: There will be an opportunity to create a similar API
```

This is a _positive_ effect, while the effects we had before were _negative_ ones.
The job of a project manager is not only to identify negative effects, but
to find a similar amount of positive effects for most risks and causes.

To summarize, this is what we have now:

```text
C1 → R1 → E1
   → R2 → E2
        → E3
```

Get the diagram? The cause `C1` leads to the risks `R1` and `R2`, which have
a number of effects each: `E1`, `E2`, and `E3`. In order to be able to define
such a multi-level diagram and avoid duplication of text
we need to split each anticipated event into three parts.

There are some rules I learned for myself about those three parts:

  * **Does**.
    The cause should always sound like a statement in
    [the present tense](https://en.wikipedia.org/wiki/Present_tense),
    since it states a fact that exists right now, e.g.
    "we use Hibernate,"
    "Java 6 is not supported anymore,"
    "70% of our users are on Android,"
    "payments are sent via PayPal,"
    "GitHub is the sole maintainer of our repository,"
    and so on.

  * **May**.
    The Risk statement should use the word "may",
    since it is something that hasn't happened yet, but is only anticipated, e.g.
    "we may lose the customer,"
    "the architect may quit,"
    "Apple Store may delay in reviewing our app,"
    "the investor may pull out,"
    etc.

  * **Will**.
    The Effect should be in
    [the future tense](https://en.wikipedia.org/wiki/Future_tense), explicitly
    stating the outcome we will experience in the future if the risk occurs, e.g.
    "we will go bankrupt,"
    "we will have to rewrite the entire module,"
    "we will spend another $10,000 for hardware,"
    and so on.

Needless to say, the shorter the statements the better. A properly
defined cause, risk, and effect should include up to 20 words each. Longer
statements mean only one thing: the author is not clear about what's going on
and needs to spend more time investigating the situation.

## Qualitative Analysis

Not all risks and effects are equally likely, as you can see. It is very
unlikely that the entire Blockchain API will die, but it's very likely
that it may change its HTTP protocol. It would be silly to pay
equal attention to all risks, since some of them are _primary_, while
others are _secondary_. How do we know which one is which? We assign
numbers. Here is how.

First, we analyze all risks and assign a _probability_ to each of them,
where 1 means that the risk will most likely never occur and 9
means that the risk will undoubtedly happen:

```text
C1 → R1:7 → E1
   → R2:2 → E2
          → E3
```

I assigned 7 and 2 to the risks above. It was my _expert judgment_. No math here.
I just took a look at the risks and made my personal decision,
as an owner/manager of the project.

Then, we assign an _impact_ to each effect, again within the `[1..9]` range.
Here, 1 means that the consequences we are expecting won't hurt anyone
and won't really help anyone either, while 9 means that the effect is crucial
(either in a negative or a positive way):

```text
C1 → R1:7 → E1↓:3
   → R2:2 → E2↓:8
          → E3↑:3
```

Again, I chose the numbers according to my expert judgment. Changing the gem
according to a slightly changed API is one thing (the impact is 3), while
re-writing it for an entirely new API is a completely different amount
of work (hence the impact is 8).

The final step is to multiply them: probability × impact. We will get this
list of risks:

```text
C1 → R1:7 → E1↓:3 ⇢ 7×3 = 21
C1 → R2:2 → E2↓:8 ⇢ 2×8 = 16
C1 → R2:2 → E3↑:3 ⇢ 2×3 =  6
```

You can now see what is what in our list. Even though the consequences of the
second line in the list are more serious, the probability is lower and,
in the overall map of the risks, this line is less important.

What we just did is called qualitative risk analysis: we determined
which risks are more important and need to be addressed immediately, and
which are less important and can simply be ignored for a while.

## Quantitative Analysis

I will skip this section. I don't think it's important or feasible
for a small software project. According to Rita Mulcahy:
"As a project manager, you should always do qualitative risk analysis
but quantitative risk analysis is not required for all projects or for all
risks and may be skipped in favor of moving on to risk response planning."

## Plan Risk Responses

Now it's time to put my _response plans_ in place. There are basically
two options for me in each _positive_ line of my _Risk List_:

  * **Avoid**.
    I can do something to lower the probability of the risk. Take risk `R2`---can
    I do something to make sure the Blockchain API stays on the market for
    longer and doesn't die? Well, I can tweet about it, promote it, or maybe
    even donate some money to it. But I doubt any of that will really help.
    So _avoiding_ is not the right strategy here. I simply can't lower the probability, no matter what I do.
    If the Risk `R2` has to occur, it will occur. The same it true about
    the Risk `R1`.

  * **Mitigate**.
    The second possible risk response _strategy_ is _mitigation_ of the impact
    of the effect. Take a look at the effect `E1`. As discussed above, it will
    be wise to do two things. First, create integration tests and configure
    the CI to send me an email when the API is changed. Second, regularly
    check the repo for consistency and minimize the amount of time the repo
    will stay out of sync with the API, right after the API is changed.

Well, there are other options like _accepting_ (do nothing and just wait)
or _transferring_ (find a scapegoat to blame when things go south), but they
are less practical.

There are two options for a _good_ risk (E1/R2/E3) too:

  * **Exploit**.
    I may do something to expedite the quick death of Blockchain API,
    thus making the risk `R2` happen faster, right? Well, this may sound
    like a joke in this case, but very often we may choose to push things
    forward with a positive risk. This strategy is called _exploiting_.

  * **Enhance**.
    I may do something to increase the positive impact of the effect `E3`. For
    example, I may prepare a similar API and make it market ready. When the
    Blockchain API dies, I immediately launch mine and start promoting it
    with "Hey, those guys are dead, switch here now!" I'm kidding, but you
    get the idea.

So, simply put, we can have a plan attached either to a risk or to an effect.
We can either do something with the probability or with the impact. Well, we
can do something with the cause too. For example, I can eliminate the entire
list of risks if I just delete my gem and kill the project, right? There will
be no trouble anymore. No frustrated users, no risks, no opportunities. This
may also be a solution in some cases (though not in this one).

The bottom line is that a plan may be attached to either a cause, a risk,
or an effect. I would define three plans, all mitigating the impact
of `E1`:

```text
P1→E1: Create integration tests (once)
P2→E1: Configure CI (once)
P3→E1: Check the repo for compliance with API (weekly)
```

The first two are one-time actions, which I have to perform ASAP. Once
completed they will lower the impact of `E1`. The plan `P3` should
be performed every week, in order to lower the impact of `E1` too.
Here is how my Risk List looks, together with the plans:

```text
C1 → R1:7 → E1↓:3 ⇢ 7×3 = 21
  P1, P2, P3
C1 → R2:2 → E2↓:8 ⇢ 2×8 = 16
  No plans
C1 → R2:2 → E3↑:3 ⇢ 2×3 =  6
  No plans
```

Make sense?
I hope so. I definitely recommend you read
[_Risk Management Tricks of the Trade for Project Managers_](https://amzn.to/2V5b0wp).
It explains it all in much more detail and it's fun to read.

I created a simple web project, which makes it possible to put exactly
this type of risk structure in writing: [0rsk.com](https://www.0rsk.com)
(it's in the [Zerocracy](https://www.zerocracy.com) product family, that's why
the name starts with zero). You just
login there, create a new project, and "add" your risks. Try it out.
Then, when the risks are registered, you attach response plans to them.
The interface is pretty intuitive, so you should have no issues. If there are any
difficulties, don't hesitate to [submit an issue](https://github.com/yegor256/0rsk/issues).

## Implement Risk Responses

Now it's time to do what was planned, to _implement_ the plans. [0rsk](https://www.0rsk.com) turns
plans into _tasks_, when the time comes. The tasks are explicit instructions
for you, the project manager. Then you do them yourself or delegate to your
project members.

In the near future [0rsk](https://www.0rsk.com) [will integrate](https://github.com/yegor256/0rsk/issues/21)
with GitHub and other task trackers, to drop new tasks there and monitor
their execution. Stay tuned, there will be more features soon.

There is also a Telegram integration. Every time a new plan has to be executed,
[0rsk](https://www.0rsk.com) pings me in Telegram, reminding that it's time to work on that. Try
it out, the bot is here: [@zerorsk_bot](https://t.me/zerorsk_bot).

<hr/>

Honestly, I find this risk-driven way of managing my scope of work very
productive and results focused. First, I identify what the most important
situations are in my project (which could be people, resources, bank accounts,
software products, assets, etc), then I think about risks and I do this regularly,
creating a few new risks every day, together with effects. Then, I plan
what I can do in order to minimize their probabilities and react to their
impacts. Finally, the Telegram bot starts telling me what to do every day.

Thanks to all of this, I don't miss the overall scope---it is defined by the
cause-risk-effect-plan structure in my [0rsk](https://www.0rsk.com) project---and I stay
focused on what matters, every day.

Now I don't react to problems, I prevent them, just like Rita Mulcahy suggested.

You can do too, [0rsk](https://www.0rsk.com) is free for all.

P.S. There is a curated list of causes, risks, and effects, where you can
pick your the one most relevant to your case: [yegor256/awesome-risks](https://github.com/yegor256/awesome-risks).
You can even add your ideas there.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Do you have a formal Risk List in your project?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1340641674595328000?ref_src=twsrc%5Etfw">December 20, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>