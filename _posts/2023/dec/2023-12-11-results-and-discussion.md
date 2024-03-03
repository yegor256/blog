---
layout: post
title: "Results and Discussion: Facts and Interpretation"
date: 2023-12-11
place: Moscow, Russia
tags: science
description: |
  Two very important sections of a research paper must
  present the data collected and the interpretations made.
keywords:
  - discussion section
  - results section
  - results and discussion
  - scientific writing
  - interpretation of data
image: /images/2023/12/mulholland-drive.jpg
jb_picture:
  caption: Mulholland Drive (2001) by David Lynch
---

Almost every [empirical research](https://en.wikipedia.org/wiki/Empirical_research) 
paper contains two essential sections: _Results_
and _Discussion_. The former presents the facts collected through the research
[method]({% pst 2023/oct/2023-10-11-method-of-research %}), 
while the latter interprets them to answer the research questions. When
interpreting the data, you must address the most obvious concerns that readers
may have. For example, in the Results section, you might state: "85% of
respondents refused to participate in our survey" (this is a _fact_). Then, in
the Discussion section, you might say: "We believe that programmers are
innately lazy and irresponsible" (this is an _interpretation_). You might also
add, "Perhaps not all of them were lazy, but just busy." While the Results
section leaves no room for doubt, summarizing findings "as is," the Discussion
section engages in an open _debate_ with an imaginative reader.

<!--more-->

{% jb_picture_body %}

In the [Method]({% pst 2023/oct/2023-10-11-method-of-research %}) section, 
you've already explained how you collected, processed, and analyzed the data. 
Now, in the **Results** section, you present the actual data collected and generated. 
The simpler the method of data representation, the better. Thus, in order of 
preference (with the last being your last choice):

  * Plain text
  * Lists (`\begin{itemize}`)
  * Table (`\begin{tabular}`)
  * Graphs and diagrams (`\begin{figure}`)

If the data is too extensive to show in the paper, you can store it 
in a GitHub repository and mention its address in the Results section. For example:

```text
\section{Results}

We contacted 135 programmers from three 
software companies: ACME Inc, Google, and
Amazon. We asked them kindly to answer
a short questionnaire of just 128 questions.
115 people refused, which is 85%.
The full list of those who refused, along with 
their names and home addresses, 
is published in GitHub repository\footnote{
  \url{https://github.com/...}}.
```

In the [Method]({% pst 2023/oct/2023-10-11-method-of-research %}) section, 
you posed several _Research Questions_. Now, in the **Discussion** section, 
you answer them using the data you've just presented in the Results. 
This is the time for an opinionated interpretation of the data: be brave and direct, yet careful.

When you've answered the Research Questions, you initiate a debate 
with your readers, imagining them asking difficult and important questions. 
The answers you provide are your speculation, imagination, improvisation, etc. 
Also, through the Q&A format, you acknowledge the limitations of your 
research and suggest potential future research topics.

Consider these questions (re-phrase them for your own context):

  * Why are these results important?
  * Why has no one discovered this before?
  * Is it possible that we made a mistake?
  * How else could the data be interpreted?
  * What's next?

I suggest dedicating exactly one paragraph per question, starting 
with a bold-faced formulation of it, followed by your answer to 
your imagined opponent. Here's an example:

```text
\section{Discussion}

\textbf{RQ1: How many programmers are lazy?}
Since 85% of our respondents refused to complete
our short questionnaire, we strongly believe 
that most programmers are lazy.

\textbf{RQ2: Why are programmers lazy?}
Since the majority of programmers refused to complete
the 128-question questionnaire, we believe
they become lazy when confronted with a number
that is a power of two.

\textbf{Is it possible that programmers are 
just busy?} Yes, it's possible, but highly
unlikely, as \citet{x2019} previously found 
that programmers spend 90% of their office time 
reading jokes on the internet.
```

The more you overlook in the Discussion section, the greater the chance of your
paper being rejected. Reviewers are often knowledgeable individuals with many
years of experience in the field; they will certainly have concerns about your
Method, Results, and answers to the Research Questions. If you don't address
these concerns explicitly in the Discussion section, they may think you are
either concealing the research's weaknesses or are not astute enough to
recognize them. In either case, it could lead to a rejection of your paper.

<hr/>

You may find inspiration in these papers 
(use [Google Scholar](https://scholar.google.com/) to download their PDFs):

  * Zhaowei Zhang et al., _Diet Code Is Healthy: Simplifying Programs for Pre-trained Models of Code_, ESEC/FSE 2022
  * Norman Peitek et al., _Correlates of Programmer Efficacy and Their Link to Experience: A Combined EEG and Eye-Tracking Study_, ESEC/FSE 2022
  * Jennifer Bauer et al., _Indentation: Simply a Matter of Style or Support for Program Comprehension?_, ICPC 2019

<hr/>

These opinions might also be helpful:

  * [Guide to Writing the Results and Discussion Sections of a Scientific Article](https://goldbio.com/articles/article/Guide-to-results-and-discussion-section)
    by [Tyasning Kroemer](https://www.linkedin.com/in/tyasning-kroemer/)
  * [How to write the Results and Discussion](https://healthprofessions.udmercy.edu/academics/na/agm/htresult.htm)
    by Michael P. Dosch
  * [How to Write Discussions and Conclusions](https://plos.org/resource/how-to-write-conclusions/)
    by PLOS
  * [The Discussion](https://libguides.usc.edu/writingguide/discussion)
    by USC Libraries
  * [Fourteen Steps to Writing an Effective Discussion Section](https://jivasquez.files.wordpress.com/2016/06/discussion.pdf)
    by Paul Kretchmer
  * [Discussion Section for Research Papers](https://www.sjsu.edu/writingcenter/docs/handouts/Discussion%20Section%20for%20Research%20Papers.pdf)
    by Rowan Dunton
  * [Distinguishing between Results and Discussion](https://www.uvm.edu/sites/default/files/Graduate-Writing-Center/GWC%20Guides/Genres/Science_Writing_Results_Discussion.pdf)
    by University of Vermont

