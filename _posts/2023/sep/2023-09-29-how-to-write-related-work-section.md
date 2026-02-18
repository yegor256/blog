---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Related Work: A Critical Taxonomy of Prior Art"
date: 2023-09-29
place: Moscow, Russia
tags: science
description: |
  In every reseach paper, the "Related Work" section is one of
  the most important and probably the most difficult to write.
keywords:
  - related work
  - related works
  - paper references
  - research paper references
  - how many references
image: /images/2023/09/mean-streets.jpg
jb_picture:
  caption: Mean Streets (1973) by Martin Scorsese
---

In almost any research paper, it is mandatory to have a section titled "Related Work"
([or "Related Works"](https://english.stackexchange.com/questions/55898/related-work-or-related-works)),
where you refer to the results previously obtained by other
authors or yourself. By including this section in your paper, you are not only paying
respect to those who laid the foundation for your results, but also motivating and guiding
your readers. Most of them may not be aware of existing studies or
the importance of the problem you are solving. You must put these guys into
[context]({% pst 2018/oct/2018-10-16-dont-make-me-guess %}).

<!--more-->

{% jb_picture_body %}

As far as I understand it, a well-crafted "Related Work" section should convey the following _message_:

  * Not only you believe that the problem is important,
  * Previous studies have either overlooked or failed to solve it, and
  * Your research is not a mere replication of someone else's work.

Before diving in, let's clarify that the "Related Work" section
[is not](https://academia.stackexchange.com/questions/157842) the place
to explain foundational concepts like
[Deep Learning](https://en.wikipedia.org/wiki/Deep_learning) or
[Dataflow Architecture](https://en.wikipedia.org/wiki/Dataflow_architecture).
That's what the "[Background](https://scientific-publishing.webshop.elsevier.com/manuscript-preparation/what-background-study-and-how-should-it-be-written/)" section is for.
In "Related Work," it's assumed that the reader is already familiar with the subject matter.

To effectively communicate the three-fold message, create a _taxonomy_ of existing studies.
In simple terms, classify them. For instance, if your paper focuses on a new type
of cat food designed to extend feline longevity and improve happiness,
your "Related Work" section might look like this:

```
There are three categories of research related to our
study: cat food, cat happiness, and cat lifespan.

Earlier studies [2, 13, 8] have suggested that
cat food containing meat [21], potato [11], and
fish [7] results in complaints in only 7.5% of all
cases. However, no experiments have been conducted
with food made from fruits.

The happiness of cats and other pets has been
studied by Johnson [22] and Dickson [17]. They
identified a strong correlation between the mood
of a pet's owner and the mood of the pet. However,
they did not investigate the effect of food on cat
happiness.

It has been observed [15, 18] that cats live
longer when they consume food with fewer carbohydrates
and more protein. However, these experiments were
conducted with cats living in only one city, which
limits the applicability of these studies.

To the best of our knowledge, the method of feeding
cats with fruits to increase their happiness and
prolong their lives has not been studied yet.
```

Note the use of the word "_however_" in the last sentence of each paragraph.
It highlights gaps in existing research that your study aims to fill.
The final paragraph confirms your awareness that your research is unique.
While you might be mistaken, explicitly stating your unawareness would make it an honest mistake.

In this toy example, we've categorized all relevant prior work into
three groups. We've cited key papers in each category and summarized
their findings relevant to our study. We've also highlighted areas
that our research will address, emphasizing its novelty.

When gathering references for the "Related Work" section, you'll likely
encounter many papers worth mentioning. How do you decide which to cite?
Consider the following factors:

  * Relevance: The closer it is to your topic, the better.
  * Citations: Opt for papers that are cited more frequently.
  * Venue: Consult [journal rankings](https://www.scimagojr.com/journalrank.php) and [conference rankings](http://portal.core.edu.au/conf-ranks/) to choose the most reputable sources.

Lastly, [Google Scholar](https://scholar.google.com) is the best place
for finding prior work. If you can't access a PDF version of a paper, try the Telegram bot:
[@scihubbot](https://t.me/scihubbot).

<hr/>

These articles and books might also be helpful:

  * [How to write a Related Work...](https://www.youtube.com/watch?v=tBud5yewkkc&t=19s) (video)
    by [Simone Silvestrini](https://scholar.google.com/citations?user=cZ5pY9wAAAAJ)
  * [Literature Review: Step by Step...](https://www.youtube.com/watch?v=rk_jgtdJOD0) (video)
    by [David Stuckler](https://scholar.google.com/citations?user=W03REUoAAAAJ)
  * [A Formula for Academic Papers: Related Work](http://slowsearching.blogspot.com/2014/11/a-formula-for-academic-papers-related.html)
    by [Jaime Teevan](https://scholar.google.com/citations?user=F5Ik84MAAAAJ)
  * [How to write a research paper in science](http://lucalongo.eu/howtowritearesearchpaper.html)
    by [Luca Longo](https://scholar.google.com/citations?user=oBqRuY8AAAAJ)
  * [Writing the Literature Review](https://sites.umiacs.umd.edu/elm/2019/02/22/writing-the-literature-review/)
    by [Niklas Elmqvist](https://scholar.google.com/citations?user=LoQXe24AAAAJ)
  * [Why I Don't Write a “Related Work” Section](http://steveharoz.com/blog/2015/related-work-section/)
    by [Steve Haroz](https://scholar.google.com/citations?user=OcKUn3gAAAAJ)
  * [How to get a paper accepted at OOPSLA](https://dl.acm.org/doi/10.1145/165854.165934)
    by Kent Beck et al.
  * [Write good papers](https://lemire.me/blog/rules-to-write-a-good-research-paper/)
    by [Daniel Lemire](https://scholar.google.com/citations?user=q1ja-G8AAAAJ)
  * [Common mistakes in technical writing](https://web.archive.org/web/20260212094959/https://cs.dartmouth.edu/~wjarosz/writing.md.html)
    by [Wojciech Jarosz](https://scholar.google.com/citations?user=vrjL9p0AAAAJ)
  * [How to Write a Good Scientific Paper](https://spie.org/samples/9781510619142.pdf)
    by [Chris A. Mack](https://scholar.google.com/citations?hl=en&user=kMsXV0oAAAAJ)
  * [Writing for Computer Science](https://link.springer.com/book/10.1007/978-1-4471-6639-9)
    by [Justin Zobel](https://scholar.google.com/citations?hl=en&user=uEHvqE8AAAAJ)
