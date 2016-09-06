---
layout: post
title: "OOP without Classes?"
date: 2016-09-08
place: Palo Alto, CA
tags: oop
description: |
  Do we really need classes in OOP? Maybe it's
  possible to have just objects, methods and types?
keywords:
  - class in oop
  - what is class in oop
  - object-oriented programming
  - role of class in oop
  - classes in oop
---

I've been [interviewing](https://www.youtube.com/watch?v=s-hdZZzMCac)
David West, the author of [Object Thinking](http://amzn.to/266oJr4) book,
a few weeks ago and he said that classes are not meant to be in
object-oriented programming at all. He actually said that
[earlier](https://www.youtube.com/watch?v=RdE-d_EhzmA), I just didn't
understand him then. The more I'm thinking about this the more it looks
obvious that we don't need classes indeed.

<!--more-->

Here is a prototype.

Let's say, we have only _types_ and _objects_. First, we define a type:

{% highlight text %}
type Book {
  void print();
}
{% endhighlight %}

Then, we _create_ an object (pay attention, not "instantiate"):

{% highlight text %}
Book b1 = new Book("Object Thinking") {
  private String title;
  Book(String t) {
    this.title = t;
  }
  public void print() {
    print("my title: " + this.title);
  }
}
{% endhighlight %}

Then, we want to create another object, which will behave similar
to the one we already have, but with different constructor arguments.
We _copy_ an existing one:

{% highlight text %}
Book b2 = copy b1("Elegant Objects");
{% endhighlight %}

Libraries will deliver us objects, which we can copy.

That's it.

No implemetation inheritance, of course.
Only [subtyping](https://en.wikipedia.org/wiki/Subtyping).

Why not?
