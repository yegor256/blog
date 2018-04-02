---
layout: post
title: "Learning by Refactoring"
date: 2018-04-10
place: Moscow, Russia
tags: refactoring
description: |
  ...
keywords:
  - refactoring
  - learning by refactoring
  - refactoring and learning
  - refactoring in java
  - refactoring benefits
image: /images/2017/12/
jb_picture:
  caption:
---

I [was asked](https://twitter.com/yegor256/status/977799130100781056)
on Twitter recently how is it possible to refactor
if one doesn't understand how the code works.
I [replied](https://twitter.com/yegor256/status/977966601227112449)
that it is "learning by refactoring." Then tried to Google it
and found [nothing](https://www.google.ru/search?q="learning+by+refactoring").
I am surprised. To me refactoring seems to be the most effective and
obvious way to study the source code.

<!--more-->

{% jb_picture_body %}

[Code refactoring](https://en.wikipedia.org/wiki/Code_refactoring) is the
process of restructuring existing computer code&mdash;changing the
factoring&mdash;without changing its external behavior. The goal
of refactoring is to make code more readable and suitable for modifications.

{% badge /images/2018/04/refactoring.jpg 96 https://amzn.to/2E7i17H %}

Martin Fowler in his famous book [Refactoring: Improving the Design of Existing Code](https://amzn.to/2E7i17H)
suggested a number of refactoring techniques which help making
code simpler, more abstract, more readable, etc. Some of them
are rather
[questionable]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})
from an object-oriented standpoint, like
[Encapsulate Field](https://en.wikipedia.org/wiki/Field_encapsulation),
for example, but most of them are valid.

Here is what I'm usually doing the code I don't know, but need to modify it.
The techniques are sorted by the order of complexity. Let's start with
the simplest.

## Remove IDE Red Spots

When I open the source code of Cactoos in IntelliJ IDEA, using my
custom [`settings.jar`](/bin/settings.jar), I see something like this:

{% figure /images/2018/04/cactoos-listing.jpg 600 %}

When I open the source code of, say,
[Spring Boot](https://github.com/spring-projects/spring-boot), I see something like this
(it's [`o.s.b.ImageBanner`](https://github.com/spring-projects/spring-boot/blob/v2.0.0.RELEASE/spring-boot-project/spring-boot/src/main/java/org/springframework/boot/ImageBanner.java)
randomly picked out of a thousand of other
classes that look very similar):

{% figure /images/2018/04/springboot-listing.jpg 600 %}

See the difference?

The first thing I do when I see someone's code, I make it red spots free. Most
of them are easy to remove, while others will take some time to refactor.
While doing that I learn a lot about the <del>crap</del> program I have
to deal with.

## Remove Empty Lines

I wrote some time ago that empty lines inside method bodies are bad things.
They are obvious indicators of

This is a method from [Apache Maven](https://github.com/apache/maven) code base
(class [`RepositoryUtils`](https://github.com/apache/maven/blob/maven-3.5.3/maven-core/src/main/java/org/apache/maven/RepositoryUtils.java)
picked randomly, almost all other clases are formatted same way):

{% figure /images/2018/04/maven-listing.jpg 600 %}

Aside from being "all red" their code is full of empty lines.
Removing them will make code more readable and will also help
understand how it works. Bigger methods will need refactoring, since
without empty lines they will become almost absolutely unreadable.

## Make Names Shorter

I'm general in favor of short one-noun names for variables and one-verb
for methods. I [believe]({% pst 2015/jan/2015-01-12-compound-name-is-code-smell %})
that longer "compound" names are an indicator of unnecessary code complexity.



## Apply Static Analysis

## Document Classes

## Remove Multiple Returns

## Make Objects Immutable

## Get Rid of NULLs

## Remove Static Methods
