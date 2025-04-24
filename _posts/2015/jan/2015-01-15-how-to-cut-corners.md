---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "How to Cut Corners and Stay Cool"
date: 2015-01-15
tags: management agile
categories: jcg
description: |
  When a task you're working on is too big or you simply
  don't want to do it, you cut corners; here is how you can
  do it professionally.
keywords:
  - agile task management
  - agile task management open source
  - how to manage tasks agile
  - agile planning
  - agile task planning
  - time management agile
translated:
  - Spanish: https://medium.com/@izarodsos/c%C3%B3mo-tomar-atajos-y-quedarte-tranquilo-ddfc680c97e8
image: /images/2015/01/regarding-henry.jpg
jb_picture:
  caption: Regarding Henry (1991) by Mike Nichols
---

You have a task assigned to you, and you don't like it. You are simply
not in the mood. You don't know how to fix that damn bug. You have no idea
how that bloody module was designed, and you don't know how it works. But
you have to fix the issue, which was reported by someone who has no clue how
this software works. You get frustrated and blame that
[stupid project manager]({% pst 2015/sep/2015-09-22-micromanagement %}) and
programmers who were fired two years ago. You spend hours just to find out
how the code works. Then even more hours trying to fix it. In the end,
you miss the deadline and _everybody blames you_. Been there, done that?

<!--more-->

{% jb_picture_body %}

There is, however, an alternative approach that provides a professional exit
from this situation. Here are some tips I recommend to my peers who code with me
in [Zerocracy](https://www.zerocracy.com) projects.
In a nutshell, I'm going to explain how you can _cut corners_ and remain
professional, 1) protecting your nerves, 2) optimizing your project's expenses,
and 3) increasing the quality of the source code.

{% youtube b6r2W3P9vgY %}

Here is a list of options you have, in order of preference. I would
recommend you start with the first one on the list and proceed down when you
have to.

## Create Dependencies, Blame Them, and Wait

This is the first and most preferable option. If you can't figure out
how to fix an issue or how to implement a new feature, it's a fault
of the project, not you. Even if you can't figure it out because you
don't know anything about Ruby and they hired you to fix bugs
in a Ruby on Rails code base---it's their fault. Why did they hire
you when you know nothing about Ruby?

So be positive; don't blame yourself. If you don't know how this
damn code works, it's a fault of the code, not you. Good code is
easy to understand and maintain.

{% badge /images/2015/01/cut-corners-1.png 250 %}

Don't try to eat spaghetti code; complain to the chef and ask
him or her to cook something better (BTW, I love spaghetti).

How can you do that? Create dependencies---new bugs complaining
about unclear design, lack of unit tests, absence of necessary classes, or
whatever. Be creative and offensive---in a constructive and professional way,
of course. Don't get personal. No matter who cooked that spaghetti, you have
nothing against him or her personally. You just want another dish, that's all.

{% quote If you don't know how this damn code works, it's a fault of the code, not you. %}

Once you have those dependencies reported, explain in the main ticket
that you can't continue until all of them are resolved. You will
legally stop working, and someone else will improve the code you need. Later,
when all dependencies are resolved and the code looks better, try to
get back to it again. If you still see issues, create new dependencies.
Keep doing this until the code in front of you is clean and easy to fix.

Don't be [a hero]({% pst 2015/dec/2015-12-29-turnover-is-good-for-maintainability %})---don't rush into fixing the
[bad code]({% pst 2015/nov/2015-11-24-imprisonment-for-irresponsible-coding %}) you inherited. Think
[like a developer, not a hacker]({% pst 2014/oct/2014-10-26-hacker-vs-programmer-mentality %}).
Remember that your first and most important responsibility as
a disciplined engineer is to help the project _reveal_ maintainability issues.
Who will fix them and how is the responsibility of a
[project manager]({% pst 2016/may/2016-05-24-who-is-project-manager %}).
Your job is to reveal, not to hide. By being a hero and trying to fix everything
in the scope of a single task, you're not doing the project a favor---you're concealing the problem(s).

Edit: Another good example of a dependency may be a question raised
at, for example, [Stack Overflow]({% pst 2017/feb/2017-02-14-stackoverflow-is-your-tool %})
or a user list of a third-party library.
If you can't find a solution yourself and the problem is outside of the scope
of your project---submit a question to SO and put its link to the
source code (in JavaDoc block, for example).

## Demand Better Documentation and Wait

All dependencies are resolved and the code looks clean, but you still
don't understand how to fix the problem or implement a new feature. It's
too complex. Or maybe you just don't know how this library works. Or you've
never done anything like that before. Anyhow, you can't continue because
you don't understand. And in order to understand, you will need a lot of
time---much more than you have from your project manager or your Scrum board. What
do you do?

{% badge /images/2015/01/cut-corners-2.png 250 %}

Again, think positively and don't blame yourself. If the software is not
clear enough for a total stranger, it's "their" fault, not yours. They created
the software in a way that's difficult to digest and modify. But the code is
clean; it's not spaghetti anymore. It's a perfectly cooked lobster, but
you don't know how to eat lobster! You've never ate it before.

The chef did a good job; he cooked it well, but the restaurant didn't give
you any instructions on how to eat such a sophisticated dish. What do you do?

You ask for a manual. You ask for documentation. Properly designed
and written source code must be properly documented. Once you see that
something is not clear for you, create new dependencies that ask for better
documentation of certain aspects of the code.

Again, don't be a hero and try to understand everything yourself. Of course
you're a smart guy, but the project doesn't need a single smart guy. The
project needs
[maintainable code]({% pst 2015/dec/2015-12-29-turnover-is-good-for-maintainability %})
that is easy to modify, even by someone
who is not as smart as yourself. So do your project a favor: reveal the
documentation issue, and ask someone to fix it for you. Not just for you,
for everybody. The entire team will benefit from such a request.
Once the documentation is fixed, you will continue with your
task, and everybody will get source code that is a bit better than it
was before. Win-win, isn't it?

## Reproduce the Bug and Call It a Day

Now the code is clean, the documentation is good enough,
but you're stuck anyway. What to do?
Well, I'm a big fan of test-driven development, so my next suggestion would be
to create a test that reproduces the bug. Basically, this is what you should start
every ticket with, be it a bug or a feature. Catch the bug with a unit test!
Prove that the bug exists by failing the build with a new test.

{% badge /images/2015/01/working-effectively-with-legacy-code.png 96 https://amzn.to/1SdcZ8M %}

This may be rather difficult to achieve, especially when the software you're
trying to fix or modify was written by <span class="strike">idiots</span>
someone who had no idea about unit testing. There are plenty of techniques
that may help you find a way to make such software more testable. I would
highly recommend you read
[Working Effectively with Legacy Code](https://amzn.to/1SdcZ8M)
by Michael Feathers. There are many different patterns, and most of them work.

{% quote Catching a bug with a unit test is, in most cases, more than 80% of success. %}

Once you manage to reproduce the bug and the build fails, stop right there.
That's more than enough for a single piece of work. Skip the test
(for example, using `@Ignore` annotation in JUnit 4) and commit your changes.
Then add documentation to the unit test you just created, preferably in the
form of a `todo`. Explain there that you managed to reproduce the problem
but didn't have enough time to fix it. Or maybe you just don't know how to
fix it. Be honest and give all possible details.

I believe that catching a bug with a unit test is, in most cases, more than 80% of success.
The rest is way more simple: just fix the code and make the test pass. Leave
this job to someone else.

## Prove a Bug's Absence

Very often you simply can't reproduce a bug. That's not because the code is not
testable and can't be used in a unit test but because you can't reproduce
an error situation. You know that the code crashes in production, but you can't
crash it in a test. The error stack trace reported by the end user or your
production logging system is not reproducible. It's a very common situation.
What do you do?

{% badge /images/2015/01/cut-corners-3.png 250 %}

I think the best option here is to create a test that will prove that
the code works as intended. The test won't fail, and the build will remain clean.
You will commit it to the repository and ... report that the problem is solved.
You will say that the reported bug doesn't really exist in real life. You
will state that there is no bug---"our software works correctly; here
is the proof: see my new unit test."

Will they believe you? I don't think so, but they don't have a choice. They
can't push you any further. You've already done something---created
a new test that proves everything is fine. The ticket will be closed
and the project will move on.

{% youtube YBQoTZ-1X-o %}

If, later on, the same problem occurs in
production, a new bug will be reported. It will be linked to your ticket. Your
experience will help someone investigate the bug further. Maybe that
guy will also fail to catch the bug with a test and will also create
a new, successful and "useless" test. And this may happen again and again.
Eventually, this cumulative group experience will help the last guy
catch the bug and fix it.

Thus, a new passing test is a good response to a bug that you can't catch
with a unit test.

## Disable the Feature

Sometimes the unit test technique won't work, mostly because a bug will be
too important to be ignored. They won't agree with you when you show them
a unit test that proves the bug doesn't exist. They will tell you
that "when our users are trying to download a PDF, they get a blank page."
And they will also say they don't really care about your bloody
unit tests. All they care about is that PDF document that should be
downloadable. So the trick with a unit test won't work. What do you do?

{% quote Production errors are not programmers' mistakes, though delayed tickets are. %}

It depends on many factors, and most of these factors are not technical.
They are political, organizational, managerial, social, you name it. However,
in most cases, I would recommend you disable that toxic feature,
release a new version, and close the ticket.

You will take the problem off your shoulders and everybody will be pleased.
Well, except that poor end user. But this is not your problem. This is the
fault of management, which didn't organize pre-production testing properly.
Again, don't take this blame on yourself. Your job is to keep the code
clean and finish your tickets in a reasonable amount of time. Their
job is to make sure that developers, testers, DevOps, marketers, product
managers, and designers work together to deliver the product with an
acceptable number of errors.

Production errors are not programmers' mistakes, though delayed
tickets are. If you keep a ticket in your hands for too long, you become
an unmanageable unit of work. They simply can't manage you anymore. You're doing
something, trying to fix the bug, saying "I'm trying, I'm trying ..."
How can they manage such a guy? Instead, you should deliver quickly, even if
it comes at the cost of a temporarily disabled feature.

## Say No

OK, let's say none of the above works. The code is clean, the documentation
is acceptable, but you can't catch the bug, and they don't accept a unit
test from you as proof of the bug's absence. They also don't allow you to
disable a feature, because it is critical to the user experience. What choices
do you have? Just one.

{% badge /images/2015/01/cut-corners-4.png 250 %}

Be professional and say "No, I can't do this; find someone else."
Being a professional developer doesn't mean being able to fix any problem. Instead,
it means honesty. If you see that you can't
fix the problem, say so as soon as possible. Let them decide what to do.
If they eventually decide to fire you because of that, you will remain a
professional. They will remember you as a guy who was honest and took his
reputation seriously. In the end, you will win.

Don't hold the task in your hands. The minute you realize you're
not the best guy for it or you simply can't fix it---notify
your manager. Make it his problem. Actually, it is his problem in the
first place. He hired you. He [interviewed]({% pst 2016/mar/2016-03-01-how-we-interview-programmers %})
you. He decided to give you this
task. He estimated your abilities and your skills.
So it's payback time.

{% quote Being a professional developer doesn't mean being able to fix any problem. %}

Your "No!" will be very valuable feedback for him. It will help him
make his next important management [decisions]({% pst 2023/aug/2023-08-15-decision-making-process %}).

On the other hand, if you lie just to give the impression you're a guy who
can fix anything and yet fail in the end, you will damage not only your
reputation but also the project's performance and objectives.
