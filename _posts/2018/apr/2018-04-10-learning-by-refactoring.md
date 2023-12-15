---
layout: post
title: "Nine Steps of Learning by Refactoring"
date: 2018-04-10
place: Moscow, Russia
tags: programming
description: |
  The best way to learn foreign or legacy code is
  to refactor it; here is a list of nine steps I go through
  when the Java code is new to me.
keywords:
  - refactoring
  - learning by refactoring
  - refactoring and learning
  - refactoring in java
  - refactoring benefits
image: /images/2018/04/dom-hemingway.jpg
jb_picture:
  caption: Dom Hemingway (2013) by Richard Shepard
---

I [was asked](https://twitter.com/yegor256/status/977799130100781056)
on Twitter recently how is it possible to refactor
if one doesn't understand how the code works.
I [replied](https://twitter.com/yegor256/status/977966601227112449)
that it is "learning by refactoring." Then I tried to Google it
and found [nothing](https://www.google.ru/search?q="learning+by+refactoring").
I was surprised. To me refactoring seems to be the most effective and
obvious way to study the source code. Here is how I usually do it,
in nine object-oriented steps.

<!--more-->

{% jb_picture_body %}

According to Wikipedia,
[code refactoring](https://en.wikipedia.org/wiki/Code_refactoring) is
"the process of restructuring existing computer code---changing the
factoring---without changing its external behavior." The goal
of refactoring is to make code more readable and suitable for modifications.

{% badge /images/2018/04/refactoring.jpg 96 https://amzn.to/2E7i17H %}

Martin Fowler in his famous book [Refactoring: Improving the Design of Existing Code](https://amzn.to/2E7i17H)
suggested a number of refactoring techniques which help making
code simpler, more abstract, more readable, etc. Some of them
are rather
[questionable]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})
from an object-oriented standpoint---like
[Encapsulate Field](https://en.wikipedia.org/wiki/Field_encapsulation),
for example---but most of them are valid.

Here is what I'm usually doing when I don't know the code, but need to modify it.
The techniques are sorted by the order of complexity, starting with
the easiest one.

## Remove IDE Red Spots

When I open the source code of [Cactoos](http://www.cactoos.org)
in IntelliJ IDEA, using my
custom [`settings.jar`](/bin/settings.jar), I see something like this:

{% figure /images/2018/04/cactoos-listing.jpg 600 %}

When I open the source code of, say,
[Spring Boot](https://github.com/spring-projects/spring-boot),
I see something like this
(it's [`o.s.b.ImageBanner`](https://github.com/spring-projects/spring-boot/blob/v2.0.0.RELEASE/spring-boot-project/spring-boot/src/main/java/org/springframework/boot/ImageBanner.java)
randomly picked out of a thousand other classes that look very similar):

{% figure /images/2018/04/springboot-listing.jpg 600 %}

See the difference?

The first thing I do, when I see someone else's code, is to make it "red spots free"
for my IDE. Most of those red spots are easy to remove,
while others will take some time to refactor.
While doing that I learn a lot about the ~~crap~~ program I have
to deal with.

## Remove Empty Lines

I [wrote]({% pst 2014/nov/2014-11-03-empty-line-code-smell %})
some time ago that empty lines inside method bodies are bad things.
They are obvious indicators of redundant complexity. Programmers tend
to add them to their methods in order to simplify things.

This is a method from the [Apache Maven](https://github.com/apache/maven) code base
(class [`RepositoryUtils`](https://github.com/apache/maven/blob/maven-3.5.3/maven-core/src/main/java/org/apache/maven/RepositoryUtils.java)
picked at random, but almost all other classes are formatted the same way):

{% figure /images/2018/04/maven-listing.jpg 600 %}

Aside from being "all red" their code is full of empty lines.
Removing them will make code more readable and will also help me
understand how it works. Bigger methods will need refactoring, since
without empty lines they will become almost completely unreadable. Hence,
I compress, understand, and make them smaller mostly by breaking
them down into smaller methods.

## Make Names Shorter

I'm generally in favor of short one-noun names for variables and one-verb names
for methods. I [believe]({% pst 2015/jan/2015-01-12-compound-name-is-code-smell %})
that longer "compound" names are an indicator of unnecessary code complexity.

For example, I found this method
`registerServletContainerInitializerToDriveServletContextInitializers` (69 characters!)
in the [`o.s.b.w.e.u.UndertowServletWebServerFactory`](https://github.com/spring-projects/spring-boot/blob/v2.0.0.RELEASE/spring-boot-project/spring-boot/src/main/java/org/springframework/boot/web/embedded/undertow/UndertowServletWebServerFactory.java)
class in Spring Boot.
I wonder why the author skipped the `couldYouPlease` prefix
and the `otherwiseThrowAnException` suffix.

Jokes aside, such long method names clearly demonstrate that the code
is too complex and can't be explained with a simple `register` or even
`registerContainer`. It seems that there are many different containers,
initializers, servlets, and other creatures that need to be registered
somehow. When I join a project and see a method with this name I'm getting
ready for big trouble.

Making names shorter is the mandatory refactoring step I take when
starting to work with foreign or legacy code.

## Add Unit Tests

Most classes (and methods) come without any documentation, especially
if we are talking about closed-source commercial code. We are lucky if
the classes have more or less descriptive names and are small and
cohesive.

{% badge /images/2015/04/book-goos.jpg 96 https://amzn.to/1PBpoDT %}

{% badge /images/2015/04/book-legacy.jpg 96 https://amzn.to/1SdcZ8M %}

However, instead of documentation I prefer to deal with unit tests. They
explain the code much better and prove that it works. When I don't
understand how the class works, I try to write a unit test for it. In most
cases it's not possible, for many reasons. In such a case I try to apply
everything I learned from
[_Working Effectively With Legacy Code_](https://amzn.to/1SdcZ8M)
by Michael Feathers
and
[_Growing Object-Oriented Software, Guided by Tests_](https://amzn.to/1PBpoDT)
by Steve Freeman and Nat Pryce.
Both books are pretty much focused on this very problem: what to do
when you don't know what to do, testing-wise.

## Remove Multiple Returns

I [wrote earlier]({% pst 2015/aug/2015-08-18-multiple-return-statements-in-oop %})
that the presence of multiple `return` statements in a single method is not something
object-oriented programming should encourage. Instead, a method must
always have a single exit point, just like those functions in
functional programming.

Look at this method from the
[`o.s.b.c.p.b.Binder`](https://github.com/spring-projects/spring-boot/blob/v2.0.0.RELEASE/spring-boot-project/spring-boot/src/main/java/org/springframework/boot/context/properties/bind/Binder.java)
class from Spring Boot (there are many similar examples there, I picked this one randomly):

{% figure /images/2018/04/binder-listing.jpg 600 %}

There are five `return` statements in such a small method. For object-oriented
code that's too much. It's OK for procedural code, which I also write
sometimes. For example, [this Groovy script](https://github.com/zerocracy/farm/blob/master/src/main/resources/com/zerocracy/stk/pm/in/orders/start_order_if_assigned_in_github.groovy)
of ours has five `return` keywords too:

{% figure /images/2018/04/farm-listing.jpg 600 %}

But this is Groovy and it's not a class. It's just a procedure, a script.

Refactoring and removing multiple `return` statements definitely helps
make code cleaner. Mostly because without them it's necessary to use
deeper nesting of `if/then/else` statements and then the code starts to look
ugly, unless you break it down into smaller pieces.

## Get Rid of NULLs

NULLs [are evil]({% pst 2014/may/2014-05-13-why-null-is-bad %}),
it's a well-known fact. However, they are still everywhere. For example,
there are 4,100 Java files in Spring Boot v2.0.0.RELEASE and 243K LoC,
which include the `null` keyword 7,055 times. This means approximately one `null`
for every 35 lines.

To the contrary, [Takes Framework](http://www.takes.org), which I founded a few years ago,
has 771 Java files, 154K LoC, and 58 `null` keywords. Which is roughly
one `null` per 2,700 lines. See the difference?

The code gets cleaner when you remove NULLs, but it's not so easy to do.
Sometimes it's even impossible. That's why we still have those 58 cases
of `null` in Takes. We simply can't remove them, because they are coming
from the JDK.

## Make Objects Immutable

As I [demonstrated]({% pst 2014/nov/2014-11-07-how-immutability-helps %})
some time ago,
[immutability]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %})
helps keep objects smaller. Most classes
that I see in the foreign code I deal with are mutable. And large.

If you look at any artifact analyzed by [jpeek](http://www.jpeek.org),
you will see that in most of them approximately 80% of classes
are mutable. Moving from mutability to immutability is a big challenge
in object-oriented programming, which, if resolved, leads to better
code.

This refactoring step of make things immutable is purely profitable.

## Remove Static

Static methods and attributes are convenient,
if you are a procedural programmer. If your
code is object-oriented, they
[must go away]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}). In Spring Boot there
are 7,482 `static` keywords, which means one for every 32 lines of code.
To the contrary, in Takes we have 310 `static`-s, which is
one every 496 lines.

Compare these numbers with the statistics about NULL and you will see
that getting rid of `static` is a more complex task.

## Apply Static Analysis

This is the final step and the most complex one. It's complex because
I configure static analyzers to their maximum potential or even more.
I'm using [Qulice](http://www.qulice.com),
which is an aggregator of
[Checkstyle](http://checkstyle.sourceforge.net/),
[PMD](http://pmd.sourceforge.net/), and
[FindBugs](http://findbugs.sourceforge.net/).
Those guys are strong by themselves, but Qulice makes them
[even stronger]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}),
adding a few dozen custom-made checks.

The principle I use for static analysis is 0/100. This means that either
the entire code base is clean and there are no Qulice complaints, or it's
dirty. There is nothing in the middle. This is not a very typical way
of looking at static analysis. Most programmers are using those tools
just to collect "opinions" about their code. I'm using them as guides
for refactoring.

Check out this video, which demonstrates the amount of complaints Qulice
gives for the `spring-boot-project/spring-boot` sub-module in Spring Boot
(the video has no end, since I lost my patience in waiting):

<iframe width="560" height="315" src="https://www.youtube.com/embed/DDtAKIyuRMA?rel=0&amp;controls=0&amp;showinfo=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

When Qulice says that everything is clean, I consider the code base fully
ready for maintenance and modifications. At this point the refactoring
is done.

