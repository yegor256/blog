---
layout: post
title: "Research Paper Simple Template"
date: 2022-08-24
place: Moscow, Russia
tags: science
description: |
  Here is a very simplified guideline for newbie academic
  writers like myself, to help you structure a paper
  in a way that won't surprise your reviewers too much.
keywords:
  - academic writing
  - scientific writing
  - how to write academic paper
  - writing for computer science
  - academic paper
image: /images/2022/08/il-camorrista.jpg
jb_picture:
  caption: Il Camorrista (1986) by Giuseppe Tornatore
---

My [first academic paper](http://dblp.uni-trier.de/db/conf/krdb/krdb98.html#Bugaenko98)
was accepted and published in 1998. My most recent one was rejected by SPLASH just a week ago.
I'm writing two papers right now and co-authoring about ten others.
So far, my results are very poor: way more rejections than I expected.
The key lesson I've learned so far: the reason most papers get rejected
is not because they are essentially wrong. Instead, reviewers reject them
because they have no enthusiasm for decrypting a poorly structured text,
even though it may contain potentially interesting thoughts.
In this blog post I suggest how to structure a [research paper](https://en.wikipedia.org/wiki/Research_paper).
Take it with a grain of salt though.

<!--more-->

{% jb_picture_body %}

Read [_Writing for Computer Science_](https://link.springer.com/book/10.1007/978-1-4471-6639-9) by Justin Zobel.

Use [LaTeX](https://www.latex-project.org), either locally or in [Overleaf](https://www.overleaf.com).

Read my personal [best practices](https://yegor256.github.io/latex-best-practices/main.pdf) for LaTeX.

Keep the same [organizational structure](https://www.sheffield.ac.uk/academic-skills/study-skills-online/academic-writing) in each paragraph.

## Title

The [title](https://www.nature.com/nature-index/news-blog/how-to-write-a-good-research-science-academic-paper-title)
is the [key message](https://www.nature.com/articles/d41586-018-02404-4) of your paper.

Use [this method](https://blog.wordvice.com/how-to-write-the-perfect-title-for-your-research-paper/) to invent it.

## Authors

I [suggest](https://www.youtube.com/watch?v=TF8MKOfo3gI) the following rule:
The first author in the list is you.
The last one is your boss.
Key contributors stay in the middle, in alphabetic order of their last names.
Everybody else is listed in the Acknowledgments section.

## Abstract

An [abstract](https://writing.wisc.edu/handbook/assignments/writing-an-abstract-for-your-research-paper/)
is a one-paragraph version of the paper, with an emphasis
on Introduction, Results, and Discussion.

## Introduction

[Answer](https://goldbio.com/articles/article/how-to-write-introduction-section)
these questions in this particular order:

  * What is going on in your field of study?
  * What is wrong?
  * Why is this Problem important?
  * Why is it not fixed yet by others?

Then, formulate your
[Research Question(s)](https://en.wikipedia.org/wiki/Research_question)
or a [Hypothesis](https://www.enago.com/academy/how-to-develop-a-good-research-hypothesis/).

Next, make a disputable [Thesis Statement](https://writingcenter.unc.edu/tips-and-tools/thesis-statements/).

Then, enumerate the Contributions that your article makes to science.
A Contribution is something tangible, which a reader can take from your study
and use somehow in their own studies.
A theorem, a method, a toolkit, a data-set, or an algorithm are good examples of a Contribution.

Finally, help your reader understand how the rest of the paper is structured and why.

## Background

A reader may not know much about your field of study. This section
may help them understand your problem domain and its terminology better.
For example, if you write about a new programming language, this section may explain
what a compiler is, and grammar, front-end, back-end, AST, and so on.

Educate your readers in order to make it more comfortable for them
to read the rest of the paper.

## Related Work

In the first paragraph, give an overview of all existing studies that
you managed to find. Classify them [somehow]({% pst 2023/sep/2023-09-29-how-to-write-related-work-section %}).

Then write one paragraph per study. Explain what the study was about
and what are its key findings. Finish each paragraph with the flaws
you found in the study. Make a claim that due to these flaws this
study is not a solution to the Problem.

Finish the section with a paragraph claiming that, to the best of your knowledge,
not a single existing study solves the Problem.

## Method or Device

There are two types of research:
you either _observe_ the reality in order to discover its new laws
(this is how [Isaac Newton](https://en.wikipedia.org/wiki/Isaac_Newton)
discovered his [laws of motion](https://en.wikipedia.org/wiki/Newton's_laws_of_motion)),
or _extend_ the reality with a new device
(this is how [Thomas Edison](https://en.wikipedia.org/wiki/Thomas_Edison) invented the [light bulb](https://en.wikipedia.org/wiki/Incandescent_light_bulb)).

If you observe, algorithmically [describe]({% pst 2023/oct/2023-10-11-method-of-research %}) the Method.

If you extend, describe the Device and its usage scenarios.

## Proof

Formally prove that your Device possesses certain qualities, predicted in the Hypothesis.

The section mostly consists of definitions, examples, lemmas, theorems, and proofs.

## Experimental Results

Apply the Method, step by step, to the real data.

Present your findings using tables and graphs.

Post your input data, intermediate data, and all output data in a public
GitHub repository. Make a reference to it.

## Discussion

Informally [interpret](https://plos.org/resource/how-to-write-conclusions/) your results.

Explain how your results are different from Related Work.

Highlight limitations of the study. Discuss its [threats to validity](https://www.creative-wisdom.com/teaching/WBI/threat.shtml).
Any method or any idea has its flaws. If you don't admit them, your
readers will think that you are either concealing the issues or
not understanding your own domain well enough.

Highlight the significance of the study.

Discuss unanswered questions and suggest topics for future studies.

## Conclusion

Spend one paragraph explaining how your research question was answered
in this paper. Imagine the reader just reads the Introduction and
then immediately this Conclusion. It should read fluently.

This paragraph is a short version of the Discussion.

## Acknowledgments

Here, you say "many thanks to individuals and organizations that
contributed to the research, including ..." You list them all, in
alphabetic order. You may add your bosses, colleagues, people
who reviewed your paper, your parents, and even your dog.

If the research was done while you were an employee of ACME Inc.,
say that "the research was funded by ACME Inc."

## References

Use [BibLaTeX](https://ctan.org/pkg/biblatex?lang=en) to automate citations,
and [read this](https://tex.stackexchange.com/questions/25701).

Use either [APA](https://en.wikipedia.org/wiki/APA_style)
or [IEEE](https://ieeeauthorcenter.ieee.org/wp-content/uploads/IEEE-Reference-Guide.pdf)
citation styles.

## Appendices

Long tables, complex proofs, large figures are good candidates for placing
into appendices. Keeping them in the main part of the paper may jeopardize
its readability.
