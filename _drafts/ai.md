---
layout: post
title: "Fallacies of AI Driven Coding"
date: 2022-02-03
place: Moscow, Russia
tags: ai
description: |
  AI will eventually replace programmers? AlphaCode and Codex
  are two best examples of coder killers? I don't think so.
keywords:
  - ai coder
  - ai programmer
  - codex
  - alphacode
  - ai coding
image: /images/2022/02/wheelman.jpg
jb_picture:
  caption: Wheelman (2017) by by Jeremy Rush
---

A few days ago, [DeepMind](https://deepmind.com) 
([acquired](https://techcrunch.com/2014/01/26/google-deepmind/) by Google in 2014) released
[AlphaCode](https://alphacode.deepmind.com) and self-published
a
[paper](https://storage.googleapis.com/deepmind-media/AlphaCode/competition_level_code_generation_with_alphacode.pdf)
explaining how their artifical intelligence (AI) can "understand"
a programming contest task written in English and then write a Python, Java or C++ program, which
would work in about 30% of cases.
Earlier last year [OpenAI](https://en.wikipedia.org/wiki/OpenAI) 
([$1B-funded](https://openai.com/blog/microsoft/) by Microsoft in 2019)
released [Codex](https://openai.com/blog/openai-codex/)
and published a [paper](https://arxiv.org/abs/2107.03374), claiming
that their AI can also solve around 30% of programming tasks it was
tested with.
[Wired](https://www.wired.com/story/ai-write-code-like-humans-bugs/),
[Financial Times](https://www.ft.com/content/65477c33-cb72-418d-b03d-b60cfc5a8b5d),
[The Verge](https://www.theverge.com/2022/2/2/22914085/alphacode-ai-coding-program-automatic-deepmind-codeforce)
and many others have already announced the victory: 
AI [will replace programmers](https://www.bbc.com/news/business-57914432) 
and we all are going to lose our jobs. 
Is it so?

<!--more-->

{% jb_picture_body %}

No, it's not. 
I would identify five beliefs about AI and its code writing abilities,
which, in my opinion, are fundamental fallacies:

  * **AI writes code (NOT!)**<br/>
    It's not true.
    Neither AlphaCode nor Codex _write_ code. Instead, they _find_ it.
    According to AlphaCode paper, "generating code that solves a specific task 
    requires _searching_ in a huge structured space of programs
    with a very sparse reward signal." Machine Learning (ML) makes searching
    faster, but doesn't make it writing. As far as I understand (the paper
    is pretty vague on exact details of model training), they turn
    descriptions of programming tasks into sequences of numbers (tokenized characters!)
    and then label them with solutions found ... in GitHub or 
    [Codeforces](https://codeforces.com) open repositories.
    Then, they ask the model to find the best solution for a vector of characters
    at question. Can this algorithm be really called "writing" and, what's more
    important, will it ever be able to write anything aside from already existing
    blocks of code previously written and tested?

  * **AI understands requirements in a natual language (NOT!)**<br/>
    It doesn't really _understand_ anything.
    Neither AlphaCode nor Codex analyze the _semantic_ of the input. Either it
    says "draw a green line" or "save a file," AI sees just two sequences of characters:
    of 17 and 11 length respectively. It doesn't _know_ what means "green" and how it's different
    from a "file." They tokenize texts into vectors. They don't use 
    [CNL](https://en.wikipedia.org/wiki/Controlled_natural_language), but they might.

  * **AI pair-programs with a human (NOT!)**<br/>
    We may expect AI not entirely replace us programmers, but instead help us
    write certain blocks of code: [Copilot](https://copilot.github.com) 
    ([released](https://github.blog/2021-06-29-introducing-github-copilot-ai-pair-programmer/) 
    by [GitHub](https://github.com) in 2021) 
    is a notable example, [powered](https://hackernoon.com/openais-new-code-generator-github-copilot-and-codex-bb143773)
    by the same Codex. A few months ago I got an early access to Codex and played a bit with
    its features. My impression, as a programmer, was that it wasn't able to
    write an entire program (predictable) and the blocks of
    code it produced in return to my requests didn't fit together. They were syntactically
    valid and implemented the functionality requested, but the AI was falling short in combining
    them the way I, a human, may agree to maintain later.

  * **AI autocompletes that's why can write (NOT!)**<br/>
    Indeed, there are a few products which do code autocompletion
    with the use of ML, for example [Codota](https://www.codota.com),
    [Tabnine](https://www.tabnine.com),
    and
    [Kite](https://www.kite.com).
    However, they don't work with natural languages.
    These are two different research problems: 
    1) how to [autocomplete](https://en.wikipedia.org/wiki/Autocomplete) 
    an existing program with a known
    functionality and already existing [AST](https://en.wikipedia.org/wiki/Abstract_syntax_tree), 
    and 
    2) how to turn a natural language text into an AST.
    As far as I undersand, they don't and will never overlap.
    Knowing how to extend an existing AST doesn't imply knowing
    how to create it from scratch.

  * **AI just needs time to mature (NOT!)**<br/>
    [Some](https://spectrum.ieee.org/openai-wont-replace-coders) believe
    that AI will replace programmers, but "that day won't arrive any time soon."
    It seems to me that it's not a matter of maturity. The very 
    direction researchers of OpenAI and DeepMind are trying to pursue is a dead end.
    ML is just not the right tool to turn an unstructured English text into a well-structured 
    AST, which is parseable by C++ compiler. To do this we need AI to 
    learn the semantic of the natural language and then, using 
    _creativity_ and _imagination_,
    create all necessary AST elements in the right order. 
    I simply don't believe that ML is the right technology for this.

To conclude, ML will never write our code, because ... it's not possible. 

However, it may be suitable for other things, like autocompletion, 
refactoring, bug fixing, optimization, and so on. I'm particulary interested
in automated refactoring: imagine a large legacy code base given to AI,
which improves certain parts of it, making the code more faster,
safer, more readable, shorter, or maybe even upgrade to newer frameworks, SDKs,
and dependencies. This is where ML already helps and will help more,
improving _existing_ ASTs.

Besides, how much good will it do to the industry if programmers write
code mostly by finding samples in Internet, copying, and sticking them together.
Many of them already do that even without AI.
The [analysis](https://stackoverflow.blog/2021/12/30/how-often-do-people-actually-copy-and-paste-from-stack-overflow-now-we-know/) 
recently done by Stack Overlow demonstrates that "the higher a user's reputation, 
the less often they are copying." Less skillful programmers tend to copy.
Is this a good tendency? Do we want AI to push it further?

