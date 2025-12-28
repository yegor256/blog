---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "TypeScript"
date: 2025-12-28
place: Istanbul, Turkey
tags: oop
description: |
  ...
keywords:
  - TypeScript
  - TypeScript is ugly
  - TypeScript vs javascript
  - TypeScript types
  - TypeScript is clumsy
image: /images/2025/12/platoon.jpg
jb_picture:
  caption: Platoon (1986) by Oliver Stone
---

In 1995, [Brendan Eich] was hired by [Netscape] and asked to create a language for their HTML browser.
Rumors say, he designed Mocha in [10 days], later renamed to [LiveScript], and then to [JavaScript].
It was [planned][popularity-post] to make it similar to [Scheme], a LISP-syntax language.
Instead, to [please][popularity-post] the crowd of C++/Java coders, it was made syntactically similar to Java.
In 2008, Brendan has made a tragic mistake: he [donated] $1,000 in support of Californian anti-gay marriage [law].
In 2014, he joined [Mozilla] as a CEO and the crowd rememembered him his anti-diversity gesture.
He had to [step down] and found Brave Software, the delover of the [Brave] brower.
Somewhere around that time they started to kill JavaScript.
They are doing pretty good, thanks to recent [ECMAScript] updates and [TypeScript].
By "they" I mean the crowd, not homosexuals specifically, of course.

<!--more-->

{% jb_picture_body %}

Let's see what Brendan [said][popularity-post] about JS in 2008:

> I'm happy that I chose Scheme-ish first-class functions and Self-ish prototypes as the main ingredients.

First-class functions means that it's possible use a function as a value assignable to a variable.
And then he concluded (pay attention, it's C not C++):

> Yet many curse it, including me. I still think of it as a quickie love-child of C and Self.

[Self], which he refers to a few times, is an prototype-based object-oriented programming language
  designed by [David Ungar] and [Randall Smith] in [Xerox PARC], then [Stanford University], and then [Sun Microsystems].
Self doesn't have classes, such as Java or C++.
Instead, it only has objects.
To create a new object we take a copy of an existing object, known as prototype, and then modify some slots (attributes).

In Self, objects don't have types: all method calls are dispatched in runtime.
For example, we ask a book to rename itself:

```
book rename: "Object Thinking".
```

The `rename` is the method of the `book` that we call with a single string argument.
The computer doesn't know anything about the `book` until it's time to call the `rename` method.
Obviously, such a [duck typing] has its performance drawback.
Every `rename` leads to a search in a [virtual table] of `book`.
To the contrary, C++, where types are known in compile time, can dispatch `rename()` instantly:

```
Book b();
b.rename("Object Thinking");
```

Types (classes in C++ and interfaces in Java) and [type annotations] are helpful---to the compiler.
They are not helpful to us humans because they require us to do the work of the compiler.
We have to polute our code with such messages: "This object `b` is of type `Book`, please remember."
The compiler must be smart enough to understand it without our hints.

This is a debatable topic though.
Some believe that type annotations help programmers better understand the code and make less mistakes.
I'm also of favor of less mistakes, but would rather expect the compiler to do this work for me.
If I do `b.rename()` and `b` is known to be a car instead of a book, I would expect the compiler to refuse to compile.

Anyway, JavaScript was designed as a prototype-based dynamically typed language with a minimalistic syntax that resembles Java.

In 2012, [Microsoft] created TypeScript.
It was JavaScript with type annotations, supposedly making our lives easier.

Then, in 2015, ECMAScript 6 added classes to the JavaScript specification.
Supposedly to make JavaScript more intuitive to those already traumatized by Java/C++ class hierachies.
Let's hear what Douglas Crockford, one of the developers of JS, [said][douglas-said] in 2014:

> Class-free programming is JavaScript's contribution to humanity.

Unfortunately, not anymore.
The developers of recent versions of JS believe in something else.
Or maybe they don't want to make a contribution to humanity anymore.
Maybe they just want to make the crowd happy.

It's sad to see how once straight object-centric language paradim turns into a diversity of unmatchable and suboptimal features.

[Brendan Eich]: https://github.com/BrendanEich
[JavaScript]: https://en.wikipedia.org/wiki/JavaScript
[10 days]: https://exploringjs.com/es5/ch04.html
[Netscape]: https://en.wikipedia.org/wiki/Netscape
[steps down]: https://blog.mozilla.org/en/mozilla/brendan-eich-steps-down-as-mozilla-ceo/
[donated]: https://www.theguardian.com/technology/2014/apr/02/controversial-mozilla-ceo-made-donations-right-wing-candidates-brendan-eich
[Brave]: https://brave.com/
[Mozilla]: https://www.mozilla.org/
[Scheme]: https://www.scheme.org/
[LiveScript]: https://stackoverflow.com/questions/2018731
[ECMAScript]: https://en.wikipedia.org/wiki/ECMAScript
[TypeScript]: https://www.typescriptlang.org/
[law]: https://en.wikipedia.org/wiki/2008_California_Proposition_8
[popularity-post]: https://brendaneich.com/2008/04/popularity/
[David Ungar]: https://en.wikipedia.org/wiki/David_Ungar
[Randall Smith]: https://www.linkedin.com/in/randallsmith1/
[Xerox PARC]: https://en.wikipedia.org/wiki/PARC_(company)
[Stanford University]: https://www.stanford.edu/
[Sun Microsystems]: https://en.wikipedia.org/wiki/Sun_Microsystems
[douglas-said]: https://www.youtube.com/watch?v=PSGEjv3Tqo0&t=360s
[Douglas Crockford]: https://www.crockford.com/pronto.html
[Microsoft]: https://www.microsoft.com/
