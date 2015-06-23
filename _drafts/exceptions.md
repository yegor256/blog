---
layout: post
title: "Catch Me If You Can't... Otherwise"
date: 2015-06-14
tags: oop
description:
  Catching an exception must be your last resort;
  a properly designed application would catch
  exceptions only in one place.
keywords:
  - exception catching
  - catch exception
  - when to catch exceptions
  - catch exception java
  - exceptions java
---

I don't know whether it's an anti-pattern or just a common and a very popular
mistake, but I see it everywhere and simply must write about it. I'm talking
about exception catching without re-throwing. I'm talking about something like
this code:

{% highlight java %}
try {

} catch () {
}
{% endhighlight %}


<!--more-->

{% highlight java %}
{% endhighlight %}

Let's see what's happening behind the scene.
