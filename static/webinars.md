---
layout: static
title: "Webinars"
description: |
  Here is a full list of my webinars, which
  happen every first Wednesday of each month,
  on Google Hangout
permalink: webinars.html
keywords:
  - programming webinars
  - software development webinars
  - webinars about software development
  - webinars about programming
  - software engineers webinars
image: /images/andreea/webinar.png
style: |
  .wnr {
    width: 192px;
    height: 108px;
    display: block;
    margin-top: 4em;
    filter: grayscale(100%);
  }
---

{% badge /images/andreea/webinar.svg 200 %}

On the first Wednesday of each month, at 11am PST, I _try to_ organize
a webinar. For about an hour we talk about software
development, object-oriented programming <del>and project management</del>
(for project management topics listen to the [Shift-M](/shift-m.html) podcast).
Here is a full list of all webinars on [YouTube](https://www.youtube.com/playlist?list=PLaIsQH4uc08x0H7Cu_OO72DBTNADqFXNm)
(don't forget [to subscribe](https://www.youtube.com/c/yegor256?sub_confirmation=1)
to the channel).

<!--
Here is [my calendar](https://calendar.google.com/calendar/ical/mt9l1l9jdo05rnj54daq5tdsb0%40group.calendar.google.com/public/basic.ics),
feel free to import it (to Google Calendar or iCal) and stay
informed about everything I do publicly, including these webinars.
-->

## 2021

<!--
{% webinar 12-05-2021 56 rbphMrFM7W8 Inheritance vs. Composition in Object-Oriented Programming %}

<a href="https://youtu.be/rbphMrFM7W8"><img src="https://i.ytimg.com/vi/rbphMrFM7W8/mqdefault.jpg" class="wnr" alt="Webinar no.56 by Yegor Bugayenko"/></a>
May 12, 2021<br/>
&#35;56: **Inheritance vs. Composition in Object-Oriented Programming**<br/>
Implementation Inheritance is a mechanism of code reuse, which is very popular in OOP code. However, many practitioners believe that composition is a better and cleaner alternative.
-->

<a href="https://www.youtube.com/watch?v=fJvUTlPHSvU"><img src="https://i.ytimg.com/vi/fJvUTlPHSvU/mqdefault.jpg" class="wnr" alt="Webinar no.55 by Yegor Bugayenko"/></a>
Feb 10, 2021<br/>
&#35;55: **Encapsulation Is Dead, Let's Use Distance of Coupling Instead**<br/>
Encapsulation is one of four fundamental principles in object-oriented programming. However, as we practitioners know, it doesn't really work. Getters and setters don't really help, but only make the code more complex. It is suggested to use a different approach to enforce decoupling: distance of coupling metric.

<a href="https://www.youtube.com/watch?v=I9xyZVSo-HY"><img src="https://i.ytimg.com/vi/I9xyZVSo-HY/mqdefault.jpg" class="wnr" alt="Webinar no.53 by Yegor Bugayenko"/></a>
Jan 6, 2021<br/>
&#35;54: **How to Make a DSL with ANTLR4**<br/>
You can create your own Domain Specific Language (DSL) using ANTLR4 library in Java.
Here we discuss how this can be done and create a new DSL in less than an hour.

## 2020

<a href="https://www.youtube.com/watch?v=4u83tJkqQgU"><img src="https://i.ytimg.com/vi/4u83tJkqQgU/mqdefault.jpg" class="wnr" alt="Webinar no.53 by Yegor Bugayenko"/></a>
Dec 2, 2020<br/>
&#35;53: **Best Practices of Exception Throwing**<br/>
We discuss what are good and bad habits in exception throwing: how to create them, whether to use checked or unchecked, when to use more detailed and less detailed objects, and so on.

<a href="https://www.youtube.com/watch?v=4ZWHs1mloUw"><img src="https://i.ytimg.com/vi/4ZWHs1mloUw/mqdefault.jpg" class="wnr" alt="Webinar no.52 by Yegor Bugayenko"/></a>
Nov 4, 2020<br/>
&#35;52: **RAII in Java**<br/>
Resource Acquisition Is Initialization (RAII) is a design idea introduced in C++ by Bjarne Stroustrup for exception-safe resource management. Thanks to garbage collection Java doesn’t have this feature, but we can implement something similar, using try-with-resources. Let's see how exactly.

<a href="https://www.youtube.com/watch?v=rsWrgxm8ktU"><img src="https://i.ytimg.com/vi/rsWrgxm8ktU/mqdefault.jpg" class="wnr" alt="Webinar no.51 by Yegor Bugayenko"/></a>
Oct 7, 2020<br/>
&#35;51: **Fat and Skinny Design**<br/>
It seems that type/class hierarchies in OOP may be designed in two extreme ways: either with full encapsulation of data in mind; or with just a few interfaces making raw data visible, and letting classes deal with it, parse it, and turn it into smaller data elements. You may be surprised, but I’m suggesting the second option is more elegant.

<a href="https://www.youtube.com/watch?v=nErn5G_JHhE"><img src="https://i.ytimg.com/vi/nErn5G_JHhE/mqdefault.jpg" class="wnr" alt="Webinar no.50 by Yegor Bugayenko"/></a>
August 5, 2020<br/>
&#35;50: **Veil Objects to Replace DTOs**<br/>
We all know that DTOs (aka value objects) are evil. But what is the alternative when we need some data to be transferred temporarily? I'm suggesting Veil Objects and this webinar demonstrates how they are used.

<a href="https://www.youtube.com/watch?v=eeXdDvIVu-Y"><img src="https://i.ytimg.com/vi/eeXdDvIVu-Y/mqdefault.jpg" class="wnr" alt="Webinar no.49 by Yegor Bugayenko"/></a>
March 12, 2020<br/>
&#35;49: **What Is Cohesion in OOP?**<br/>
There are two important metrics in OOP: cohesion and coupling. The first one is the most interesting one since it can be measured. There are many ways to measure it. We discuss which of them make sense and why we should care.

## 2019

<a href="https://www.youtube.com/watch?v=3blBn65iQmU"><img src="https://i.ytimg.com/vi/3blBn65iQmU/mqdefault.jpg" class="wnr" alt="Webinar no.48 by Yegor Bugayenko"/></a>
December 4, 2019<br/>
&#35;48: **Why Private Static Literals are Evil?**<br/>
The most commonly used solution for the code duplication code is private static constants, which sometimes stay in the same class, but very often reside in a special Constants utility class. This approach is very wrong and only kills your design.

<a href="https://www.youtube.com/watch?v=6AfBsXOgx1s"><img src="https://i.ytimg.com/vi/6AfBsXOgx1s/mqdefault.jpg" class="wnr" alt="Webinar no.47 by Yegor Bugayenko"/></a>
November 6, 2019<br/>
&#35;47: **Aspect Oriented Programming: Pros and Cons**<br/>
AOP is a very powerful technique, which is so easily can be abused. We discuss how it works, what is it for, and how to use it responsively in order to stay object-oriented.

<a href="https://www.youtube.com/watch?v=oNtTAF0UjjA"><img src="https://i.ytimg.com/vi/oNtTAF0UjjA/mqdefault.jpg" class="wnr" alt="Webinar no.46 by Yegor Bugayenko"/></a>
August 7, 2019<br/>
&#35;46: **Xembly, an imperative language for XML manipulations**<br/>
Xembly is an "Assembly for XML", an imperative language for building and modifying XML documents. I'm using it in many Java projects where I need to build or modify XML pages. Here is a live demonstration of its features.

<a href="https://www.youtube.com/watch?v=_d3AmqeGcMU"><img src="https://i.ytimg.com/vi/_d3AmqeGcMU/mqdefault.jpg" class="wnr" alt="Webinar no.45 by Yegor Bugayenko"/></a>
July 3, 2019<br/>
&#35;45: **How Much Immutability Is Enough**<br/>
Immutability is a virtue in object-oriented programming, but very often it is being confused with constants. Those are different things. Immutable objects are not constants and there are a lot of possibilities to make an object immutable but still ready to accept changes.

<a href="https://www.youtube.com/watch?v=SoXV_scCMNY"><img src="https://i.ytimg.com/vi/SoXV_scCMNY/mqdefault.jpg" class="wnr" alt="Webinar no.44 by Yegor Bugayenko"/></a>
June 12, 2019<br/>
&#35;44: **Logging, the Object-Oriented Way**<br/>
How do you log events from your objects? Do you use static loggers? Do
you use static methods? If you do, you are doing it wrong. There is
a better, a more object-oriented way to do that.

<!--
<a href="https://www.youtube.com/watch?v=xh6PSEmWcmg"><img src="https://i.ytimg.com/vi/xh6PSEmWcmg/mqdefault.jpg" class="wnr" alt="Webinar no.43 by Yegor Bugayenko"/></a>
March 06, 2019<br/>
&#35;43: **Adding thread-safety to existing objects, in Ruby**<br/>
Thread-safety is a quality some objects in OOP may possess, but some may
not need that. It's a good practice to add thread-safety (unless you really
need something very specific and fast) via decorators. Here we demonstrate
how this can be done in Ruby.
-->

<a href="https://www.youtube.com/watch?v=bVzEPOZ_mDU"><img src="https://i.ytimg.com/vi/bVzEPOZ_mDU/mqdefault.jpg" class="wnr" alt="Webinar no.42 by Yegor Bugayenko"/></a>
February 13, 2019<br/>
&#35;42: **A practical example of making an object-oriented HTTP server in Java**<br/>
Most web frameworks hide the details of HTTP requests processing
from software developers, making it difficult to design a web application right;
in the webinar we analyze how it can be done right, in an object-oriented way.

<a href="https://www.youtube.com/watch?v=u8JMaMXydbs"><img src="https://i.ytimg.com/vi/u8JMaMXydbs/mqdefault.jpg" class="wnr" alt="Webinar no.41 by Yegor Bugayenko"/></a>
January 2, 2019<br/>
&#35;41: **How many RETURN statements is enough?**<br/>
Multiple RETURN statements are considered as bad practice in object-oriented programming.
We analyze practical examples and see why exactly those statements are bad or not. The discussion is in this blog post:
[_Why Many Return Statements Are a Bad Idea in OOP_]({% pst 2015/aug/2015-08-18-multiple-return-statements-in-oop %}).

## 2018

<a href="https://www.youtube.com/watch?v=gLHdZnrlPD8"><img src="https://i.ytimg.com/vi/gLHdZnrlPD8/mqdefault.jpg" class="wnr" alt="Webinar no.40 by Yegor Bugayenko"/></a>
December 5, 2018<br/>
&#35;40: **The Power of Decorators**<br/>
The Decorator design pattern is a powerful tool in object-oriented programming. There is
a real practical example demonstrated, from Zold source code.

<a href="https://www.youtube.com/watch?v=uznmzI7qsvI"><img src="https://i.ytimg.com/vi/uznmzI7qsvI/mqdefault.jpg" class="wnr" alt="Webinar no.39 by Yegor Bugayenko"/></a>
November 7, 2018<br/>
&#35;39: **A practical example of ORM-free persistence layer**<br/>
There is a demonstration of a real web application ([mailanes.com](https://www.mailanes.com)),
where the persistence layer
is designed without the use of any ORM frameworks, on top of plain PostgreSQL Ruby SDK.

<a href="https://www.youtube.com/watch?v=GIyAZRRgWPg"><img src="https://i.ytimg.com/vi/GIyAZRRgWPg/mqdefault.jpg" class="wnr" alt="Webinar no.38 by Yegor Bugayenko"/></a>
October 3, 2018<br/>
&#35;38: **Parsing Objects vs Parsers**<br/>
The Parser is a very commonly used pattern in OOP, which is actually
not very object-oriented; a better alternative is parsing objects.
The discussion is based on this:
[_Don't Parse, Use Parsing Objects_]({% pst 2018/feb/2018-02-27-parsing-objects %}).

<a href="https://www.youtube.com/watch?v=oXj9UWm1134"><img src="https://i.ytimg.com/vi/oXj9UWm1134/mqdefault.jpg" class="wnr" alt="Webinar no.37 by Yegor Bugayenko"/></a>
September 12, 2018<br/>
&#35;37: **Names of objects, methods and variables in OOP**<br/>
Finding the right name for a class, a method, an object, an attribute or a variable
is a complex task in OOP. There are a few thoughts and practical examples.

<a href="https://www.youtube.com/watch?v=FNWyN_Q10TI"><img src="https://i.ytimg.com/vi/FNWyN_Q10TI/mqdefault.jpg" class="wnr" alt="Webinar no.36 by Yegor Bugayenko"/></a>
August 8, 2018<br/>
&#35;36: **What's wrong with global variables?**<br/>
We all know that global variables are evil, but most of us keep using them.
Here we discuss what exactly is wrong with them. The discussion is based on this blog post:
[_What's Wrong With Global Variables?_]({% pst 2018/jul/2018-07-03-global-variables %})

<a href="https://www.youtube.com/watch?v=-drZbHxydMc"><img src="https://i.ytimg.com/vi/-drZbHxydMc/mqdefault.jpg" class="wnr" alt="Webinar no.35 by Yegor Bugayenko"/></a>
July 4, 2018<br/>
&#35;35: **When do you validate your objects?**<br/>
Very often we need to validate our objects for consistency, before working with them.
A file may be absent, a database connection may get lost, a data structure may
contain invalid information, and so on. When is the right moment to validate
that, in a constructor or some time later, in a method?
[_Object Validation: to Defer or Not?_]({% pst 2018/may/2018-05-29-object-validation %})

<a href="https://www.youtube.com/watch?v=NQRyqiQehBk"><img src="https://i.ytimg.com/vi/NQRyqiQehBk/mqdefault.jpg" class="wnr" alt="Webinar no.34 by Yegor Bugayenko"/></a>
May 10, 2018<br/>
&#35;34: **How to Get Rid of the NEW Operator**<br/>
We discussed what was wrong with the operator NEW and how object-oriented code could get rid of it.
More details here:
[_Operator new() is Toxic_]({% pst 2018/jan/2018-01-02-operator-new-is-toxic %}).

<a href="https://www.youtube.com/watch?v=REj8pJesMVI"><img src="https://i.ytimg.com/vi/REj8pJesMVI/mqdefault.jpg" class="wnr" alt="Webinar no.33 by Yegor Bugayenko"/></a>
April 4, 2018<br/>
&#35;33: **The Alternative to Fluent Interfaces in Java**<br/>
We discussed fluent interfaces design pattern by example. We
tried to create an HTTP client as an alternative to jcabi-http,
without fluent interfaces, but only with decorators and smart objects.
This blog post explains the idea:
[_Fluent Interfaces Are Bad for Maintainability_]({% pst 2018/mar/2018-03-13-fluent-interfaces %}).

<a href="https://www.youtube.com/watch?v=rC17YwowURQ"><img src="https://i.ytimg.com/vi/rC17YwowURQ/mqdefault.jpg" class="wnr" alt="Webinar no.32 by Yegor Bugayenko"/></a>
February 7, 2018<br/>
&#35;32: **Synchronized Decorators for Thread-Safety**<br/>
We discussed thread-safety in OOP and synchronized decorators to solve the problem.
The discussion was based on this blog post:
[_Synchronized Decorators to Replace Thread-Safe Classes_]({% pst 2017/jan/2017-01-17-synchronized-decorators %}).

<a href="https://www.youtube.com/watch?v=Wcy53ZSF78o"><img src="https://i.ytimg.com/vi/Wcy53ZSF78o/mqdefault.jpg" class="wnr" alt="Webinar no.31 by Yegor Bugayenko"/></a>
January 3, 2018<br/>
&#35;31: **Decorating Envelopes**<br/>
We discussed a simple object-oriented technique I keep using in my projects and find very convenient,
it was discussed in this blog post:
[_Decorating Envelopes_]({% pst 2017/jan/2017-01-31-decorating-envelopes %})
earlier.

## 2017

<a href="https://www.youtube.com/watch?v=7WmsiV22IXM"><img src="https://i.ytimg.com/vi/7WmsiV22IXM/mqdefault.jpg" class="wnr" alt="Webinar no.30 by Yegor Bugayenko"/></a>
December 13, 2017<br/>
&#35;30: **Lazy Loading via Java Lambda**<br/>
We went through a number of functional interfaces and classes of Cactoos library and
saw how they can be used in order to implement Lazy Loading in an object-oriented way.

<a href="https://www.youtube.com/watch?v=Z70PMGaxGhY"><img src="https://i.ytimg.com/vi/Z70PMGaxGhY/mqdefault.jpg" class="wnr" alt="Webinar no.29 by Yegor Bugayenko"/></a>
November 1, 2017<br/>
&#35;29: **How to win $4096 in the next year Quality Award?**<br/>
I've shown by examples what quality meant for me when I was deciding
which project deserved to be the winner in the annual Quality Award.

<a href="https://www.youtube.com/watch?v=KYd24FN58wg"><img src="https://i.ytimg.com/vi/KYd24FN58wg/mqdefault.jpg" class="wnr" alt="Webinar no.28 by Yegor Bugayenko"/></a>
October 4, 2017<br/>
&#35;28: **Object-Oriented Java Web App from Scratch in One Hour: ThreeCopies.com**<br/>
We discussed a fully functional web app in Java, which was built with the best principles of
object-oriented programming in mind. The application was
ThreeCopies.com, an online backup solution for server-side data.

<a href="https://www.youtube.com/watch?v=rEK3Rk2lX3M"><img src="https://i.ytimg.com/vi/rEK3Rk2lX3M/mqdefault.jpg" class="wnr" alt="Webinar no.27 by Yegor Bugayenko"/></a>
August 2, 2017<br/>
&#35;27: **Releasing Cactoos 0.12**<br/>
We went through the entire Cactoos library,
polished its code and released version 0.12 to Maven Central.

<a href="https://www.youtube.com/watch?v=Mj1gA5mEk68"><img src="https://i.ytimg.com/vi/Mj1gA5mEk68/mqdefault.jpg" class="wnr" alt="Webinar no.26 by Yegor Bugayenko"/></a>
July 12, 2017<br/>
&#35;26: **Unit Testing vs Debugging**<br/>
We discussed why debugging was a bad practice in general and how unit testing
could replace it in all places. The discussion was based on this article previously published:
[_Are You Still Debugging?_]({% pst 2016/feb/2016-02-09-are-you-still-debugging %}).

<a href="https://www.youtube.com/watch?v=uhDmHkMAYnM"><img src="https://i.ytimg.com/vi/uhDmHkMAYnM/mqdefault.jpg" class="wnr" alt="Webinar no.25 by Yegor Bugayenko"/></a>
June 7, 2017<br/>
&#35;25: **Micro-management vs. micro-tasking**<br/>
We discussed how bad was micromanagement and how great was micro-tasking.
Somehow our discussion was based on this article:
[_Are You a Micromanager?_]({% pst 2015/sep/2015-09-22-micromanagement %}).

<a href="https://www.youtube.com/watch?v=DjrA7_Uymok"><img src="https://i.ytimg.com/vi/DjrA7_Uymok/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
May 3, 2017<br/>
&#35;24: **Inheritance vs. Subtyping**<br/>
We discussed subtyping in OOP and implementation inheritance, and compared
how they are different and which one is good, which one is evil. The
discussion was based on this article
[_Inheritance Is a Procedural Technique for Code Reuse_]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %}).

<a href="https://www.youtube.com/watch?v=nsYGC2aUwfQ"><img src="https://i.ytimg.com/vi/nsYGC2aUwfQ/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
April 6, 2017<br/>
&#35;23: **Puzzle Driven Development**<br/>
We discussed Puzzle Driven Development, the methodology that we've been using in
our projects since 2009, with a lot of success. More about it here:
[_Puzzle Driven Development_]({% pst 2010/mar/2010-03-04-pdd %}).

<a href="https://www.youtube.com/watch?v=Nm274dGikFc"><img src="https://i.ytimg.com/vi/Nm274dGikFc/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
March 15, 2017<br/>
&#35;22: **Naked Data isn't OOP**<br/>
We will discuss the problem of data presence in object-oriented
code and how their negative effect can be neutralized.
The discussion will be based on this blog post:
[_Encapsulation Covers Up Naked Data_]({% pst 2016/nov/2016-11-21-naked-data %})

<a href="https://www.youtube.com/watch?v=GWLpAZqvqSc"><img src="https://i.ytimg.com/vi/GWLpAZqvqSc/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
February 8, 2017<br/>
&#35;21: **How to Deal With Conflicts in a Software Team**<br/>
We discussed what was the most effective attitude towards conflicts
in a software team, which was aiming for higher quality. The discussion
was based on this blog post:
[_How Much Do You Love Conflict?_]({% pst 2017/jan/2017-01-03-how-much-you-love-conflicts %})

<a href="https://www.youtube.com/watch?v=PVvLQGnyDrQ"><img src="https://i.ytimg.com/vi/PVvLQGnyDrQ/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
January 11, 2017<br/>
&#35;20: **Gradients of Immutability**<br/>
We discussed what immutability really was, with a few example in Java and [EO](http://www.eolang.org)
(new language we're developing now). The discussion was based on this blog post:
[_Gradients of Immutability_]({% pst 2016/sep/2016-09-07-gradients-of-immutability %}).

## 2016

<a href="https://www.youtube.com/watch?v=zaKTNK8g2-M"><img src="https://i.ytimg.com/vi/zaKTNK8g2-M/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
December 7, 2016<br/>
&#35;19: **Who Is a Project Manager?**<br/>
We discussed what was the role of a project manager in a software project and how it
was different from other roles. The discussion was based on this article:
[_Who Is a Project Manager?_]({% pst 2016/may/2016-05-24-who-is-project-manager %}).

<a href="https://www.youtube.com/watch?v=_Q0cNykXB04"><img src="https://i.ytimg.com/vi/_Q0cNykXB04/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
September 7, 2016<br/>
&#35;18: **Printers Instead of Getters in OOP**<br/>
Getters are evil in OOP, but what is the alternative?
Printers is the way to go. The discussion was based on this article:
[_Printers Instead of Getters_]({% pst 2016/apr/2016-04-05-printers-instead-of-getters %}).

<a href="https://www.youtube.com/watch?v=7DYr8GYzJ6Q"><img src="https://i.ytimg.com/vi/7DYr8GYzJ6Q/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
August 3, 2016<br/>
&#35;17: **The Philosophy of Bugs**<br/>
We discussed what bugs were for, how they must be understood by the management,
how many of them we should expect to find and
what is in general the right philosophy of bug tracking.
This article were mentioned:
[_When Do You Stop Testing?_]({% pst 2015/sep/2015-09-10-testing-exit-criteria %}).

<a href="https://www.youtube.com/watch?v=Xk9tIqwca3k"><img src="https://i.ytimg.com/vi/Xk9tIqwca3k/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
July 7, 2016<br/>
&#35;16: **Smart Classes and Functionality-Poor Interfaces**<br/>
We discussed why `java.io.InputStream` design was wrong,
what Smart-Classes are for and why interfaces must be functionality poor.
The discussion was based on this blog post:
[_Why `InputStream` Design Is Wrong_]({% pst 2016/apr/2016-04-26-why-inputstream-design-is-wrong %})

<a href="https://www.youtube.com/watch?v=YBQoTZ-1X-o"><img src="https://i.ytimg.com/vi/YBQoTZ-1X-o/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
June 1, 2016<br/>
&#35;15: **How to Cut Corners and Stay Cool**<br/>
we'll discuss how to cut corners and stay cool and how
to turn chaos into discipline. The discussion will be based
on these articles:
[_How to Cut Corners and Stay Cool_]({% pst 2015/jan/2015-01-15-how-to-cut-corners %})
and
[_It's Not a School!_]({% pst 2015/feb/2015-02-16-it-is-not-a-school %}).

<a href="https://www.youtube.com/watch?v=g1ctRcW214w"><img src="https://i.ytimg.com/vi/g1ctRcW214w/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
May 4, 2016<br/>
&#35;14: **Java Annotations Are a Big Mistake**<br/>
We discussed why Java annotations were actually a mistake
in object-oriented programming and how they motivated us to
break object's consistency and turn it into a data bag. The
discussion was based on this article:
[_Java Annotations Are a Big Mistake_]({% pst 2016/apr/2016-04-12-java-annotations-are-evil %}).

<a href="https://www.youtube.com/watch?v=AvVQ5NjS_Nk"><img src="https://i.ytimg.com/vi/AvVQ5NjS_Nk/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
April 13, 2016<br/>
&#35;13: **Who is Software Architect?**<br/>
Software architect is responsible for failures and is
powerful enough to make and overrule any decision. But that
is not it. We also talked about delegation of responsibility and
micromanagement. Mostly, this webinar summarized what these articles are talking about:
[_Are You a Micromanager?_]({% pst 2015/sep/2015-09-22-micromanagement %})
and
[_Who Is Software Architect?_]({% pst 2014/oct/2014-10-12-who-is-software-architect %}).

<a href="https://www.youtube.com/watch?v=nheD2LNYrpk"><img src="https://i.ytimg.com/vi/nheD2LNYrpk/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
March 2, 2016<br/>
&#35;12: **Takes, Java Web Framework, Intro**<br/>
This was be a very practical Java coding webinar. We created
[jare.io](http://www.jare.io), a web system, using Takes Framework, immutable objects
and the best practices of pure fanatical object-oriented programming.
We used this blog post as a guidance:
[_Java Web App Architecture In Takes Framework_]({% pst 2015/mar/2015-03-22-takes-java-web-framework %})

<a href="https://www.youtube.com/watch?v=ibT5oKToMoQ"><img src="https://i.ytimg.com/vi/ibT5oKToMoQ/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
February 3, 2016<br/>
&#35;11: **Daily Stand-Up Meetings Are Evil**<br/>
We talked about famous daily meetings and why they were
actually a bad idea in a properly managed
and disciplined software project. The discussion was
based on this post:
[_Daily Stand-Up Meetings Are a Good Tool for a Bad Manager_]({% pst 2015/jan/2015-01-08-morning-standup-meetings %})

<a href="https://www.youtube.com/watch?v=DEqcn4-freM"><img src="https://i.ytimg.com/vi/DEqcn4-freM/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
January 6, 2016<br/>
&#35;10: **Why ORM is an Anti-Pattern?**<br/>
We discussed why Object-Relational Mapping (ORM) was actually
an anti-pattern and its usage must be replaced with
SQL-speaking objects. The discussion was based on
this blog post:
[_ORM Is an Offensive Anti-Pattern_]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %}).

## 2015

<a href="https://www.youtube.com/watch?v=oV6Utb5Jows"><img src="https://i.ytimg.com/vi/oV6Utb5Jows/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
December 1, 2015<br/>
&#35;9: **Dependency Injection Container is a Bad Idea**<br/>
We discussed why Dependency Injection (DI) containers were not
a good idea in object-oriented programming and what they
should be replaced with. The discussion was mostly be based
on
[_DI Containers are Code Polluters_]({% pst 2014/oct/2014-10-03-di-containers-are-evil %}).

<a href="https://www.youtube.com/watch?v=l6MpCBzwDbg"><img src="https://i.ytimg.com/vi/l6MpCBzwDbg/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
November 4, 2015<br/>
&#35;8: **What Fake Objects Are For?**<br/>
We discussed the role of fake objects and the importance
of their existence in every object-oriented library. The discussion
was based on this post:
[_Built-in Fake Objects_]({% pst 2014/sep/2014-09-23-built-in-fake-objects %}).

<a href="https://www.youtube.com/watch?v=9yjtsCK6Wdk"><img src="https://i.ytimg.com/vi/9yjtsCK6Wdk/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
October 7, 2015<br/>
&#35;7: **A Few Thoughts About Constructors in OOP**<br/>
We discussed the role of constructors in OOP and a few
best practices for their design, including primary vs secondary
and code-free design. The discussion was based on these articles:
[_There Can Be Only One Primary Constructor_]({% pst 2015/may/2015-05-28-one-primary-constructor %})
and
[_Constructors Must Be Code-Free_]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}).

<a href="https://www.youtube.com/watch?v=psrp3TtaYYI"><img src="https://i.ytimg.com/vi/psrp3TtaYYI/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
September 2, 2015<br/>
&#35;6: **What's Wrong About Utility Classes?**<br/>
We discussed a very common design pattern known as "Utility Class"
and its negative effects on the quality of design in object-oriented
world. The discussion was be based on this post:
[_OOP Alternative to Utility Classes_]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}).

<a href="https://www.youtube.com/watch?v=WpP4rIhh5e4"><img src="https://i.ytimg.com/vi/WpP4rIhh5e4/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
August 5, 2015<br/>
&#35;5: **Don't Create Objects That End With -ER**<br/>
We talked about [class naming]({% pst 2017/feb/2017-02-28-too-many-classes %})
principles and a very typical
problem of misusing "-er" suffix for them, for example in
Managers, Observers, Controllers, Filters, Helpers, etc. The
discussion was based on this post:
[_Don't Create Objects That End With -ER_]({% pst 2015/mar/2015-03-09-objects-end-with-er %}).

<a href="https://www.youtube.com/watch?v=WSgP85kr6eU"><img src="https://i.ytimg.com/vi/WSgP85kr6eU/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
July 1, 2015<br/>
&#35;4: **Why Getters-and-Setters Is An Anti-Pattern?**<br/>
We discussed why Getters-and-Setters, a very popular design
pattern in object oriented languages, is instead an anti-pattern
and must be avoided. The discussion was be based on this blog post:
[_Getters/Setters. Evil. Period._]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})

<a href="https://www.youtube.com/watch?v=o3aNJX7AP3M"><img src="https://i.ytimg.com/vi/o3aNJX7AP3M/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
June 3, 2015<br/>
&#35;3: **What's wrong about NULL in OOP?**<br/>
This webinar was about NULL references/pointers in object-oriented
programming and their negative effect on the entire design
of your application.
The webinar was mostly motivated by this post:
[_Why NULL is Bad?_]({% pst 2014/may/2014-05-13-why-null-is-bad %}).
My attitude towards NULL references is very negative, so be prepared
for an OOP "radicalism" there.

<a href="https://www.youtube.com/watch?v=KwP7Ay9Z-hc"><img src="https://i.ytimg.com/vi/KwP7Ay9Z-hc/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
May 6, 2015<br/>
&#35;2: **Immutable Objects vs Common Sense**<br/>
The second webinar, about immutable objects and their pros and cons
in an object-oriented programming.
The webinar was based on this post:
[_Immutable Objects Are Not Dumb_]({% pst 2014/dec/2014-12-22-immutable-objects-not-dumb %}).
I made a few slides for this webinar, to illustrate my point better.
There were some interesting questions asked too.

<a href="https://www.youtube.com/watch?v=D0dqC_3Bch8"><img src="https://i.ytimg.com/vi/D0dqC_3Bch8/mqdefault.jpg" class="wnr" alt="Webinar by Yegor Bugayenko"/></a>
Apr 8, 2015<br/>
&#35;1: **Objects vs Static Methods**<br/>
The first webinar, where we discussed the
difference between static methods and objects in object-oriented languages, like Java.
Of course, I'm in favor of objects :) The webinar is basically
motivated by this earlier post:
[_Composable Decorators vs. Imperative Utility Methods_]({% pst 2015/feb/2015-02-26-composable-decorators %}).
It took a bit longer than an hour.

