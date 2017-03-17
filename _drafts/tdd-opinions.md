---
layout: post
title: "My TDD Dynamics"
date: 2017-01-10
place: Frankfurt, Germany
tags: testing
description: |
  ...
keywords:
  - ...
  - ...
  - ...
  - ...
  - ...
image: https://cf.jare.io/?u=http://www.yegor256.com/images/2017/02/...
jb_picture:
  caption:
---

...

<!--more-->

{% jb_picture_body %}

I've checked a few blog posts and books while working on this piece
and found a few interesting opinions about automated testing. I agree
with some of them and strongly disagree with others. Having in mind
everything discussed above let's go through them all.

...

GOOD:
http://programmer.97things.oreilly.com/wiki/index.php/The_Three_Laws_of_Test-Driven_Development
three laws of tdd

Robert Martin
[declares](http://blog.cleancoder.com/uncle-bob/2014/12/17/TheCyclesOfTDD.html)
a rule: "If the changes you make to the production code, pursuant to a test,
make that test pass, but would not make other unwritten tests pass,
then you are likely making the production code too specific."

I disagree with the "would not" part here. We must not care about any
"other unwritten tests." They may never exist, if noboby will require them.


BAD:
Red Green Refactor is a wrong idea
http://www.jamesshore.com/Blog/Red-Green-Refactor.html


BAD:
You don't have to write tests for Test Doubles because
the actual unit tests and the production code are the tests for those pieces of code.
https://8thlight.com/blog/uncle-bob/2014/04/30/When-tdd-does-not-work.html

GOOD
As an industry, we suck
https://8thlight.com/blog/uncle-bob/2014/04/25/MonogamousTDD.html

BAD:
Code-to-test ratios above 1:2 is a smell, above 1:3 is a stink.
https://signalvnoise.com/posts/3159-testing-like-the-tsa

BAD:
You’re probably doing it wrong if testing is taking more than 1/3 of your time. You’re definitely doing it wrong if it’s taking up more than half.
https://signalvnoise.com/posts/3159-testing-like-the-tsa

BAD:
I get paid for code that works, not for tests
http://stackoverflow.com/questions/153234/how-deep-are-your-unit-tests/153565#153565

