---
layout: post
title: "Fools Don't Write Unit Tests"
date: 2015-07-18
tags: tdd
place: Palo Alto, CA
description:
  A unit test is a tool, not a product; the absence
  of unit testing can't be excused due to
  lack of time or budget.
keywords:
  - unit testing
  - unit testing best practices
  - unit testing tools
  - unit testing definition
  - unit testing cost benefit analysis
---

"We don't have time to write unit tests" or "We don't have
budget for unit testing" is what I hear very often. Sometimes it
may sound like "we don't use TDD that's why no unit tests" or even
"TDD is too expensive for us now". I'm sure you've heard this or even
said that yourself. It doesn't make any sense to me. I don't get the
logic. In my understanding, a unit testing is not
a product, it's a **tool**. You use tests to develop a product,
faster and better. How can you say that you don't have time to use
the tool that makes your work faster? Let me show how.

<!--more-->

TDD or not, a unit test is a unit test. Either you create it before
the main piece of code of after it.

A unit test is a tool that helps you, a developer of software, to
"run" your stuff and see how it works. How else can you check that it works?
When I hear "I don't have time for unit tests", my next question is
&mdash; "how did you test your code?"

I seriously can't understand how is it possible to write something
and then not test it. Well, unless you're paid monthly and nobody
really cares about your deliverables. If you do care about the software
you produce, you are interested in seeing it in action, right?

So, how do you do this?

If it's a one page PHP web site you can probably run it in a local Apache,
modify it on disc and then `Cmd`+`R`, many times. That'll work, for a primitive
piece of code and only for you, a single developer of it. But I hear
this "I don't have time" argument from programmers working on enterprise
systems. How do you guys test your code?

I would compare unit tests with OOP classes. You can design the entire application
in a single class with a few thousand methods. You will save time on creating
other classes, structuring them, thinking about connections between them, etc.
It will a single 20,000-lines `.java` file. And, you'll say that "you didn't
have time to create classes", right? What would we say about such a product and an
author of it? Right, we'll say that he or she is just stupid. And it has nothing
to do with time or budget. Such a programmer just doesn't know how to use
object-oriented programming tools, like encapsulation, inheritance, polymorphism,
interfaces, method overloading, etc. It's not about time or budget, it's about
skills and discipline.

The same is true about unit tests. I you create a code without unit tests,
it may work, just like that monster class with 20,000-lines, but the quality
of your product will be very low. And not because you didn't have time to
write unit tests, but because you didn't know how to do it.

So, every time I hear that "I didn't have time for unit testing" I understand
that you just didn't know how and is trying to conceal this fact behind
these false excuses. It's not professional, to say the least.

