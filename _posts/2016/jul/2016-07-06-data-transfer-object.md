---
layout: post
title: "Data Transfer Object Is a Shame"
date: 2016-07-06
place: Palo Alto, CA
tags: oop
description: |
  DTO is a very popular design pattern, but it is
  actually an anti-pattern in object-oriented programming
  that has no right to exist.
keywords:
  - DTO
  - data transfer object
  - DTO design pattern
  - ORM DTO
  - DTO in java
image: /images/2016/07/before-the-devil-knows-you-are-dead.jpg
jb_picture:
  caption: Before the Devil Knows You're Dead (2007) by Sidney Lumet
buffer:
  - "DTO is just a shame, and Martin Fowler, who invented it, is just wrong."
  - "In OOP, data must not be visible. Objects must only have access to the data they encapsulate and never to the data encapsulated by other objects."
---

[DTO](https://en.wikipedia.org/wiki/Data_transfer_object),
as far as I understand it, is a cornerstone of the ORM design pattern,
which I [simply "adore."]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %})
But let's skip to the point: DTO is just a shame, and the man who invented
it is just wrong. There is no excuse for what he has done.

<!--more-->

{% jb_picture_body %}

By the way, his name, to my knowledge, was
[Martin Fowler](https://martinfowler.com/bliki/LocalDTO.html). Maybe he
was not the sole inventor of DTO, but he made it legal and recommended
its use. With all due respect, he was just wrong.

{% quote Objects must only have access to the data they encapsulate and never to the data encapsulated by other objects.  %}

The key idea of object-oriented programming is to hide data
behind objects. This idea has a name:
[encapsulation]({% pst 2016/nov/2016-11-21-naked-data %}).
In OOP, data
must not be visible. [Objects]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %})
must only have access to the data they
encapsulate and never to the data encapsulated by other objects. There
can be no arguing about this principle---it is what
[OOP]({% pst 2016/aug/2016-08-15-what-is-wrong-object-oriented-programming %}) is all about.

However, DTO runs completely against that principle.

Let's see a practical example. Say that this is a service that fetches
a JSON document from some RESTful API and returns a DTO, which we can then
store in the database:

```java
Book book = api.loadBookById(123);
database.saveNewBook(book);
```

I guess this is what will happen inside the `loadBookById()` method:

```java
Book loadBookById(int id) {
  JsonObject json = /* Load it from RESTful API */
  Book book = new Book();
  book.setISBN(json.getString("isbn"));
  book.setTitle(json.getString("title"));
  book.setAuthor(json.getString("author"));
  return book;
}
```

Am I right? I bet I am. It already looks disgusting to me. Anyway, let's
continue. This is what will most likely happen in the `saveNewBook()` method
(I'm using pure JDBC):

```java
void saveNewBook(Book book) {
  Statement stmt = connection.prepareStatement(
    "INSERT INTO book VALUES (?, ?, ?)"
  );
  stmt.setString(1, book.getISBN());
  stmt.setString(2, book.getTitle());
  stmt.setString(3, book.getAuthor());
  stmt.execute();
}
```

This `Book` is a classic example of a data transfer object design pattern.
All it does is transfer
data between two pieces of code, two procedures. The object `book` is pretty
dumb. All it knows how to do is ... nothing. It doesn't do anything. It is
actually not an object at all but rather a passive and anemic data structure.

What is the right design? There are a few. For example, this one looks
good to me:

```java
Book book = api.bookById(123);
book.save(database);
```

This is what happens in `bookById()`:

```java
Book bookById(int id) {
  return new JsonBook(
    /* RESTful API access point */
  );
}
```

This is what happens in `Book.save()`:

```java
void save(Database db) {
  JsonObject json = /* Load it from RESTful API */
  db.createBook(
    json.getString("isbn"),
    json.getString("title"),
    json.getString("author")
  );
}
```

What happens if there are many more parameters of the book in JSON that won't
fit nicely as parameters into a single `createBook()` method? How about this:

```java
void save(Database db) {
  db.create()
    .withISBN(json.getString("isbn"))
    .withTitle(json.getString("title"))
    .withAuthor(json.getString("author"))
    .deploy();
}
```

There are many other options. But the main point is that the data
_never_ escapes the object `book`. Once the object is instantiated, the
data is not visible or accessible by anyone else. We may only
ask our object to save itself or to
[print]({% pst 2016/apr/2016-04-05-printers-instead-of-getters %})
itself to some media, but we
will never [get]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})
any data from it.

The very idea of DTO is wrong because it turns object-oriented code
into procedural code. We have procedures that manipulate data, and DTO is just
a box for that data. Don't think that way, and don't do that.

PS. There are a few other names of DTO:
[business objects](https://en.wikipedia.org/wiki/Business_object),
domain objects (not in [DDD](https://en.wikipedia.org/wiki/Domain-driven_design)),
[entity objects](https://docs.oracle.com/cd/A97335_02/apps.102/bc4j/developing_bc_projects/bc_awhatisaneo.htm),
[JavaBeans](https://en.wikipedia.org/wiki/JavaBeans).
