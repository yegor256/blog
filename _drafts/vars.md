---
layout: post
title: "A Compound Name Is a Code Smell"
date: 2015-01-10
tags: oop
description:
  Variable name that consists of a few words is a code
  smell because it indicates a too big variable scope
keywords:
  - variable naming convention
  - variable name
  - naming convention
  - composite variable name
  - long variable name
---

Do you name variables like `textLength`, `table_name`, or `current-user-email`?
All of them are compound names that consist of more then one word. Even though
they look more descriptive than `name`, `length` or `email` I would strongly
recommend to avoid them. I believe that a variable name that is more complex than a noun
is a code smell. Why? Because we usually give variable a compound name when its scope
is so big and complex that a simple noun would sound ambiguous.
And a big and complex scope is an obvious code smell.

<!--more-->

A scope of a variable is a place where it is visible, for example a method. Look
at this Ruby class:

{% highlight ruby %}
class CSV
  def initialize(csvFileName)
    @fileName = csvFileName
  end
  def readRecords()
    File.readLines(@fileName).map |csvLine|
      csvLine.split(',')
    end
  end
end
{% endhighlight %}

Visibility scope of variable `csvFileName` is method `initialize()`, which
is a constructor of the class `CSV`. Why does it need a compound name
that consists of three words? Isn't it clear already that a single-argument
constructor of class `CSV` expects a name of the file with
comma-separated values? I would rename it to `file`.

Next, visibility scope of `@fileName` is the entire class `CSV`. It is a single
variable in the class and renaming it to just `@file` won't introduce
any confusion. It's still clear what file we're dealing with.
The same situation is with `csvLine` variable. It is clear that we're
dealing with CSV lines here. This `csv` prefix is just a redundancy.
Here is how I would refactor the class:

{% highlight ruby %}
class CSV
  def initialize(file)
    @file = file
  end
  def records()
    File.readLines(@file).map |line|
      line.split(',')
    end
  end
end
{% endhighlight %}

Now it looks clear and cohesive.

If you can't make such a refactoring, it means that your scope is too
big and/or too complex. An ideal method should deal with 2-5 variables
and an ideal class should encapsulate 2-5 properties (not my numbers,
I took them from ["Object Thinking"](http://www.amazon.com/gp/product/0735619654/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0735619654&linkCode=as2&tag=yegor256com-20&linkId=NQQHJZPHOKM6BTCT)
by David West).

If we have five variables, can't we find five nouns to name them?

Adam and Eve didn't have second names. They were unique in Eden.
As well as many other characters in the Old Testament. Second and middle
names were invented later, in order to resolve ambiguity. To keep
your methods and classes clean and solid and prevent ambiguity, try to give your variables
and methods unique single-word names, just like Adam and Eve were named
by you know who :)
