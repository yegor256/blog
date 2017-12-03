---
layout: post
title: "DAO Is a Good Concept With a Bad Name"
date: 2017-11-20
place: Odessa, Ukraine
tags: oop
description: |
  Data Access Objects (DAO) is a good design pattern
  in object-oriented programming, although
  with a rather confusing and misleading name.
keywords:
  - dao
  - data access objects
  - data access object
  - database access object
  - dao in oop
image: /images/2017/02/...
jb_picture:
  caption:
---

Data Access Object (DAO) is a design pattern.

<!--more-->

{% jb_picture_body %}

Here is how it looks:

{% highlight java %}
class BookDAO {
  Book find(int id);
  void delete(int id);
  Book add();
}
{% endhighlight %}

I don't see anything wrong in this design, except one thing: its name.
Why do we call it call "data" access object? We're not accessing data
here, I believe. We are accessing books, which are objects. The right
name would be "object accessing object," which sounds a bit weird.

Instead, I would just give these DAOs plural names of the objects they
are accessing. In this particular example it would be `Books`. Or, even better,
something like a `Library` or a `Bookshelf`.

I have these "DAOs" in most of my projects which work with SQL and
NoSQL databases, for example:

.
