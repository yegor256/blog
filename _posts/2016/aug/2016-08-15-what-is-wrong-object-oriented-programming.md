---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "What's Wrong With Object-Oriented Programming?"
date: 2016-08-15
place: Palo Alto, CA
tags: oop
description: |
  This is my collection of arguments against object-oriented
  programming in general, and its elements in particular,
  expressed by different people at different times.
keywords:
  - oop criticism
  - arguments against oop
  - criticism of object-oriented programming
  - why oop is bad
  - oop vs functional programming
social:
  - dzone: https://dzone.com/articles/whats-wrong-with-object-oriented-programming
style: |
  .quote-author {
    width: 125px;
    height: 150px;
  }
image: /images/2016/08/swingers.jpg
jb_picture:
  caption: Swingers (1996) by Doug Liman
---

Recently, I was trying to convince a few of my readers that
[a better understanding of an object]({% pst 2016/jul/2016-07-14-who-is-object %})
in OOP would help us solve many problems in existing pseudo-object-oriented languages.
Then, suddenly, the question came up: "_What problems?_"
I was puzzled. I thought it was obvious that the vast majority of modern software
written in modern OO languages is unmaintainable and simply a mess.
So I Googled a bit, and this is what I found (in chronological order).

<!--more-->

{% jb_picture_body %}

The list of quotes is sorted in chronological order, with the oldest on
the top:

<img src="/images/2016/08/edsger-dijkstra.jpg" class="quote-author" alt="Edsger W. Dijkstra"/><br/>
[**Edsger W. Dijkstra**](https://en.wikipedia.org/wiki/Edsger_W._Dijkstra) (1989)<br/>
"TUG LINES," Issue 32, August 1989<br/>
"Object oriented programs are offered as alternatives to correct ones"
and
"Object-oriented programming is an exceptionally bad idea
which could only have originated in California."

<!-- 1995 -->
<!--
[Paul Graham](https://en.wikipedia.org/wiki/Paul_Graham_%28computer_programmer%29)
in [Ansi Common Lisp](https://amzn.to/29JwmOz), page 408:
"The object-oriented model makes it easy to build up programs
by accretion. What this often means, in practice, is that it
provides a structured way to write spaghetti code."
-->

{% youtube cGcCcxx4xrg %}

<img src="/images/2016/08/alan-kay.jpg" class="quote-author" alt="Alan Kay"/><br/>
[**Alan Kay**](https://en.wikipedia.org/wiki/Alan_Kay) (1997)<br/>
[The Computer Revolution hasn't happened yet](https://www.youtube.com/watch?v=oKg1hTOQXoY)<br/>
"I invented the term object-oriented, and I can tell you
I did not have C++ in mind." and
"Java and C++ make you think that the new ideas are like the old ones.
Java is the most distressing thing to happen to computing since MS-DOS."
([proof](https://www.cc.gatech.edu/fac/mark.guzdial/squeak/oopsla.html))


<img src="/images/2016/08/paul-graham.jpg" class="quote-author" alt="Paul Graham"/><br/>
[**Paul Graham**](https://en.wikipedia.org/wiki/Paul_Graham_%28computer_programmer%29) (2003)<br/>
[The Hundred-Year Language](https://www.paulgraham.com/hundred.html)<br/>
"Object-oriented programming offers a sustainable way to write spaghetti code."

<img src="/images/2016/08/richard-mansfield.jpg" class="quote-author" alt="Richard Mansfield"/><br/>
**Richard Mansfield** (2005)<br/>
[Has OOP Failed?](https://www.4js.com/files/documents/products/genero/WhitePaperHasOOPFailed.pdf)<br/>
"With OOP-inflected programming languages, computer software becomes more
verbose, less readable, less descriptive, and harder to modify and maintain."

<img src="/images/2016/08/eric-raymond.jpg" class="quote-author" alt="Eric Raymond"/><br/>
[**Eric Raymond**](http://www.catb.org/~esr/) (2005)<br/>
[The Art of UNIX Programming](http://catb.org/esr/writings/taoup/html/unix_and_oo.html)<br/>
"The OO design concept initially proved valuable in the design of graphics
systems, graphical user interfaces, and certain kinds of simulation.
To the surprise and gradual disillusionment of many, it has proven
difficult to demonstrate significant benefits of OO outside those areas."

<img src="/images/2016/08/jeff-atwood.jpg" class="quote-author" alt="Jeff Atwood"/><br/>
[**Jeff Atwood**](https://blog.codinghorror.com/) (2007)<br/>
[Your Code: OOP or POO?](https://blog.codinghorror.com/your-code-oop-or-poo/)<br/>
"OO seems to bring at least as many problems to the table as it solves."

<img src="/images/2016/08/linus-torvalds.jpg" class="quote-author" alt="Linus Torvalds"/><br/>
[**Linus Torvalds**](https://en.wikipedia.org/wiki/Linus_Torvalds) (2007)<br/>
[this email](https://harmful.cat-v.org/software/c++/linus)<br/>
"C++ is a horrible language. ...
C++ leads to really, really bad design choices. ...
In other words, the only way to do good, efficient, and system-level and
portable C++ ends up to limit yourself to all the things that are
basically available in C. And limiting your project to C means that people
don't screw that up, and also means that you get a lot of programmers that
do actually understand low-level issues and don't screw things up with any
idiotic "object model" crap."

<!-- 2009 -->
<!--
[Rich Hickey](https://github.com/richhickey)
at [Are We There Yet?](https://www.infoq.com/presentations/Are-We-There-Yet-Rich-Hickey), JVM Languages Summit 2009 Keynote:
"..."
-->

<img src="/images/2016/08/oscar-nierstrasz.jpg" class="quote-author" alt="Oscar Nierstrasz"/><br/>
[**Oscar Nierstrasz**](https://en.wikipedia.org/wiki/Oscar_Nierstrasz) (2010)<br/>
[Ten Things I Hate About Object-Oriented Programming](http://blog.jot.fm/2010/08/26/ten-things-i-hate-about-object-oriented-programming)<br/>
"OOP is about taming complexity through modeling, but we have not
mastered this yet, possibly because we have difficulty distinguishing
real and accidental complexity."

<img src="/images/2016/08/rich-hickey.jpg" class="quote-author" alt="Rich Hickey"/><br/>
[**Rich Hickey**](https://github.com/richhickey) (2010)<br/>
[SE Radio, Episode 158](https://www.se-radio.net/2010/03/episode-158-rich-hickey-on-clojure/)<br/>
"I think that large objected-oriented programs struggle
with increasing complexity as you build this large object graph of
mutable objects. You know, trying to understand and keep in your mind
what will happen when you call a method and what will the side effects be."

<img src="/images/2016/08/eric-allman.jpg" class="quote-author" alt="Eric Allman"/><br/>
[**Eric Allman**](https://en.wikipedia.org/wiki/Eric_Allman) (2011)<br/>
[Programming Isn't Fun Any More](http://queue.acm.org/blogposting.cfm?id=34658)<br/>
"I used to be enamored of object-oriented programming. I'm now finding myself
leaning toward believing that it is a plot designed to destroy joy. The
methodology looks clean and elegant at first, but when you actually get
into real programs they rapidly turn into horrid messes."

<img src="/images/2016/08/joe-armstrong.jpg" class="quote-author" alt="Joe Armstrong"/><br/>
[**Joe Armstrong**](http://joearms.github.io/) (2011)<br/>
[Why OO Sucks](http://harmful.cat-v.org/software/OO_programming/why_oo_sucks)<br/>
"Objects bind functions and data structures together in
indivisible units. I think this is a fundamental error since functions and
data structures belong in totally different worlds."

<img src="/images/2016/08/rob-pike.jpg" class="quote-author" alt="Rob Pike"/><br/>
[**Rob Pike**](https://en.wikipedia.org/wiki/Rob_Pike) (2012)<br/>
[here](https://plus.google.com/+RobPikeTheHuman/posts/hoJdanihKwb)<br/>
"Object-oriented programming, whose essence is nothing more than
programming using data with associated behaviors, is a powerful idea.
It truly is. But it's not always the best idea. ...
Sometimes data is just data and functions are just functions."

<img src="/images/2016/08/john-barker.jpg" class="quote-author" alt="John Barker"/><br/>
[**John Barker**](https://www.linkedin.com/in/johnebgood) (2013)<br/>
[All evidence points to OOP being bullshit](https://tanzu.vmware.com/content/blog/all-evidence-points-to-oop-being-bullshit)<br/>
"What OOP introduces are abstractions that attempt to improve code
sharing and security. In many ways, it is still essentially procedural code."

<img src="/images/2016/08/lawrence-krubner.jpg" class="quote-author" alt="Lawrence Krubner"/><br/>
[**Lawrence Krubner**](https://www.linkedin.com/in/krubner) (2014)<br/>
[Object Oriented Programming is an expensive disaster which must end](http://www.smashcompany.com/technology/object-oriented-programming-is-an-expensive-disaster-which-must-end)<br/>
"We now know that OOP is an experiment that failed.
It is time to move on. It is time that we, as a community, admit that
this idea has failed us, and we must give up on it."

<img src="/images/2016/08/asaf-shelly.jpg" class="quote-author" alt="Asaf Shelly"/><br/>
[**Asaf Shelly**](https://www.linkedin.com/in/asafshelly) (2015)<br/>
[Flaws of Object Oriented Modeling](https://software.intel.com/en-us/blogs/2008/08/22/flaws-of-object-oriented-modeling/)<br/>
"Reading an object oriented code you can't see the big picture and
it is often impossible to review all the small functions that
call the one function that you modified."

<hr/>

If you have something to add to this list, please post a comment below.
