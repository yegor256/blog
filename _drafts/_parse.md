---
layout: post
title: "Parsing Decorators"
date: 2018-02-20
place: Moscow, Russia
tags: management
description: |
  When project scope is perfectly decomposed and management
  rules are clear and strict, the speed of delivery
  is a virtue, not the quality.
keywords:
  - quality vs speed
  - speed vs quality
  - perfection vs speed
  - speed or perfection
  - speed is king
image: /images/2017/02/...
jb_picture:
  caption:
---

<!-- here: http://www.yegor256.com/2014/09/16/getters-and-setters-are-evil.html#comment-3438202653 -->

The traditional way of integrating object-oriented backend with an external
system is through [data transfer objects]({% pst 2016/jul/2016-07-06-data-transfer-object %}),
which are serialized into JSON before going out
and deserialized from it when coming back. This way is as much popular as is wrong. The
serialialization part should be replaced by [printers]({% pst 2016/apr/2016-04-05-printers-instead-of-getters %}),
which I explained ealier.
Here is my take on deserialization, which should be done by&mdash;guess what&mdash;decorators.

<!--more-->

{% jb_picture_body %}

Say, there is a back-end entry point, which is supposed to register a new
book in the library, arriving in JSON:

{% highlight json %}
{
  "title": "Object Thinking",
  "isbn: "0735619654",
  "author: "David West"
}
{% endhighlight %}

Say, there is an object of class `Library`, which expects an object of type
`Book` to its method `register()`:

{% highlight java %}
class Library {
  public void register(Book book) {
    // Create a new record in the database
  }
}
{% endhighlight %}

Say, type `Book` has a simple method `isbn()`:

{% highlight java %}
interface Book {
  String isbn();
}
{% endhighlight %}

Now, here is the HTTP entry point
(I'm using [Takes]({% pst 2015/mar/2015-03-22-takes-java-web-framework %})),
which is accepting
POST [`multipart/form-data`](https://www.ietf.org/rfc/rfc2045.txt)
request and registers the book in the library:

{% highlight java %}
public class TkUpload implements Take {
  private final Library library;
  @Override
  public Response act(Request req) {
    String body = new RqPrint(
      new RqMtSmart(new RqMtBase(req)).single("book")
    ).printBody();
    JsonObject json = Json.createReader(
      new InputStreamOf(body)
    ).readObject();
    Book book = new BookDTO();
    book.setIsbn(json.getString("isbn"));
    library.register(book);
  }
}
{% endhighlight %}

What is wrong with this? A few things.

First, it's not reusable. If we would need something similar in a different
place, we will have to write this HTTP processing and JSON parsing again.

Second,

A better design would be to hide this parsing inside a book

{% highlight java %}
public class TkUpload implements Take {
  @Override
  public Response act(final Request req) {
    final String json = new RqPrint(
      new RqMtSmart(new RqMtBase(req)).single("book")
    ).printBody();
  }
}
{% endhighlight %}

