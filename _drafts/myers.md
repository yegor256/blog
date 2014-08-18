---
layout: post
title: "The Art of Software Testing, Glenford J. Myers, et al"
date: 2014-04-29
tags: book testing
description:
  The Art of Software Testing by Glenford Myers is a classic
  work in software engineering; I'm trying to review its
  best parts
keywords:
  - book review
  - software testing
  - books about software testing
  - art of software testing
  - quotes about software testing
---

{% badge http://img.yegor256.com/2014/08/art-of-software-testing.jpg 96 http://www.amazon.com/gp/product/1118031962/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=1118031962&linkCode=as2&tag=yegor256com-20&linkId=RFPKLHVYE6E27XYO %}

["The Art of Software Testing"](http://www.amazon.com/gp/product/1118031962/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=1118031962&linkCode=as2&tag=yegor256com-20&linkId=RFPKLHVYE6E27XYO)
by Glenford J. Myers, Tom Badgett and Corey Sandler is one of
my favorite books about testing and software engineering in
general. In this article I'm trying to give an overview of
its most interesting ideas and highlight its most important quotes.

There were three editions of the book. The first one was published
in 1979, when I was just too young to appreciate it. The second one in 2004 &mdash;
I read it first in 2007. The third one just two years ago, in 2012. I bought
it too, and read again. It is still the writing number one in software testing domain,
despite its age and some content that is rather out-dated.

## Out-dated Content

First, let's filter out what is not worth reading.

There are eleven chapters, but you can easily skip nine of them. Mostly
because the subjects they discuss were already discussed somewhere
else with a much better level of details or on a much higher level of
abstraction.

For example, Chapter 3 contains an eleven-pages checklist to be used
by a code reviewer in order to find mistakes in a program under review.
The list is definitely not complete and can't compete with, say,
["Code Complete"](http://www.amazon.com/gp/product/0735619670/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0735619670&linkCode=as2&tag=yegor256com-20&linkId=2H4TSJALESCE7Z7I) by Steve McConnell.
I believe, this checklist
had its value twenty years ago, but now it is definitely out of date.

Chapter 5 discusses basic principles and strategies of unit testing.
The discussion is not abstract enough for a short 25-pages summary,
and is not specific enough for a detailed discussion. Again, twenty
years ago this information may had some value. Nowadays,
["Growing Object-Oriented Softare, Guided by Tests"](http://www.amazon.com/gp/product/0321503627/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0321503627&linkCode=as2&tag=yegor256com-20&linkId=OW3LHYHVBT2G7ZWF) by Steven Freeman and Nat Pryce
is a much better reading on this subject.

There are also articles about usability testing, debugging,
web application testing, and mobile testing. Here we have the same
issue &mdash; they are not abstract enough and they are too much
out dated to be specific enough. I would recommend to scroll through
them.

## Psychology of Testing

The most important and valuable part of the book is Chapter 2. It is
full of priceless quotes, for example, in page 6:

> Testing is a destructive, even sadistic, process, which explains why most people find it difficult

{% badge http://img.yegor256.com/2014/08/glenford-myers.jpg 200 http://www.amazon.com/gp/product/1118031962/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=1118031962&linkCode=as2&tag=yegor256com-20&linkId=RFPKLHVYE6E27XYO %}

In the Chapter, Dr. Myers discusses the psychology of testing and a very common and terrible
misunderstanding of testing objectives. He claims, that it is commonly accepted that
the goal of software testing is "to show that a program performs its intended functions correctly" (p.5).
Testers are hired to check whether the software functions
as expected and report back to management that all tests successfully passed
and the program can be delivered to end users.

> Despite the plethora of software testing tomes available on the market today,
many developers seem to have an attitude that is counter to extensive testing

This is what Dr. Myers says in the second page, and I can humbly confirm
that in all software groups I've been working so far,
almost everybody, including testers, project managers, and programmers, share this phylosophy.
They say that "testing is the process of demonstrating
that errors are not present" (p.5)

"These definitions are upside down" (p.6). The psychology of testing
should be opposite. There are two quotes that are the most important
in the entire book. They are actually making this book, as I see it. The first
one that defines the goal of software testing, in page 6:

> Testing is the process of executing a program with the intent of finding errors

And the second on, on the next page, that makes this definition
more specific:

> An unsuccessful test case is one that causes a program to produce the
correct result without finding any errors

Dr. Myers comes back to these two thoughts in every chapter. He reiterates
over and over again that we should change the psychology in order to change
our testing results. We should focus on breaking a software instead of confirming
that it works. Testing is a "sadistic process" (p.6) of breaking things. It is a
"destructive process" (p.8).

Chapter 2, if you read it carefully and truly understand its
ideas, may change your entire life :) This chapter should be a New Testament of
every tester.

## Test Completion Criteria

In Chapter 2, Dr. Myers also mentions that a program, no matter how simple
it is, contains an unlimited number of errors. He says that "you cannot test
a program to guarantee that it is error free" (p.10) and that "it is
impractical, often impossible, to find all the errros in a program" (p.8).

And then, in the end of Chapter 6 he asks a very important question (p.135):

> One of the most difficult question to answer when testing a program
is determining when to stop, since there is no way of knowing if the
error just detected is the last remaining error

So, the problem is obvious. Since any program contains an unlimited
number of errors, it doesn't matter how long we test, we won't find
all of them. So, when do we stop? And, more importantly, what
goals do we set to our testers? Even more importantly, when do
we pay them and how much (this question is important to me since
I'm working with contractors only and I need to define measurable
and achievable goals)?

The answer Dr. Myers gives is brilliant (p.136):

> Since the goal of testing is to find errors, why not make the completion
criterion the detection of some predefined number of errors?

Then, in the next few pages he discusses how exactly this "predefined
number" can be estimated. I find this idea very interesting. I even
tried to apply it to a few projects in the last few years. It works,
although causes serious psychological problems in the team. Most people
simply resent the goal of "testing until you find a required number of bugs".
Most common answer is "what if there are no bugs any more?".

However, after a few fights, the team starts to appreciate the concept
and get used to it. So, I can humbly confirm that Dr. Myers is right in his suggestion.
Planning of testing can be based on a number of errors.

## Summary

I consider this book a number one fundamental writing in the area
of software testing. Mostly due to its Chapter 2. Actually, there are
just three pages of text that build the foundation of the entire book. They
are the skeleton of the other two hundred pages.

Unfortunately, since 1979, this skeleton hasn't become a skeleton of
software testing industry. Most of us are still working against
these principles.
