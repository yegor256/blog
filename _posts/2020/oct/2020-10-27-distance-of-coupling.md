---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "New Metric: the Distance of Coupling"
date: 2020-10-27
place: Moscow, Russia
tags: oop
description: |
  Encapsulation is a great idea, which doesn't work in practice;
  measuring the coupling distance between objects seems to be
  a better alternative.
keywords:
  - coupling
  - java coupling
  - coupling distance
  - distance between objects
  - java coupling distance
image: /images/2020/10/chacun-sa-vie.jpg
jb_picture:
  caption: Chacun sa vie (2017) by Claude Lelouch
---

[Encapsulation](https://en.wikipedia.org/wiki/Encapsulation_%28computer_programming%29),
as you know, is one of the
[four key principles](https://www.indeed.com/career-advice/career-development/what-is-object-oriented-programming)
in [object-oriented programming](https://en.wikipedia.org/wiki/Object-oriented_programming).
Encapsulation, according to [Grady Booch et al.](https://amzn.to/3o7RnDZ),
is "the process of hiding all the secrets of an object
that do not contribute to its essential characteristics."
Practically speaking, it's about those `private`
attributes that we use in Java and C++: they are not visible to the users of
our objects, that's why they can't be modified or even read.
Booch et al. believe that the purpose of encapsulation is
"to provide explicit barriers among different abstractions,"
which leads to "a clear separation of concerns."
However, does it really work as planned? Do we really have
explicit barriers between objects? Let's see.

<!--more-->

{% jb_picture_body %}

First, I'm not the first and not the only one asking this question.
[David West](https://amzn.to/266oJr4) much earlier said that "in most ways,
encapsulation is a discipline more than a real barrier," and
that "seldom is the integrity of an object protected in any absolute sense".
In practice, "it is up to the user of an object to respect that object's encapsulation.''
Indeed, let's take a look at the class `Temperature` from my blog post
about [naked data]({% pst 2016/nov/2016-11-21-naked-data %}):

```java
class Temperature {
  private int t;
  public int getT() { return this.t; }
  public void setT(int t) { this.t = t; }
}
```

Can we say that the attribute `t` is truly _encapsulated_?
Technically, it is: it's impossible
to modify it directly via the dot notation.
Simply put, we can't do this:

```java
Temperature x = new Temperature();
x.t = 10;
```

And we can't even do this:

```java
int y = x.t;
```

However, we can do exactly the same via the
[getter]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}) `getT()`
and the setter `setT()`.
Thus, the designer of the class `Temperature` gives us the ability to access
its attribute, but indirectly, through
[getters and setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}).
I would say
that the principle of encapsulation is being violated here, and, I'm sure,
[Allen Holub](https://www.infoworld.com/article/2072302/more-on-getters-and-setters.html)
would agree with me. What is the solution? The [article]({% pst 2016/nov/2016-11-21-naked-data %})
about naked data
proposed the use of the [TellDontAsk principle](http://media.pragprog.com/articles/jan_03_enbug.pdf)
and that we should get rid of the getter:

```java
class Temperature {
  private int t;
  public String toString() {
    return String.format("%d F", this.t);
  }
}
```

Now the class `Temperature` doesn't allow us to read its attribute `t`.
Instead, we can only _tell_ it to prepare a string presentation of the temperature
and return that back to us. Maybe not exactly a classic example of the "tell" paradigm,
since some data is coming back, but now it looks much better than before. The beauty
of this refactoring is less [coupling]({% pst 2018/sep/2018-09-18-fear-of-coupling %})
between the client and the object. With
the getter (or direct access to the attribute via dot notation), the client
was able to retrieve the numeric value of the temperature and recalculate it
in Fahrenheit, assuming that it was in Celsius. With the `String` being
returned the client would not do this. The string would only be used as a final
product, not modifiable. Or maybe not?

What if the client does this:

```java
Temperature x = new Temperature();
String txt = x.toString();
String[] parts = txt.split(" ");
int t = Integer.parseInt(parts[0]);
```

How does it look now? Isn't this a violation of encapsulation?
The result of `toString()` is not treated
as it is supposed to be treated. Not as a solid string, but as data with
some internal structure, which is _known_ to the client. The _knowledge_ the
client possesses about the output is the key problem here. The client knows too
much and uses this knowledge for its own benefit: to deconstruct the
data and manipulate the result.

Can we really prohibit the client from doing this? There is no such feature
in any programming language, to my knowledge. When the output of the method
is delivered to the client, the client is allowed to do whatever is needed
with it. This is that lack of respect to encapsulation, if I correctly
understood Dr. West. And we are not even discussing
the [Reflection API](https://docs.oracle.com/javase/tutorial/reflect/), which
would allow us to take the `t` out of `Temperature` without even calling any methods.

{% quote Encapsulation is not an explicit barrier, it exists for as long as we have the desire to respect it. %}

Thus, encapsulation is _not_ an explicit barrier. It exists for as long as we have
the desire to respect it. If we don't, nothing can stop us from abusing an
object in any way we want. And even `private` attribute modifiers won't help.
Moreover, they will only create an illusion of encapsulation, while in reality
everyone is able to do whatever they feel is suitable for their business case.

I have a proposal, though, which may help us make
encapsulation more explicit.

What if we had the ability to control what's happening with the data
and objects _after_ we return them to clients? What if we could prevent the client
from doing a `split()` on the output of the `toString()` method? We could do this at compile time, I think,
by going through all the code and checking how _far_ the moments of interaction with our
objects are from the places where they were returned. In the example above,
the _distance_ is two: 1) first, we do the `split`, 2) second, we do the `parseInt()`.
Larger applications will have bigger numbers, of course.

{% youtube fJvUTlPHSvU %}

It seems that we can use this distance number as a metric for coupling between objects
in the entire app. The larger the number (or the mean of all numbers), the
worse the design: in good design we are not supposed to take something
out of a method and then do some complex processing. We are, according to
the TellDontAsk principle mentioned above, supposed to let our objects do the work and only
return a quick summary of it. The distance metric will tell us exactly that:
how many times, and by how much, we violated the principle of loose coupling.

Would you be interested in creating such an analyzer for, say, Java code?
