---
layout: post
title: "SOLID is a shame, for Dummies"
date: 2017-01-10
place: Kharkiv, Ukraine
tags: oop
description: |
  There are very famous SOLID principles in
  object-oriented programming, which are supposed to
  help us design better software; in reality they don't.
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
They have been introduced almost thirty years ago. Since then
did they really made us better programmers?
Do we really understand OOP better thanks to them and write more
"legible and extensible" code? I don't think so.

<!--more-->

{% jb_picture_body %}

Let's go one by one and see how they "help."

## S

It's about [Single responsibility principle](https://en.wikipedia.org/wiki/Single_responsibility_principle),
which, according to [Clean Code](http://amzn.to/2m7LmaA) by
[Robert Martin](https://en.wikipedia.org/wiki/Robert_Cecil_Martin), means that
"a class should have only one reason to change."

This statement sounds extremely vague to me, but the book explains it, saying that
objects must be problem-centered and be responsible for "one thing."
What that one thing is is up to us, of course.

This is what we knew as
["high cohesion"](https://en.wikipedia.org/wiki/Cohesion_%28computer_science%29)
since [Larry Constantine](https://en.wikipedia.org/wiki/Larry_Constantine)
wrote about it in IBM Systems Journal in 1974.
Why a new principle 15 years later, with an ambiguous name and
a very questionable definition?

## O

This letter is about [Open/close principle](https://en.wikipedia.org/wiki/Open/closed_principle),
which was introduced by Bertrand Meyer in
[Object Oriented Software Construction](http://amzn.to/2lNxy44) in 1988.
Simply put it means that an object should not be modifiable. Can't agree more
with this.

But then it says that it should be _extendable_, literally through
[implementation inheritance](https://en.wikipedia.org/wiki/Inheritance_%28object-oriented_programming%29), which is
[known]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %}) as an anti-OOP technology.
Thus, this principle is not really applicable to objects and OOP.
It may work with modules, services, but not with objects.

## L

The third letter is for [Liskov substitution principle](https://en.wikipedia.org/wiki/Liskov_substitution_principle),
which was introduced by
[Barbara Liskov](https://en.wikipedia.org/wiki/Barbara_Liskov) in 1987.
This one is most innocent part in SOLID pentad. In simple words it says
that if your method expects a `Collection`, an `ArrayList` will work.

It is also known as [subtyping](https://en.wikipedia.org/wiki/Subtyping) and is
the foundation component of any object-oriented language. Why do we need to
call it a principle and "follow" it? Is it at all possible to create any
object-oriented software without subtyping? If this one is a principle, let's
add "variables" and "method calling" here too.

Honestly, I suspect that this principle was added to SOLID mostly in order
to somehow fill the gap between "SO" and "ID."

## I and D

I guess they both were introduced by
[Robert Martin](https://en.wikipedia.org/wiki/Robert_Cecil_Martin) while
he was working in Xerox.

[Interface segregation principle](https://en.wikipedia.org/wiki/Interface_segregation_principle)
says that you must not declare `List x` if you only need `Collection x`
or even `Iterable x`. Can't agree more. Let's see the next one.

[Dependency inversion principle](https://en.wikipedia.org/wiki/Dependency_inversion_principle)
means that instead of `ArrayList x` you must
declare `List x` and let the provider of the object decide whether
it is `ArrayList` or `LinkedList`. This one also sounds reasonable to me.

However, how all this is different from the good old
["loose coupling"](https://en.wikipedia.org/wiki/Coupling_%28computer_programming%29)
introduced together with cohesion by Constantine in 1974?
Do we really need to primitivize and blur in order to learn better?
No. Not, to learn better, but to sell better. Here goes my point.

## My point is...

The point being, is that these principles are nothing but an explanation of
"cohesion and coupling" for dummies, in a very primitive, ambiguous,
and marketable way. That dummies will buy books, seminars, and trainings,
but won't really be able to understand the logic behind. Do they really
need to? They are just <del>monkeys</del> coders, right?

"But an object must be responsible for one thing!" is what I hear at
conferences very often. People learn that mantra without even knowing
what cohesion is and understanding what is the "one thing" they are
praying for. There is no such thing as "one thing," guys! There are different
level of cohesion.

Who is guilty? Robert Martin and Co.

They are no better than
[Ridley Scott]({% pst 2015/oct/2015-10-16-ridley-scott-and-joseph-goebbels %})
and other Hollywood money makers, who
deliver primitive and easy-to-cry-at movies, just to generate profit. People
are getting dumber because of watching that&mdash;it is not of their concern.
The same happens with magic OOP principles&mdash;programmers rely on
them, thinking that the truth is right there, while the real truth
is not understood even by the creators of this magic.

Do you really want to be that dumb movie watcher?

P.S. Some other relevant links on this very subject:

  * [I don't love the single responsibility principle](http://sklivvz.com/posts/i-dont-love-the-single-responsibility-principle) by Marco Cecconi
  * [Why I Don't Teach SOLID](http://qualityisspeed.blogspot.nl/2014/08/why-i-dont-teach-solid.html) by Brian Geihsler
  * [Something is wrong with Single Reponsibility Principle](http://gusiev.com/2016/01/single-responsibility-principle-srp-criticism/)
  * [Not-so-SOLID OO Principles](https://www.tonymarston.net/php-mysql/not-so-solid-oo-principles.html)
  *
