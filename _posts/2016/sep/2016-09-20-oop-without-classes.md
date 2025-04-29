---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "OOP Without Classes?"
date: 2016-09-20
place: Palo Alto, CA
tags: oop
description: |
  Do we really need classes in OOP? Maybe it's
  possible to just have objects, and types. And,
  of course, no implementation inheritance.
keywords:
  - class in oop
  - what is class in oop
  - object-oriented programming
  - role of class in oop
  - classes in oop
image: /images/2016/09/battleship-potemkin.jpg
jb_picture:
  caption: Броненосец Потемкин (1925) by Сергей Эйзенштейн
---

I [interviewed](https://www.youtube.com/watch?v=s-hdZZzMCac)
David West, the author of the [Object Thinking](https://amzn.to/266oJr4) book,
a few weeks ago, and he said that classes were not meant to be in
object-oriented programming at all. He actually said that
[earlier](https://www.youtube.com/watch?v=RdE-d_EhzmA); I just didn't
understand him then. The more I've thought about this, the more it appears
obvious that we indeed do not need classes.

<!--more-->

{% jb_picture_body %}

Here is a prototype.

Let's say we have only _types_ and _objects_. First, we define a type:

```text
type Book {
  void print();
}
```

Then we _create_ an object (pay attention; we don't "instantiate"):

```text
Book b1 = create Book("Object Thinking") {
  String title;
  Book(String t) {
    this.title = t;
  }
  public void print() {
    print("My title: " + this.title);
  }
}
```

Then we create another object, which will behave similarly
to the one we already have but with different constructor arguments.
We _copy_ an existing one:

```text
Book b2 = copy b1("Elegant Objects");
```

Libraries will deliver us objects, which we can copy.

That's it.

No [implementation inheritance]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %})
and no [static methods]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}),
of course.
Only [subtyping](https://en.wikipedia.org/wiki/Subtyping).

Why not?
