---
layout: post
title: "When Do You Stop Testing?"
date: 2015-09-10
place: Moscow, Russia
categories: jcg
tags: testing
description: |
  How do you know when testing is enough? When there
  are no bugs? That is a very wrong approach! Instead, stop
  when certain amount of bugs is found.
keywords:
  - testing exit criteria
  - defining exit criteria for testing
  - entry and exit criteria
  - software testing
  - test planning
image: /images/2015/09/la-fille-sur-le-pont.jpg
jb_picture:
  caption: La fille sur le pont (1999) by Patrice Leconte
republished:
  -
    place: "BLOG@CACM"
    title: "The Goal of Software Testing"
    date: 2018-05-30
    url: https://cacm.acm.org/blogs/blog-cacm/228226-the-goal-of-software-testing/fulltext
---

There is a software to be tested. There is a team of testers. There is
some money in the budget. There is some time in the schedule. We start
right now. Testers are trying to break the product, finding bugs,
reporting bugs, communicating with programmers when necessary, doing
their best to find what's wrong. Eventually they stop and say
"we're done." How do they know when to stop? When there is enough
testing? It's obvious---when there are _no more bugs left_ and the
product can be shipped! If you think like this, I have bad news for you.
You're _fundamentally wrong_.

<!--more-->

{% jb_picture_body %}

All this is perfectly explained by Glenford Myers in his [great book](https://amzn.to/1Y3qAbN)
[The Art of Software Testing]({% pst 2014/aug/2014-08-22-art-of-software-testing %}).
I will just summarize it here again.

{% badge /images/2015/04/book-art-of-testing.jpg 96 https://amzn.to/1Y3qAbN %}

First, "testing is the process of executing a program with the
intent of _finding errors_" (page 6). Pay attention, the intent is to find errors.
Not to prove that the product works fine, but to prove that it _doesn't work_
as intended. The goal of any tester is to show how the product can be
broken, how it fails on different inputs, how it crashes under stress,
how it misunderstands the user, how it doesn't satisfy the requirements.
This is why Dr. Myers is calling testing "a destructive, even sadistic, process"
(page 6). This is what most testers don't understand.

{% youtube wd-SA1HVmLg %}

Second, any software
[has]({% pst 2017/may/2017-05-23-unlimited-number-of-bugs %})
an _unlimited amount of bugs_. Dr. Myers says that
"you cannot test a program to guarantee that it is error free" (page 10)
and that "it is impractical, often impossible, to find all the errors in
a program" (page 8). This is also what most testers don't understand. They
believe that there is a
[limited number]({% pst 2015/jun/2015-06-18-good-programmers-bug-free %})
of bugs, which they have to find
and call it a day. There literally
[no limit]({% pst 2017/may/2017-05-23-unlimited-number-of-bugs %})!
The amount of bugs is unlimited,
in any software product. No matter how small or big, complex or simple,
new or old is the product.

{% quote They can't find all bugs, no matter how much time we give them %}

Having these axioms in mind, let's try to decide when testers have to stop.
According to Dr. Myers, "one of the most difficult questions
to answer when testing a program is determining when to stop,
since there is no way of knowing if the error just detected is the
last remaining error" (page 135).

They can't find all bugs, no matter how much time we give them. And they
are motivated to find more and more of them. But at some point of time we
must make a decision and release the product. Looks like we will release
it with bugs inside? Yes, indeed! We will release a product _full of bugs_.
The only question is how many of them were found already and how critical
they were.

Let's put it all together. There are too many bugs to be able to find
all of them in a reasonable amount of time. However, we have to release a new
version, sooner or later. At the same time, testers will always tell us
that there are more bugs there and they can find more, just need more
time. What to do?

Dr. Myers says that "since the goal of testing is to find errors,
why not make the completion criterion the detection of some predefined
number of errors?" (page 136). Indeed, we should predict how many bugs
are just enough to find, in order to have a desirable level of _confidence_
that the product is ready to be shipped. Then, ship it, consciously
understanding that it still has an unlimited amount of not yet discovered
bugs.

{% badge https://yegor256.github.io/bibliography/book-covers/west2004object.jpg 96 https://jttu.net/west2004object %}

David West in
[Object Thinking](https://amzn.to/266oJr4)
says that "software is released for use,
not when it is known to be correct, but when the rate of discovering
errors slows down to one that management considers acceptable" (page 13).

Thus, the only valid criteria for exiting a testing process is the
discovery of a _forecast_ amount of bugs.
