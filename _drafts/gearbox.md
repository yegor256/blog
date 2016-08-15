---
layout: post
title: "Six Shades of Object Immutability"
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

Good objects are immutable. I've said it [here]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %})
and since then keep
receiving questions &mdash; whether and how it is possible to design an entire
application with just immutable objects. I've tried to explain it
[here]({% pst 2014/dec/2014-12-09-immutable-object-state-and-behavior %}) and
[here]({% pst 2014/dec/2014-12-22-immutable-objects-not-dumb %}),
but now it's time to make another attempt. Moreover, I gave this problem
a second thought and realized that immutability is not black or white. There
are a few more shades, let's take a look.

<!--more-->

As we agreed [here]({% pst 2016/jul/2016-07-14-who-is-object %}),
an object is a representative of someone else
(an entity, another object, data, etc.) Now, let's agree that we can
communicate with that someone else in two modes: read and write. Or, in a more
object way: ask and tell. We can either tell that entity to do something
or can ask it to give us some information.

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

