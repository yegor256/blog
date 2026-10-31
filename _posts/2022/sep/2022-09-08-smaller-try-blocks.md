---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Smaller Try-Blocks Are Better"
date: 2022-09-08
place: Moscow, Russia
tags: oop java
description: |
  Large try-blocks in try/catch statements are a common
  practice, because we try to avoid polluting the code
  with catch blocks; it's a bad tendency.
keywords:
  - try catch
  - oop try catch
  - exception handling oop
  - try block
  - try catch exceptions
image: /images/2022/09/the-rum-diary.jpg
jb_picture:
  caption: The Rum Diary (2011) by Bruce Robinson
social:
  - reddit: https://www.reddit.com/r/programming/comments/x95aih/smaller_tryblocks_are_better/
---

It often happens, [especially]({% pst 2015/jul/2015-07-28-checked-vs-unchecked-exceptions %})
in Java, that a few places in the method
are potential exception originators. Usually, we make a large method-size
`try` block with a single `catch` at the bottom. We catch all
the exceptions, usually even using
[grouping](https://docs.oracle.com/javase/7/docs/technotes/guides/language/catch-multiple.html).
This helps us minimize the noise, which is the exception catching.
However, such large `try` blocks jeopardize maintainability: we are unable
to provide proper [error context]({% pst 2015/dec/2015-12-01-rethrow-exceptions %})
inside `catch` blocks.

<!--more-->

{% jb_picture_body %}

What do you think is wrong with this Java method
(aside from using `System.out` instead of an injected dependency)?:

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.regex.Pattern;

void grep(Path file, Pattern regex) {
  try {
    for (String line : Files.readAllLines(file)) {
      if (regex.matcher(line).matches()) {
        System.out.println(line);
      }
    }
  } catch (IOException ex) {
    throw new IllegalStateException(ex);
  }
}
```

I believe that its try/catch block is too big. The `IOException` may only be
thrown by the [`readAllLines`](https://docs.oracle.com/javase/8/docs/api/java/nio/file/Files.html#readAllLines-java.nio.file.Path-)
static method, but the block covers a few other method calls
and statements. This code would be better:


```java
void grep(Path file, Pattern regex) {
  String[] lines;
  try {
    lines = Files.readAllLines(file);
  } catch (IOException ex) {
    throw new IllegalStateException(ex);
  }
  for (String line : lines) {
    if (regex.matcher(line).matches()) {
      System.out.println(line);
    }
  }
}
```

Now the try/catch block covers exactly the place where the exception
may originate. Nothing else!

Why are smaller try-blocks better? Because they allow more
focused error reporting with more detailed context. For example, the
second snippet can be re-written as follows:

```java
void grep(Path file, Pattern regex) {
  String[] lines;
  try {
    lines = Files.readAllLines(file);
  } catch (IOException ex) {
    throw new IllegalStateException(
      String.format(
        "Failed to read all lines from %s",
        file
      ),
      ex
    );
  }
  for (String line : lines) {
    if (regex.matcher(line).matches()) {
      System.out.println(line);
    }
  }
}
```

Can we do the same with the first snippet? We could, but the
error message would be inaccurate, because the block covers too much.
