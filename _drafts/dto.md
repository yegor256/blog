---
layout: post
title: "Data Transfer Object Is a Shame"
date: 2016-06-20
place: Palo Alto, CA
tags: oop
description: |
  DTO is a very popular design pattern, which is
  actually an anti-pattern in object-oriented programming,
  which has no right to exist.
keywords:
  - DTO
  - data transfer object
  - DTO design pattern
  - ORM DTO
  - DTO in java
---

DTO, as far as I understand it, is a corner stone of the ORM design pattern,
which I [simply adore]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %}).
Let's skip the manners &mdash; DTO is just a shame and those who invented
it were just stupid. There is no excuse for what they've done.

<!--more-->

By the way, their names are:

So, the key idea of object-oriented programming is to hide data
behind objects. This idea has a name &mdash; encapsulation. In OOP data
must not be visible. Objects must have access only to the data they
encapsulate and never to the data encapsulated by other objects. There
can be no arguing about this principle &mdash; it is what OOP is all about.

However, that smart guys

Let's see a practical example. Let's say, this is a service that fetches
a JSON document from some RESTful API and returns a DTO, which we then
can store to the database:

{% highlight java %}
Book book = api.loadBookById(123);
database.saveNewBook(book);
{% endhighlight %}

I guess, this is what will happen inside `loadBookById()` method:

{% highlight java %}
Book loadBookById(int id) {
  JsonObject json = /* load it from RESTful API */
  Book book = new Book();
  book.setISBN(json.getString("isbn"));
  book.setTitle(json.getString("title"));
  book.setAuthor(json.getString("author"));
  return book;
}
{% endhighlight %}

Am I right? I bet I am. It already looks disgusting to me. Anyway, let's
continue. This is what most probably will happen in `saveNewBook()` method
(I'm using pure JDBC):

{% highlight java %}
void saveNewBook(Book book) {
  Statement stmt = createStatement();
  stmt.setString(1, book.getISBN());
  stmt.setString(2, book.getTitle());
  stmt.setString(3, book.getAuthor());
  stmt.execute();
}
{% endhighlight %}

This `Book` is a classic data transfer object. All it does is transferring
data between two pieces of code, two procedures. The object `book` is pretty
dumb. All it knows how to do is... nothing. It doesn't do anything. It is
actually not an object but a passive and anemic data structure.

What is the right design? There are a few. For example, this one looks
good to me:

{% highlight java %}
Book book = api.bookById(123);
book.save(database);
{% endhighlight %}

This is what happens in `bookById()`:

{% highlight java %}
Book bookById(int id) {
  return new JsonBook(
    /* RESTful API access point */
  );
}
{% endhighlight %}

This is what happens in `Book.save()`:

{% highlight java %}
void save(Database db) {
  db.createBook(this.isbn, this.title, this.author);
}
{% endhighlight %}

What happens if there are many more parameters of the book? How about this:

{% highlight java %}
void save(Database db) {
  db.createBook(this.isbn, this.title, this.author);
}
{% endhighlight %}

