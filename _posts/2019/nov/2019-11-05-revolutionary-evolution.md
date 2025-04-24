---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Revolutionary Evolution"
date: 2019-11-05
place: Shenzhen, China
tags: architect
description: |
  How do you convince the team to start doing everything
  very differently, if you are just a programmer there?
  Here is my experience.
keywords:
  - how to win
  - technical debate
  - how to convince
  - tech majority
  - how to gain support
image: /images/2019/11/war-inc.jpg
jb_picture:
  caption: War, Inc. (2008) by Joshua Seftel
---

Here is the question I keep hearing almost every time I [speak](/talks.html) at
a conference about object-oriented programming and my
[non-traditional]({% pst 2014/sep/2014-09-10-anti-patterns-in-oop %})
understanding of it: "How do I convince the whole team to start doing everything so differently?"
(asked [here](https://www.yegor256.com/2016/06/27/singletons-must-die.html#comment-4637223953)
just recently). Indeed, it's easy to change your coding habits
and your software design if you are alone. What do you do if you are a member
of a larger team where everybody is very happy with the Spring Framework
and procedural programming? How do you change _their_ coding habits?
An even better question is: How do I not get fired while doing it?

<!--more-->

{% jb_picture_body %}

TL;DR You can't win alone, you need a gang; assemble it.

I remember a few years ago I joined a Java team as an architect and my boss
told me that the team had very talented programmers, but they needed
some help. He also told me that the architecture was great, but it needed
to be improved to become even better. And he also told me that I was there
to make changes, which they were looking forward to.

In just a few weeks I realized that the reality was very different. Most of those
30 programmers were actually junior and could barely tell the difference
between an object method and a static one. I also found out that there
was no architecture at all, just a collection of `.java` files created by
different people at different times. And, of course, it became obvious
that no matter how hard I tried, my ideas wouldn't be accepted, simply
because they sounded too scary to those "talented" people.

{% quote Most programmers do what everybody else does, it's safer. %}

Seriously, if I had been one of those programmers, sitting there for a few
years, writing some Java code and collecting paychecks
[twice a month]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %}), would
I be glad to meet some guy telling me that I had been very wrong for the last
few years and now it's time to re-write everything? No matter how much
sense this guy would be making, I would simply sabotage him to protect myself.
No matter how much we declare the value of individualism and independent
thinking, most people are very social and dependent on the community around
them. In other words, they do what everybody else does. It's safer.

Those 30 people were not any better. They were going with the flow, using
[Spring](https://spring.io), and [MyBatis](https://blog.mybatis.org/),
and [Singletons]({% pst 2016/jun/2016-06-27-singletons-must-die %}),
and [getters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}),
and [setters]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}),
and [everything else]({% pst 2014/sep/2014-09-10-anti-patterns-in-oop %}) we,
[real OOP programmers](https://www.elegantobjects.org), hate so much.
But I had to do something about it,
that is what I was paid for. However, just telling them that starting today we
should get rid of Spring because it's [anti-OOP]({% pst 2016/dec/2016-12-13-mvc-vs-oop %})
would mean only one thing for me: a termination of my contract, sooner or later.

Such a _revolution_ would be a serious threat, both for programmers and for
the product. First, it would put most programmers back in junior positions, forcing them
to learn new paradigms from scratch, while they want to keep
enjoying their "senior developer" job titles and salaries. Second,
radical architectural changes always jeopardize the stability of
the existing software.

This is what I did:

  * First, I picked the youngest and the most talented ones (at the same time). I talked
    to all of them and found out who had the highest potential. Pay attention,
    I picked not the best, but the ones I believed were most interested in learning
    and growing professionally. No surprise, they were the youngest (career-wise, not by age). It was
    obvious that they didn't have enough professional mentoring and no growth
    strategy. It was Spring, what growth can we talk about, right?

  * Second, I unofficially became their mentor. This is what junior and ambitious
    engineers need most: a teacher. Someone, who can show them the learning
    path and the direction to new knowledge. My mentorship was simply about
    reviewing the code they wrote and telling them what was wrong, supporting
    my criticism with my own blog posts and many other articles/books I could find
    about "good" software design.

  * Third, I organized regular weekly lectures for the entire team. I was spending
    an hour every Monday speaking in front of them and explaining why
    NULL [is bad]({% pst 2014/may/2014-05-13-why-null-is-bad %}),
    unit tests [are good]({% pst 2017/mar/2017-03-24-tdd-that-works %}),
    and so on. Everybody was free to attend. No surprise,
    my "students" were always attending.

  * Fourth, I was refactoring the code base at some critical places and asking
    my "students" to review my pull requests. These small challenging tasks gave us good
    material to debate and united our sub-team even better. My ultimate goal
    was to assemble a gang who agreed with me. Reviewing each others code
    was a perfect method for this.

In just a few months it became obvious for everybody that the entire team
was not that solid anymore. We had the mainstream majority and the true-OOP minority
gathered around me. The status quo started to shake. The minority were
not happy about the architecture and were not afraid anymore to say so. The
architecture was still bad, but it was not "our" architecture anymore. It was
something we inherited from the past and we were committed
to changing it ... eventually.

{% quote Don't wait until your boss changes your title, start building a team of supporters. %}

My first and primary objective was not to fix the architecture, but to
build a _coalition_ of supporters, and it was achieved.
I didn't manage to get the majority though.
There were only 7 people in my gang. But this size was enough to change the
direction of the entire team of 30 programmers. Others passively
joined us later.

I left that project in less than a year (I wasn't fired). However, when I was leaving, it was
heading in the right direction: test coverage was growing, objects were
becoming immutable, new DTOs were not being created,
and so on. Spring Framework was still there, though.

You can do exactly the same in your team, even if your position is still
a "junior" developer. Don't wait until your boss changes your title, start
mentoring people around you and building a team of supporters. When it gets
big enough, the changes will start happening even without your will.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">What is the best argument to convince a team?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1201034995336450049?ref_src=twsrc%5Etfw">December 1, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
