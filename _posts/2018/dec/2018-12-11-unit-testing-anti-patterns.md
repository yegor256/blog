---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Unit Testing Anti-Patterns, Full List"
date: 2018-12-11
place: Moscow, Russia
tags: testing
description: |
  This is a full list of unit-testing anti-patterns that I
  managed to find and collect; feel free to add your
  items to the list, via a pull request.
keywords:
  - anti-pattern
  - testing anti-pattern
  - unit testing anti-pattern
  - testing anti-pattern java
  - unit testing anti-pattern java
image: /images/2018/12/breaking-bad.jpg
jb_picture:
  caption: Breaking Bad (2010) by Vince Gilligan
---

I wrote some time ago about [anti-patterns in OOP]({% pst 2014/sep/2014-09-10-anti-patterns-in-oop %}).
Now it's time to write about unit testing anti-patterns---because they also exist, and there are many.
I will try to include every example I know in this list. If you know any
others, please add them via a [pull request](https://github.com/yegor256/blog) or
post a comment below. For each anti-pattern I will try to mention where it
was found, if it's not mine. Keep in mind that if I found it somewhere, that doesn't necessarily mean it
was invented there. If you spot an error, please comment.

<!--more-->

{% jb_picture_body %}

{:name='cuckoo'}
**Cuckoo**<sup>1</sup> (aka Stranger<sup>3</sup>).
This is a test method that sits in the same unit test but doesn't really belong there.

{:name='tpm'}
**Test-per-Method**<sup>1</sup>.
Although a one-to-one relationship between test and production classes is
a reasonable starting point, a one-to-one relationship between test
and production method is almost always a bad idea.

{:name='anal'}
**Anal Probe**<sup>2</sup>.
A test that has to use unhealthy ways to perform its task, such as
reading private fields using reflection.

{:name='twins'}
**Conjoined Twins**<sup>2</sup>.
Tests that are called unit tests but are really integration tests
since there is no isolation between the system-under-test and the
tests.

{:name='happy'}
**Happy Path**.
The tests stay on happy paths (i.e. expected results, e.g. 18 years old)
without testing for boundaries and exceptions (e.g. -2 years old).

{:name='poke'}
**Slow Poke**<sup>3</sup>.
A unit test that runs incredibly slow. When developers kick it off, they
have time to go to the bathroom, grab a smoke, or worse, kick the test off before
they go home at the end of the day.

{:name='giant'}
**Giant**<sup>3</sup>.
A unit test that, although it is validly testing the object under test,
can span thousands of lines and contain many many test cases. This
can be an indicator that the system-under-test is a God Object.

{:name='mockery'}
**Mockery**<sup>3</sup>.
Sometimes mocking can be good, and handy. But sometimes developers can
lose themselves in their effort to mock out what isn't being tested.
In this case, a unit test contains so many mocks, stubs, and/or fakes that
the system under test isn't even being tested at all, instead
data returned from mocks is what is being tested.

{:name='inspector'}
**Inspector**<sup>3</sup>.
A unit test that violates encapsulation in an effort to achieve 100%
code coverage, but knows so much about what is going on in the object
that any attempt to refactor will break the existing test and require
any change to be reflected in the unit test.

{:name='leftovers'}
**Generous Leftovers**<sup>3</sup> (aka [Chain Gang](https://stackoverflow.com/a/333814/187141),
[Wet Floor](https://stackoverflow.com/a/2150985/187141)).
An instance where one unit test creates data that is persisted somewhere,
and another test reuses the data for its own devious purposes. If the
"generator" is ran afterward, or not at all, the test using that
data will outright fail.

{:name='hero'}
**Local Hero**<sup>3</sup> (aka Hidden Dependency, Operating System Evangelist,
[Wait and See](https://stackoverflow.com/a/339339/187141), [Environmental Vandal](https://stackoverflow.com/a/339297/187141)).
A test case that is dependent on something specific to the development environment
it was written on, in order to run. The result is that the test passes
on development boxes, but fails when someone attempts to run it elsewhere.

{:name='nitpicker'}
**Nitpicker**<sup>3</sup>.
A unit test which compares a complete output when it's really only interested
in small parts of it, so the test has to continually be kept
in line with otherwise unimportant details.

{:name='secret'}
**Secret Catcher**<sup>3</sup>.
A test that at first glance appears to be doing no testing due
to the absence of assertions, but as they say, "the devil is in the details."
The test is really relying on an exception to be thrown when a mishap
occurs, and is expecting the testing framework to capture the exception
and report it to the user as a failure.

{:name='dodger'}
**Dodger**<sup>3</sup>.
A unit test which has lots of tests for minor (and presumably easy to test)
side effects, but never tests the core desired behavior. Sometimes you
may find this in database access related tests, where a method is
called, then the test selects from the database and runs assertions against the result.

{:name='loudmouth'}
**Loudmouth**<sup>3</sup>.
A unit test (or test suite) that clutters up the console with diagnostic
messages, logging, and other miscellaneous chatter, even when
tests are passing.

{:name='catcher'}
**Greedy Catcher**<sup>3</sup>.
A unit test which catches exceptions and swallows the stack trace, sometimes
replacing it with a less informative failure message, but sometimes even just
logging (cf. Loudmouth) and letting the test pass.

{:name='sequencer'}
**Sequencer**<sup>3</sup>.
A unit test that depends on items in an unordered list appearing
in the same order during assertions.

{:name='enumerator'}
**Enumerator**<sup>3</sup> (aka [Test With No Name](https://stackoverflow.com/a/336766/187141)).
Unit tests where each test case method name is only an enumeration,
e.g. `test1`, `test2`, `test3`. As a result, the intention of the
test case is unclear, and the only way to be sure is to read
the test case code and pray for clarity.

{:name='ride'}
**Free Ride**<sup>3</sup> (aka [Piggyback](https://stackoverflow.com/a/333883/187141)).
Rather than write a new test case method to test another feature
or functionality, a new assertion rides along in an existing test case.

{:name='setup'}
**Excessive Setup**<sup>3</sup> (aka [Mother Hen](https://stackoverflow.com/a/333909/187141)).
A test that requires a lot of work to set up in order to even begin testing.
Sometimes several hundred lines of code are used to setup the environment for one test,
with several objects involved, which can make it difficult to really ascertain
what is being tested due to the "noise" of all of the setup.

{:name='hitter'}
**Line hitter**.
At first glance, the tests cover everything and code coverage tools
confirm it with 100%, but in reality the tests merely hit the code,
without doing any output analysis.

{:name='pole'}
**Forty-Foot Pole Test** ([see](https://stackoverflow.com/a/339247/187141)).
Afraid of getting too close to the class they are trying to test, these tests
act at a distance, separated by countless layers of abstraction
and thousands of lines of code from the logic they are checking.

{:name='liar'}
**The Liar**<sup>4</sup> (aka [Evergreen Tests](https://youtu.be/1Z_h55jMe-M?t=1059), Success Against All Odds<sup>3</sup>).
A test doesn't validate any behaviour and passes in every scenario. Any new bug introduced
in the code will never be discovered by this test. It was probably created after the
implementation was finished, so the author of this test couldn't know whether the test
actually tests something.

Useful links:

  1. [_Spock: Up and Running_](https://amzn.to/2BaAKRB) by Rob Fletcher
  2. [_Mastering Software Testing with JUnit 5_](https://amzn.to/2DpkFc6) by Boni Garcia
  3. [_TDD Anti-Patterns_](http://archive.is/3acB#selection-119.0-119.17) by James Carr
  4. [_Anti-Patterns_](https://www.digitaltapestry.net/testify/manual/AntiPatterns.html) by William E. Kempf
