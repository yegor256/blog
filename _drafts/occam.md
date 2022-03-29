---
layout: post
title: "Bugs Occam's Razor"
date: 2022-03-28
place: Moscow, Russia
tags: management
description: |
  It's a responsibility of a bug reporter to make sure
  the description of a problem is the smallest and simplest
  possible.
keywords:
  - bug reports
  - good bug report
  - how to report bugs
  - bugs
  - issues
image: /images/2022/03/game-of-thrones.jpg
jb_picture:
  caption: Game of Thrones (2011–2019) by David Benioff
---

For each accepted explanation of a phenomenon, there may be an extremely 
large, perhaps even incomprehensible, number of possible and 
more complex alternatives. The principle of parsimony, also known
as [Occam's razor](https://en.wikipedia.org/wiki/Occam's_razor), 
suggests we prefer the simplest one. For example, 
"I can't open the door and can't attend the meeting" is a description
of a problem, which could be reduced to "I can't open the door"
without losing any information, which might be important for those
who are waiting for me in the meeting room. I suggest applying the same
principle to bug reports.

<!--more-->

{% jb_picture_body %}

Let's say I design a simple imperative programming language and you submit
this bug report to me:

{% highlight text %}
Here is my code:

a := 7
a := a + 5 - 3
a := a / 3
print a

It doesn't work as expected. It prints 4, 
but it should print 3.
{% endhighlight %}

Now I have to investigate and find out which operator is broken: 
maybe the addition doesn't work, or maybe
the assignment, or the division. I don't know, and I have to
[debug/test]({% pst 2016/feb/2016-02-09-are-you-still-debugging %}) 
in order to find out... Me. Not you. Why not you?

The more I work with bug reports the more I believe that 
this must be your job as a bug reporter,
to play with the code and do the best you can to make your snippet as
short as it can to be to represent the defect.

Of course, you don't need to do glass-box testing of my code finding the cause
of the bug, but on the API surface you must do your job and conclude
that the subtraction operator is broken:

{% highlight text %}
Here is my code:

a := 7
a := a - 3
print a

It doesn't work as expected. It prints 7, 
but it should print 4.
{% endhighlight %}

Here, you've _reduced_ the scope of the defect to a much smaller one. 
You did your "home work" and found out that only one 
particular operator in my programming language is broken: the
subtraction. You saved my time and increased the chance of your
bug report being fixed sooner rather than later.

In general, I believe that this bug optimization work 
must be done by reporters, not product owners.
I would even say that this might be a valid bug rejection reason: 
the report is not the simplest possible one.

