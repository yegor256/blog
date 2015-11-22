---
layout: post
title: "Procedures, Functions, Methods, and Temporal Coupling"
date: 2015-11-25
place: Kyiv, Ukraine
tags: java oop
description:
  ...
keywords:
  - procedures vs functions
  - oop procedures
  - procedures in oop
  - temporal coupling
  - methods vs functions
---

There is no much of a difference between them, right? Procedures,
methods, functions &mdash; just a piece of code that accepts some
arguments and performs something for us. Basically, a set of
instructions for the CPU, with a name and a list of parameters. Right.
This is a procedure. Functions and methods are something else, something
very different. But, theory aside, I want to show a practical example
of refactoring, which makes procedural code more object-oriented and
removes temporal coupling.

<!--more-->

Here is the code:

{% highlight java %}
class Foo {
  public List<String> names() {
    List<String> list = new LinkedList();
    Foo.append(list, "Jeff");
    Foo.append(list, "Walter");
    return list;
  }
  private static void append(
    List<String> list, String item) {
    list.add(item.toLowerCase());
  }
}
{% endhighlight %}

What do you think about it? I believe, it's clear what `names()` is doing &mdash;
creating a list of names. In order to avoid duplication, there is a supplementary
_procedure_ `append()`, which converts an item to lower case and adds to the
list.

This design is bad.

It is a **procedural** design and there is **temporal coupling** between
lines in method `names()`.

Let me show you first what is a better (not the best!) design,
than will try to explain its benefits:

{% highlight java %}
class Foo {
  public List<String> names() {
    return Foo.with(
      Foo.with(
        new LinkedList(),
        "Jeff"
      ),
      "Walter"
    );
  }
  private static List<String> with(
    List<String> list, String item) {
    list.add(item.toLowerCase());
    return list;
  }
}
{% endhighlight %}

An ideal design of method `with()` would create a new instance of
`List`, populate it through `addAll(list)`, then `add(item)` to it and
then return. That would be perfectly
[immutable](http://www.yegor256.com/2014/06/09/objects-should-be-immutable.html),
but slow.

So, what is wrong with this:

{% highlight java %}
List<String> list = new LinkedList();
Foo.append(list, "Jeff");
Foo.append(list, "Walter");
return list;
{% endhighlight %}

Looks pefectly clean, right? Instantiate a list, append two items to it, and
return it. Yes, it is clean, for now. Because we remember what `append()` is
doing. In a few months we'll get back to this code and it will look like this:

{% highlight java %}
List<String> list = new LinkedList();
// 10 more lines here
Foo.append(list, "Jeff");
Foo.append(list, "Walter");
// 10 more lines here
return list;
{% endhighlight %}

Is it so clear now that `append()` is actually adding `"Jeff"` to `list`? What
will happen if I remove that line? Will it affect the result being
returned in the last line? I don't know. I need to check the body of method
`append()` to make sure.

Also, how about returning `list` first and calling `append()` afterwards? This
is what possible "refactoring" may do to our code:

{% highlight java %}
List<String> list = new LinkedList();
if (/* something */) {
  return list;
}
// 10 more lines here
Foo.append(list, "Walter");
Foo.append(list, "Jeff");
// 10 more lines here
return list;
{% endhighlight %}

First of all, we return `list` too early, when it is not ready. But did anyone
tell me that these two calls to `append()` must happen before `return list`?
Second, we changed the order of `append()` calls. Again, did anyone tell me
that it's important to call them in that particular order?

Nobody. Nowere. This is called **temporal coupling**.

Our lines are **coupled** together. They must stay in this particular order and the
knowledge about the order is hidden. It's easy to destroy
the order and our compiler won't be able to catch us.

To the contrary, this design doesn't have any "order":

{% highlight java %}
return Foo.with(
  Foo.with(
    new LinkedList(),
    "Jeff"
  ),
  "Walter"
);
{% endhighlight %}

It just **returns** a list, which is constructed by a few calls to `with()`
method. It is a single line, instead of four.

As [discussed before]({% pst 2015/aug/2015-08-18-multiple-return-statements-in-oop %}),
an ideal method in OOP must have just a single statement and this statement is
`return`.

The same is true about validation. For example, this code is bad:

{% highlight java %}
list.add("Jeff");
Foo.checkIfListStillHasSpace(list);
list.add("Walter");
{% endhighlight %}

While this one is much better:

{% highlight java %}
list.add("Jeff");
Foo.listWithEnoughSpace(list).add("Walter");
{% endhighlight %}

See the difference?
