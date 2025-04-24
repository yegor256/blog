---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Alan Kay Was Wrong About Him Being Wrong"
date: 2017-12-12
place: Moscow, Russia
tags: java
description: |
  Alan Kay said in 1998 that object-oriented programming
  should have been called message-oriented programming instead;
  I disagree.
keywords:
  - alan kay oop
  - alan kay about oop
  - message oriented programming
  - messages oop
  - alan kay oop definition
image: /images/2017/12/rain-man.jpg
jb_picture:
  caption: Rain Man (1988) by Barry Levinson
buffer:
  - "Alan Kay, inventor of objects, says that the very term \"object\" is misleading and a more appropriate one would be \"messaging\""
  - "The key in making great and growable systems is much more to design how its modules communicate rather than what their internal properties and behaviors should be."
---

From time to time someone asks me what I think about what
[Alan Kay](https://en.wikipedia.org/wiki/Alan_Kay), the father of OOP,
the designer of [Smalltalk](https://en.wikipedia.org/wiki/Smalltalk),
the first object-oriented language,
[said](http://lists.squeakfoundation.org/pipermail/squeak-dev/1998-October/017019.html)
in 1998 about OOP. He literally said that the very
term "object" was misleading and a more appropriate one would be "messaging."
Here is what I think.

<!--more-->

{% jb_picture_body %}

I believe that there are two orthogonal means of interaction between objects:
messaging and composition. Let's say, we have a point and a canvas:

```java
Point p = new Point(x, y);
Canvas canvas = new Canvas();
```

This is how messaging would look:

```java
p.printTo(canvas);
```

The problem with messaging is that it keeps objects on the same
level of abstraction. They communicate
as equal and independent "modules," sending
[data messages]({% pst 2016/nov/2016-11-21-naked-data %}) to each other.
Even though they look object-oriented, the entire communication pattern
is very procedural. We try to encapsulate as much as we can inside a single
object, however inevitably still having to expose a lot of its data in order to
be able to "connect" it with other objects.

We turn objects into "little computers," as [some books](https://amzn.to/2npiZZQ) refer to them. They
expect data to come in, they process the data, and return back some new data.
The maintainability problem is not really solved with this approach---we
still have to deal with a lot of data, remembering its semantic outside of
the objects. In other words, there is no true encapsulation.

On the other hand, this is how composition would look instead:

```java
Point p2 = new PrintedOn(p, canvas);
```

Every time we need objects to communicate we create a bigger object that
encapsulates more primitive ones, letting them interact inside. Of course,
the data will also go from object to object, but that will happen
inside a bigger object. We can even make the encapsulator
and the encapsulated "friends," as [I suggested before]({% pst 2016/dec/2016-12-20-can-objects-be-friends %}),
to make that interaction more transparent and avoid data exposure through
[getters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}) or
even
[printers]({% pst 2016/apr/2016-04-05-printers-instead-of-getters %}).

Let me
[quote](http://lists.squeakfoundation.org/pipermail/squeak-dev/1998-October/017019.html)
Alan Kay again:

> The key in making great and growable systems is much more to design how
  its modules communicate rather than what their internal properties
  and behaviors should be.

It seems to me that he means _modules_, which are not objects. These are
different things. Modules are elements of the architecture, while objects
are elements of the design. These are two different levels. At the level of
architecture we obviously need messages and Kay's statement is perfectly correct.
However, at the level of design we need composable structures,
to increase maintainability and messaging is not what can help us achieve
this goal.

Thus, I believe Alan Kay was right when he invented objects, called them
objects, and gave their programming style the "object-oriented" title.
