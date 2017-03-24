---
layout: post
title: "TDD Misbeliefs"
date: 2017-01-10
place: Minsk, Belarus
tags: testing
description: |
  Test-driven development is a very obvious and at the same
  very unclear territory in modern software development;
  what is the truth?
keywords:
  - tdd
  - testing
  - test driven development
  - unit testing
  - automated testing
image: https://cf.jare.io/?u=http://www.yegor256.com/images/2017/02/...
jb_picture:
  caption:
---

While I was working with the
[previous article about TDD]({% pst ... %})
I've read many blog posts and a few books on this very subject and found
out that I either strongly agree with them or strongly disagree. There
is nothing in the middle. Let me share the most interesting.

<!--more-->

{% jb_picture_body %}

<!-- ************************************************************** -->
Robert Martin
([@unclebobmartin](https://twitter.com/unclebobmartin))
in [The Cycles Of TDD](http://blog.cleancoder.com/uncle-bob/2014/12/17/TheCyclesOfTDD.html):

> If the changes you make to the production code, pursuant to a test,
  make that test pass, but would not make other unwritten tests pass,
  then you are likely making the production code too specific.

<span class="red">I disagree</span>.
This statement goes against the very philosophy of testing: "a passing test
is a _bad_ test." Unfortunately, a traditional understanding of testing
is quite the opposite: tests must pass to make us happy. Thus, if we
keep thinking about how to make our future tests pass we will shoot
ourselves in the foot: tests will pass and the code quality will go down.
Instead, we must design our code the way that it's easy to break with
the future tests. The code must help its tests to break it! Because
a test that is easy to make "red" is a good test. A test that is always
"green" is a useless test. Uncle Bob, I'm sure you are aware of that.


<!-- ************************************************************** -->
James Shore
([@jamesshore](https://twitter.com/jamesshore))
in [Red-Green-Refactor](http://www.jamesshore.com/Blog/Red-Green-Refactor.html)
(Nov 2005):

> You'll run through several cycles very quickly, then find yourself
  slowing down and spending more time on refactoring.

<span class="red">I disagree</span>.
I have nothing against the first two steps: 1) the test is "red" because
it doesn't pass, and 2) the test is "green" when the code is fixed and
passes. I disagree that refactoring is a responsibility of the person
who fixes the test. If the code needs refactoring, it's a _bug_, just
like any other bug, either functional or design. It has to be reported,
assigned and paid for. We must not do any code modifications, no matter
how good our intentions are, if they are not required and paid. Refactoring
after fixing the test is a frivoulus violation of management and coordination
structure in a project.


<!-- ************************************************************** -->
Robert Martin
([@unclebobmartin](https://twitter.com/unclebobmartin))
in [When TDD doesn't work](https://8thlight.com/blog/uncle-bob/2014/04/30/When-tdd-does-not-work.html)
(April 2014):

> You don't have to write tests for Test Doubles because
  the actual unit tests and the production code are
  the tests for those pieces of code.

<span class="red">I disagree</span>.
Test Doubles (also known as
[fake objects]({% pst 2014/sep/2014-09-23-built-in-fake-objects %}))
are the tools that help us find our where the code is broken. If the tool
is unreliable, how can we test our code against it. This reminds me an old
joke when a patient comes to the doctor and says "Help me doc, my body hurts anywhere
I touch it with my finger!", and the doctor answers
"It's just your finger, it is broken!" A very similar situation here:
If we test our production objects with broken Test Doubles, they all will look
broken.

<!-- ************************************************************** -->
David Heinemeier Hansson
([@dhh](https://twitter.com/dhh))
in [Testing like the TSA](https://signalvnoise.com/posts/3159-testing-like-the-tsa)
(April 2012):

> Code-to-test ratios above 1:2 is a smell, above 1:3 is a stink.

<span class="red">I disagree</span>.
I don't know exactly what units of measurement were used to compare that
"code" and "test", but I can only assume Lines-of-Code. I was curious and
decided to calculate this ration in a few projects of mine. First, I tried
at [jcabi-github](https://github.com/jcabi/jcabi-github),
an immutable GitHub Java API client. The numbers were:
9.8K LoC in production classes,
6.2K in built-in fake classes, and
16.2K in test classes.
Thus, the ratio was 9.8 to 22.4, which meant 1:2.3. Somewhere between
a "smell" and a "stink", according to David. Then, I calculated the ratio
for a few other projects of mine:
[jcabi-http](https://github.com/jcabi/jcabi-http) (1:1),
[xembly](https://github.com/yegor256/xembly) (1:0.92),
[takes](https://github.com/yegor256/takes) (1:0.91), and
[rultor](https://github.com/yegor256/rultor) (1:0.6). It looks that the higher
the ratio the higher my _confidence_ in the product's quality. Thus, I don't think that
it's a smell or a stink. Instead, in a yummy scented product the amount
of test code is a few times bigger than its production counterpart.


<!-- ************************************************************** -->
Kent Beck
([@kentbeck](https://twitter.com/kentbeck))
in
[How deep are your unit tests?](http://stackoverflow.com/questions/153234/how-deep-are-your-unit-tests/153565#153565)
(Sep 2008):

> I get paid for code that works, not for tests.

<span class="red">I disagree</span>.
Tests are not a separate a product, which we either are paid for or not.
Tests are part of the code. An instrument of its development, maintenance
and validation. Tests are similar to, say, file names. We don't write
our code naming all files like `1.java`, `2.java`, `234.java`, and then
saying: "Now you pay me so that I rename them properly." That would be weird,
right? That's how that statement "I'm not paid for writing tests" sounds
to me: weird. Do we really have to be paid to name files correctly? We just
do it, because it's convenient for us. Because proper self-descriptive
file names make our code more readable and maintanable. It's impossible to
imagine a modern maintainable code base without tests. I would actually
suggest to change that phrase to: "I get paid for code that is tested, not
for just code."



