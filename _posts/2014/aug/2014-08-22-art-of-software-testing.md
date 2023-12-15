---
layout: post
title: "The Art of Software Testing by Glenford Myers"
date: 2014-08-22
tags: book-review testing
description: |
  The Art of Software Testing by Glenford Myers is a classic
  work in software engineering; I will review the
  best parts of the book
keywords:
  - book review
  - software testing
  - books about software testing
  - art of software testing
  - quotes about software testing
---

{% badge /images/2014/08/art-of-software-testing.png 96 https://amzn.to/1Y3qAbN %}

"[The Art of Software Testing"](https://amzn.to/1Y3qAbN)"
by Glenford J. Myers, Tom Badgett and Corey Sandler is one of
my favorite books concerning testing and software engineering in
general. In this article, I will provide an overview of the book, as well as
highlight the ideas and quotes that I found to be the most interesting.

<!--more-->

There were three editions of the book. The first one was published
in 1979, when I was just too young to appreciate it. The second one was published in 2004---I read it first in 2007. The third one was published just two years ago, in 2012. I bought
this edition also, and read it like it was my first time. This book is still one of the top
books in the software testing domain, despite its age and some content that is rather out-dated.

## Out-dated Content

First, let's filter out what is not worth reading (in my opinion).

There are eleven chapters, but you can easily skim through nine of them. This is
because those chapter discuss concepts that are discussed elsewhere in the book
with a more robust level of detail or on a much higher level of abstraction.

For example, Chapter 3 contains an eleven-page checklist to be used
by a code reviewer in order to find programming mistakes.
This list is definitely not comprehensive and it can't compete with, say,
"[Code Complete](https://amzn.to/2bNjO8C)" by Steve McConnell.
I believe, this checklist had significant value twenty years ago, but now it is out of date.

Chapter 5 discusses basic principles and strategies of unit testing.
However, the discussion is not abstract enough for a short 25-page summary,
and is not specific enough for a detailed discussion. Again, twenty
years ago this information may have had some value. Nowadays,
"[Growing Object-Oriented Software, Guided by Tests](https://amzn.to/1PBpoDT)"
by Steven Freeman and Nat Pryce
is a much better source for this subject.

There are also articles about usability testing,
[debugging]({% pst 2016/feb/2016-02-09-are-you-still-debugging %}),
web application testing, and mobile testing. Here we have the same
issue---they are not abstract enough and they are much too
outdated to be relevant to the current issues in software testing.
I would recommend readers to briefly skim those subjects for background
information, but to not read too much into it.

## Psychology of Testing

The most important and valuable part of the book is Chapter 2. It is
full of priceless quotes that can also be very practical. For example, on page 6:

> Testing is a destructive, even sadistic, process, which explains why most people find it difficult

{% badge /images/2014/08/glenford-myers.png 200 https://amzn.to/1Y3qAbN %}

In Chapter 2, Dr. Myers discusses the psychology of testing and a very common and crucial
misunderstanding of testing objectives. He claims that it is commonly accepted that
the goal of software testing is "to show that a program performs its intended functions correctly" (p.5).
Testers are hired to check whether the software functions
as expected. They then report back to management whether all tests have successfully passed
and whether the program can be delivered to end users.

> Despite the plethora of software testing tomes available on the market today,
many developers seem to have an attitude that is counter to extensive testing

This is what Dr. Myers says on the second page, and I can humbly confirm
that in all software groups I've been worked in thus far,
almost everyone, including testers,
[project managers]({% pst 2016/feb/2016-02-18-holacracy-autocracy %}),
and programmers, share this philosophy.
They all believe that "testing is the process of demonstrating
that errors are not present" (p.5)

However, "these definitions are upside down" (p.6). The psychology of testing
should be viewed as the opposite. There are two quotes that support this theory and
I feel that they make the entire book.

The first one, on page 6, defines the goal of software testing:

> Testing is the process of executing a program with the intent of finding errors

The second one, on the following page, further refines the first
goal:

> An unsuccessful test case is one that causes a program to produce the
correct results without finding any errors

Dr. Myers comes back to these two thoughts in every chapter. He reiterates
over and over again that we should change the underlying psychology of how we
view testing, in order to change our testing results. We should focus on breaking the
software instead of confirming that it works. Because testing is a "sadistic process" (p.6)
of breaking things. It is a "destructive process" (p.8).

If you read Chapter2 very carefully and truly understand its
underlying ideas, it may change your entire life. This chapter should be a New Testament of
every tester.

## Test Completion Criteria

In Chapter 2, Dr. Myers also mentions that a program, no matter how simple,
contains an [unlimited]({% pst 2017/may/2017-05-23-unlimited-number-of-bugs %})
number of errors. He says that "you cannot test
a program to guarantee that it is error free" (p.10) and that "it is
impractical, often impossible, to find all the errors in a program" (p.8).

Furthermore, at the end of Chapter 6, he makes an important observation (p.135):

> One of the most difficult questions to answer when testing a program
is determining when to stop, since there is no way of knowing if the
error just detected is the last remaining error

The problem is [obvious]({% pst 2015/sep/2015-09-10-testing-exit-criteria %}).
Since any program contains an unlimited
number of errors, it doesn't matter how long we test, we won't find
all of them. So when do we stop? What goals do we set for our testers?
And even more importantly, when do we pay them and how much
(this question is important to me since I only work with contractors
and am required to define measurable and achievable goals)?

The answer Dr. Myers gives is brilliant (p.136):

> Since the goal of testing is to find errors, why not make the completion
criterion the detection of some predefined number of errors?

He then goes on to discuss exactly how this "predefined
number" can be estimated. I find this idea very interesting. I have even
applied it to a few projects I've had in the last few years. It works.
However it can also cause serious psychological problems for the team. Most people
simply resent the goal of "testing until you find a required number of bugs."
The most common response is "what if there are no bugs any more?."

However, after a few fights, the team eventually begins to appreciate the concept
and get used to it. So, I can humbly confirm that Dr. Myers is right in his suggestion.
You can successful plan testing based on a predefined number of errors.

## Summary

I consider this book a fundamental writing in the area
of software testing. This is mostly due to Chapter 2 of the book. In fact, there are
just three pages of text that build the foundation of the entire book. They
are the skeleton of the other two hundred pages.

Unfortunately, since 1979, this skeleton hasn't become the backbone of
the software testing industry. Most of us are still working against
these principles.
