---
layout: post
title: "Object-Oriented Chain of Processors"
date: 2019-02-28
place: Moscow, Russia
tags: java oop
description: |
  ...
keywords:
  - java object-oriented
  - processing data
  - oop data processing
  - data processor oop
  - object oriented data processor
image: /images/2019/03/...
jb_picture:
  caption:
---

Imagine a situation: you have a table in a relational database, which contains a large
data set, like a few million records. You have to fetch them all and process,
one by one. Moreover some of them should be grouped with others. In the end
you want to get a file with some summary of the information from the database.
How would you do it in, say, Java? I guess, you would create a database "reader,"
a number of data "processors," and a file "writer." Well, that's how
[Spring Batch](https://spring.io/projects/spring-batch), and many other data
processing frameworks work. However, this is not really object-oriented enough.
How would we do it instead?

<!--more-->

{% jb_picture_body %}

I would use, guess what, ... decorators.
[Horizontal]({% pst 2015/oct/2015-10-01-vertical-horizontal-decorating %}) ones.
First, I would create an interface for the source of data, which may look
very similar to the `Iterator` interface from JDK:

{% highlight java %}
interface Source {
   read();
  boolean hasMore();
}
{% endhighlight %}



