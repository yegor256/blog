---
layout: post
title: "How Does Inversion of Control Really Work"
date: 2017-04-08
place: Odessa, Ukraine
tags: oop
description: |
  IoC is a very popular concept, which for most programmers
  look over-complicated or very much coupled with
  dependency injection containers; it's not.
keywords:
  - IoC
  - inversion of control
  - dependency injection
  - IoC OOP
  - dependency control
image: /images/2015/03/?
jb_picture:
  caption: xxx
---

[IoC](https://en.wikipedia.org/wiki/Inversion_of_control)
seems to become the cornerstone concept of many frameworks
and object-oriented designs since it was described by
[Martin Fowler](https://martinfowler.com/bliki/InversionOfControl.html),
[Robert Martin](https://web.archive.org/web/20041221102842/http://www.objectmentor.com/resources/articles/dip.pdf)
and others ten years ago. Despite its popularity IoC is
misunderstood and over complicated, very often.

<!--more-->

{% jb_picture_body %}

Look at this code:

{% highlight java %}
print(book.title());
{% endhighlight %}

It is pretty straight forward: we retrieve the title from the book and
give it to the `print()` procedure, or whatever it is. We are in charge,
the _control_ is in our hands.

To the contrary, this is the _inversion_:

{% highlight java %}
print(book);
{% endhighlight %}

We give the entire book to the procedure `print()` and
it calls `title()` when it feels like it. We _delegate_ control.

This is pretty much everything you need to know about IoC.

Does it have to do anything with
[dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) containers?
Well, of course, we can put the book into a container, inject the entire
container into `print()`, let it retrieve the book from the container and
then call `title()`. However, that's not what IoC is really about&mdash;this
would be just one of its
[perverted]({% pst 2014/oct/2014-10-03-di-containers-are-evil %}) usage scenarios.

The main point of IoC is exactly the same as I was proposing
in my previous posts about [naked data]({% pst 2016/nov/2016-11-21-naked-data %})
and [object friends]({% pst 2016/dec/2016-12-20-can-objects-be-friends %}):
we must _not_ deal with _data_, but instead only with
[object composition](https://en.wikipedia.org/wiki/Object_composition). In the
given example the right design would be even better if we get rid of the
`print()` procedure and replace it with an object:

{% highlight java %}
new PrintedBook(book);
{% endhighlight %}

That would be pure [object composition](https://en.wikipedia.org/wiki/Object_composition).

There is not much to say any more on this subject; I hope I cleared it up&mdash;it
is just as simple as that.
