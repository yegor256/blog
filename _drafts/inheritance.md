---
layout: post
title: "Why Inheritance is Bad?"
date: 2016-09-04
tags: oop
place: Palo Alto, CA
description: |
  Inheritance is generally considered as a bad
  practice in object-oriented programming, but why
  exactly? Here we are trying to answer this question.
keywords:
  - inheritance in oop
  - inheritance is bad
  - inheritance over composition
  - inheritance vs composition
  - composition over inheritance
---

We all know that
[inheritance](https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming))
is bad and that
[composition over inheritance](https://en.wikipedia.org/wiki/Composition_over_inheritance)
is a
[good idea](http://programmers.stackexchange.com/questions/65179),
but do we really understand why?
In <del>most</del> all articles
[I've found](https://www.google.com/search?q=inheritance+is+bad)
about this subject, authors are saying that inheritance may be harmful
to your code so it's better not to use it. This "better" part is what bothers me:
does it mean that sometimes inheritance makes sense?
I've been interviewing [David West](http://davewest.us/)
(the author of [Object Thinking](http://amzn.to/266oJr4), my favorite book about OOP)
a few weeks ago and he said that inheritance should not exist in
object-oriented programming at all ([full video](https://www.youtube.com/watch?v=s-hdZZzMCac)).
Maybe David is right and we should totally forget `extends` keyword in Java?

<!--more-->

I think we should. And I think I know the reason why.

And it's not because we lose flexibility and introduce coupling, as Allen Holub
said in his JavaWorld blog
[Why extends is evil](http://www.javaworld.com/article/2073649/core-java/why-extends-is-evil.html),
even though he is definitely right.

We [discussed](https://gitter.im/yegor256/elegantobjects?at=57bcd2e4cd00bdff6e745584)
it in our Gitter chat a week ago and found out that inheritance,
as a term, doesn't really make sense if you think more about it.
Don't get me wrong, but [inheritance](https://en.wikipedia.org/wiki/Inheritance)
literally is "the practice of passing on property, titles, debts, rights, and obligations
upon the death of an individual."

When class `Cat` inherits class `Animal` who exactly is dying and what properties,
titles or debts are being passed? You may say that I'm being silly and inheritance
doesn't really mean exactly that in OOP, but let me show you that someone
is dead and some properties are passed, indeed.

Here is the `Animal`:

{% highlight java %}
class Animal {
  protected String name;
  public void move() {
    System.out.println("left, right...");
  }
}
{% endhighlight %}

And this is the `Cat`:

{% highlight java %}
class Cat extends Animal {
  public void meow() {
    System.out.println("meow!");
  }
}
{% endhighlight %}



The main issue, I believe is that the term inheritance makes sense
only if objects are containers of data attributes. In that case,
a `Cat` inherits them from an `Animal`. But if an object is a black box
with exposed behavior then how an ability to



