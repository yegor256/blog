---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "How Much Cohesion Is Enough?"
date: 2019-11-19
place: Moscow, Russia
tags: oop
description: |
  There are two extreme cases: all methods in a single
  large class or a large number of small classes; which
  one do you prefer?
keywords:
  - srp principle
  - abstraction layers
  - separation of concerns
  - oop layers
  - oop design
image: /images/2019/11/irreversible.jpg
jb_picture:
  caption: Irréversible (2002) by Gaspar Noé
---

Which one is better: `books.del(42)` or `books.book(42).del()`?
I do both and I rarely can tell which one is better. The first option
is shorter, while the second one is more object-oriented. The first
option is more difficult to extend, while the second one is more
verbose and requires more lines of code, which means a higher chance
of making mistakes. Which one do you prefer?

<!--more-->

{% jb_picture_body %}

Either one will work, of course, but the question is which design
is more object-oriented? It seems to depend on the size of the
object `books`. If it's small, there's no need to get the book first, we can
just delete it right there:

```java
interface Books {
  void create(String title);
  void delete(int id);
  void rename(int id, String title);
}
```

However, if it's larger, it's better to get the `book` first:

```java
interface Book {
  void delete(); // Here!
  void rename(String title);
}
interface Books {
  void create(String title);
  int total();
  Iterable<Book> all();
  Book all(String query);
  Book book(int id); // Here!
}
```

Is there an explicit hard line between these two? Is there
a [strict rule]({% pst 2017/dec/2017-12-19-srp-is-hoax %})
or maybe the ambiguous question "Is this class large enough already?"
should be answered every time by a vote?

Let's try to give two extreme answers:
1) never large enough, and 2) always large enough.

  * If a class is _never_ ready for extracting any parts of it
    and turning them into new objects, we will end up with a very big
    class, with many attributes, methods, and long lists of arguments
    in almost all of them.

  * If a class is _always_ good enough for extractions,
    we will end up with [many small classes]({% pst 2017/feb/2017-02-28-too-many-classes %}),
    methods with almost no
    arguments, and ... a better object-oriented design.

{% youtube eeXdDvIVu-Y %}

The common denominator is [_cohesion_](https://en.wikipedia.org/wiki/Cohesion_%28computer_science%29).

Highly cohesive classes include attributes and methods that are related to
each other, while non-cohesive classes include whatever their developers
decided to add, even though some elements may not really belong together.
The first answer will give us a class with a very low cohesion, while
the second one will produce a large amount of highly cohesive small
classes.

{% quote You question the cohesion of your class once you see more than seven methods or more than four attributes. %}

Thus, the second option is better? Yes, it is. Smaller classes,
higher cohesion, ... but more opportunities to lose focus and spread
functionality around too many places. "All methods in one object"
is a much more popular design, even though it's less cohesive, exactly
because it's easier to create: just put everything in one place and
call it a day. Later, of course, maintainability problems will show up.

The bottom line is that there is no exact distinction between the right and
the wrong design in this case. We just have to do our best to keep classes highly
cohesive by decreasing the amount of methods in each of them. If there are
just a few methods, no need to extract the `Book`, but once the amount of methods
gets bigger, the `Book` is a perfect candidate for a new entity to
define.

How many methods is OK?

[Nobody knows](https://softwareengineering.stackexchange.com/questions/104406/),
but I would suggest you question the cohesion of your class once you see
more than seven methods or more than four attributes. Also, start thinking
about refactoring when any of your methods (except constructors) accepts more than
two arguments.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Which design is better? <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1198599871495835649?ref_src=twsrc%5Etfw">November 24, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
