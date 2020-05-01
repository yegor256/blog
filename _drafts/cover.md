---
layout: post
title: "Object Cover"
date: 2020-05-10
place: Moscow, Russia
tags: oop
description: |
  To be written later... To be written later... To be written later...
  To be written later... To be written later... To be written later...
keywords:
  - ...
  - ...
  - oop
  - ...
  - ...
image: /images/2020/05/
jb_picture:
  caption: ...
---

...

<!--more-->

{% jb_picture_body %}

Imagine, you need to fetch a list of items from the database
and return them as a collection of objects. First, you fetch
them and you get a list of hashes
(I'm using [`pgtk`](https://github.com/yegor256/pgtk), my own
library to work with PostgreSQL):

{% highlight ruby %}
def Books
  def popular
    pgsql.exec('SELECT * FROM book')
  end
end
{% endhighlight %}


