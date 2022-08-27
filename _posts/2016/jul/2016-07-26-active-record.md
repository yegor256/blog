---
layout: post
title: "ActiveRecord Is Even Worse Than ORM"
date: 2016-07-26
place: Palo Alto, CA
tags: oop
description: |
  ActiveRecord is a popular design pattern that seemed
  to be better than ORM, though from an object thinking standpoint
  it is even worse.
keywords:
  - ActiveRecord
  - ActiveRecord ORM
  - ActiveRecord design pattern
  - ActiveRecord java
  - ActiveRecord anti-pattern
social:
  - dzone: https://dzone.com/articles/activerecord-is-even-worse-than-orm
book: elegant-objects-2 6.5
image: /images/2016/07/en-duva-satt-pa-engren.jpg
jb_picture:
  caption: En duva satt på en gren och funderade på tillvaron (2014) by Roy Andersson
---

You probably remember what [I think]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %})
about ORM, a very popular design pattern. In a nutshell,
it encourages us to turn objects into
[DTOs]({% pst 2016/jul/2016-07-06-data-transfer-object %}), which are
anemic, passive, and not objects at all. The consequences are usually dramatic---the entire programming paradigm shifts from object-oriented to procedural.
I've tried to explain this at a [JPoint](https://www.youtube.com/watch?v=aER4uwyFbqQ) and
[JEEConf](https://www.youtube.com/watch?v=63tS3HNmhiE) this year. After
each talk, a few people told me that what I'm suggesting is called
[ActiveRecord](https://en.wikipedia.org/wiki/Active_record_pattern) or
[Repository](https://msdn.microsoft.com/en-us/library/ff649690.aspx) patterns.

<!--more-->

{% jb_picture_body %}

Moreover, they claimed that ActiveRecord actually solves the problem
I've found in ORM. They said I should explain in my talks that
what I'm offering (SQL-speaking objects) already exists and has a name:
ActiveRecord.

I disagree. Moreover, I think that ActiveRecord is even worse than ORM.

{% quote What's even worse in ActiveRecord is that it hides the fact that objects are data containers. %}

ORM consists of two parts: the session and
[DTOs]({% pst 2016/jul/2016-07-06-data-transfer-object %}), also known as "entities."
The entities have no functionality; they are just primitive containers for the
data transferred from and to the session. And that is what the problem is---objects don't encapsulate but rather expose data. To understand why this is wrong and why it's
against the object paradigm, you can read
[here]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}),
[here]({% pst 2016/apr/2016-04-05-printers-instead-of-getters %}),
[here]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %}),
[here]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}), and
[here]({% pst 2016/jul/2016-07-06-data-transfer-object %}).
Now, let's just agree that it's very wrong and move on.

What solution is ActiveRecord proposing? How is it solving the problem?
It moves the engine into the _parent class_, which all our entities inherit from.
This is how we were supposed to save our entity to the database in the ORM
scenario (pseudo-code):

```java
book.setTitle("Java in a Nutshell");
session.update(book);
```

And this is what we do with an ActiveRecord:

```java
book.setTitle("Java in a Nutshell");
book.update();
```

The method `update()` is defined in book's parent class and uses
book as a _data container_. When called, it fetches data
from the container (the book) and updates the database. How is it
different than ORM? There is absolutely no difference. The book
is still a container that knows nothing about SQL and any persistence
mechanisms.

What's even worse in ActiveRecord, compared to ORM, is that it _hides_
the fact that objects are data containers. A book, in the second snippet,
_pretends_ to be a [proper object]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}),
while in reality it's just a dumb data bag.

I believe this is what misguided those who were saying
that my SQL-speaking objects concept is exactly the same as the ActiveRecord
design pattern (or Repository, which is almost exactly the same).

No, it's not.
