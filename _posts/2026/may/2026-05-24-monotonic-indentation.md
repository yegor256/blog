---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Monotonic Indentation"
date: 2026-05-24
place: Moscow, Russia
tags: style
description: |
  Between two adjacent lines, indentation may grow by one unit only,
  but may shrink by any number of units — a rule that resolves most
  code formatting disputes.
keywords:
  - monotonic indentation
  - code indentation rule
  - code formatting style
  - indentation in Java
  - off-side rule
image: /images/2026/05/pokrovskie-vorota.jpg
jb_picture:
  caption: Покровские ворота (1983) by Михаил Козаков
style: |-
  .tab { color: lightgray; }
---

People have been arguing about how to indent code for as long as there's been code,
  and nobody has settled it.
Java's [Checkstyle] aligns continuations under the open paren,
  [ESLint] and [Prettier] each invent their own rules,
  Go's [gofmt] uses tabs and shrugs,
  [RuboCop] hands you a menu,
  Python's [PEP 8] picks four spaces and leaves the rest to taste.
Every tool has its own dialect, and teams waste hours fighting over the details.
I suggest a simple rule of _monotonic_ indentation for source code of any programming language:

> Between any two adjacent lines, indentation may increase by exactly one unit.

This rule should resolve most disputes about code formatting style.
It is easy to add as an extra check to any existing style checker,
  or to deploy on its own as a small standalone tool.

<!--more-->

{% jb_picture_body %}

According to the rule, this Java code is illegal:

```java
class Repository {
    void save(File file,
              String text, String summary,
              boolean overwrite) {
        if (file.exists()
                && !overwrite) {
            throw new IllegalStateException(
                    "file already exists");
        }
        update(file,
               text,
               summary);
    }
}
```

This one is legal (and pretty, if you ask me):

<div class="language-java highlighter-rouge"><div class="highlight"><pre class="highlight"><code>class Repository {
<span class="tab">→→</span>void save(File file,
  <span class="tab">→→</span>String text, String summary,
    boolean overwrite) {
    if (file.exists()
    <span class="tab">→→</span>&amp;&amp; !overwrite) {
      throw new IllegalStateException(
      <span class="tab">→→</span>"file already exists");
    }
    update(file,
    <span class="tab">→→</span>text,
      summary);
  }
}
</code></pre></div></div>

The idea is simple: going down the code, you may step right by one notch at a time,
  but you may jump back left by as many notches as you want.
You can't skip steps on the way in, but you can leap out freely.
Every line still lands on a grid, never in between.

Together with the [Paired Brackets]({% pst 2014/oct/2014-10-23-paired-brackets-notation %}) rule,
  this makes the code look ideal:
  brackets line up vertically and indentation never jumps further than necessary.

BTW, the parser of [EO], our experimental language, enforces this rule syntactically.
This is similar to the [off-side rule] of Python,
  where indentation defines block structure rather than braces.
However, in EO everything is an object, while in Python it is not.
That's why EO can afford to be stricter and demand monotonic steps everywhere.

[EO]: https://www.eolang.org
[off-side rule]: https://en.wikipedia.org/wiki/Off-side_rule
[Checkstyle]: https://checkstyle.org
[ESLint]: https://eslint.org
[Prettier]: https://prettier.io
[gofmt]: https://pkg.go.dev/cmd/gofmt
[RuboCop]: https://rubocop.org
[PEP 8]: https://peps.python.org/pep-0008/
