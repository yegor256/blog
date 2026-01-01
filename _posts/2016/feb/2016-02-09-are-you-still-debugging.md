---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Are You Still Debugging?"
date: 2016-02-09
tags: tdd
place: Palo Alto, CA
description: |
  The necessity of debugging is an indicator of code problems
  and a great motivator for immediate refactoring
  and unit testing.
category: jcg
keywords:
  - debugging
  - debugging vs testing
  - debugging vs unit testing
  - debugging is evil
  - stop debugging
translated:
  - Russian: https://habrahabr.ru/company/piter/blog/278567/
image: /images/2016/02/the-revenant.jpg
jb_picture:
  caption: The Revenant (2015) by Alejandro G. Iñárritu
---

[Debugging](https://en.wikipedia.org/wiki/Debugging)
is "a process of running a program/method interactively,
breaking execution flow after each statement and showing..." In a nutshell, it is
a very useful technique ... for a bad programmer. Or an old programmer
who is still writing procedural code in C. Object-oriented programmers
never debug their code---they write unit tests. My point here
is that unit testing is a technique that completely replaces debugging.
If debugging is required, the _design is bad_.

<!--more-->

{% jb_picture_body %}

Let's say I'm a [bad]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %})
imperative procedural programmer, and this is my Java code:

```java
class FileUtils {
  public static Iterable<String> readWords(File f) {
    String text = new String(
      Files.readAllBytes(Paths.get(f)),
      "UTF-8"
    );
    Set<String> words = new HashSet<>();
    for (String word : text.split(" ")) {
      words.add(word);
    }
    return words;
  }
}
```

This static [utility]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %})
method reads file content and then
finds all the unique words in it. Pretty simple. However, if
it doesn't work, what do we do? Let's say this is the file:

```text
We know what we are,
but know not what we may be.
```

From it, we get this list of words:

```text
"We"
"know"
"what"
"we"
"are,\n"
"but"
"not"
"may"
"be\n"
```

Now that doesn't look right to me ... so what is the next step? Either the file
reading doesn't work correctly or the split is broken. Let's _debug_, right?
Let's give it a file through an input and go step by step, tracing and watching
the variables. We'll find the bug and fix it. But when a similar
problem shows up, we'll have to debug again! And that's what unit testing
is supposed to _prevent_.

We're supposed to create a unit test once, in which the problem is reproduced.
Then we fix the problem and make sure the test passes. That's how we save
our investments in problem solving. We won't fix it again, because it won't
happen again. Our _test_ will prevent it from happening.

{% quote If you perceive debugging to be faster and easier, think about the quality of your code. %}

However, all this will work only if it's easy to create a unit test. If it's
difficult, I'll be too lazy to do it. I will just debug and fix the problem.
In this particular example, creating a test is a rather expensive procedure.
What I mean is the complexity of the unit test will be rather high. We have to
create a temporary file, fill it with data, run the method, and check the results.
To find out what's going on and where the bug is, I'll have to create a number
of tests. To avoid code duplication, I'll also have to create some supplementary
utilities to help me create that temporary file and fill it with data.
That's a lot of work. Well, maybe not "a lot," but way more than a few minutes
of debugging.

{% youtube Mj1gA5mEk68 %}

Thus, if you perceive debugging to be faster and easier, think about the quality
of your code. I bet it has a lot of opportunities for refactoring, just like
the code from the example above. Here is how I would modify it. First of all,
I would turn it into a class, because utility static methods are a
[bad practice]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}):

```java
class Words implements Iterable<String> {
  private final File file;
  Words(File src) {
    this.file = src;
  }
  @Override
  public Iterator<String> iterator() {
    String text = new String(
      Files.readAllBytes(Paths.get(this.file)),
      "UTF-8"
    );
    Set<String> words = new HashSet<>();
    for (String word : text.split(" ")) {
      words.add(word);
    }
    return words.iterator();
  }
}
```

It looks better already, but the complexity is still there. Next, I would
break it down into smaller classes:

```java
class Text {
  private final File file;
  Text(File src) {
    this.file = src;
  }
  @Override
  public String toString() {
    return new String(
      Files.readAllBytes(Paths.get(this.file)),
      "UTF-8"
    );
  }
}
class Words implements Iterable<String> {
  private final String text;
  Words(String txt) {
    this.text = txt;
  }
  @Override
  public Iterator<String> iterator() {
    Set<String> words = new HashSet<>();
    for (String word : this.text.split(" ")) {
      words.add(word);
    }
    return words.iterator();
  }
}
```

What do you think now? Writing a test for the `Words` class is a pretty
trivial task:

```java
import org.junit.Test;
import static org.hamcrest.MatcherAssert.*;
import static org.hamcrest.Matchers.*;
public class WordsTest {
  @Test
  public void parsesSimpleText() {
    assertThat(
      new Words("How are you?"),
      hasItems("How", "are", "you")
    );
  }
}
```

How much time did that take? Less than a minute. We don't need to create
a temporary file and load it with data, because class `Words` doesn't do
anything with files. It just parses the incoming string and finds the unique
words in it. Now it's easy to fix, since the test is small and we can
easily create more tests; for example:

```java
import org.junit.Test;
import static org.hamcrest.MatcherAssert.*;
import static org.hamcrest.Matchers.*;
public class WordsTest {
  @Test
  public void parsesSimpleText() {
    assertThat(
      new Words("How are you?"),
      hasItems("How", "are", "you")
    );
  }
  @Test
  public void parsesMultipleLines() {
    assertThat(
      new Words("first line\nsecond line\n"),
      hasItems("first", "second", "line")
    );
  }
}
```

My point is that debugging is necessary when the amount of time
to write a unit test is significantly more than the time it takes to click
those Trace-In/Trace-Out buttons. And it's logical. We all are lazy and
want fast and easy solutions. But debugging burns time and wastes
energy. It helps us find problems but doesn't help prevent
them from reappearing.

Debugging is needed when our code is
[procedural]({% pst 2015/feb/2015-02-20-utility-classes-vs-functional-programming %})
and algorithmic---when the code is all
about _how_ the goal should be achieved instead of _what_ the goal is.
See the examples above again. The first static method is all about
how we read the file, parse it, and find words. It's even named `readWords()` (a _verb_).
To the contrary, the second example is about what will be achieved. It's either
the `Text` of the file or `Words` of the text (both are _nouns_).

I believe there is no place for debugging in clean object-oriented
programming. Only unit testing!
