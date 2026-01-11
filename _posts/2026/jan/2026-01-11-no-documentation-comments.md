---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Comments Considered Harmful in the Age of LLMs"
date: 2026-01-11
place: Kazan, Russia
tags: oop
description: |
  Instead of writing code comments that decay and mislead, let LLMs
  generate documentation on-demand and fail the build when code is
  too obscure for them to explain.
keywords:
  - code documentation
  - self-documenting code
  - code comments
  - LLM code analysis
  - code interpretability
image: /images/2026/01/full-metal-jacket.jpg
jb_picture:
  caption: Full Metal Jacket (1987) by Stanley Kubrick
---

Writing code documentation is a pain.
Not writing it leads to even bigger pain---we can't comprehend the code.
However, writing it and then forgetting to update causes the ultimate pain: it lies and confuses us.
How about we cure all three pains at once: _prohibit all comments!_
How do we know what is the intent of the code, if we don't have any comments?
We ask an LLM to explain it to us.
What if the LLM fails to explain and confesses its inability?
Then, we automatically fail the build and blame the author of the code.
Thus, we introduce a new quality gate: _Code Interpretability Score_.
The build passes only if this score is high enough.

<!--more-->

{% jb_picture_body %}

The best minds in software engineering have long dreamed of self-documenting code.
In 1974, [Brian Kernigan] and [Phillip James Plauger] [said][eps] that
  "the only reliable documentation of a computer program is the code itself."
In 2004, [Steven McConnell] in [_Code Complete_][code complete] claimed that
  "the main contributor to code-level documentation isn't comments, but good programming style."
In 2008, [Robert Martin] in [_Clean Code_][clean code] suggested that
  "if our programming languages were expressive enough, or if we had the talent to subtly wield those languages to express our intent,
  we would not need comments very much---perhaps not at all."
They all wanted the same thing: code that explains itself.
They just lacked the tools to enforce it.

Why do we write comments at all?
A Java method of a hundred lines may take hours to understand.
A tiny Javadoc block saves this time:

```java
/**
 * Recursively finds the shortest
 * path between two nodes in the graph.
 */
int[] shortest(int[][] g, int a, int b) {
  // A hundred lines of code goes
  // here, which we have no desire
  // to read and understand.
}
```

Comments promise to help us.
In practice, they fail in two distinct ways.

First, they are _unclear_.
[David Parnas] once [said][software aging] that
  "documentation that seems clear and adequate to its authors is often about _as clear as mud_ to the
  programmer who must maintain the code six months or six years later."
What the author considers obvious, the reader finds cryptic.

Second, they _decay_.
Being static metadata, comments do not evolve automatically with the code.
If the implementation of the `shortest()` function stops being recursive, we may forget to update the Javadoc block.
Such negligence leads to _hallucinating documentation_ that causes bugs, broken trust, and wasted debugging time.
In 1999, [Andrew Hunt] and [Dave Thomas] in [_The Pragmatic Programmer_][tpp] warned that
  "_untrustworthy_ comments are _worse_ than no comments at all."
A recent [analysis] of 13 open source projects
  demonstrated that out-of-date comments are not rare but common.

Now we have a tool that solves both problems: the LLM.

Instead of writing the Javadoc block manually, we let the IDE generate it on-demand.
The LLM reads the hundred lines of code, comprehends it, and summarizes the intent in a single English sentence.
Modern models accomplish this task better than most humans.
The documentation is always fresh because it is generated from the current code, not from a stale comment written months ago.

But we can go further.
We can integrate an LLM into the build pipeline and ask it to assess the _Code Interpretability Score_ (CIS) of every function.
If the model has low confidence in explaining the logic, this signals that the code is too clever or convoluted.
The compiler can enforce a threshold: if the CIS is too low, the build fails.
This transforms readability from a subjective preference into an objective, measurable quality gate.

Once this gate exists, manual comments become not just unnecessary but _harmful_.
They introduce a second source of truth that can contradict the code.
The logical conclusion: prohibit them entirely.
This forces developers to write clean, structured logic that is inherently machine-interpretable.

Robert Martin wished for more expressive languages.
He didn't know about LLMs.
Today, we don't need better languages---we need an LLM that can interpret any language.
If the LLM can't explain the code, we blame the programmer and stop the build.

We are making [EO], our experimental object-oriented language, this restrictive.


[eps]: https://en.wikipedia.org/wiki/The_Elements_of_Programming_Style
[Brian Kernigan]: https://en.wikipedia.org/wiki/Brian_W._Kernighan
[Phillip James Plauger]: https://en.wikipedia.org/wiki/P._J._Plauger
[EO]: https://www.eolang.org
[David Parnas]: https://en.wikipedia.org/wiki/David_Parnas
[software aging]: https://doi.org/10.1109/icse.1994.296790
[Andrew Hunt]: https://en.wikipedia.org/wiki/Andy_Hunt_(author)
[Dave Thomas]: https://en.wikipedia.org/wiki/Dave_Thomas_(programmer)
[tpp]: https://en.wikipedia.org/wiki/The_Pragmatic_Programmer
[analysis]: https://doi.org/10.1145/3663529.3664458
[code complete]: https://amzn.to/2cs4cXW
[clean code]: https://amzn.to/2m7LmaA
[Robert Martin]: https://en.wikipedia.org/wiki/Robert_C._Martin
[Steven McConnell]: https://en.wikipedia.org/wiki/Steve_McConnell
