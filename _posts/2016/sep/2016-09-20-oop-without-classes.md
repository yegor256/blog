---
layout: post
title: "OOP Without Classes?"
date: 2016-09-20
place: Palo Alto, CA
tags: oop
description: |
  Do we really need classes in OOP? Maybe it's
  possible to just have objects, and types. And,
  of course, no implementation inheritance.
keywords:
  - class in oop
  - what is class in oop
  - object-oriented programming
  - role of class in oop
  - classes in oop
---

I [interviewed](https://www.youtube.com/watch?v=s-hdZZzMCac)
David West, the author of the [Object Thinking](http://amzn.to/266oJr4) book,
a few weeks ago, and he said that classes were not meant to be in
object-oriented programming at all. He actually said that
[earlier](https://www.youtube.com/watch?v=RdE-d_EhzmA); I just didn't
understand him then. The more I've thought about this, the more it appears
obvious that we indeed do not need classes.

<!--more-->

{% picture /images/2016/09/battleship-potemkin.jpg 0 Battleship Potemkin (1925) by Sergei M. Eisenstein %}

Here is a prototype.

Let's say we have only _types_ and _objects_. First, we define a type:

{% highlight text %}
type Book {
  void print();
}
{% endhighlight %}

Then we _create_ an object (pay attention; we don't "instantiate"):

{% highlight text %}
Book b1 = create Book("Object Thinking") {
  String title;
  Book(String t) {
    this.title = t;
  }
  public void print() {
    print("My title: " + this.title);
  }
}
{% endhighlight %}

Then we create another object, which will behave similarly
to the one we already have but with different constructor arguments.
We _copy_ an existing one:

{% highlight text %}
Book b2 = copy b1("Elegant Objects");
{% endhighlight %}

Libraries will deliver us objects, which we can copy.

That's it.

No implementation inheritance and no static methods, of course.
Only [subtyping](https://en.wikipedia.org/wiki/Subtyping).

Why not?
