---
layout: post
title: "How to Be Lazy and Stay Calm"
date: 2018-04-17
place: Moscow, Russia
tags: management zerocracy
description: |
  Solving technical problems in a large scope which
  is difficult to understand is a very stressful activity;
  I suggest we behave professionally.
keywords:
  - lazy
  - programming lazy
  - lazy and calm
  - zerocracy
  - noaltruism
image: /images/2018/04/sin-city.jpg
jb_picture:
  caption: Sin City (2005) by Frank Miller
---

What frustrates me most in my profession of software development
is the regular necessity to understand large problem scopes before fixing
small bugs, especially if the code is
[legacy](https://en.wikipedia.org/wiki/Legacy_code) and not mine. Actually,
it's even more frustrating when the code _is_ mine. The "deep thinking," as
[they call it](https://twitter.com/yegor256/status/984759494918987776),
which is always required before even a small issue can be resolved, seriously
turns me away from programming. Or did turn me away. Until I started
to think differently and encourage myself to be lazy. Here is how.

<!--more-->

{% jb_picture_body %}

I wrote about this a few years ago in this blog post:
[How to Cut Corners and Stay Cool]({% pst 2015/jan/2015-01-15-how-to-cut-corners %}).
However, in [our Telegram group](https://t.me/joinchat/CLxAaQ0xp-g_3WWI3MBr2g),
where we talk about [Zerocracy](https://www.zerocracy.com),
some programmers keep asking me the same
question over and over again: What should I do when the project is absolutely
new to me, I have just [30 minutes]({% pst 2018/jan/2018-01-09-micro-budgeting %}),
and the bug is very complex?

{% quote This literally means that you should always and only think about yourself and your personal profit. %}

One of the core [principles](https://www.zerocracy.com/toc.html) of Zerocracy is
[#NoAltruism](https://www.youtube.com/watch?v=vXUwE3FGfpg).
This literally means that
you should always and only think about yourself and your personal profit. You should
not try to improve the project, to increase its quality, to fix the code, or to refactor anything...
unless you are _paid_ for it.

First of all, when the task, which you are going to be paid for, is in front of you and
you can't understand how to solve it, _don't_ blame yourself. You are not
supposed to be an expert in the legacy code you just opened up.
Strictly speaking, you are not supposed to be an expert in anything.
A project, ~~unlike your mom~~, doesn't expect you to
be intelligent or tech-savvy. It needs you to
[close tickets]({% pst 2017/nov/2017-11-28-microtasking %}).

{% youtube vXUwE3FGfpg %}

Who do you blame, if not yourself, when the bug is serious, the
code is messy, and you have no idea how much time it will take just to
understand it, let alone fix it? Well, you can blame everybody around you,
but first of all you should blame the code base itself. How do you blame it?
You report its low quality by creating new tickets, which may sound
like this:

  * "The class X is not sufficiently documented, I don't understand how it works."
  * "The method X is too complex, I don't know what it does."
  * "The algorithm X is messy, I can't figure out what it does."
  * "The library X is used here, but I don't understand why you don't use library Y."
  * "The rules of class naming are not clear, document them please."
  * "The principle of data organization is not obvious, document it."

However, don't make the mistake many programmers are making when we tell
them that tickets are the only
[right way]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %})
to solve problems. They start asking questions and seeking help in the tickets, just like this:

  * "How can I unit test class X, please explain."
  * "Please help me create class X."
  * "Where should I put class X, in which package?"
  * "Which library should I use for doing X?"

The project is [not a school]({% pst 2015/feb/2015-02-16-it-is-not-a-school %}),
it's not interested in making you smarter
or more of an expert in its code. Nobody will explain anything to _you_,
because it's a waste of money and time. What the project will do instead is
fix its code base so that it becomes cleaner and more obvious for
you _and everybody else_. Thus, never ask for explanation or help, ask for
documentation and source code fixes.

{% quote You can blame everybody around you, but first of all you should blame the code base itself. %}

What do you do next? You sit and wait, until those tickets are resolved.
Who will resolve them? You don't care. That's a problem for the project manager.
Maybe he/she will even assign those tickets back to you and it will
be your problem to resolve them. But if that happens, the scope of work will
be different for you. You won't need to fix the bug anymore, you will
have to document some functionality or refactor some module.

You will have other problems in this new and smaller scope.
You will create new tickets, blaming everybody around you, and they also
may come back to you. And so on and so forth. Ultimately, the scope
of a ticket will be as small as it's possible to fix in 30 minutes.

See the algorithm? I'm sure you do, but it's very difficult to apply it to
real life and real software projects, for a few obvious psychological reasons:

  * **You are ashamed**.
    You are trained to feel guilty when you are not smart enough.
    What can I say?
    Just [stop it](https://www.youtube.com/watch?v=Ow0lr63y4Mw)!

  * **You are a [perfectionist](https://en.wikipedia.org/wiki/Perfectionism_%28psychology%29)**.
    You want to complete the entire ticket, solve the entire problem,
    and understand the entire scope.
    What can I say?
    This won't be solved while the project continues to pay you
    [by the hour/month]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %}).
    Once they start paying for results, this disease will be cured.

  * **You have no passion**.
    You just don't care about the quality of code at all.
    You don't want it to look clean, you can't even tell what clean is
    or what messy is. You just want them to pay you by the end
    of the month. In this case you won't even know what tickets to
    report.
    What can I say?
    I guess you have to try and find another job.
    Maybe a [manager]({% pst 2016/jan/2016-01-05-how-to-punish-employees %})?

  * **You are afraid**.
    Blaming the project and reporting tickets may look like you
    have a negative attitude towards the code base, and people who
    created it, which is not true. Instead, your attitude is
    [positive]({% pst 2014/apr/2014-04-13-bugs-are-welcome %}),
    since you care about it and want it to get better.
    What can I say?
    Make your tickets sound extremely polite and gentle.
    But keep reporting them.

  * **You have no time**.
    You have to solve the problem now and you have no time to wait
    for the resolution of those complaints you reported.
    What can I say?
    Blame the management and require more time. Much more time.
    But never blame yourself.

Software development is perfect territory for
[cutting corners]({% pst 2015/jan/2015-01-15-how-to-cut-corners %}),
being lazy and remaining calm, because our work is often discrete and can
be very incremental. Very occasionally it might not be possible to blame the project
and put the ticket on pause until all your complaints are addressed.
I can't imagine such a situation though. If you can, please let me know.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">The source code is too complex, you have to modify it, and you can&#39;t understand how it works. Whose fault is it? <a href="https://twitter.com/hashtag/codeahead?src=hash&amp;ref_src=twsrc%5Etfw">#codeahead</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1145222618854887424?ref_src=twsrc%5Etfw">June 30, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
