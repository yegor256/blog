---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Bibcop: Style Checker for BibTeX"
date: 2023-09-05
place: Moscow, Russia
tags: latex
description: |
  By the quality of the 'References' section some people
  may judge the quality of your research paper; bibcop helps
  you keep everything clean.
keywords:
  - bibtex style
  - bibtex static analyis
  - bibtex style checker
  - bib files checker
  - check quality of bibtex files
---

Almost every document you may write in
[LaTeX](https://en.wikipedia.org/wiki/LaTeX) format will
have a list of references at the end. Most likely, you will
use [BibTeX](https://www.ctan.org/pkg/bibtex)
or [BibLaTeX](https://www.ctan.org/pkg/biblatex)
to print this list of references in a nicely formatted way.
It is also highly probable that your `.bib` file will contain
many typographic, stylistic, and logical mistakes. I'm fairly
certain that you won't find the time to identify and correct them.
As a result, the "References" section in your paper may appear sloppy.
I suggest using the [`bibcop`](https://www.ctan.org/pkg/bibcop)
package, which identifies mistakes in the `.bib` file
and auto-fixes some of them.

<!--more-->

Here is a practical example. Let's say, you want to
cite a famous paper about transformers. First, you find it in
[Google Scholar](https://scholar.google.com/) and click "Cite":

{% picture /images/2023/09/bibcop-scholar.png %}

Then, you put this "bib" item into your `main.bib` file:

```java
@article{vaswani2017attention,
  title={Attention is all you need},
  author={Vaswani, Ashish and Shazeer, Noam and
    Parmar, Niki and Uszkoreit, Jakob and Jones, Llion and
    Gomez, Aidan N and Kaiser, {\L}ukasz and Polosukhin, Illia},
  journal={Advances in neural information processing systems},
  volume={30},
  year={2017}
}
```

Then, you write something like this in your paper:

```java
\documentclass{article}
\usepackage[maxbibnames=9]{biblatex}
\addbibresource{main.bib}
\begin{document}
Transformers~\cite{vaswani2017attention}
changed everything!
\printbibliography
\end{document}
```

This is what you will get:

{% picture /images/2023/09/bibcop-before.png %}

Looks more or less fine.
However, if you go to [the website](https://proceedings.neurips.cc/paper_files/paper/2017)
of the publisher of this article, you will see that:

  * The name of [the journal](https://proceedings.neurips.cc/) is typed with first letters capitalized in all major words,
  * The title of the paper is also capitalized,
  * The middle name of "Aidan N. Gomez" has a trailing dot.

In other words, Google Scholar gave you the citation with a few typographic
mistakes. While not fatal, the quality of the "References" section
can sometimes be seen as reflective of the quality of the paper as a whole.
Simply put, negligence is not forgivable when dealing with information about other authors.
We must be accurate down to every letter and every dot.

By including `bibcop` package to the document, the problem may be solved.
First, you install it (I assume, you are using [TeX Live](https://tug.org/texlive/)):

```bash
$ sudo tlmgr install bibcop
```

Then, you add this to your document, right before the `\addbibresource` command:


```java
...
\usepackage{bibcop}
\addbibresource{main.bib}
...
```

When you compile the document, the following warnings will be printed
to the console, together with other logs:

```
Package bibcop Warning: A shortened name must have
  a tailing dot in the 6th 'author', as in 'Knuth, Donald E.',
  in the 'vaswani2017attention' entry.
Package bibcop Warning: All major words in the 'title'
  must be capitalized, while the 2nd word 'is' is not,
  in the 'vaswani2017attention' entry.
Package bibcop Warning: A mandatory 'doi' tag for '@article'
  is missing among (author, journal, title, volume, year),
  in the 'vaswani2017attention' entry.
Package bibcop Warning: The 'title' must be wrapped
  in double curled brackets,
  in the 'vaswani2017attention' entry.
```

You fix them all in the `main.bib` file and recompile the document:

{% picture /images/2023/09/bibcop-after.png %}

This one looks much better to me
(especially with the [DOI](https://en.wikipedia.org/wiki/Digital_object_identifier), which
was not provided by Google Scholar).

By the way, some formatting problems may be auto-fixed by bibcop.
You can use it from the command line, assuming you have your
`main.bib` file in the current directory:

```bash
$ bibcop --fix --in-place main.bib
```

This command will make as many fixes as possible.
Then, you can run `bibcop` again, from the command line,
in order to check what style violations are still there:

```bash
$ bibcop main.bib
```

This will print the same errors as you saw earlier in the LaTeX log.

<hr/>

[In CTAN](https://ctan.org/pkg/bibcop), you can find full PDF documentation.

You are welcome to suggest additional style checkers,
via [GitHub issues](https://github.com/yegor256/bibcop).
