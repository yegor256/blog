---
layout: post
title: "Constant Objects"
date: 2015-02-10
tags: oop
description:
  Constant objects behave identically ow
keywords:
  - object relational mapping
  - object relational mapping tools
  - object relational mapping tutorials
  - orm is an anti-pattern
  - orm is antipattern
---

There is a class `Ocket` in [jcabi-s3](http://s3.jcabi.com) that reads
the entire content

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
