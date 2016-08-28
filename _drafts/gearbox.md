---
layout: post
title: "Fifty Shades of Object Immutability"
date: 2016-06-20
place: Palo Alto, CA
tags: oop
description: |
  There are a few levels of immutability in OOP, which
  all can be used when they seem appropriate.
keywords:
  - immutability
  - immutability java
  - immutable list
  - immutable object
  - immutable object java
---

Good objects are immutable, but not necessarily constants.
I tried to explain it [here]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}),
[here]({% pst 2014/dec/2014-12-09-immutable-object-state-and-behavior %}) and
[here]({% pst 2014/dec/2014-12-22-immutable-objects-not-dumb %}),
but now it's time to make another attempt. Actually, the more I think about it
the more I realize that immutability is not black or white &mdash; there
are a few more shades, let's take a look.

<!--more-->

As we agreed [here]({% pst 2016/jul/2016-07-14-who-is-object %}),
an object is a **representative** of someone else
(some entit(ies), other object(s), data, memory, files, etc.)
Let's see a number of objects, which look exactly the same
for us, but represent different things. And all of that things
will be a "gearbox"

{% highlight java %}
class Gearbox {
  private final int port;
  Gearbox switchTo(int gear) {
    // return a new gearbox that
    // is switched to the required gear
  }
  int gear() {
    // return current gear
  }
}
{% endhighlight %}


Now, there is basically a matrix that shows how our object can communicate
with that entity:

{% highlight java %}
Ask    | Tell   |
-------------------------
any    | any    |
any    | once   |
any    | never  |
once   | any    |
once   | once   |
once   | never  |
never  | any    |
never  | once   |
never  | never  |
{% endhighlight %}

1. stays loyal
read allowed/once/never
write allowed/once/never
2. doesn't allow changes
4. caches all responses
3. doesn't allow any communications

{% highlight java %}
class Gearbox {
  Gearbox switchTo(int gear) {
    // return a new gearbox that
    // is switched to the required gear
  }
  int gear() {
    // return current gear
  }
}
{% endhighlight %}

And now take a look

{% highlight java %}
class Gearbox {
  void switchTo(int gear) {
    // switch it to the required gear
  }
  int gear() {
    // return current gear
  }
}
{% endhighlight %}

