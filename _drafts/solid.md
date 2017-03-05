---
layout: post
title: "SOLID is OOP for Dummies"
date: 2017-01-10
place: Kharkiv, Ukraine
tags: oop
description: |
  ...
keywords:
  - SOLID principles
  - S.O.L.I.D.
  - SOLID in OOP
  - SRP
  - principles of OOP
image: https://cf.jare.io/?u=http://www.yegor256.com/images/2017/02/...
jb_picture:
  caption:
---

You definitely know that [SOLID](https://en.wikipedia.org/wiki/SOLID_%28object-oriented_design%29)
acronym. It stands for five principles
of object-oriented programming, which, if followed, are supposed to
make your code both [legible and extensible](https://en.wikipedia.org/wiki/SOLID_%28object-oriented_design%29).
I've been taught so, by many OOP books. But let me ask you, honestly,
do these five principles really make sense to you? And, what is more important,
do you apply them to your code? Or, maybe you don't, but you know how to do it?
Unfortunately, I don't think I do.

<!--more-->

{% jb_picture_body %}

Let's go one by one.

**S** stands for [single responsibility principle](https://en.wikipedia.org/wiki/Single_responsibility_principle),
which, according to [Clean Code](http://amzn.to/2m7LmaA) by
[Robert Martin](https://en.wikipedia.org/wiki/Robert_Cecil_Martin), means that
"a class should have only one reason to change." The book explains

literally means that "every module or class should have responsibility over a single part
of the functionality provided by the software, and that responsibility should
be entirely encapsulated by the class." Sounds interesting, but what is
that "functionality"?

**O** stands for [open/close principle](https://en.wikipedia.org/wiki/Open/closed_principle),
which was introduced by Bertrand Meyer in
[Object Oriented Software Construction](http://amzn.to/2lNxy44) in 1988.
Simply put it means that an object should not be modifiable. Can't agree more
with this. But then it says that it should be extendable, literally through
[implementation inheritance]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %}),
which is known as an anti-object technology. Thus, this principle is
not really applicable to objects and OOP. It may work with modules, services,
but not with objects.

**L** stands for [Liskov substitution principle](https://en.wikipedia.org/wiki/Liskov_substitution_principle),
which was introduced by
[Barbara Liskov](https://en.wikipedia.org/wiki/Barbara_Liskov) in 1987.
This one is most innocent part in SOLID pentad. In simple words it says
that if your method expects a `Collection`, an `ArrayList` will work. It
is also known as [subtyping](https://en.wikipedia.org/wiki/Subtyping) and is
the foundation component of any object-oriented language. Why do we need to
call it a principle and "follow" it? Is it at all possible to create any
object-oriented software without subtyping? If this is a principle, let's
add "variables" and "method calling" here too. I suspect that this
principle was added to SOLID mostly in order to somehow fill the gap between
"SO" and "ID."

**I** stands for [Interface segregation principle](https://en.wikipedia.org/wiki/Interface_segregation_principle)

**D** stands for [Dependency inversion principle](https://en.wikipedia.org/wiki/Dependency_inversion_principle)
and, simply put, means that instead of `ArrayList x` you must
declare `List x` and let the provider of the object decide whether
it is `ArrayList` or `LinkedList`. Sounds reasonable to me, however,
my question is how is this different from the good old "loose coupling"?
Why it's called an inversion? Because we're inverting the brains of
programmers who were not smart enough to understand what coupling meant?
That's the only explanation I have.


