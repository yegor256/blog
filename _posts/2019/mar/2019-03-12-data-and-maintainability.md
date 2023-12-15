---
layout: post
title: "How Data Visibility Hurts Maintainability"
date: 2019-03-12
place: Moscow, Russia
tags: oop
description: |
  In object-oriented programming, the more visible
  and accessible object attributes are, the lower
  the maintainability of the code around it.
keywords:
  - object-oriented
  - object-oriented spaghetti code
  - spaghetti code
  - object-oriented maintainability
  - object-oriented readability
image: /images/2019/03/taboo.jpg
jb_picture:
  caption: Taboo (2017) by Tom Hardy, et al.
---

I've been writing [so much](/tags/oop.html) about object-oriented programming and its
[pitfalls]({% pst 2016/feb/2016-02-03-design-patterns-and-anti-patterns %}),
claiming that most of the design patterns and "good practices" which we are accustomed to
are actually [wrong and hurtful]({% pst 2014/sep/2014-09-10-anti-patterns-in-oop %}),
that I totally forgot to explain the bigger picture problem.
Someone [asked](https://www.yegor256.com/2016/11/21/naked-data.html#comment-3879044054)
me some time ago in the [blog post]({% pst 2016/nov/2016-11-21-naked-data %})
about "naked" data: What is the problem we are solving and why exactly does maintainability
suffer if we don't _encapsulate_ our data enough? Here is the answer.

<!--more-->

{% jb_picture_body %}

I re-read the first few pages of [_Elegant Objects, Volume 1_](/elegant-objects.html),
my book entirely dedicated to the problem of modern object-oriented programming
[flaws]({% pst 2016/aug/2016-08-15-what-is-wrong-object-oriented-programming %}),
and found out that maintainability is directly mentioned there:
"The main goal I'm trying to achieve with this writing is to
increase the _maintainability_ of your code," and then it also explains
that maintainability is "the time required for me to understand your code." You
[can argue with that](https://softwareengineering.stackexchange.com/questions/141005),
but the question remains: how does the lack of "true" object-orientation and proper encapsulation
hurt readability?

I don't know the exact answer, but here is my own version, derived from
my years of coding and suffering: _smaller scope_ is the key success factor of
better maintainability, and lack of encapsulation leads to a larger scope. You know what
[scope of visibility](https://en.wikipedia.org/wiki/Scope_%28computer_science%29)
is, right? Let's take this C code as an example:

```c
void print() {
  for (int i = 0; i < 10; ++i) {
    printf("%d * 2 = %d", i, i * 2);
  }
  for (int i = 0; i < 10; ++i) {
    printf("%d * 3 = %d", i, i * 3);
  }
}
```

There are two variables `i`, visible in two different `for` loops, two
different scopes of visibility. The _size_ of each scope is three lines of code.
How about this code, doing exactly the same:

```c
void print() {
  int i = 0;
  while (++i < 10) {
    printf("%d * 2 = %d", i, i * 2);
  }
  i -= 10;
  while (++i < 10) {
    printf("%d * 3 = %d", i, i * 3);
  }
}
```

Now, the scope of visibility of `i` is ten lines of code. The code works as well
as in the first snippet, but its maintainability is lower, because in order
to understand what's going on and how to modify it, I need more time. I need
to read a 10-line block of code, instead of two 3-line blocks.
I need to understand the entire method `print()` before I can start making any modifications.
I need to understand the lifetime algorithm of that poor `i` and why,
for example, it gets decremented by 10 instead of being reassigned to zero---this is
the surprise previous programmers left for me. Maybe they were not aware of
the existence of `for` loops?

It's obvious that the first snippet is better than the second one.
The question is how do we _make_ programmers write code the way the first
snippet is written and make the scope of each variable and function smaller?
We can teach them, write books for them, convince them, train them, or maybe
even punish them for larger scope and less readable code, but if the
programming language itself doesn't prevent these large scopes from happening,
nothing will really help. It's better to
[invent]({% pst 2016/nov/2016-11-29-eolang %})
a programming language or
an entire programming paradigm to make it harder, or impossible, to grow the scope.

For example, the largest scope you can imagine in C/C++, Python, Ruby and many other
modern languages is the [global]({% pst 2018/jul/2018-07-03-global-variables %})
one, for example here:

```c
int i = 0;
void print() {
  while (++i < 10) {
    printf("%d * 2 = %d", i, i * 2);
  }
}
```

Now the variable `i` is visible not only inside the function `print()` but
in ~~many~~ all other places of the application we develop. The scope
of visibility of `i` is the size of the entire code base. Needless to say that
makes the code of function `print()` [very unreadable]({% pst 2018/jul/2018-07-03-global-variables %}).
I simply can't know what value to expect in `i` when the execution of `print()` starts---I
have to go through the entire code base to find it out. If it's a small app, maybe
I will manage, but if it's a large piece of software, I will have big troubles.
So, how about we create a programming language, which will not allow global
variables? This will solve the problem. Programmers will have no technical
ability to define them and their scopes will inevitably be smaller.

{% quote I believe that objects were invented to force programmers to keep their scopes of visibility smaller. %}

I believe that objects [were invented]({% pst 2017/dec/2017-12-12-alan-kay-was-wrong %})
exactly to do that:
to _force_ programmers to keep their scopes of visibility smaller. Well, actually,
functions and sub-routines were invented for that too, but with a less
strong emphasis on the "force" part, since they could co-exist with code
parts that were not decomposed yet. To the contrary, objects were supposed to be first-class
citizens of an object world, communicating with objects only.

They were.

But then C++ showed up and ruined everything.

Let's try to introduce an object to our C snippet, the way
~~most~~ some C++ programmers would do it:

```cpp
class Idx {
public:
  int get() { return v; }
  void add(int a) { v += a; }
private:
  int v = 0;
}
```

And then:

```cpp
void print() {
  Idx i();
  while (i.get() < 10) {
    printf("%d * 2 = %d", i.get(), i.get() * 2);
    i.add(1);
  }
  i.add(-10);
  while (i.get() < 10) {
    printf("%d * 3 = %d", i.get(), i.get() * 3);
    i.add(1);
  }
}
```

What changed? Not much. Instead of a plain "scalar" variable `i` we have
an "object," which stores an integer value inside and provides a few methods
to access it and modify it. Did it help us minimize the scope? Not at all. Moreover,
the length of `print()` is now even a few lines longer. But now we have
an object and can call our code object-oriented!

This is how most of the "objects" are used nowadays, mostly thanks to C++: they are just data holders,
while the real users of the data are still outside of them. The object `Idx`
doesn't know anything about the real purpose of the data it holds. It doesn't
know that its `v` is used as a step counter and that it gets multiplied by
something before printing some text. `Idx` is a data holder, while the real
logic is outside of it.

The maintainability problem is not solved, the scope
is not smaller, the complexity of the code is not reduced. Moreover, it is
increased, because now, in order to understand how `print()` works, I have
to know what is inside the `Idx`. The object paradigm in this particular
example made a promise to take part of the problem and let me never worry about it,
but in reality it only made the problem larger, by giving me back two problems:
`print()` and `Idx`.

{% badge /images/2019/03/bjarne-stroustrup-book.jpg 96 https://amzn.to/2uMlANB %}

Why is this thanks to C++? Because C++ added object-orientation on top of C procedural
programming ideas, never even thinking about prohibiting some of them, to _force_
programmers to write objects the way they are supposed to be written: as black
boxes that encapsulate everything they need and never allow anyone from the
outside to even _know_ what's inside! C++ didn't even make an attempt to
switch the paradigm from procedures and variables to objects and methods.
[Bjarne Stroustrup](https://en.wikipedia.org/wiki/Bjarne_Stroustrup), the creator of C++, just gave programmers
methods and classes and said: "Use them, they are more convenient
than variables, ... or maybe not, sometimes, ... I don't know"
(I'm not sure it's his quote, but I believe that it's very close to what he
had in mind). Read [his book](https://amzn.to/2uMlANB), and you will see how many pages are dedicated to
the philosophy of object orientation and how many to the technicalities of
operators and statements.

A proper object-oriented solution would look different and would involve
true encapsulation, where data never "escapes" the borders of its owner. First,
here is how I would design `Idx`... well, I would rename it first and call it
`Line`:

```cpp
class Line {
public:
  Line(int m): mul(m) {};
  void print() {
    printf("%d * %d = %d", v, m, v * m);
  }
  bool next() {
    bool n = true;
    if (v < 10) {
      ++v;
    } else {
      n = false;
    }
    return n;
  }
private:
  int mul;
  int v = 0;
}
```

And now here is the code of `print()`:

```cpp
void print() {
  Line a(2);
  while (a.next()) { a.print(); }
  Line b(3);
  while (b.next()) { b.print(); }
}
```

As you see, `print()` doesn't have any access to the internal data of `Line`.
All `print()` can do is ask the `Line` to move forward and print itself. How exactly
this logic is implemented inside the `Line`---nobody knows and nobody wants to know.
Since we don't have any [getters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})
in the `Line`, we can't fetch the data out of it.

Since we can't get the data out, we can't build any logic in the `print()`. We
simply have nothing to work with, no data, no integers, no numbers. We can only
deal with objects, which don't trust us with their internals. We can only _politely_ ask
them to do something for us. The scope of `print()` is pretty small now and
very well _isolated_ from the internals of the `Line`. Proper encapsulation
helped us achieve that: by not exposing the internals of the `Line` we made
it impossible for anyone to invite themselves into its own scope. The `print()` simply can't
do anything with the data encapsulated by the `Line`.

Thus, the more visible and accessible the data is,
the lower the maintainability.

The very idea of object-oriented programming is based on encapsulation, which
doesn't mean just restricting the ability to modify object attributes from the
outside, but also prohibiting everyone from reading those attributes.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">What is wrong with this Java object? <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a> <a href="https://twitter.com/hashtag/java?src=hash&amp;ref_src=twsrc%5Etfw">#java</a><br><br>final class Time {<br>  int getHours();<br>  int getMinutes();<br>  int getSeconds();<br>}</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1109750701285142533?ref_src=twsrc%5Etfw">March 24, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
