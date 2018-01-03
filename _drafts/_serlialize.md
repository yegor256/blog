---
layout: post
title: "Don't Serialize Me, Please!"
date: 2018-01-10
place: Minsk, Belarus
tags: oop
description: |
  ...
keywords:
  - ...
  - ...
  - ...
  - ...
  - ...
image: /images/2017/12/
jb_picture:
  caption:
---

Do you know how serialization and deserialization work in Java? I bet you
don't. Even if you do, let's go through it once again and see the "beauty"
of it. I have to say, before we start, that this is the worst piece of design
you can find in JDK, in my opinion. Nothing can beat it in its ugliness.
Even those recently introduced
[private interface methods]({% pst 2017/oct/2017-10-03-java9 %}) are not
as terrible as this serialization API.

<!--more-->

{% jb_picture_body %}

Say, we have a [DTO]({% pst 2016/jul/2016-07-06-data-transfer-object %}):

{% highlight java %}
class Point {
  public int x;
  public int y;
}
{% endhighlight %}

It's not a DTO? Yes, it is. It just doesn't have [getters and setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}),
but the purpose of this "class" is nothing but to transfer data.

Now, we want to _save_ it to the disc. Then, we will shut down the JVM,
but the object of class `Point` will remain in the file. We will start
the JVM and will _restore_ it. How can we do that? We need to serialize
it first and then deserialize back.

First
