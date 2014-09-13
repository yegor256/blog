---
layout: post
title: "Getters/Setters. Evil. Period."
date: 2014-09-15
tags: oop anti-pattern
description:
  Getters and setters is a terrible anti-pattern in
  object-oriented programming and should be avoided,
  the article explains why
keywords:
  - object design
  - getters and setters
  - getters and setters are evil
  - why getters and setters are evil
  - getters and setters is an anti-pattern
---

There is an old debate, started in 2003 by Allen Holub
in this [Why getter and setter methods are evil](http://www.javaworld.com/article/2073723/core-java/why-getter-and-setter-methods-are-evil.html)
famous article, about whether getters/setters is an anti-pattern
and should be avoided or is it something we inevitably need in object-oriented
programming. I'll try to add my few cents to this discussion.

The gist of the following text is this: getters and setters is
a terrible practice and those who use it can't be excused.
Again, to avoid any misunderstanding, I'm not saying that get/set should be avoided when possible.
No. I'm saying that you should **never** have them near your code.

<!--more-->

{% badge http://img.yegor256.com/2014/09/object-thinking-by-david-west.jpg 96 http://www.amazon.com/gp/product/0735619654/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0735619654&linkCode=as2&tag=yegor256com-20&linkId=NQQHJZPHOKM6BTCT %}

Arrogant enough to catch your attention? You're using
that get/set pattern for 15 years and you're a respected Java architect?
And you don't want to hear that nonsense from a stranger? Well, I understand
your feelings. I felt almost the same when I stumbled upon
[Object Thinking](http://www.amazon.com/gp/product/0735619654/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0735619654&linkCode=as2&tag=yegor256com-20&linkId=NQQHJZPHOKM6BTCT)
by David West, the best book about object-oriented programming I've read so far.
Please, calm down and try to understand what I try to explain.

## Existing Arguments

There already were a few arguments against "accessors"
(another pen name for getters and setters), in an object-oriented world.
All of them, I think, are not strong enough. Let's briefly go
through them.

**Ask, Don't Tell**.
Allen Holub says, "Don't ask for the information
you need to do the work; ask the object that has the information
to do the work for you".

**Violated Encapsulation Principle**.
An object can be teared apart by other objects, since they
are able to inject any new data into it, through setters. The object simply
can't encapsulate its own state safely enough, since anyone
can alter it.

**Exposed Implementation Details**.
If we can get an object out
of another object, we rely too much on the first one's implementation
details. If tomorrow it will change, say, the type of that result,
we have to change our code as well.

All these justifications are reasonable, but they are missing the main point.

## Fundamental Misbelief

Most programmers believe that an object is a data structure with methods.
I'm quoting [Getters and Setters Are Not Evil](http://java.dzone.com/articles/getters-and-setters-are-not)
article by Bozhidar Bozhanov:

> But the majority of objects for which people generate getters
and setters are simple data holders

That's the problem of a huge misunderstanding!
Objects are not "simple data holders". Objects are **not** data structures
with attached methods. This "data holder" concept came to object-oriented programming
from a procedural one, especially C and COBOL.
Again and again, an object is **not** a set of data elements
and functions that manipulate them. An object is **not** a data entity.

What is it then?

## A Ball and A Dog

In true object-oriented programming, objects are
living creatures, like me and you. They are living organisms,
with their own behaviour, properties and a life cycle.

Can a living organism have a setter?
Can you "set" a ball to a dog? But this is
exactly what that piece of software is doing:

{% highlight java %}
Dog dog = new Dog();
dog.setBall(new Ball());
{% endhighlight %}

How does it sound?

Can you get a ball from a dog? Well, you probably can,
if she ate it before and you're doing a surgery in order to get it out
of her. In that case, yes, we can "get" a ball from a dog. This is what
I'm talking about:

{% highlight java %}
Dog dog = new Dog();
Ball ball = dog.getBall();
{% endhighlight %}

Or even more ridiculous example:

{% highlight java %}
Dog dog = new Dog();
dog.setWeight("23kg");
{% endhighlight %}

Can you imagine this transaction in a real world? :)

Does it look similar to what you're writing every day? If yes,
than you're a procedural programmer. Admit it. And this is what
David West says about it, on page 30:

> Step one in the transformation of a successful procedural developer
into a successful object developer is a lobotomy

Do you need a lobotomy? Well, I definitely needed one and received it, while
reading his [Object Thinking](http://www.amazon.com/gp/product/0735619654/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0735619654&linkCode=as2&tag=yegor256com-20&linkId=NQQHJZPHOKM6BTCT).

## Object Thinking

Start thinking like an object and you will immediately rename that methods.
This is what you will probably get:

{% highlight java %}
Dog dog = new Dog();
dog.take(new Ball());
Ball ball = dog.give();
{% endhighlight %}

Now, we're treating the dog as a real animal, who can take a ball from us
and can give it back, when we ask. Worth mentioning that the
dog can't give `NULL` back. Dogs simply don't know what that is :)
Object thinking immediately eliminates
[NULL references]({% post_url 2014/may/2014-05-13-why-null-is-bad %})
from your code.

Besides that, object thinking will lead to object immutability, like in
that "weight of the dog" example. You would re-write it like that instead:

{% highlight java %}
Dog dog = new Dog("23kg");
int weight = dog.weight();
{% endhighlight %}

The dog is an immutable living organism, which doesn't allow anyone from
outside to change her weight, or size, or name, etc. She can tell, on
request, her weight or name. There is nothing wrong in public
methods that demonstrate requestors certain "insides" of an object. But these
methods are not "getters" and they should never have "get" prefix. We're
not "getting" anything from the dog. We're not getting her name. We're asking
her to tell us her name. See the difference?

We're not talking semantic here. We are differentiating procedural
programming mindset from an object-oriented one. In procedural programming,
we're working with data, manipulating them, getting, setting,
and deleting when necessary. We're in charge and the data is a passive component.
The dog is nothing for us, but just a "data holder".
It doesn't have its own life. We are free
to get whatever is necessary from it and set any data into it.
This is how C, COBOL, Pascal and many other procedural languages work(ed).

To the contrary, in true object-oriented world, we treat objects like
living organisms, with their own date of birth and a moment of death,
with their own identity and habits, if you wish. We can ask a dog to
give us some piece of data (for example, her weight), and she may
return us that information. But we always remember that the dog is
an active component. She decides what will happen after our request.

That's why, **it is conceptually wrong to have any methods starting
with `set` or `get` in an object**. And it's not about breaking encapsulation, like
many people argue. It is whether you're thinking like an object
or you're still writing COBOL in Java syntax.

PS. Yes, you may ask, &mdash; what about JavaBeans, JPA, JAXB, and many more
Java APIs that rely on the get/set notation? What about Ruby built-in feature
that simplies the creation of accessors? Well, all of that is our misfortune.
It is much easier to stay in a primitive world of procedural COBOL than
truly understand and appreciate the beautiful world of true objects.
