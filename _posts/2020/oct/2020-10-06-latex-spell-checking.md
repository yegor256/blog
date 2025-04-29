---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Spell Check Your LaTeX Writings Using GNU Aspell"
date: 2020-10-06
place: Moscow, Russia
tags: latex
description: |
  Spell-checking LaTeX pages is a challenging task, since
  it's a markup language, which is full of meta-commands;
  GNU aspell knows how to do it, but it's hard to configure it
keywords:
  - aspell
  - latex spell checking
  - latex spelling
  - latex aspell
  - latex check spelling
image: /images/2020/10/zero-2.jpg
jb_picture:
  caption: Zero 2 (2010) by Emilis Velyvis
---

Do you use [LaTeX](https://www.latex-project.org/)
for your academic and technical writings? You don't?
Well you should! It's the ~~most~~ only professional instrument for
making properly formatted PDF documents.
MS Word and Apple Pages are for ~~secretaries~~ non-tech people,
while LaTeX is serious. It's perfect in so many ways, thanks to
[Donald Knuth](https://en.wikipedia.org/wiki/Donald_Knuth)
(the creator of TeX) and
[Leslie Lamport](https://en.wikipedia.org/wiki/Leslie_Lamport)
(the author of LaTeX),
but it lacks one very convenient feature:
[spell checking](https://tex.stackexchange.com/questions/42843).
The only solution I've found so far, which works perfectly for my documents, is
[GNU aspell](http://aspell.net/).

<!--more-->

{% jb_picture_body %}

[GNU aspell](http://aspell.net/) is a command line tool
which expects you to provide the LaTeX source code
(indeed, it is code, not "text") as an input and prints a list of found spelling
errors. The beauty of it is that it checks only the text, ignoring
TeX commands. For example, this is LaTeX document:

```text
\documentclass{article}
\begin{document}
Hello, \textbf{Yegor}!
\end{document}
```

If we feed this text to some other spell checker (or GNU aspell without the
option `--mode=tex`) the word `textbf` would be an obvious spelling mistake; aspell,
however, understands it as a LaTeX command and ignores it.
Moreover, aspell can understand the word `Yegor`, even though it's not
an English word, by using a custom dictionary provided by the `--pws` option.

There are a few other useful features in aspell. Long story short, I decided to create
a small wrapper around aspell, to simplify the process of its configuration:
[texsc](https://github.com/yegor256/texsc)
(stands for "TeX Spell Checking").
It's a command line tool, which you install and then run, for example like this
(you can see how it's configured in the `Makefile` of
[this paper](https://github.com/yegor256/requs-paper)):

```text
$ texsc --pws aspell.en.pws --ignore=code,citep article.tex
```

There is a list of arguments you can supply to `texsc`:

  * `--pws` is the location of a custom dictionary, where each
    line is a word aspell is supposed to ignore. It's important to
    have the first line equal to `personal_ws-1.1 en 741 utf-8`. Why?
    I don't know. But if it contains something else, aspell will just
    silently ignore the file. Nice, huh?

  * `--ignore` (you may have many of them) is the list of
    TeX commands, and which arguments should be ignored. A good example is the
    `\code{}` command, which in all cases has something that is not
    an English word. You may also have commands with multiple arguments,
    in which case you say something like `--ignore=code:op` and in the
    command `\code[foo]{bar}` both `foo` and `bar` will be ignored.
    The `:op` suffix means that an optional (`o`) argument is ignored and then
    a mandatory one (`p`). Something like `:oppp` would tell aspell
    to ignore one optional and then three mandatory arguments.

  * `--min-word-length` is the minimum length of word to pay attention to.
    I use the number `3` and this is the default value. Shorter words (one or two characters)
    are not important and don't need to be spell-checked.

I use `texsc` in all my LaTeX projects, usually as part of their
build cycle, which I automate with [GNU make](https://www.gnu.org/software/make/).
You can do the same, as it's open source.
