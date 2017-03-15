---
layout: post
title: "The TDD That Works For Me"
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

tdd is this, by the book
it can't work this way, because it's weird

I do it this way:
- code
- deploy
- bug
- test
- fix

dynamics are like this: look at jare

what other guys are wrong about:


...

GOOD:
http://programmer.97things.oreilly.com/wiki/index.php/The_Three_Laws_of_Test-Driven_Development
three laws of tdd

BAD:
TDD rule: As the tests get more specific, the code gets more generic.
"If the changes you make to the production code, pursuant to a test,
make that test pass, but would not make other unwritten tests pass,
then you are likely making the production code too specific"
http://blog.cleancoder.com/uncle-bob/2014/12/17/TheCyclesOfTDD.html

BAD:
Red Green Refactor is a wrong idea
http://www.jamesshore.com/Blog/Red-Green-Refactor.html

GOOD
It would not surprise me if, one day, TDD had the force of law behind it
https://8thlight.com/blog/uncle-bob/2014/05/02/ProfessionalismAndTDD.html


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

