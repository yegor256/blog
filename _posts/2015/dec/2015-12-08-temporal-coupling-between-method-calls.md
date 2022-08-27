---
layout: post
title: "Temporal Coupling Between Method Calls"
date: 2015-12-08
place: Kyiv, Ukraine
tags: java oop
description: |
  Sequential method calls inevitably mean
  temporal coupling, which is a bottleneck for
  effective refactoring; avoid them.
category: jcg
keywords:
  - temporal coupling
  - temporal coupling java
  - temporal coupling hidden
  - temporal coupling in oop
  - temporal coupling definition
book: elegant-objects-2 5.6
image: /images/2015/12/blueberry.jpg
jb_picture:
  caption: Blueberry (2004) by Jan Kounen
---

Temporal coupling happens between sequential method calls
when they must stay in a particular order. This is inevitable
in imperative programming, but we can reduce the negative effect
of it just by turning those static procedures into functions. Take
a look at this example.

<!--more-->

{% jb_picture_body %}

Here is the code:

```java
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
```

What do you think about that? I believe it's clear what `names()` is doing---creating a list of names. In order to avoid duplication, there is a supplementary
_procedure_, `append()`, which converts an item to lowercase and adds it to the
list.

This is poor design.

It is a **procedural** design, and there is **temporal coupling** between
lines in method `names()`.

Let me first show you a better (though not the best!) design,
then I will try to explain its benefits:

```java
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
```

An ideal design for method `with()` would create a new instance of
`List`, populate it through `addAll(list)`, then `add(item)` to it, and
finally return. That would be perfectly
[immutable](https://www.yegor256.com/2014/06/09/objects-should-be-immutable.html),
but slow.

So, what is wrong with this:

```java
List<String> list = new LinkedList();
Foo.append(list, "Jeff");
Foo.append(list, "Walter");
return list;
```

It looks perfectly clean, doesn't it? Instantiate a list, append two items to it, and
return it. Yes, it is clean---for now. Because we remember what `append()` is
doing. In a few months, we'll get back to this code, and it will look like this:

```java
List<String> list = new LinkedList();
// 10 more lines here
Foo.append(list, "Jeff");
Foo.append(list, "Walter");
// 10 more lines here
return list;
```

Is it so clear now that `append()` is actually adding `"Jeff"` to `list`? What
will happen if I remove that line? Will it affect the result being
returned in the last line? I don't know. I need to **check** the body of method
`append()` to make sure.

Also, how about returning `list` first and calling `append()` afterwards? This
is what possible "refactoring" may do to our code:

```java
List<String> list = new LinkedList();
if (/* something */) {
  return list;
}
// 10 more lines here
Foo.append(list, "Walter");
Foo.append(list, "Jeff");
// 10 more lines here
return list;
```

First of all, we return `list` too early, when it is not ready. But did anyone
tell me that these two calls to `append()` must happen before `return list`?
Second, we changed the order of `append()` calls. Again, did anyone tell me
that it's important to call them in that particular order?

Nobody. Nowhere. This is called **temporal coupling**.

Our lines are **coupled** together. They must stay in this particular order, but the
knowledge about that order is hidden. It's easy to destroy
the order, and our compiler won't be able to catch us.

To the contrary, this design doesn't have any "order":

```java
return Foo.with(
  Foo.with(
    new LinkedList(),
    "Jeff"
  ),
  "Walter"
);
```

It just **returns** a list, which is constructed by a few calls to the `with()`
method. It is a single line instead of four.

As [discussed before]({% pst 2015/aug/2015-08-18-multiple-return-statements-in-oop %}),
an ideal method in OOP must have just a single statement, and this statement is
`return`.

The same is true about validation. For example, this code is bad:

```java
list.add("Jeff");
Foo.checkIfListStillHasSpace(list);
list.add("Walter");
```

While this one is much better:

```java
list.add("Jeff");
Foo.withEnoughSpace(list).add("Walter");
```

See the difference?

And, of course, an ideal approach would be to use
[composable decorators]({% pst 2015/feb/2015-02-26-composable-decorators %})
instead of these ugly static methods. But if it's not possible for
some reason, just don't make those static methods look like procedures.
Make sure they always return results, which become arguments to
further calls.
