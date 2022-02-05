---
layout: post
title: "Five Fallacies of Robotic-Programmers"
date: 2022-02-08
place: Moscow, Russia
tags: ai
description: |
  ...
keywords:
  - ..
  - ..
  - ..
  - ..
  - ..
image: /images/2022/02/
jb_picture:
  caption:
---

A few days ago, DeepMind (acquired by Google in 2014) released
[AlphaCode](https://alphacode.deepmind.com) and self-published
a
[paper](https://storage.googleapis.com/deepmind-media/AlphaCode/competition_level_code_generation_with_alphacode.pdf)
explaining how AI can understand a task written in English 
for a programming contest and then write a program, which
would work in about 30% of cases.
Earlier last year [OpenAI](https://en.wikipedia.org/wiki/OpenAI) 
(founded by Elon Musk in 2015 and $1B-funded by Microsoft in 2019)
released [Codex](https://openai.com/blog/openai-codex/)
and published a [paper](https://arxiv.org/abs/2107.03374), claiming
that their AI can also solve around 30% of programming tasks it was
tested with.
[Wired](https://www.wired.com/story/ai-write-code-like-humans-bugs/),
[Financial Times](https://www.ft.com/content/65477c33-cb72-418d-b03d-b60cfc5a8b5d),
[The Verge](https://www.theverge.com/2022/2/2/22914085/alphacode-ai-coding-program-automatic-deepmind-codeforce),


"Generating code that solves a specific task requires searching in a huge structured space of programs
with a very sparse reward signal."
"The architecture takes as input to the encoder the problem description _X_ as a flat sequence of tokenized characters, and samples autoregressively from the decoder one token at a time until an end of code token is produced,
at which point the code can be compiled and run."

[Copilot](https://copilot.github.com) powered by


<!--more-->

{% jb_picture_body %}

**AI writes code**<br/>
It's not true.
Neither AlphaCode nor Codex _write_ code. Instead, they _find_ it.
According to AlphaCode paper, "generating code that solves a specific task 
requires _searching_ in a huge structured space of programs
with a very sparse reward signal." Machine Learning makes searching
faster, but doesn't make it writing. As far as I understand (the paper
is pretty vague on exact details of model training), they turn
descriptions of programming tasks into sequences of numbers (tokenized characters!)
and they label them with solutions found ... in GitHub or Codeforces open repositories.

**AI understands requirements in a natual language**<br/>
It's not true.
Neither AlphaCode nor Codex analyze the _semantic_ of the input. Either it
says "draw a green line" or "save a file," AI sees just two sequences of characters:
17 and 11 respectively. It doesn't _know_ what means "green" and how it's different
from a "file"

**AI pair-programs with a human**<br/>
It can only replace a coder entirely, since the code created by AI is not maintainable. 

**AI just needs time to mature**<br/>
[Thomas Smith](https://spectrum.ieee.org/openai-wont-replace-coders) believes
that AI may replace programmers, but "that day won't arrive any time soon."

**AI can autocomplete that's why can write**<br/>

Conclustion: it will never happen. ML is not suitable for code 
generation. It may be suitable for refactoring, bug fixing,
optimization, etc. But not for coding.

On a second thought, maybe quantum computers may help...