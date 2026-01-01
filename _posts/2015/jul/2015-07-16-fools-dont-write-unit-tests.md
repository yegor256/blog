---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Fools Don't Write Unit Tests"
date: 2015-07-16
tags: tdd
categories: jcg
place: Palo Alto, CA
description: |
  A unit test is a tool, not a product; the absence
  of unit testing can't be excused due to a
  lack of time or budget.
keywords:
  - unit testing
  - unit testing best practices
  - unit testing tools
  - unit testing definition
  - unit testing cost benefit analysis
image: /images/2015/07/ex-machina.jpg
jb_picture:
  caption: Ex Machina (2015) by Alex Garland
---

"We don't have time to write unit tests" or "We don't have the
budget for unit testing" are complaints I hear very often. Sometimes it
may sound like, "We don't use
[TDD]({% pst 2017/mar/2017-03-24-tdd-that-works %}), so that's why there are no unit tests," or even
"TDD is too expensive for us now." I'm sure you've heard this or even
said it yourself. It doesn't make any sense to me. I don't get the
logic. In my understanding, unit testing is not
a product; it's a _tool_. You use tests to develop a product
faster and better. How can you say you don't have time to use
the tool that makes your work faster? Let me show you how.

<!--more-->

{% jb_picture_body %}

[TDD or not]({% pst 2017/mar/2017-03-24-tdd-that-works %}),
a unit test is a unit test. Either you create it before
the main piece of code or after it.

A unit test is a _tool_ that helps you, a developer of software,
"run" your stuff and see how it works. How else can you check if it works?
When I hear, "I don't have time for unit tests," my next question is:
"How did you test your code?"

I seriously can't understand how it is possible to write something
and then not test it. Well, unless you're
[paid monthly]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %})
and nobody really cares about your deliverables. If you do care about the software
you produce, you're interested in seeing it in action, right?

So, how do you do this?

If it's a one-page PHP website, you can probably run it locally on Apache,
modify it on disk, and then `Cmd`+`R` many times. That will work for a primitive
piece of code and only for you, a single developer of it. But I hear
this "I don't have time" argument from programmers working on _enterprise_
systems. How do you guys test your code?

{% quote Not because you didn't have time, you just didn't know how. %}

I would compare unit tests with OOP classes. You can design the entire application
in a single class with a few thousand methods. You will save time on creating
other classes, structuring them, thinking about connections between them, etc.
It will be a single 20,000-line `.java` file. And you'll say that "you didn't
have time to create classes," right? What would we say about such a product and the
author of it? Right, we'd say he or she is just _stupid_. And it has nothing
to do with time or budget. Such a programmer just doesn't know how to use
object-oriented programming tools, like
[encapsulation]({% pst 2016/nov/2016-11-21-naked-data %}),
[inheritance]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %}), polymorphism,
interfaces, [method overloading]({% pst 2023/aug/2023-08-01-method-overloading %}),
etc. It's not about time or budget; it's about
skills and discipline.

The same is true for unit tests. If you create code without unit tests,
it may work, just like that monster class with 20,000 lines, but the quality
of your product will be very low. And not because you didn't have time to
write unit tests, but because you _didn't know_ how to do it.

So every time I hear, "I didn't have time for unit testing," I understand
that you just didn't know how and are trying to conceal that fact behind
false excuses. It's not professional, to say the least.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Why don&#39;t you write unit tests? <a href="https://twitter.com/hashtag/testing?src=hash&amp;ref_src=twsrc%5Etfw">#testing</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1079264946356211712?ref_src=twsrc%5Etfw">December 30, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
