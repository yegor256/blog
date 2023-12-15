---
layout: post
title: "The Educational Aspect of Static Analysis"
date: 2018-01-16
place: Moscow, Russia
tags: quality
description: |
  Static analysis, if done manually, may seriously improve
  programmer's skills; auto-formatting tools are lacking
  that aspect and don't help us on the long run.
book: code-ahead-1 1
keywords:
  - static analysis
  - teaching by static analysis
  - code auto-formatting
  - auto-formatting
  - java static analysis
image: /images/2018/01/blind-fury.jpg
jb_picture:
  caption: Blind Fury (1989) by Phillip Noyce
---

[Very often](https://github.com/yegor256/cactoos/issues/544)
new programmers who join our projects ask us whether we
have auto-formatting instruments to make Java code look exactly
the way [Qulice]({% pst 2014/aug/2014-08-13-strict-code-quality-control %})
expects. (Qulice is the static analyzer we use.) I always reply that having
such an automated code polisher would only be harmful and wouldn't help
the project and its members improve and grow. Here is why I think so.

<!--more-->

{% jb_picture_body %}

Static analysis, the way we do it in combination with
[read-only master branch]({% pst 2014/jul/2014-07-21-read-only-master-branch %}),
is a fully automated uncompromising review of your pull request, mostly
intended to spot code formatting mistakes. Say we want Java code in
our entire repository to look like this:

```java
final class Doc {
  private final File file;
  public void remove() {
    if (this.file.exists()) {
      this.file.delete();
    }
  }
}
```

However, you refactor it as part of a bigger task, and submit a pull request like this:

```java
class Doc {
  private File f;
  public void remove()
  {
    if (f.exists())
      f.delete();
  }
}
```

For some of you this may not seem like a big difference, since both code snippets
compile without issues and work exactly the same way. However, for us,
the repository maintainers, it is a big deal. We do want our classes to always be
`final`, we do want them to be immutable (so all attributes should also be `final`),
we want to prefix all attribute references with `this.`, and we want the
code to be formatted the same way, since we believe that the uniformity
of the code seriously increases its maintainability.

{% quote Of course, we could create a tool, but in that case you would never learn what the project wants from you and why. %}

Of course, we could create a tool which you could then use to re-format
the code, to make it look the way we want. But in that case you would
never _learn_ what the project wants from you and _why_.

You will not know the reasoning behind our rules. You will never think about them.
You will not really care about them. But they are not only about the formatting
of spaces and brackets. There are [over 900]({% pst 2014/jul/2014-07-21-read-only-master-branch %})
of them in [Qulice](https://www.qulice.com) and some of
them were designed especially for the object-oriented philosophy
[we](https://www.elegantobjects.org) are preaching.

Thus, simply put, we don't want you to go through the static analysis phase easily.
We want you to suffer in order to learn.

