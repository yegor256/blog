---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Inheritance Is a Procedural Technique for Code Reuse"
date: 2016-09-13
tags: oop
place: Palo Alto, CA
description: |
  Inheritance is generally considered a bad
  practice in object-oriented programming, but why
  exactly? Here we try to answer that question.
keywords:
  - inheritance in oop
  - inheritance is bad
  - inheritance over composition
  - inheritance vs composition
  - composition over inheritance
book: elegant-objects-2 5.7
translated:
  - Polish: https://bulldogjob.pl/news/288-dziedziczenie-to-technika-proceduralna
image: /images/2016/09/death-at-a-funeral.jpg
jb_picture:
  caption: Death at a Funeral (2007) by Frank Oz
---

We all know that
[inheritance](https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming))
is bad and that
[composition over inheritance](https://en.wikipedia.org/wiki/Composition_over_inheritance)
is a
[good idea](http://programmers.stackexchange.com/questions/65179),
but do we really understand why?
In ~~most~~ all articles
[I've found](https://www.google.com/search?q=inheritance+is+bad)
addressing this subject, authors have said that inheritance may be harmful
to your code, so it's better not to use it. This "better" part is what bothers me;
does it mean that sometimes inheritance makes sense?
I interviewed [David West](http://davewest.us/)
(the author of [Object Thinking](https://amzn.to/266oJr4), my favorite book about OOP)
a few weeks ago, and he said that inheritance should not exist in
object-oriented programming at all ([full video](https://www.youtube.com/watch?v=s-hdZZzMCac)).
Maybe Dr. West is right and we should totally forget `extends` keyword in Java,
for example?

<!--more-->

{% jb_picture_body %}

I think we should. And I think I know the reason why.

It's not because we introduce unnecessary coupling, as Allen Holub said in his
[Why extends is evil](https://www.javaworld.com/article/2073649/core-java/why-extends-is-evil.html) article.
He was definitely right, but I believe it's not the root cause of the problem.

"Inherit," as an English verb, has a number of meanings.
[This one](https://www.oxforddictionaries.com/us/definition/american_english/inherit)
is what inheritance inventors in [Simula](https://en.wikipedia.org/wiki/Simula) had in mind, I guess:
"Derive (a quality, characteristic, or predisposition) genetically from one's parents or ancestors."

{% youtube DjrA7_Uymok %}

Deriving a characteristic from another object is a great idea, and it's called
[subtyping](https://en.wikipedia.org/wiki/Subtyping).
It perfectly fits into OOP and actually enables
[polymorphism](https://en.wikipedia.org/wiki/Polymorphism_%28computer_science%29):
An object of class `Article` inherits all characteristics of objects in class `Manuscript`
and adds its own. For example, it _inherits_ an ability to print itself
and _adds_ an ability to submit itself to a conference:

```java
interface Manuscript {
  void print(Console console);
}
interface Article extends Manuscript {
  void submit(Conference cnf);
}
```

This is _subtyping_, and it's a perfect technique; whenever a
manuscript is required, we can provide an article and nobody will
notice anything, because type `Article` is a subtype of type `Manuscript`
([Liskov substitution principle](https://en.wikipedia.org/wiki/Liskov_substitution_principle)).

But what does _copying_ methods and attributes from a parent class to a child
one have to do with "deriving characteristics?" Implementation inheritance
is exactly that---copying---and it has nothing to do with the meaning
of the word "inherit" I quoted above.

Implementation inheritance is much closer to a different
[meaning](https://www.oxforddictionaries.com/us/definition/american_english/inherit):
"Receive (money, property, or a title) as an heir at the death of the previous holder."
Who is dead, you ask? An object is dead if it allows other objects to
_inherit_ its encapsulated code and data. This is implementation
inheritance:

```java
class Manuscript {
  protected String body;
  void print(Console console) {
    console.println(this.body);
  }
}
class Article extends Manuscript {
  void submit(Conference cnf) {
    cnf.send(this.body);
  }
}
```

Class `Article` _copies_ method `print()` and attribute `body`
from class `Manuscript`, as if it's not a
[living organism]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}), but rather a dead
one from which we can inherit its parts, "money, properties, or a title."

{% badge https://yegor256.github.io/bibliography/book-covers/west2004object.jpg 96 https://jttu.net/west2004object %}

Implementation inheritance was created as a mechanism for
[code reuse](https://en.wikipedia.org/wiki/Code_reuse),
and it doesn't fit into OOP at all. Yes, it may look convenient in the
beginning, but it is absolutely wrong in terms of [object thinking](https://amzn.to/266oJr4).
Just like [getters and setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}),
implementation inheritance turns
objects into _containers_ with data and procedures. Of course, it's
convenient to copy some of those data and procedures to a new object
in order to avoid code duplication. But this is not what objects are about. They
are not dead; they are alive!

Don't _kill_ them with inheritance!

Thus, I think inheritance is bad because it is a _procedural_ technique for _code reuse_.
It comes as no surprise that it introduces all the problems people have been talking about for years.
Because it is procedural!
That's why it doesn't fit into object-oriented programming.

By the way, we [discussed](https://gitter.im/yegor256/elegantobjects?at=57bcd2e4cd00bdff6e745584)
this problem in our
[Gitter chat](https://gitter.im/yegor256/elegantobjects) (it's dead already)
a week ago, and that's when it became obvious to me what exactly is
wrong with inheritance. Take a look at our discussion there.
