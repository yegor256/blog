---
layout: post
title: "Encapsulation Covers Up Naked Data"
date: 2016-11-21
tags: oop java
place: Moscow, Russia
description: |
  Encapsulation is what makes OOP objects solid,
  cohesive, and trustworthy; publicly accessible data
  is what breaks encapsulation.
keywords:
  - encapsulation
  - encapsulation data
  - encapsulation trusted objects
  - encapsulation meaning
  - encapsulation violation
---

Encapsulation is the core principle of object-oriented programming
that makes objects solid, cohesive, trustworthy, etc. But
what exactly is encapsulation? Does it only protect against access
to private attributes from outside an object? I think it's much more.
Encapsulation leads to the absence of _naked_ data on all levels and in all forms.

<!--more-->

{% picture /images/2016/11/borat.jpg 0 Borat: Cultural Learnings of America for Make Benefit Glorious Nation of Kazakhstan (2006) by Larry Charles %}

This is what naked data is (C code):

{% highlight C %}
int t;
t = 85;
printf("The temperature is %d F", t);
{% endhighlight %}

Here `t` is the data, which is publicly accessible by the code around it.
Anyone can modify it or read it.

Why is that bad? For one reason: tight and hidden coupling.

The code around `t` inevitably makes a lot of assumptions about the data. For
example, both lines after `int t` decided that the temperature is in Fahrenheit.
At the moment of writing, this may be true, but this assumption couples the
code with the data. If tomorrow we change `t` to Celsius, the code won't know
about this change. That's why I call this coupling _hidden_.

If we change the type of `t` from `int` to, say, `double`, the `printf`
line won't print anything after the decimal point. Again, the coupling is
there, but it's hidden. Later on, we simply won't be able to find all the places in our
code where we made these or other assumptions about `t`.

This will seriously affect maintainability.

And this is not a solution, as you can imagine (Java now):

{% highlight java %}
class Temperature {
  private int t;
  public int getT() { return this.t; }
  public void setT(int t) { this.t = t; }
}
{% endhighlight %}

It looks like an object, but the data is still naked. Anyone can retrieve
`t` from the object and decide whether it's Fahrenheit or Celsius, whether
it has digits after the dot or not, etc. This is not encapsulation yet!

The only way to encapsulate `t` is to make sure nobody can touch
it either directly or by retrieving it from an object. How do we do that?
Just stop exposing data and start exposing functionality. Here is how,
for example:

{% highlight java %}
class Temperature {
  private int t;
  public String toString() {
    return String.format("%d F", this.t);
  }
}
{% endhighlight %}

We don't allow anyone to retrieve `t` anymore. All they can do is
convert temperature to text. If and when we decide to change `t` to Celsius,
we will do it just once and in one place: in the class `Temperature`.

{% quote Any data elements that escape objects are naked and lead to maintainability problems %}

If we need other functions in the future, like math operations or conversion
to Celsius, we add more methods to class `Temperature`. But we never
let anyone touch or know about `t`.

This idea is close to
["printers instead of getters,"]({% pst 2016/apr/2016-04-05-printers-instead-of-getters %})
which we discussed earlier, though from a much wider perspective.
Here I'm saying that any data elements that escape objects are _naked_
and lead to maintainability problems.

The question is how we can work entirely without naked data, right? Eventually
we have to let objects exchange data, don't we? Yes, that's true. But not entirely.
I'll explain that in
[my next post]({% pst 2016/dec/2016-12-20-can-objects-be-friends %}).
