---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "The Method Section: A Recipe for Research"
date: 2023-10-11
place: Nizhny Novrogod, Russia
tags: science
description: |
  The essence of a research paper is the Method section,
  which may be easier to write if you follow a few
  simple principles.
keywords:
  - method section
  - method of research
  - how to write method of research
  - method of paper
  - method section in paper
image: /images/2023/10/underground.jpg
jb_picture:
  caption: Underground (1995) by Emir Kusturica
---

Every empirical research paper must have a section titled "Method" (or "Methodology," or "Study Design"). In this section, you describe what was done to obtain the data presented in the following "Results" section. You explain the _recipe_, which may be replicated later by another researcher, leading to the same (or very similar) results. You
tell the reader what ingredients you used, how you mixed them, and---most
importantly---why.

<!--more-->

{% jb_picture_body %}

You start the section with a paragraph where you state the main _objective_ of the
research, then break it down into a few
[_research questions_](https://en.wikipedia.org/wiki/Research_question) (RQs),
which are question-mark-ending sentences.

Then, you explain the _procedures_ of the method (strictly one procedure per paragraph).
In each step, you either collected, combined, or generated data. First, you explain what
you did. Second, you highlight how your procedure contributed to one of the
research questions. Third, you justify your actions by providing strong enough
reasons for why you performed these specific manipulations with the data.

Use past tense
[only](https://www.scribbr.com/frequently-asked-questions/tense-methods-section/).

Here is a toy sample of the Method section:

```
\section{Method}

The goal of this study is to understand whether
cats love fruits. This leads to the following
research questions:
\begin{description}
\item[RQ1] What is a correlation between the color
of a cat's fur and its passion for fruits?
\item[RQ2] Which fruits are preferred by cats:
bananas, apples, or marakujas?
\end{description}

First, we found 15 cats: 2 white, 3 black,
and 10 of mixed color. It is important for RQ1
that they are of different colors. We believe
that 15 is enough because this is a toy research.

Second, we excluded 5 cats: those who were
younger than one year old or older than 8 years
old. This was motivated by RQ2; we decided that
young and old cats may have difficulty cracking
the hard cover of a marakuja.

Third, we gave our cats all three fruits mentioned
in RQ2, left them for an hour, and observed their
behavior. One hour was enough for a hungry
cat to make a decision.

All cat owners agreed to have their cats
participate in the study.
```

At the end of the section, we mentioned that all participants in the experiment
provided informed consent—this is important if humans (or cats) are involved,
so don't forget about it.

In the "Results" section, which follows the Method, you
[present]({% pst 2023/dec/2023-12-11-results-and-discussion %}) the data that
were collected, combined, or generated (without giving any opinion or
subjective interpretation of it!). Some of this data may have already been
mentioned in the Method section, but not the most important details. For
example, we've already said that we found 15 cats, but we didn't provide their
names, ages, or breeds---this information goes into the Results, in the form of
a nicely formatted table. How much "results" to show in the Method and how much
in the Results is, I believe, a matter of taste.

In the "Discussion" section, which follows the Results, you
[engage in a dialogue]({% pst 2023/dec/2023-12-11-results-and-discussion %})
with yourself, questioning the procedures of the Method. This is where
you are allowed to have an opinion about the data collected, combined, and
generated. For example, we may discuss whether the results of our research
are trustworthy enough, taking into account that we only analyzed the behavior
of just 15 cats, while in the Method, we were absolutely sure that we were doing
the right thing. In the Discussion, you play the opposite role by doubting
every single step of the Method, highlighting its weaknesses and limitations.

<hr/>

You may find inspiration in these papers
(use [Google Scholar](https://scholar.google.com/) to download their PDFs):

  * Melina Vidoni, _Evaluating Unit Testing Practices in R Packages_, ICSE 2021
  * Reem S. Alsuhaibani et al., _On the Naming of Methods: A Survey of Professional Developers_, ICSE 2021
  * Anastasia Ruvimova et al., _An Exploratory Study of Productivity in Software Teams_, ICSE 2022

<hr/>

These opinions might also be helpful:

  * [How to Write Research Methodology](https://research.com/research/how-to-write-research-methodology)
    by [Imed Bouchrika](https://scholar.google.com/citations?user=kudrpNsAAAAJ)
  * [Writing the 'Research Methods'...](https://www.youtube.com/watch?v=SxKd66g7M1s) (video)
    by [David Russell](https://soc.appstate.edu/faculty-staff/david-russell-phd)
  * [How To Write Methodology...](https://www.youtube.com/watch?v=jWPul_eifeU) (video)
    by [Marek Kiczkowiak](https://scholar.google.com/citations?user=MR45-AwAAAAJ)
  * [Formulation of Research Question](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6322175/)
    by Simmi K. Ratan
