---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "How to Handle the Problem of Too Many Classes"
date: 2017-02-28
place: Odessa, Ukraine
tags: oop java
description: |
  I often hear that having too many classes in an
  object-oriented design is a problem; let's investigate
  when this is likely to happen and how to handle it correctly.
keywords:
  - too many classes
  - OOP classes
  - class names in OOP
  - naming classes in OOP
  - many classes
image: /images/2017/02/el-dia-de-la-bestia.jpg
jb_picture:
  caption: El día de la bestia (1995) by Álex de la Iglesia
---

During nearly [every presentation](/talks.html) in which I explain
[my view]({% pst 2016/jul/2016-07-14-who-is-object %})
of [object-oriented programming]({% pst 2016/aug/2016-08-15-what-is-wrong-object-oriented-programming %}),
there is someone who shares a comment like this:
"If we follow your advice, we will have so many small classes."
And my answer is always the same: "Of course we will, and that's great!"
I honestly believe that even if you can't consider having "a lot of classes" a virtue,
you can't call it a drawback of any truly object-oriented code either. However,
there may come a point when classes become a problem;
let's see when, how, and what to do about that.

<!--more-->

{% jb_picture_body %}

There were a number of "rules" previously mentioned that, if applied,
would obviously lead to a large number of classes, including:
a) all public methods [must be]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}) declared in interfaces;
b) objects must not have more than four attributes (Section 2.1 of [Elegant Objects](/elegant-objects.html));
c) static methods are [not allowed]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %});
d) constructors [must be]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}) code-free;
e) objects must expose fewer than five public methods (Section 3.1 of [Elegant Objects](/elegant-objects.html)).

{% quote Types in OOP constitute your vocabulary, which explains the world around your code. %}

The biggest concern, of course, is maintainability: "If, instead of 50 longer classes,
we had 300 shorter ones, then the code would be way less readable."
This will most certainly happen if you design them wrong.

Types (or classes) in OOP constitute your [_vocabulary_](https://en.wikipedia.org/wiki/Vocabulary),
which explains the world around your code---the world your code lives in.
The richer the vocabulary, the more powerful your code.
The more types you have, the better you can understand and explain the world.

If your vocabulary is big enough, you will say something like:

> Read the book that is on the table.

With a much smaller vocabulary, the same phrase would sound like:

> Do it with the thing that is on that thing.

Obviously, it's easier to read and understand the first phrase. The same
occurs with types in OOP: the more of them you have at your disposal,
the more expressive, bright, and readable your code is.

Unfortunately, Java and many other languages are not designed with
this concept in mind. Packages, modules, and namespaces don't really help,
and we usually end up with names like
`AbstractCookieValueMethodArgumentResolver` (Spring)
or
`CombineFileRecordReaderWrapper` (Hadoop).
We're trying to pack as many semantics into class names as possible so
their users won't doubt for a second. Then we're trying to put as many
methods into one class as possible to make life easier for users; they will
use their IDE hints to find the right one.

This is anything but OOP.

If your code is object-oriented, your classes must be small, their
names must be nouns, and their method names must be just one word. Here is
what I do in my code to make that happen:

**Interfaces are nouns**.
For example, [`Request`](https://javadoc.io/static/org.takes/takes/1.1/org/takes/Request.html),
[`Directive`](https://javadoc.io/static/com.jcabi.incubator/xembly/0.22/org/xembly/Directive.html), or
[`Domain`](https://github.com/yegor256/jare/blob/0.8.4/src/main/java/io/jare/model/Domain.java).
There are no exceptions. Types (also known as
[interfaces](https://docs.oracle.com/javase/tutorial/java/concepts/interface.html) in Java)
are the core part of my vocabulary; they have to be nouns.

**Classes are prefixed**.
My classes [always]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %})
implement interfaces. Thanks to that, I can say they always _are_
requests, directives, or domains. And I always want their users to remember that.
Prefixes help. For example,
[`RqBuffered`](https://javadoc.io/static/org.takes/takes/1.1/org/takes/rq/RqBuffered.html)
is a buffered request,
[`RqSimple`](https://javadoc.io/static/org.takes/takes/1.1/org/takes/rq/RqSimple.html)
is a simple request,
[`RqLive`](https://javadoc.io/static/org.takes/takes/1.1/org/takes/rq/RqLive.html)
is a request that represents a "live" HTTP connection,
and
[`RqWithHeader`](https://javadoc.io/static/org.takes/takes/1.1/org/takes/rq/RqWithHeader.html)
is a request with an extra header.

An alternative approach is to use the type name as the central part of the
class name and add a prefix that explains implementation details.
For example,
[`DyDomain`](https://github.com/yegor256/jare/blob/0.8.4/src/main/java/io/jare/dynamo/DyDomain.java)
is a domain that persists its data in DynamoDB.
Once you know what that `Dy` prefix is for, you can easily understand what
[`DyUser`](https://github.com/yegor256/jare/blob/0.8.4/src/main/java/io/jare/dynamo/DyUser.java)
and
[`DyBase`](https://github.com/yegor256/jare/blob/0.8.4/src/main/java/io/jare/dynamo/DyBase.java)
are about.

In a medium-sized application or a library, there will be as many as 10 to 15
prefixes you will have to remember, no more. For example, in the
[Takes Framework](https://www.takes.org), there are 24,000 lines of code,
410 Java files, and 10 prefixes: `Bc`, `Cc`, `Tk`, `Rq`, `Rs`, `Fb`,
`Fk`, `Hm`, `Ps`, and `Xe`. Not so difficult to remember what they mean, right?

Among all [240 classes](https://javadoc.io/static/org.takes/takes/1.1/allclasses-frame.html),
the longest name is
[`RqWithDefaultHeader`](https://javadoc.io/static/org.takes/takes/1.1/org/takes/rq/RqWithDefaultHeader.html).

I find this approach to class naming rather convenient. I used it
in these open source projects (in GitHub):
[yegor256/takes](https://github.com/yegor256/takes) (10 prefixes),
[yegor256/jare](https://github.com/yegor256/jare) (5 prefixes),
[yegor256/rultor](https://github.com/yegor256/rultor) (6 prefixes), and
[yegor256/wring](https://github.com/yegor256/wring) (5 prefixes).
