---
layout: post
title: "Unit Testing Anti-Patterns, Full List"
date: 2018-01-29
place: Moscow, Russia
tags: testing
description: |
  This is a full list of unit-testing anti-patterns I
  managed to find and collect; feel free to add your
  items to the list, via a pull request.
keywords:
  - anti-pattern
  - testing anti-pattern
  - unit testing anti-pattern
  - testing anti-pattern java
  - unit testing anti-pattern java
image: /images/2018/11/
jb_picture:
  caption:
---

I wrote some time ago about [anti-patterns in OOP]({% pst 2014/sep/2014-09-10-anti-patterns-in-oop %}).
Now it's time to write about unit testing anti-patterns. They also exist and many.
I will try to include everything I know into this list. If you know something
else, please add via a [pull request](https://github.com/yegor256/blog) or
post a comment below. For each anti-pattern I will try to mention where it
was found, if it's not mine. Keep in mind that if I found it somewhere doesn't necessarily mean that it
was invented there. If you spot an error, please comment.

<!--more-->

{% jb_picture_body %}

**Cuckoo**<sup>1</sup>.
It's a test method that sits in the same unit test but doesn't really belong there.

**Test-per-Method**<sup>1</sup>.
Although a one-to-one relationship between test and production classes is
a reasonable starting point, a one-to-one relationship between test
and production method is almost always a bad idea.

**Anal Probe**<sup>2</sup>.
A test that has to use unhealthy ways to perform its task, such as
reading private fields using reflection.

**Conjoined Twins**<sup>2</sup>.
Tests that are called unit tests but are really integration tests
since there is no isolation between the system under testing and
tests.

**Happy Path**.
The test stays on happy paths (i.e. expected results) without testing
for boundaries and exceptions.

**Slow Poke**<sup>3</sup>.
A unit test that runs incredibly slow. When developers kick it off, they
have time to go to the bathroom, grab a smoke, or worse, kick the test off before
they go home at the end of the day.

**Giant**<sup>3</sup>.
A unit test that, although it is validly testing the object under test,
can span thousands of lines and contain many many test cases. This
can be an indicator that the system under tests is a God Object.

**Mockery**<sup>3</sup>.
Sometimes mocking can be good, and handy. But sometimes developers can
lose themselves and in their effort to mock out what isn't being tested.
In this case, a unit test contains so many mocks, stubs, and/or fakes that
the system under test isn't even being tested at all, instead
data returned from mocks is what is being tested.

**Inspector**<sup>3</sup>.
A unit test that violates encapsulation in an effort to achieve 100%
code coverage, but knows so much about what is going on in the object
that any attempt to refactor will break the existing test and require
any change to be reflected in the unit test.

**Generous Leftovers**<sup>3</sup>.
An instance where one unit test creates data that is persisted somewhere,
and another test reuses the data for its own devious purposes. If the
"generator" is ran afterward, or not at all, the test using that
data will outright fail.



Useful links:

  1. [_Spock: Up and Running_](https://amzn.to/2BaAKRB) by Rob Fletcher
  2. [_Mastering Software Testing with JUnit 5_](https://amzn.to/2DpkFc6) by Boni Garcia
  3. [TDD Anti-Patterns](http://archive.is/3acB#selection-119.0-119.17) by James Carr
