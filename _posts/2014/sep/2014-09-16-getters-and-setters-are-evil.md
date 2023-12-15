---
layout: post
title: "Getters/Setters. Evil. Period."
date: 2014-09-16
tags: oop
categories: best jcg
description: |
  Getters and setters is a terrible anti-pattern in
  object-oriented programming and should be avoided.
  This article explains why.
keywords:
  - object design
  - getters and setters
  - getters and setters are evil
  - why getters and setters are evil
  - getters and setters is an anti-pattern
translated:
  - Japanese: http://tbd.kaitoy.xyz/2015/07/22/getters-setters-evil/
  - Russian: http://info.javarush.ru/translation/2014/12/15/%D0%93%D0%B5%D1%82%D1%82%D0%B5%D1%80%D1%8B-%D0%A1%D0%B5%D1%82%D1%82%D0%B5%D1%80%D1%8B-%D0%97%D0%BB%D0%BE-%D0%98-%D1%82%D0%BE%D1%87%D0%BA%D0%B0-.html
  - Polish: https://bulldogjob.com/news/215-gettery-i-settery-to-czyste-zlo-kropka
  - Spanish: https://medium.com/@arcanefoam/getters-setters-perversos-punto-fe889b690332
social:
  - reddit: https://www.reddit.com/r/programming/comments/2y7jcb/getterssetters_evil_period/
book: elegant-objects-1 3.5
image: /images/2014/09/fish-called-wanda.png
jb_picture:
  caption: A Fish Called Wanda (1988) by Charles Crichton
---

There is an old debate, started in 2003 by Allen Holub
in this [Why getter and setter methods are evil](http://www.javaworld.com/article/2073723/core-java/why-getter-and-setter-methods-are-evil.html)
famous article, about whether getters/setters is an
[anti-pattern]({% pst 2016/feb/2016-02-03-design-patterns-and-anti-patterns %})
and should be avoided or if it is something we inevitably need in object-oriented
programming. I'll try to add my two cents to this discussion.

The gist of the following text is this: getters and setters is
a terrible practice and those who use it can't be excused.
Again, to avoid any misunderstanding, I'm not saying that get/set should be avoided when possible.
No. I'm saying that you should _never_ have them near your code.

<!--more-->

{% jb_picture_body %}

Arrogant enough to catch your attention? You've been using
that get/set pattern for 15 years and you're a respected Java architect?
And you don't want to hear that nonsense from a stranger? Well, I understand
your feelings. I felt almost the same when I stumbled upon
[Object Thinking](https://amzn.to/266oJr4)
by David West, the best book about object-oriented programming I've read so far.
So please. Calm down and try to understand while I try to explain.

## Existing Arguments

{% badge /images/2014/09/object-thinking-by-david-west.png 96 https://amzn.to/266oJr4 %}

There are a few arguments against "accessors"
(another name for getters ~~and setters~~), in an object-oriented world.
All of them, I think, are not strong enough. Let's briefly go
through them.

**Tell, Don't Ask**
Allen Holub says, "Don't ask for the information
you need to do the work; ask the object that has the information
to do the work for you."

**Violated Encapsulation Principle**
An object can be teared apart by other objects, since they
are able to inject any new data into it, through setters. The object simply
can't encapsulate its own state safely enough, since anyone
can alter it.

{% youtube WSgP85kr6eU %}

**Exposed Implementation Details**
If we can get an object out
of another object, we are relying too much on the first object's implementation
details. If tomorrow it will change, say, the type of that result,
we have to change our code as well.

All these justifications are reasonable, but they are missing the main point.

## Fundamental Disbelief

Most programmers believe that an object is a data structure with methods.
I'm quoting [Getters and Setters Are Not Evil](http://java.dzone.com/articles/getters-and-setters-are-not),
an article by Bozhidar Bozhanov:

> But the majority of objects for which people generate getters
and setters are simple data holders.

This misconception is the consequence of a huge misunderstanding!
Objects are not "simple data holders." Objects are _not_ data structures
with attached methods. This "data holder" concept came to object-oriented programming
from procedural languages, especially C and COBOL.
I'll say it again: an object is _not_ a set of data elements
and functions that manipulate them. An object is _not_ a data entity.

What is it then?

## A Ball and A Dog

In true object-oriented programming, objects are
[living creatures]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}),
like you and me. They are living organisms,
with their own behavior, properties and a life cycle.

Can a living organism have a setter?
Can you "set" a ball to a dog? Not really.
But that is exactly what the following piece of software is doing:

```java
Dog dog = new Dog();
dog.setBall(new Ball());
```

How does that sound?

Can you get a ball from a dog? Well, you probably can,
if she ate it and you're doing surgery. In that case, yes, we can "get" a ball from a dog. This is what
I'm talking about:

```java
Dog dog = new Dog();
Ball ball = dog.getBall();
```

Or an even more ridiculous example:

```java
Dog dog = new Dog();
dog.setWeight("23kg");
```

Can you imagine this transaction in the real world?

{% youtube F4N25kZ2zQU %}

Does it look similar to what you're writing every day? If yes,
then you're a procedural programmer. Admit it. And this is what
David West has to say about it, on page 30 of his book:

> Step one in the transformation of a successful procedural developer
into a successful object developer is a lobotomy.

Do you need a lobotomy? Well, I definitely needed one and received it, while
reading West's [Object Thinking](https://amzn.to/266oJr4).

## Object Thinking

Start thinking like an object and you will immediately rename those methods.
This is what you will probably get:

```java
Dog dog = new Dog();
dog.take(new Ball());
Ball ball = dog.give();
```

Now, we're treating the dog as a real animal, who can take a ball from us
and can give it back, when we ask. Worth mentioning is that the
dog can't give `NULL` back. Dogs simply don't know what `NULL` is.
Object thinking immediately eliminates
[NULL references]({% pst 2014/may/2014-05-13-why-null-is-bad %})
from your code.

Besides that, object thinking will lead to object immutability, like in
the "weight of the dog" example. You would re-write that like this instead:

```java
Dog dog = new Dog("23kg");
int weight = dog.weight();
```

The dog is an immutable living organism, which doesn't allow anyone from
the outside to change her weight, or size, or name, etc. She can tell, on
request, her weight or name. There is nothing wrong with public
methods that demonstrate requests for certain "insides" of an object. But these
methods are not "getters" and they should never have the "get" prefix. We're
not "getting" anything from the dog. We're not getting her name. We're asking
her to tell us her name. See the difference?

We're not talking semantics here, either. We are differentiating the procedural
programming mindset from an object-oriented one. In procedural programming,
we're working with data, manipulating them, getting, setting,
and deleting when necessary. We're in charge, and the data is just a passive component.
The dog is nothing to us---it's just a "data holder."
It doesn't have its own life. We are free
to get whatever is necessary from it and set any data into it.
This is how C, COBOL, Pascal and many other procedural languages work(ed).

On the contrary, in a true object-oriented world, we treat objects like
living organisms, with their own date of birth and a moment of death---with their own identity and habits, if you wish. We can ask a dog to
give us some piece of data (for example, her weight), and she may
return us that information. But we always remember that the dog is
an active component. She decides what will happen after our request.

That's why, _it is conceptually incorrect to have any methods starting
with `set` or `get` in an object_. And it's not about breaking
[encapsulation]({% pst 2016/nov/2016-11-21-naked-data %}), like
many people argue. It is whether you're thinking like an object
or you're still writing COBOL in Java syntax.

PS. Yes, you may ask,---what about JavaBeans, JPA, JAXB, and many other
Java API-s that rely on the get/set notation? What about Ruby's built-in
[feature](http://ruby-doc.org/docs/ruby-doc-bundle/UsersGuide/rg/accessors.html)
that simplifies the creation of accessors? Well, all of that is our
[misfortune]({% pst 2013/dec/2013-12-29-proto %}).
It is much easier to stay in a primitive world of procedural COBOL than to
truly understand and appreciate the beautiful world of true objects.

PPS. Forgot to say, yes, dependency injection via setters is also
a terrible anti-pattern. About it, in
[one of the next posts]({% pst 2014/oct/2014-10-03-di-containers-are-evil %}).

PPPS. Here is what I'm suggesting to use instead of getters:
[printers]({% pst 2016/apr/2016-04-05-printers-instead-of-getters %}).

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Getters-and-setters is ...</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1256977935451422723?ref_src=twsrc%5Etfw">May 3, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
