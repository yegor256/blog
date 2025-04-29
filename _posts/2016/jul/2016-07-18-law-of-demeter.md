---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "The Law of Demeter Doesn't Mean One Dot"
date: 2016-07-18
place: Palo Alto, CA
tags: oop
description: |
  The well-known Law of Demeter is seriously misunderstood
  by object-oriented programmers---it isn't equal
  to the law of one dot.
keywords:
  - law of demeter
  - law of demeter java
  - law of demeter violation
  - law of demeter example
  - law of demeter c#
book: elegant-objects-2 5.9
image: /images/2016/07/spartacus.jpg
jb_picture:
  caption: Spartacus (1960) by Stanley Kubrick
---

You've probably heard about that 30-year-old
[Law of Demeter](https://en.wikipedia.org/wiki/Law_of_Demeter) (LoD). Someone
asked me recently what I think about it. And not just what I think, but
how it is possible to keep objects small and obey the LoD. According to the
law, we're not allowed to do something like `book.pages().last().text()`.
Instead, we're supposed to go with `book.textOfLastPage()`.
It puzzled me, because I strongly disagree. I believe the first construct
is perfectly valid in OOP. So I've done some research to find out
whether this law is really a law. What I found out is that the law is
perfect, but its common understanding in the OOP world is simply wrong
(not surprisingly).

<!--more-->

{% jb_picture_body %}

[Object-Oriented Programming: An Objective Sense of Style](https://www.ccs.neu.edu/research/demeter/papers/law-of-demeter/oopsla88-law-of-demeter.pdf),
K.Lieberherr, I.Holland, and A.Riel, OOPSLA'88 Proceedings, 1988.

This is where it was introduced. Let's see what it literally says (look for
Section 3 in that PDF document):

> For all classes C, and for all methods M attached to C, all objects to which M sends a message must be instances of classes associated with the following classes: 1) the argument classes of M (including C), 2) the instance variable classes of C.

Say it's a Java class:

```java
class C {
  private B b;
  void m(A a) {
    b.hello();
    a.hello();
    Singleton.INSTANCE.hello();
    new Z().hello();
  }
}
```

All four calls to four different `hello()` methods are legal, according
to the LoD. So what would be illegal, I ask myself? No surprise;
the answer is this: `a.x.hello()`. That would be illegal. Directly
accessing the attribute from another object and then talking to it
is not allowed by the law.

But we don't do that anyway. We're talking about `book.pages().last().text()`.
In this chain of method calls, we're not accessing any attributes. We're
asking our objects to build new objects for us. What does the law say about
that? Let me read it and quote:

> Objects created by M, or by functions or methods that M calls, are considered as arguments of M

In other words, the object `Pages` that method call `book.pages()` returns
is a perfectly valid object that can be used. Then, we can call method
`last()` on it and get an object `Page`, and then call method `text()`, etc. This
is a perfectly valid scenario that doesn't violate the law at all, just
as I expected.

{% quote So the bottom line is that the Law of Demeter is not against method chaining at all. %}

So where does this common understanding of the law come from? Why does
[Wikipedia](https://en.wikipedia.org/wiki/Law_of_Demeter)
call it a rule of "one dot" and say that
"an object should avoid invoking methods of a member object returned by another method?"
This is absolutely to the contrary of what the original paper says!
What's going on?

The answer is simple: [getters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}).

The majority of OOP developers think most object methods that
return anything are getters. And getters, indeed, are no different than
direct access to object attributes. That's why Wikipedia actually says
"no direct access to attributes and, since most of your methods are getters,
don't touch them either, silly."

That's just sad to see.

So the bottom line is that the Law of Demeter is not against
method chaining at all. Of course, it's against getters and direct attribute
access. But who isn't, right?
