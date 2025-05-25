---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Stop Asking and Suggesting — Just Complain"
date: 2025-05-25
place: Moscow, Russia
tags: management testing
description: |
  When every piece of work is framed as a bug report --- including
  feature requests and questions --- a software team may become more productive.
keywords:
  - bug driven development
  - bugs and TDD
  - TDD
  - test driven development
  - tests and bugs
image: /images/2025/05/ghost-dog.jpg
jb_picture:
  caption: Ghost Dog (1999) by Jim Jarmush
---

Wikipedia [says][wiki] that Bug Driven Development (BDD) is an anti-pattern.
[Raja Shankar Kolluru] perfectly [explains][rajakolluru2010] why.
However, [Florian Rappl][Florian Rappl] [argues][rappl2014] that it's not.
[Ben Winding][Ben Winding] [believes][winding2022] that it's better than TDD.
In simple words, BDD is kind of like trying to build a plane while it's flying, based on passenger complaints.
Nobody builds planes like that (well, maybe [Boeing][travis2019] and [Airbus][gibbs2015]).
However, a software team that practices BDD might demonstrate higher productivity.

<!--more-->

{% jb_picture_body %}

A software team does BDD if it follows one simple principle:
Every piece of work is formulated as a **complaint**.

It started [in 2002][reis2002], by Mozilla:

> Every code change in the Mozilla codebase is made as part of a "fix" for a uniquely numbered "bug." Though it commonly has a pejorative connotation, in the Mozilla Project the term bug is used to refer to any filed request for modification in the software, be it an actual defect, an enhancement, or a change in functionality.

If you listen to Mozilla's advice, you won't have feature requests, or questions, or tasks in your [issue tracking system].
Only bug reports.
They may sound like "The wing is on fire!"---a perfect complaint---or "A plane doesn't have a jacuzzi!"---a perfect feature request in the form of a complaint.
Questions may also look like complaints: "It is unclear how to fasten the belt."
Whether they are coming from testers or customers, the format is the same: "I don't like it."

The primary benefit that BDD can give to a project is **noise reduction**.
I can think of two reasons for that:

1. Complaints, due to their rather aggressive nature, require their authors to provide strong arguments to back them up.
They must think twice before submitting a ticket that accuses the codebase of being broken or imperfect.
They must be specific and precise.
No noise.

2. Similarly, programmers must convince a complainant that the problem is resolved.
They can't close the ticket with just a text answer.
They need to demonstrate a reasonably significant contribution to the codebase.
No noise.

A good complaint identifies a **flaw** in something tangible.
A good resolution of a good complaint is a **patch** to that tangible something.
Obviously, in a software project, the **source code** is what is tangible.

In a disciplined team, every ticket is a bug report that addresses a flaw in the source code.
Every bug report leads to a patch---a contribution to the source code.
No noise.
The team is focused and demonstrates the best possible productivity.

BDD also has a major drawback.
It may be hard to train the team to use it.
The adoption of BDD may require a change of their **mindset**.
They must switch from noise-makers to flaw-finders.

[Jeff Atwood], in his blog post about [complaint-driven development][atwood2014], explains it from a business point of view.
He suggests that instead of implementing what you believe is right, it's better to give your customers a rough draft and let them complain.
You're most often wrong about what they'll actually complain about.
The more they complain, the better you listen, the bigger the value you deliver.


[reis2002]: https://www.researchgate.net/publication/2559439_An_Overview_of_the_Software_Engineering_Process_and_Tools_in_the_Mozilla_Project
[wiki]: https://en.wikipedia.org/wiki/Tester-driven_development
[Florian Rappl]: https://github.com/FlorianRappl
[Ben Winding]: https://github.com/benwinding
[Raja Shankar Kolluru]: https://github.com/rajakolluru
[rajakolluru2010]: https://itmusings.com/bug-driven-development/
[winding2022]: https://blog.benwinding.com/bug-driven-development-sometimes-its-the-best-choice/
[rappl2014]: https://www.florian-rappl.de/News/Page/227/bug-driven-development
[Jeff Atwood]: https://blog.codinghorror.com/about-me/
[atwood2014]: https://blog.codinghorror.com/complaint-driven-development/
[issue tracking system]: https://en.wikipedia.org/wiki/Issue_tracking_system
[travis2019]: https://spectrum.ieee.org/how-the-boeing-737-max-disaster-looks-to-a-software-developer
[gibbs2015]: https://www.theguardian.com/technology/2015/may/20/airbus-issues-alert-software-bug-fatal-plane-crash
