---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: static
title: "Research"
description: |
  If you are a student, or a team of students, you are welcome to pick
  one of the research topics, write a paper together with me,
  and get a stipend of $4,096.
permalink: research.html
image: /images/andreea/academic-writing.png
keywords:
  - publications
  - papers
  - academic papers
  - yegor bugayenko stipend
  - stipend for research
---

{% badge /images/andreea/academic-writing.svg 175 %}

Aside from being a programmer, I'm also a part-time researcher.
You can find me in [Scopus], [Google Scholar], and [DBLP] too.
I'm also a chair of the organization committee of the [ICCQ] conference.
I'm interested in answering two primary research questions:

* **Can robots increase [η] of humans?**

* **Can objects be faster than functions?**

As you can imagine, the questions are challenging, especially for a solo researcher.
I need your help.
If you are a student, a practitioner, a professor, or a team of them---we can do a study together.
I'm not looking for free help, though, and am prepared to reward you.

This is how it works:
First, you pick up one of the secondary research questions listed below.
Then, you reach out to me to get an approval to start the research ([text me][tg]).
Then, we together do the study, write a paper, and try to publish it on a _Technical Track_ of an A*-conference, as co-authors.
When the paper is accepted by a conference, I pay you a stipend of **$4,096** (per paper, not per author).

If you have some talent and work hard, at least 20 hours per week, a study should take about three months.
If it takes longer or finishes sooner, the amount of reward remains the same.

An important thing to note before you start: we must strictly follow the [Research Flow]({% pst 2024/feb/2024-02-06-research-flow %}) guidelines.
If we fall off the schedule, I may stop contributing to the study.
I simply can't afford spending time on every single project, especially if the discipline is compromised.
However, even if I stop contributing, you may still publish the study, but without my name on it.
In this case you will get only **$1,024**.

If we together or you alone publish it on a B+ conference, you get **$256**.

If I suspect that the paper is being written by AI, I will walk away immediately.

Now, the research questions, most important at the top:

* Can types of _all_ objects and in _all_ programs be inferred in [EO](https://www.eolang.org),
  a dynamically typed object-oriented programming language that
  [doesn't have]({% pst 2025/aug/2025-08-17-type-annotations %})
  type annotations?

* Can any Java program _map_ to [𝜑-calculus] and backwards
  (we've [tried](https://github.com/polystat/j2eo),
  also for [C](https://github.com/polystat/c2eo) and
  [Python](https://github.com/polystat/py2eo))?

* Can _confluence_ of [𝜑-calculus] be proven using [Lean4]
  (we've [tried](https://github.com/objectionary/proof))?

* How different is the _productivity_ of a team paid
  per time vs. the team paid per delivered results
  ([some data]({% pst 2014/apr/2014-04-11-cost-of-loc %}) already available)?

* How do the most popular object-oriented programming languages _benchmark_
  on dynamic dispatch and object allocation features
  ([some data](https://github.com/yegor256/fibonacci) is ready)?

* How does _measuring_ work results affect human motivation?

* How often are _virtual table_ calls used in modern open source C++ projects
  [we've [done it](https://arxiv.org/abs/2410.05631) for Java]?

* How many design patterns, out of all actively used ones, are _dataless_
  (the [dataset](https://github.com/yegor256/cam) is ready)?

* How often and how objectively, in 50+ surveyed software teams,
  is the _output_ of programmers' work measured?

I update the list regularly.
Please, revisit it later to check for changes.

[Scopus]: https://www.scopus.com/authid/detail.uri?authorId=30367443600
[Google Scholar]: http://scholar.google.ru/citations?user=cYmXh60AAAAJ
[DBLP]: https://dblp.uni-trier.de/pers/hd/b/Bugayenko:Yegor
[tg]: https://t.me/yegor256
[ICCQ]: https://www.iccq.ru/
[η]: https://en.wikipedia.org/wiki/Energy_conversion_efficiency
[𝜑-calculus]: https://arxiv.org/abs/2111.13384
[Lean4]: https://github.com/leanprover/lean4
