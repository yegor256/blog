---
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
---

Recently, I was trying to convince a few of my readers that
[a better understanding of an object]({% pst 2016/jul/2016-07-14-who-is-object %})
in OOP would help us solve many problems in existing pseudo-object-oriented languages.
Then, suddenly, the question came up: "**What problems?**"
I was puzzled. I thought it was obvious that the vast majority of modern software
written in modern OO languages is unmaintainable and simply a mess.
So I Googled a bit, and this is what I found (in chronological order).

<!--more-->

{% picture /images/2016/08/swingers.jpg 0 Swingers (1996) by Doug Liman %}

<!-- 1989 -->
<div class="clear"></div>
{% badge /images/2016/08/edsger-dijkstra.jpg 200 %}
[Edsger W. Dijkstra](https://en.wikipedia.org/wiki/Edsger_W._Dijkstra)
in "TUG LINES", Issue 32, August 1989:
"Object oriented programs are offered as alternatives to correct ones"
and
"Object-oriented programming is an exceptionally bad idea
which could only have originated in California."

<!-- 1995 -->
<!--
[Paul Graham](https://en.wikipedia.org/wiki/Paul_Graham_%28computer_programmer%29)
in [Ansi Common Lisp](http://amzn.to/29JwmOz), page 408:
"The object-oriented model makes it easy to build up programs
by accretion. What this often means, in practice, is that it
provides a structured way to write spaghetti code."
-->

<!-- 1997 -->
<div class="clear"></div>
{% badge /images/2016/08/alan-kay.jpg 200 %}
[Alan Kay](https://en.wikipedia.org/wiki/Alan_Kay)
in [The Computer Revolution hasn't happened yet](https://www.youtube.com/watch?v=oKg1hTOQXoY), OOPSLA'97 Keynote:
"I invented the term object-oriented, and I can tell you
I did not have C++ in mind."

<!-- 2003 -->
<div class="clear"></div>
{% badge /images/2016/08/paul-graham.jpg 200 %}
[Paul Graham](https://en.wikipedia.org/wiki/Paul_Graham_%28computer_programmer%29)
in [The Hundred-Year Language](http://www.paulgraham.com/hundred.html):
"Object-oriented programming offers a sustainable way to write spaghetti code."

<!-- 2007 -->
<div class="clear"></div>
{% badge /images/2016/08/linus-torvalds.jpg 200 %}
[Linus Torvalds](https://en.wikipedia.org/wiki/Linus_Torvalds)
in [this email](http://article.gmane.org/gmane.comp.version-control.git/57918/):
"C++ is a horrible language. ...
C++ leads to really, really bad design choices. ...
In other words, the only way to do good, efficient, and system-level and
portable C++ ends up to limit yourself to all the things that are
basically available in C. And limiting your project to C means that people
don't screw that up, and also means that you get a lot of programmers that
do actually understand low-level issues and don't screw things up with any
idiotic 'object model' crap."

<!-- 2009 -->
<!--
[Rich Hickey](https://github.com/richhickey)
at [Are We There Yet?](https://www.infoq.com/presentations/Are-We-There-Yet-Rich-Hickey), JVM Languages Summit 2009 Keynote:
"..."
-->

<!-- 2010 -->
<div class="clear"></div>
{% badge /images/2016/08/oscar-nierstrasz.jpg 200 %}
[Oscar Nierstrasz](https://en.wikipedia.org/wiki/Oscar_Nierstrasz)
in [Ten Things I Hate About Object-Oriented Programming](http://blog.jot.fm/2010/08/26/ten-things-i-hate-about-object-oriented-programming):
"OOP is about taming complexity through modeling, but we have not
mastered this yet, possibly because we have difficulty distinguishing
real and accidental complexity."

<!-- 2010 -->
<div class="clear"></div>
{% badge /images/2016/08/rich-hickey.jpg 200 %}
[Rich Hickey](https://github.com/richhickey)
at [SE Radio](http://www.se-radio.net/2010/03/episode-158-rich-hickey-on-clojure/), Episode 158:
"I think that large objected-oriented programs struggle
with increasing complexity as you build this large object graph of
mutable objects. You know, trying to understand and keep in your mind
what will happen when you call a method and what will the side effects be."

<!-- 2011 -->
<div class="clear"></div>
{% badge /images/2016/08/joe-armstrong.jpg 200 %}
[Joe Armstrong](http://joearms.github.io/)
in [Why OO Sucks](http://harmful.cat-v.org/software/OO_programming/why_oo_sucks):
"Objects bind functions and data structures together in
indivisible units. I think this is a fundamental error since functions and
data structures belong in totally different worlds."

<!-- 2012 -->
<div class="clear"></div>
{% badge /images/2016/08/rob-pike.jpg 200 %}
[Rob Pike](https://en.wikipedia.org/wiki/Rob_Pike)
[here](https://plus.google.com/+RobPikeTheHuman/posts/hoJdanihKwb):
"Object-oriented programming, whose essence is nothing more than
programming using data with associated behaviors, is a powerful idea.
It truly is. But it's not always the best idea. ...
Sometimes data is just data and functions are just functions."

<!-- 2013 -->
<div class="clear"></div>
{% badge /images/2016/08/john-barker.jpg 200 %}
[John Barker](https://www.linkedin.com/in/johnebgood)
in [All evidence points to OOP being bullshit](https://blog.pivotal.io/labs/labs/all-evidence-points-to-oop-being-bullshit):
"What OOP introduces are abstractions that attempt to improve code
sharing and security. In many ways, it is still essentially procedural code."

<!-- 2014 -->
<div class="clear"></div>
{% badge /images/2016/08/lawrence-krubner.jpg 200 %}
[Lawrence Krubner](https://www.linkedin.com/in/krubner)
in [Object Oriented Programming is an expensive disaster which must end](http://www.smashcompany.com/technology/object-oriented-programming-is-an-expensive-disaster-which-must-end):
"We now know that OOP is an experiment that failed.
It is time to move on. It is time that we, as a community, admit that
this idea has failed us, and we must give up on it."

<hr/>

I can't prove this quote (maybe you can help?):

Alan Kay:
"Java and C++ make you think that the new ideas are like the old ones.
Java is the most distressing thing to happen to computing since MS-DOS."

If you have something to add to this list, please post a comment below.
