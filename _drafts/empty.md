---
layout: post
title: "Empty Line is a Code Smell"
date: 2014-11-02
tags: design
description:
  Empty line inside your method body is an indicator
  of a lack of cohesion in its design and a good motivator
  for immediate refactoring
keywords:
  - empty line in method body
  - empty line is evil
  - empty line in function body
  - empty line is bad
  - avoid empty lines in method body
---

The subject may sound like a joke, but it is not. An empty line,
used as a separator of instructions in an object method, is a code smell.
Why? In short, because a method may not contain "parts". A method
should always do one thing (see Single Responsibility Principle) and its
functional decomposition should be done by language constructs
(for example, new methods), and **never** by empty lines.

<!--more-->

Look at this code (it smells to me):

{% highlight java %}
final class TextFile {
  private final File file;
  TextFile(File src) {
    this.file = src;
  }
  public int grep(Pattern regex) throws IOException {
    Collection<String> lines = new LinkedList<>();

    int total = 0;
    for (String line : lines) {
      if (regex.matcher(line).matches()) {
        ++total;
      }
    }
    return total;
  }
}
{% endhighlight %}

This method, first, loads the content of the file. Second, it
counts how many lines match the regular expression provided. Why does
method `grep` smells? Because it does two things instead of one.

If we make a rule, to avoid empty lines in method bodies, the method
will have to be refactored in order to preserve the separation
introduced by that empty line:

{% highlight java %}
final class TextFile {
  private final File file;
  TextFile(File src) {
    this.file = src;
  }
  public int grep(Pattern regex) throws IOException {
    return this.count(this.lines(), regex);
  }
  private int count(Iterable<String> lines, Pattern regex) {
    int total = 0;
    for (String line : lines) {
      if (regex.matcher(line).matches()) {
        ++total;
      }
    }
    return total;
  }
  private Iterable<String> lines() throws IOException {
    Collection<String> lines = new LinkedList<>();
    return lines;
  }
}
{% endhighlight %}

I believe it is obvious that this new class has methods that are
much more cohesive and readable. Now every method is doing exactly
one thing and it's easy to understand which thing it is.

This idea about avoiding empty lines is applicable to other languages,
not just Java/C++/Ruby, etc. For example, this CSS code is
definitely begging for refactoring:

{% highlight css %}
.container {
  width: 80%;
  margin-left: auto;
  margin-right: auto;

  font-size: 2em;
  font-weight: bold;
}
{% endhighlight %}

The empty line here is telling us (screaming, actually) that this `container`
class is too complex and has to be decomposed into two classes:

{% highlight css %}
.wide {
  width: 80%;
  margin-left: auto;
  margin-right: auto;
}
.important {
  font-size: 2em;
  font-weight: bold;
}
{% endhighlight %}

Unfortunately, it is a very common habit, to use empty lines to
separate blocks of code. Moreover, very often I see empty blocks of
two or even three lines, which are playing this evil role of a
separator of concerns.

Needless to say that a properly designed class must have up to five public
methods and a properly designed method must have up to ten instructions.
Empty lines inside methods encourage us to break this awesome rule and
turn them into multi-page poems.

Of course, it's easier to just click `enter` a few times and continue to
code right in the same method, instead of thinking and refactoring first.
This laziness will eventually lead to the code that is hardly maintainable
at all.

... examples ...

To prevent this from happening in your projects, stop using empty
lines inside methods at all. Ideally, prohibit them in your automated build.
In [qulice.com]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}),
a static analysis tool we're using in all Java projects,
we created a custom Checkstyle check that prohibits empty lines in every
method.
