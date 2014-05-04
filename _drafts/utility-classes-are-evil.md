---
layout: post
title: "OOP Alternative to Utility Classes"
date: 2014-05-02
tags: quality oop design
description:
  Utility classes is a very popular design pattern in Java
  and other object-oriented languages, however they are considered
  as a terrible practice and should be avoided
keywords:
  - static methods
  - static is evil
  - utility class is evil
  - utility class
  - utility classes
  - how to avoid utility classes
  - utility class alternative
  - alternative of utility class
  - singleton is evil
  - bad practices utility class
  - helper class is evil
  - helper class is bad
---

A utility class (aka helper class)
is a "structure" that has only static methods and encapsulate
no state. `StringUtils`, `IOUtils`, `FileUtils` from
[Apache Commons](http://commons.apache.org/);
`Iterables` and `Iterators` from
[Guava](https://code.google.com/p/guava-libraries/),
and [`Files`](http://docs.oracle.com/javase/7/docs/api/java/nio/file/Files.html) from JDK7
are perfect examples of utility classes.

This design idea is very popular in Java
world (as well as C#, Ruby, etc.),
because utility classes provide common functionality used everywhere.
We want to follow
[DRY principle](http://en.wikipedia.org/wiki/Don't_repeat_yourself)
and avoid duplication. We place
common code blocks into utility classes and reuse them when necessary:

{% highlight java %}
// This is a terrible design, don't reuse
public class NumberUtils {
  public static int max(int a, int b) {
    return a > b ? a : b;
  }
}
{% endhighlight %}

Indeed, a very convenient technique?!

## Utility Classes Are Evil

However, in a object-oriented world utility classes are considered as
a very bad (some may say "terrible") practice.
There were many discussions of this subject, to name a few:
[Are Helper Classes Evil?](http://blogs.msdn.com/b/nickmalik/archive/2005/09/06/461404.aspx) by Nick Malik,
[Why helper, singletons and utility classes are mostly bad](http://smart421.wordpress.com/2011/08/31/why-helper-singletons-and-utility-classes-are-mostly-bad-2/) by Simon Hart,
[Avoiding Utility Classes](http://www.marshallward.org/avoiding-utility-classes.html) by Marshal Ward,
[Kill That Util Class!](http://www.jroller.com/DhavalDalal/entry/kill_that_util_class) by Dhaval Dalal,
[Helper Classes Are A Code Smell](http://www.robbagby.com/posts/helper-classes-are-a-code-smell/) by Rob Bagby.

There are a few questions on StackExchange about it:
[If a “Utilities” class is evil, where do I put my generic code?](http://stackoverflow.com/questions/3339929/if-a-utilities-class-is-evil-where-do-i-put-my-generic-code),
[Utility Classes are Evil](http://stackoverflow.com/questions/3340032/utility-classes-are-evil).

A dry summary of all their arguments is that
utility classes are not proper objects that's why they don't fit
into object-oriented world. They were inherited from
procedural programming, mostly because most of us were
used to a functional decomposition paradigm back then.

Assuming you agree with the arguments and want to stop using utility
classes, I'll show by example how these creatures can be replaced
with proper objects.

## Procedural Example

Say, you want to read a text file, split it into lines, trim every line
and save the result into another file. This is how this can be done with
[`FileUtils`](http://commons.apache.org/proper/commons-io/apidocs/org/apache/commons/io/FileUtils.html)
from Apache Commons:

{% highlight java linenos=table %}
void transform(File in, File out) {
  Collection<String> src = FileUtils.readLines(in, "UTF-8");
  Collection<String> dest = new ArrayList<>(src.size());
  for (String line : src) {
    dest.add(line.trim());
  }
  FileUtils.writeLines(out, dest, "UTF-8");
}
{% endhighlight %}

The code may look clean, however, this is a procedural
programming, not object-oriented.
We are manipulating data (bytes and bits), explicitly
telling the computer where to get them and where to put, on every single
line of code. We're defining *a procedure of execution*.

## Object-Oriented Alternative

In object-oriented paradigm we should instantiate and compose objects,
letting them manage data when and how *they* desire. Instead of calling
supplementary static functions we should create objects that are capable
of exposing the behaviour we're looking for:

{% highlight java %}
public class Pair {
  private final int a;
  private final int b;
  public Pair(int x, int y) {
    this.a = x;
    this.b = y;
  }
  public int max() {
    return this.a > this.b ? this.a : this.b;
  }
}
{% endhighlight %}

This procedural call:

{% highlight java %}
int max = NumberUtils.max(10, 5);
{% endhighlight %}

Will become object-oriented:

{% highlight java %}
int max = new Pair(10, 5).max();
{% endhighlight %}

Potato, potato? Not really. Read on...

## Objects Instead of Data Structures

This is how I would design
the same file-transforming
functionality as above but in a object-oriented way:

{% highlight java linenos=table %}
void transform(File in, File out) {
  Collection<String> src = new Trimmed(
    new FileLines(new UnicodeFile(in))
  );
  Collection<String> dest = new FileLines(
    new UnicodeFile(out)
  );
  dest.addAll(src);
}
{% endhighlight %}

`FileLines` implements `Collection<String>` and encapsulates all
file reading and writing operations. An instance of `FileLines` behaves
exactly as a collection of strings, hiding all I/O operations. When we
iterate it &mdash; a file is being read. When we `addAll()` to it &mdash;
a file is being written.

`Trimmed` also implements `Collection<String>` and encapsulates a
collection of strings
([Decorator pattern](http://en.wikipedia.org/wiki/Decorator_pattern)).
Every time the next line is retrieved, it gets trimmed.

All classes taking participation in the snippet are
rather small: `Trimmed`, `FileLines`, and `UnicodeFile`.
Each of them is responsibile for its own single feature,
thus perfectly following
[single responsibility principle](http://en.wikipedia.org/wiki/Single_responsibility_principle).
On our side, as users of the library, this may be not so important,
but for their developers it definitely is.
It is much easier to develop, maintain, and unit test class `FileLines`
instead of `readLines()` method in a 80+ methods and 3000 lines
utility class `FileUtils`. Seriously, look at
[its source code](http://svn.apache.org/viewvc/commons/proper/io/trunk/src/main/java/org/apache/commons/io/FileUtils.java?view=co).

Object-oriented approach enables lazy execution.
The `in` file is not read until its data is required.
If we fail to open `out` due to some I/O error,
the first file won't even be touched.
The whole show starts only when we call `addAll()`.

All lines in the second snippet, except the last one, are instantiating
and composing smaller objects into bigger ones. This object composition
is rather cheap for the CPU since it doesn't cause any data transformations.

Besides that, it is obvious, that the second script runs in O(1) space, while the
first one is in O(n). This is the consequence of our procedural
approach to data, in the first script.

In object-oriented world, there is no data, there are only objects
and their behavior!
