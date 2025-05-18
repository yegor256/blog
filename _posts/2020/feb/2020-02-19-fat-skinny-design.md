---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Fat vs. Skinny Design"
date: 2020-02-19
place: Moscow, Russia
tags: oop java
description: |
  Type hierarchies may be designed in two extreme
  approaches, making them either very extendable and
  reusable, or not.
keywords:
  - oop design
  - class vs interface
  - fat design
  - skinny design
  - type hierarchy
image: /images/2020/02/owning-mahowny.jpg
jb_picture:
  caption: Owning Mahowny (2003) by Richard Kwietniowski
---

It seems that type/class hierarchies in OOP may be designed in two
extreme ways: either with full encapsulation of data in mind; or with just a few
interfaces making raw data visible, and letting classes deal with it, parse it,
and turn it into smaller data elements. You may be surprised, but I'm
suggesting the second option is more elegant. It seems to me that we don't
lose object orientation, but rather gain a lot of flexibility, reusability, testability,
and so on.

<!--more-->

{% jb_picture_body %}

Take a look at this (let's call it _fat_ and I will explain why later):

```java
interface Article {
  Head head();
}
interface Head {
  Author author();
  String title();
}
interface Author {
  String name();
  String email();
}
```

To obtain the name of the author we do:

```java
// It is stored in PostgreSQL (that's why the Pg
// prefix) and retrieves everything using SQL
Article a = new PgArticle();
String name = a.head().author().name();
```

Visually, this design may look like this (in UML):

{% plantuml style="width:75%" %}
allowmixing
Interface Article
Interface Head
Interface Author
Article o-> Head : "head()"
Head o-> Author : "author()"
Author : String name()
Author : String email()
Article <|-- PgArticle
Head <|-- PgHead
Author <|-- PgAuthor
PgArticle o-> PgHead
PgHead o-> PgAuthor
component PostgreSQL
PgArticle ..> PostgreSQL
PgHead ..> PostgreSQL
PgAuthor ..> PostgreSQL
{% endplantuml %}

Now, let's compare it with an alternative design (which is much less
_fat_ than the previous one, I would even call it _skinny_):

```java
interface Article {
  String head();
}
class TxtHead {
  private final Article article;
  String author();
  String title();
}
class TxtAuthor {
  private final Head head;
  String name();
  String email();
}
```

Here, in order to obtain the name of the author we have to extract
the head as a `String`, extract the author as a `String`, and then
extract the name as a `String`:

```java
Article a = new PgArticle();
String head = a.head();
String author = new TxtHead(head).author();
String name = new TxtAuthor(author).name();
```

Visually in UML, it looks like this:

{% plantuml style="width:75%" %}
allowmixing
Interface Article
TxtAuthor *- TxtHead
TxtHead *- Article
Article : String head()
TxtHead : String author()
TxtAuthor : String name()
TxtAuthor : String email()
Article <|-- SqlArticle
component PostgreSQL
SqlArticle ..> PostgreSQL
{% endplantuml %}

There were three interfaces in the first design, while the second one
has only one interface and two classes. I call the first one "fat" because
it returns interfaces, which already implement the functionality we are
looking for, and we don't need to cover them with additional decorators
or adapters. Its hierarchy of _three_ interfaces is rich enough to give
us everything we need. That's why it's fat. The second one, on other hand
is pretty _skinny_, there is only one interface, which returns us plain
text data, which we have to parse on our own. We need to _dress it up_.

It seems that the skinny design is better, for a number of reasons:

* **Extendability**.
  The skinny design is definitely easier to extend. In order
  to extract some new information from the author we just need to add a new
  method to the class `TxtAuthor`. We don't need to re-design the entire hierarchy
  of interfaces and to modify all their implementations. We deal with pure data,
  which is managed and parsed later, in decorators, adapters, and other
  supplementary [smart]({% pst 2016/apr/2016-04-26-why-inputstream-design-is-wrong %}) classes.

* **Cohesion**.
  The skinny design is definitely more cohesive, since everything that is
  related to the management of PostgreSQL data stays in one class `SqlArticle`. To the contrary,
  the fat design spreads the functionality among many classes and, thanks to that,
  makes the entire class-set more difficult to maintain.

* **Reusability**.
  Class `TxtAuthor` can definitely be used in any other place, where
  parsing of an author's information is required, while class `PgAuthor` is
  only suitable for one particular case: fetching and parsing
  PostgreSQL-related data.

* **Testability**.
  Obviously, the skinny design is much easier to test, because mocking
  a single interface is a much simpler task than mocking the entire
  hierarchy. To test the class `TxtAuthor` we just pass some fake text to
  its constructor and check how it works. To test the class `PgAuthor` we
  would need to do much more, including running a fake instance of a PostgreSQL server.

Everything said above is true for both 1) from-PostgreSQL data retrievals
and 2) to-PostgreSQL data manipulations. Of course, manipulations may
require many methods to exist in `SqlArticle`, which will make the skinny
design look ugly, and it will become obvious that some of these methods
have to be moved to lower-level classes/interfaces. This only demonstrates
that it's not always possible to make skinny design with a single interface,
like in the example above. Sometimes we simply _have_ to make it more fat.

{% youtube rsWrgxm8ktU %}

However, there is one serious concern related to the skinny design: it lets
the raw [naked]({% pst 2016/nov/2016-11-21-naked-data %})
data jump out of `SqlArticle`, which is against the very idea
of object-oriented programming, as
[we know]({% pst 2016/nov/2016-11-21-naked-data %}). Indeed, if we let
`TxtHead` do the parsing, we may lose some interesting PostgreSQL-related
context, which is available only inside `SqlArticle`. We don't want
complex data parsing to happen far away from the place where the data
is born. We want everything data-related to happen where the data lives:
inside `SqlArticle`.

This is a valid concern, but letting PostgreSQL-related information (like connection
settings) move from `PgArticle` to `PgHead` and then to `PgAuthor` is an even
larger violation of the data encapsulation principle.

In real-life situations, of course, it's not possible to imagine pure
one-interface skinny designs. They will all be fat to some extent. My suggestion, though,
is to try to make designs less fat, letting interface users
dress them up however they like. This suggestion is very close to
what I said earlier about [smart classes]({% pst 2016/apr/2016-04-26-why-inputstream-design-is-wrong %}),
but this time the principle is broader.
