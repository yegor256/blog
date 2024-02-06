---
layout: post
title: "I&I Research Flow"
date: 2024-02-06
place: Moscow, Russia
tags: science
description: |
  This is a highly simplified description of a straightforward research workflow 
  that I employ with my students in their research courses and diploma projects.
keywords:
  - research workflow
  - how to do a research
  - research simple workflow
  - research step by step
  - research paper how to
image: /images/2024/02/respublica-shkid.jpg
jb_picture:
  caption: Республика Шкид (1966) by Геннадий Полока
---

Say, you are a student, and I'm your [teacher]({% pst 2021/dec/2021-12-01-teaching %}). 
Your task is to conduct 
an experiment or a study and then write a research paper about it. 
You can do it on your own and then present me with the results in the end. 
Sometimes it may work, but most probably it won't. I will have many comments, 
suggestions, and plain simple disagreements with your research questions, results, 
or conclusions. Just like in software engineering, the [Waterfall](https://en.wikipedia.org/wiki/Waterfall_model) approach 
is not an effective one. Instead, an _incremental and iterative_ workflow 
may yield way better results: you take a small step forward, 
we discuss it, you rewrite, we agree, and you take the next step. 
The ultimate objective is to write a paper that will be published in 
a good journal or presented at a [decent conference]({% pst 2021/apr/2021-04-14-how-we-organized-iccq %}). 
Well, yes, a passing grade is also an objective.

<!--more-->

{% jb_picture_body %}

Since the goal is a research paper, your first step is to create 
a skeleton of it in LaTeX. If you don't know LaTeX yet, 
read [_LaTeX: A Document Preparation System_](https://www.amazon.com/LaTeX-Document-Preparation-System-2nd/dp/0201529831) 
by [Leslie Lamport](https://en.wikipedia.org/wiki/Leslie_Lamport) (just 242 pages). 
If you think you already know LaTeX, 
read [this short list of its best practices](https://yegor256.github.io/latex-best-practices/main.pdf) 
and [_Writing for Computer Science_](https://link.springer.com/book/10.1007/978-1-4471-6639-9) 
by [Justin Zobel](https://scholar.google.com/citations?user=uEHvqE8AAAAJ).

Now, create a document in [Overleaf](https://overleaf.com), 
and [share a link](https://www.overleaf.com/learn/how-to/Sharing_a_project#Link_sharing) 
with me so that I can also edit the project. Make your skeleton look like 
this (you should also create an empty `main.bib` file in the Overleaf folder):

```tex
\documentclass[sigplan,nonacm,anonymous,review]{acmart}
\settopmatter{printfolios=false,printccs=false,printacmref=false}
\usepackage[utf8]{inputenc}
\usepackage{natbib}
\title{My article}
\author{John Doe}
\orcid{0000-0001-0000-0000}
\email{your email}
\affiliation{\institution{University}\city{City}\country{Country}}
\begin{abstract}
This paper is about something new.
\end{abstract}
\begin{document}
\maketitle
\section{Introduction}
Hello, world!
\section{Method}
\section{Results}
\section{Discussion}
\section{Conclusion}
\bibliographystyle{ACM-Reference-Format}
\bibliography{main}
\end{document}
```

Now, you are ready to begin your research incrementally, 
and I will review each step in the following order:

  1. Research Questions
  1. Research Method --- [how to?]({% pst 2023/oct/2023-10-11-method-of-research %})
  1. Preliminary Experiments
  1. Related Work --- [how to?]({% pst 2023/sep/2023-09-29-how-to-write-related-work-section %})
  1. Results --- [how to?]({% pst 2023/dec/2023-12-11-results-and-discussion %})
  1. Limitations
  1. Discussion --- [how to?]({% pst 2023/dec/2023-12-11-results-and-discussion %})
  1. Conclusion
  1. Introduction
  1. Abstract
  1. Title

Each step produces a few new paragraphs in the LaTeX document. 
In [this blog post]({% pst 2022/aug/2022-08-24-research-paper-template %}), 
you can find recommendations for each of the steps. I strongly advise against 
moving on to the next step unless the previous one is discussed and approved. 
Doing so may result in greater frustration on your part when you've 
written almost the entire paper, and we both realize that the 
whole piece must be rewritten, and experiments must be redone.

Before we start, please put a date on each of the steps mentioned above and send 
me the entire work plan. It's better to meet every milestone as a disciplined student; 
otherwise, the risk of failure will be larger.

