---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Prefixed Naming"
date: 2020-03-03
place: Moscow, Russia
tags: oop java
description: |
  Using prefixes in class names in order to locate
  them easily in a large type hierarchy seems to be
  an effective naming convention.
keywords:
  - class names
  - class naming
  - oop naming
  - best naming in oop
  - java class names
image: /images/2020/03/buffalo-66.jpg
jb_picture:
  caption: Buffalo'66 (1998) by Vincent Gallo
---

If you look at the source code of
[Takes](https://github.com/yegor256/takes) or
[Cactoos](https://github.com/yegor256/cactoos) for the first time,
you most probably, like many others, will be triggered by the naming
convention, which implies that most class names have two-letter prefixes:
[`BkSafe`](https://www.javadoc.io/static/org.takes/takes/1.9.1/org/takes/http/BkSafe.html),
[`RqFake`](https://www.javadoc.io/static/org.takes/takes/1.9.1/org/takes/rq/RqFake.html),
[`RsWithStatus`](https://www.javadoc.io/static/org.takes/takes/1.9.1/org/takes/rs/RsWithStatus.html),
[`TkGzip`](https://www.javadoc.io/static/org.takes/takes/1.9.1/org/takes/tk/TkGzip.html),
and so on. To be honest,
I haven't seen a single Java developer who would be comfortable with this
convention at first sight. I have, however, seen many who are in love with it
now. This article is for those who are interested in moving from the
first category to the second one.

<!--more-->

{% jb_picture_body %}

Any software package, module, library, or framework of a decent size has
a large amount of classes. Well, it [has to have]({% pst 2017/feb/2017-02-28-too-many-classes %}).
If it doesn't, there is definitely a problem with its design.
So there's always a problem of how to name those classes. The easiest and most
obvious approach is the one used in Java and its flagship framework
[Spring](https://spring.io/):
make class names as descriptive and as long as possible. Here are
[some examples](https://gist.github.com/thom-nic/2c74ed4075569da0f80b):

  * `ObjectFactoryCreatingFactoryBean`
  * `SimpleBeanFactoryAwareAspectInstanceFactory`
  * `TransactionAwarePersistenceManagerFactoryProxy`
  * `AbstractAnnotationConfigDispatcherServletInitializer`

This is garbage, isn't it?

A much more sophisticated and time-consuming way of naming classes is
by the [DDD paradigm](https://en.wikipedia.org/wiki/Domain-driven_design),
which suggests using _nouns_ after _entities_ in the real world, like port, car,
book, story, user, socket, and so on. Identifying the right entities
is a big challenge for a software architect. A bad one would just resort
to `ConnectionFactoryUtils` or `DefaultListableBeanFactory` and call it a day.
A more professional one may spend hours or days, but will eventually come up with
something more _domain-driven_.

Let's assume you are the latter and you managed to find the right nouns.
How many of them will be out there in your domain? A few dozen, I believe. Even
if the application is rather complex, you won't have more than 30 entities
in its problem domain. However, as was [mentioned above]({% pst 2017/feb/2017-02-28-too-many-classes %}),
the amount of
classes will be much larger, sometimes over a thousand or more. Thus, the
second problem you will face is how to name classes which are
"entities with specifiers." For example, you have a port and also a random port
and a TCP port, and a port already closed, and a port not yet opened, and so on.

There will be nouns with _adjectives_: random port, closed port, opened port,
TCP port, broken port, and so on. How do you name those classes? Maybe, as simply
as this: `RandomPort`, `OpenedPort`, `ClosedPort`, `TcpPort`.
Maybe, but I think it's better to turn the common `Port` part into a common prefix `Pt`
for all classes:

  * `PtRandom`
  * `PtOpened`
  * `PtClosed`
  * `PtTcp`

The only disadvantage of this approach is that newcomers may have no idea
what the `Pt` prefix means. Indeed, it may take some time (a few minutes) to learn it. However,
the advantage is greater: once you learn all the prefixes that exist
in the application (and there will be just a few of them, since the amount
of entities in the domain is pretty limited), you can immediately understand
which part of the type hierarchy the class belongs to (this one is from
[Takes](https://github.com/yegor256/takes)):

{% plantuml %}
Request <|-- RqChunk
Request <|-- RqGreedy
Request <|-- RqMultipart
Back <|-- BkParallel
Back <|-- BkSafe
Take <|-- TkFailure
Take <|-- TkGzip
Take <|-- TkMeasured
{% endplantuml %}

Once you see the `Rq` prefix you immediately understand that you are dealing with
an implementation of the
[`org.takes.Request`](https://www.javadoc.io/doc/org.takes/takes/latest/org/takes/Request.html) interface. Not the
[`ServletRequest`](https://docs.oracle.com/javaee/6/api/javax/servlet/ServletRequest.html)
from [JDK](https://en.wikipedia.org/wiki/Java_servlet),
not [`HttpRequest`](https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/http/HttpRequest.html)
from Spring,
and not [`Request`](https://square.github.io/okhttp/3.x/okhttp/okhttp3/Request.html)
from [OkHttp](https://square.github.io/okhttp/).
You know that it's the `Request` from Takes!

Thus, by using short prefixes instead of nouns we add clarity to the code.
We remove the noise of repeated usage of the same noun over and over again and
make referencing easier. Each prefix is a unique locator of a class in
the type hierarchy.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Which class name you would use: SynchronizedDatabaseConnection or SncConn?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1239065472491978752?ref_src=twsrc%5Etfw">March 15, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
