---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "The Fall of JavaScript"
date: 2025-12-28
place: Istanbul, Turkey
tags: oop
description: |
  JavaScript was an elegant prototype-based class-free language
  until TypeScript and ES6 classes ruined it.
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
In 2008, Brendan made a tragic mistake: he [donated] $1,000 in support of Californian anti-gay marriage [law].
In 2014, he joined [Mozilla] as a CEO and the crowd remembered his anti-diversity gesture.
He had to [step down] and founded Brave Software, the developer of the [Brave] browser.
Somewhere around that time they started to kill JavaScript.
Still doing it pretty good, thanks to recent [ECMAScript] updates and [TypeScript].

<!--more-->

{% jb_picture_body %}

In the JavaScript created 30 years ago, objects were primitive associative arrays of properties.
Either data, a function, or another object may be attached to a property of an object.
Let's see what Brendan [said][popularity-post] about JS in 2008:

> I'm happy that I chose Scheme-ish first-class functions and Self-ish prototypes as the main ingredients.

First-class functions mean that it's possible to use a function as a value assignable to a variable.
And then he [concluded][popularity-post] (pay attention, it's C not C++):

> Yet many curse it, including me. I still think of it as a quickie love-child of C and Self.

[Self], which he refers to a few times, is a prototype-based object-oriented language
  designed by [David Ungar] and [Randall Smith] in [Xerox PARC], then [Stanford University], and then [Sun Microsystems].
Self doesn't have classes, unlike Java or C++.
Instead, it only has objects.
To create a new object in Self we make a copy of an existing object, known as prototype, and then modify some of its slots (attributes).

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
Book b;
b.rename("Object Thinking");
```

Types (classes in C++ and interfaces in Java) and [type annotations]({% pst 2025/aug/2025-08-17-type-annotations %}) are helpful---to the compiler.
To us humans they are a burden.
They require us to do the work of the compiler.
We have to pollute our code with messages like: "This object `b` is of type `Book`, please remember."
The compiler must be smart enough to understand it without our hints.

This is a debatable topic though.
Some believe that type annotations help programmers better understand the code and make fewer mistakes.
I'm also in favor of fewer mistakes, but would rather expect the compiler to infer types automatically, without my annotations.
If I do `b.rename()` and `b` is known to be a car instead of a book, I would expect the compiler to figure this out on its own and refuse to compile.

Anyway, JavaScript was designed as a prototype-based dynamically typed language with a minimalistic syntax that resembles Java.
It worked perfectly fine until the industry decided to "fix" it.

In 2008, [Mozilla] and others [proposed][es4-story] ECMAScript 4, which included classes, modules, and other features.
[Microsoft] took an [extreme position][es4-fight], refusing to accept any part of ES4.
Chris Wilson, Microsoft's Internet Explorer platform architect, [criticized][es4-fight] ES4 for trying to introduce too many changes.
Brendan Eich [accused][es4-fight] Wilson of spreading falsehoods and playing political games.
ES4 was [abandoned][es4-story], and classes were dropped.

Then, in 2012, Microsoft created [TypeScript], a JavaScript with type annotations and classes.
Since classes weren't in the standard, Microsoft made their own.

Finally, in 2015, [ECMAScript 6] added classes (among other features) to the JavaScript specification.
Many ES4 features, including classes, were [revived][es4-story] in a "maximally minimal" form.
The crowd of Java/C++ developers got what they wanted.

Let's hear what [Douglas Crockford], the creator of [JSON] and [JSLint], [said][douglas-said] in 2014:

> Class-free programming is JavaScript's contribution to humanity.

Unfortunately, not anymore.
It looks like the developers of recent versions of JS believe in something else.
Or maybe they don't want to make a contribution to humanity anymore.
Maybe they just want to make the crowd happy.

Type annotations and classes don't match with the concept of class-free object-based programming of JavaScript.
They came from Java or C++ but don't fit in.
Some programmers may find them helpful, but only because they are used to seeing them in other languages.
JavaScript is not Java, even though the names look similar.

Java, with its
  [classes]({% pst 2016/sep/2016-09-20-oop-without-classes %}),
  [implementation inheritance]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %}),
  and
  [static methods]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}),
  is OOP for dummies.
It's object-oriented programming for those who, according to [Douglas Crockford][douglas-said], don't know what
  [object-oriented programming]({% pst 2016/aug/2016-08-15-what-is-wrong-object-oriented-programming %}) is.
JavaScript, on the other hand, is a member of conceptually solid OO languages, like [Smalltalk] and Self.
Blending Java flavors into JavaScript only ruins the flavor of the latter.

It's sad to see how a once straight object-centric language paradigm turned into a diversity of unmatchable and suboptimal features.

P.S. JavaScript is still a great language if you ignore classes and type annotations.
When I write in JavaScript, I don't use them.
Look at the code in the [yegor256/jo] repository.
It illustrates the [Junior Objects](/junior-objects.html) book of mine.
I'm proud of this code.

[Brendan Eich]: https://github.com/BrendanEich
[JavaScript]: https://en.wikipedia.org/wiki/JavaScript
[10 days]: https://exploringjs.com/es5/ch04.html
[Netscape]: https://en.wikipedia.org/wiki/Netscape
[step down]: https://blog.mozilla.org/en/mozilla/brendan-eich-steps-down-as-mozilla-ceo/
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
[Self]: https://selflanguage.org/
[duck typing]: https://en.wikipedia.org/wiki/Duck_typing
[virtual table]: https://en.wikipedia.org/wiki/Dispatch_table
[es4-story]: https://auth0.com/blog/the-real-story-behind-es4/
[es4-fight]: https://www.theregister.com/2008/08/15/adobe_microsoft_ecma_javascript/
[ECMAScript 6]: https://262.ecma-international.org/6.0/
[yegor256/jo]: https://github.com/yegor256/jo
[Smalltalk]: https://en.wikipedia.org/wiki/Smalltalk
[JSON]: https://en.wikipedia.org/wiki/JSON
[JSLint]: https://github.com/jslint-org/jslint
