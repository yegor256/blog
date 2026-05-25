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
---

I suggest a rule of _monotonic_ indentation for source code of any programming language:

> Between any two adjacent lines, indentation may increase by exactly one unit.

This rule should resolve most disputes about code formatting style.

<!--more-->

{% jb_picture_body %}

According to the rule, this Java code is legal:

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

This one is not:

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
