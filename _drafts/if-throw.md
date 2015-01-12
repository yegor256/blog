---
layout: post
title: "If-Throw-Else. Why?"
date: 2015-01-10
tags: java oop
description:
  There is an obvious optimization of If-Then-Else statement
  that throws an exception of exits by Break or Continue, which
  is very often overlooked
keywords:
  - if-throw-else
  - if throw exception
  - if throw exception java
  - if then else exception
  - if throw else exception
---

This is the code I never understand:

{% highlight java %}
if (x < 0)
  throw new IllegalArgumentException("X can't be negative");
} else {

}
{% endhighlight %}


<!--more-->

{% highlight java %}
Session session = factory.openSession();
try {
  session.beginTransaction();
  Post post = new Post();
  post.setTitle("How to cook an omelette");
  session.save(post);
  session.getTransaction().commit();
} finally {
  session.close();
}
{% endhighlight %}

Let's see what's happening behind the scene.
