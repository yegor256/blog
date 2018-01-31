---
layout: post
title: "Don't Serialize Me, Please!"
date: 2018-01-10
place: Moscow, Russia
tags: oop
description: |
  ...
keywords:
  - ...
  - ...
  - ...
  - ...
  - ...
image: /images/2018/02/
jb_picture:
  caption:
---

Do you know how [Java Object Serialization](https://docs.oracle.com/javase/8/docs/technotes/guides/serialization/index.html)
works? I bet you don't. Even if you do, let's go through it once again and see the "beauty"
of it. I have to say, before we start, that this is the worst piece of design
you can find in JDK, in my opinion. Nothing can beat it in its ugliness.
Even those recently introduced
[private interface methods]({% pst 2017/oct/2017-10-03-java9 %})
are not as terrible as this Serialization API.

<!--more-->

{% jb_picture_body %}

First, let's see how it technically works.
Say, we have a [DTO]({% pst 2016/jul/2016-07-06-data-transfer-object %}):

{% highlight java %}
class Point {
  public int x;
  public int y;
}
{% endhighlight %}

It's not a DTO? Yes, it is. It just doesn't
have [getters and setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}),
but the purpose of this "class" is nothing but to transfer data from
point A to point B:

{% highlight java %}
Point point = new Point();
point.x = 50;
point.y = 75;
{% endhighlight %}

Now, we want to _save_ `point` to the disc. Then, we can shut down the JVM.
Later, when we start the JVM again and _restore_ `point`, it will contain
exactly the same `x` and `y`. How to achieve that?
We need to serialize it first and then deserialize back.

Here is how we serialize `point` to a file (correct me if I'm wrong, since
I've never done this in my life, just taking code samples from
[Oracle documentation](https://docs.oracle.com/javase/8/docs/platform/serialization/spec/serialTOC.html)):

{% highlight java %}
try (ObjectOutput out =
  new ObjectOutputStream(new FileOutputStream("point.bin"))) {
  out.writeObject(point);
}
{% endhighlight %}

What will `writeObject()` do in order to "convert" `point` to a stream
of bytes? It will use reflection API to find all object attributes


