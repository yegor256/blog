---
layout: post
title: "Law of Demeter Doesn't Mean One Dot"
date: 2016-07-20
place: Palo Alto, CA
tags: oop
description: |
  A well-known Law of Demeter is seriously misunderstood
  by object-oriented programmers &mdash; it isn't equal
  to the law of one dot.
keywords:
  - law of demeter
  - law of demeter java
  - law of demeter violation
  - law of demeter example
  - law of demeter c#
---

You've probably heard about that 30-years old
[Law of Demeter](https://en.wikipedia.org/wiki/Law_of_Demeter) (LoD). Someone
asked me recently what I think about it. And not just what I think, but
how is possible to keep objects small and obey the LoD? According to the
law, we're not allowed to do something like `book.pages().last().text()`.
Instead, we're supposed to go with `book.textOfLastPage()`.
It puzzled me, since I strongly disagree. I believe that the first construct
is perfectly valid in OOP. So, and I've done some research to find out
maybe the law is not really a law. What I found out is that the law is
perfect, but its common understanding in OOP world is simply wrong
(not surprisingly).

<!--more-->

[Object-Oriented Programming: An Objective Sense of Style](http://www.ccs.neu.edu/research/demeter/papers/law-of-demeter/oopsla88-law-of-demeter.pdf)
K.Lieberherr, I.Holland, and A.Riel, OOPSLA'88 Proceedings, 1988.

This is where it was introduced. Let's see what it literally says (you need
Section 3 in that PDF document). Say, it's a Java class:

{% highlight java %}
class C {
  private B b;
  void m(A a) {
    b.hello();
    a.hello();
    Singleton.INSTANCE.hello();
    new Z().hello();
  }
}
{% endhighlight %}

All four calls to four different `hello()` methods are legal, according
to the LoD. So, what would be illegal, I'm asking myself? No surprise,
the answer is this: `a.x.hello()`. That would be illegal. Directly
accessing the attribute from another object and then talking to it
is not allowed by the law.

But we don't do that anyway. We're talking about `book.pages().last().next()`.
In this chain of method calls we're not accessing any attributes. We're
asking our objects to build new objects for us. What does the law says about
that? Let me read it and quote:

> objects created by m(), or by functions or methods that m() calls are considered as arguments of m()

In other words, the object `Pages` that method call `book.pages()` returns
is a perfectly valid object, which can be used. Then, we can call method
`last()` on it and get an object `Page`, and then call method `text()`, etc. This
is a perfectly valid scenario that doesn't violate the law at all. Just
as I expected.

So, where this common understanding of the law is coming from? Why
[Wikipedia](https://en.wikipedia.org/wiki/Law_of_Demeter)
is calling it a rule of "one dot" and is saying that
"an object should avoid invoking methods of a member object returned by another method".
This is absolutely to the contrary with what the original paper says!
What's going on?

The answer is simple: [getters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}).

The majority of OOP developers think that most object methods that
return anything are getters. And getters indeed are no different than
direct access to object attributes. That's why Wikipedia actually says
"no direct access to attributes and, since most of your methods are getters,
don't touch them either, silly."

That's just sad to see.

So, the bottom line is that the Law of Demeter is not against
method chaining at all. Of course, it's against getters and direct attribute
access. But who isn't, right?

