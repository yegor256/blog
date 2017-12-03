---
layout: post
title: "DAO is Yet Another OOP Shame"
date: 2017-11-20
place: Odessa, Ukraine
tags: oop
description: |
  Data Access Objects (DAO) is a design pattern
  that is supposed to abstract a persistence layer
  from a business one; I find its implementation very wrong.
keywords:
  - dao
  - data access objects
  - data access object
  - database access object
  - dao in oop
image: /images/2017/12/requiem-for-a-dream.jpg
jb_picture:
  caption: Requiem for a Dream (2000) by Darren Aronofsky
---

Someone asked me what I think about DAO and I realized that, even
though I wrote about ORM, DTO, and getters, I haven't had a change
yet to mention DAO. Here is my take on it&mdash;it's as much of a shame
as its friends&mdash;ORM, DTO, and getters. In a nutshell,
[Data Access Object](http://www.oracle.com/technetwork/java/dataaccessobject-138824.html)
is an object [that](https://en.wikipedia.org/wiki/Data_access_object)
"provides an abstract interface to some type of database or other
persistence mechanism." The purpose is noble, but the implementation
is terrible.

<!--more-->

{% jb_picture_body %}

Here is how it [may look](https://stackoverflow.com/a/19154487/187141):

{% highlight java %}
class BookDAO {
  Book find(int id);
  void update(Book book);
  // Other methods here ...
}
{% endhighlight %}

The idea is simple&mdash;method `find()` creates
a [DTO]({% pst 2016/jul/2016-07-06-data-transfer-object %})
`Book`, someone else injects new data into it and calls `update()`:

{% highlight java %}
BookDAO dao = BookDAOFactory.getBookDAO();
Book book = dao.find(123);
book.setTitle("Don Quixote");
dao.update(book);
{% endhighlight %}

What is wrong, you ask? Everything that was wrong with the
[ORM]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %}),
but instead of a "session" we have this DAO. The problem remains the
same: the `book` is not an object, but a data container. I quote
my own three years old statement from the [ORM article]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %}),
with a slight change in the name:
"DAO, instead of encapsulating database interaction inside an object,
extracts it away, literally tearing a solid and cohesive living organism apart."
For more details, please check that article.

However, I have to say that I have something like DAO in most of my
[pet projects](/pets.html), but they
don't return or accept DTOs. Instead, they return objects and sometimes accept
operations on them. Here are a few examples. Look at this
[`Pipes`](https://github.com/yegor256/wring/blob/0.17.4/src/main/java/io/wring/model/Pipes.java)
interface from
[Wring.io]({% pst 2016/mar/2016-03-15-wring-dispatcher-github-notifications %}):

{% highlight java %}
interface Pipes {
  void add(String json);
  Pipe pipe(long number);
}
{% endhighlight %}

Its method [`add()`](https://github.com/yegor256/wring/blob/0.17.4/src/main/java/io/wring/model/Pipes.java#L55)
creates a new item in the "collection" and method
[`pipe()`](https://github.com/yegor256/wring/blob/0.17.4/src/main/java/io/wring/model/Pipes.java#L62)
returns a single object from the collection. The
[`Pipe`](https://github.com/yegor256/wring/blob/0.17.4/src/main/java/io/wring/model/Pipe.java)
is not a DTO, it is
a normal object that is fully capable of doing all necessary database
operations, without any help of any DAO. For example, there is
[`Pipe.status(String)`](https://github.com/yegor256/wring/blob/0.17.4/src/main/java/io/wring/model/Pipe.java#L63)
method to update its status. I'm not going to `Pipes` for that, I just do
`pipe.status("Hello, world!)`.

Here is yet another example from
[Jare.io]({% pst 2016/mar/2016-03-30-jare-instant-free-cdn %}): interface
[`Base`](https://github.com/yegor256/jare/blob/0.11/src/main/java/io/jare/model/Base.java)
that returns a list of objects of type
[`Domain`](https://github.com/yegor256/jare/blob/0.11/src/main/java/io/jare/model/Domain.java).
Then, when we want to delete a domain, we just call
[`domain.delete()`](https://github.com/yegor256/jare/blob/0.11/src/main/java/io/jare/model/Domain.java#L54).
The domain is fully capable of doing all necessary database manipulations.

The problem with DAO is right in its name, I believe. It says that we are
accessing "data" and does exactly that: goes to the database, retrieves
some data, and returns _data_. Not an object, but data, also known as
"data transfer object." As we [discussed before]({% pst 2016/nov/2016-11-21-naked-data %}),
direct data manipulations are what break encapsulation and make
object-oriented code procedural and unmaintainable.

