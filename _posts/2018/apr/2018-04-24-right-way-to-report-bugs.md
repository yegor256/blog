---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "The Right Way to Report a Bug"
date: 2018-04-24
place: Moscow, Russia
tags: testing zerocracy
description: |
  Not every bug you report will be accepted by a project
  and paid for; here is a list of tricks to increase
  your chances.
keywords:
  - pay per bug
  - good bug
  - quality of bugs
  - bug quality
  - good defects
image: /images/2018/04/burn-after-reading.jpg
jb_picture:
  caption: Burn After Reading (2008) by Coen Brothers
---

You know, at [Zerocracy](https://www.zerocracy.com), either you are a programmer or a tester,
and [we pay]({% pst 2014/apr/2014-04-13-bugs-are-welcome %})
for each bug you find and report. Well, not quite. We pay for
each bug report a project architect considers good enough to pay for.
The architect's decision is totally subjective and non-disputable,
according to [§29](https://www.zerocracy.com/policy.html#29)
of the [Policy](https://www.zerocracy.com/policy.html).
Some of our developers find this unfair and ask me to explain
how they can report bugs such that they are definitely paid.
Here is a non-exhaustive list of my recommendations.

<!--more-->

{% jb_picture_body %}

To be honest, there are [many articles](https://www.google.com/search?q=how+to+write+good+bug+reports)
written before on this very subject. I will try not to repeat them. They
mostly say reasonable things, like
"be specific,"
"choose a strong title,"
"avoid duplicates," and many others.
My recommendations here are more of a psychological nature.

**Stay cool**.
Don't expect all of your bugs to be accepted and paid for.
Some of them won't be.
This must not stop you from reporting them.

{% quote Present it as if the entire world will collapse tomorrow if they don't fix it. %}

**Exaggerate**.
No matter how minor the bug is, present it as if the entire world will
collapse tomorrow if they don't fix it.
Of course, they will make their own decision about the priority and severity of the bug,
but don't help them to make it against you.

**Victimize yourself**.
Don't just say "the class is broken"---there is no victim in this statement.
So, no need to save anyone's life. The bug is minor---no need to pay.
Instead, say "I can't use the class." Present yourself as a victim.
Or even better, represent a group of victims: "Nobody can really use this class."

**Push them**.
If a bug report is not paid for, don't hesitate to ask why.
Insist that it was a very important problem and you deserve to be paid.
If they still don't pay, forget it and move on.
You must not look like it offends you somehow.

{% youtube Hrk_Jorc5z4 %}

**Show efforts**.
The bug description must look "rich," clearly demonstrating that
you invested a lot of effort in its creation. If there is just a single line,
it's easier for them to not pay you---they won't feel any guilt.
However, if it's long, detailed, properly formatted, and contains multiple supporting links,
they will feel bad if they don't pay.

**Look engaged**.
Say something like "I'm ready to investigate more and provide additional details,
if you need me too." Of course you won't do that (in most cases),
but you have to say it. This will look like you care and this bug comes
right from your heart. How can they not pay for it?

**Look altruistic**.
Don't show them that you are reporting these bugs just to get money.
They know that anyway, but still.
Look like you care about the project and honestly want to help.
Say that you worry about the users, about the market, about the mission, about
the bigger scope, etc.

**Aggregate**.
This may sound against the
[principles]({% pst 2014/nov/2014-11-24-principles-of-bug-tracking %})
of bug tracking I suggested earlier,
but when your bugs are small and cosmetic---aggregate them. In such a
case you have a chance to win. They will reject three minor bugs, but they
won't reject a bigger one with three minor parts.

I believe that if you follow these simple recommendations,
you will be a more successful bug reporter. At least at
[Zerocracy](https://www.zerocracy.com).

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">What do you feel when you report a bug? <a href="https://twitter.com/hashtag/codeahead?src=hash&amp;ref_src=twsrc%5Etfw">#codeahead</a> <a href="https://twitter.com/hashtag/bugs?src=hash&amp;ref_src=twsrc%5Etfw">#bugs</a></p>--- Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1023455022997233664?ref_src=twsrc%5Etfw">July 29, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
