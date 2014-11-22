---
layout: post
title: "ORM Is an Anti-Pattern. What Is the Alternative?"
date: 2014-11-19
tags: oop
description:
  Object-relational mapping is a design pattern that
  violates encapsulation, one of the fundamental principles
  of OOP, but what is a possible alternative to it?
keywords:
  - object relational mapping
  - object relational mapping tools
  - object relational mapping tutorials
  - orm is an anti-pattern
  - orm is antipattern
---

TL;DR ORM is an terrible anti-pattern violating all principles of
object oriented programming and turning your objects into dumb and passive
data bags. There is no excuse for ORM existence in any application, be it
a small web app or an enterprise-size system with thousands of tables and CRUD
manipulations on them. What is the alternative? **SQL speaking objects**. Read on.

<!--more-->

## How ORM Works?

[Object Relational Mapping](https://en.wikipedia.org/wiki/Object-relational_mapping)
(ORM) is a technique (aka design pattern) of
accessing a relational database from an object-oriented language
(for example, Java). There are multiple implementations of ORM
in almost every language, for example
[Hibernate](http://hibernate.org/orm/) for Java,
[ActiveRecod](http://guides.rubyonrails.org/active_record_basics.html) for Ruby on Rails
[Doctrine](http://www.doctrine-project.org/) for PHP
[SQLAlchemy](http://www.sqlalchemy.org/) for Python.
In Java the ORM design is even standardized as [JPA](https://en.wikipedia.org/wiki/Java_Persistence_API).

First, let's see how ORM works, by example. Let's use Java, PostgreSQL and Hibernate.
Let's say, we have a single table in the database, called `post`:

{% highlight text %}
+-----+------------+--------------------------+
| id  | date       | title                    |
+-----+------------+--------------------------+
|   9 | 10/24/2014 | How to cook a sandwitch? |
|  13 | 11/03/2014 | My favorite movies       |
|  27 | 11/17/2014 | How much I love my job   |
+-----+------------+--------------------------+
{% endhighlight %}

Now we want to CRUD-manipulate this table from our Java app (CRUD
stands for create, read, update and delete). First, we should create
a `Post` class (I'm sorry it's so long, but that's the best I can do):

{% highlight java %}
@Entity
@Table(name = "post")
public class Post {
  @Id
  @GeneratedValue
  private int id;
  private Date date;
  private String title;

  @Column(name = "id")
  public int getId() {
    return this.id;
  }

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = "date")
  public Date getDate() {
    return this.date;
  }

  @Column(name = "title")
  public Title getTitle() {
    return this.title;
  }

  public void setDate(Date when) {
    this.date = when;
  }

  public void setTitle(String txt) {
    this.title = txt;
  }
}
{% endhighlight %}

Before any operation with Hibernate, we have to create a session factory:

{% highlight java %}
SessionFactory factory = new AnnotationConfiguration()
  .configure()
  .addAnnotatedClass(Post.class)
  .buildSessionFactory();
{% endhighlight %}

This factory will give us "sessions" every time we want to manipulate
with `Post` objects. Every manipulation with the session should be wrapped
in this code block:

{% highlight java %}
Session session = factory.openSession();
try {
  Transaction txn = session.beginTransaction();
  // your manipulations with the ORM, see below
  txn.commit();
} catch (HibernateException ex) {
  txn.rollback();
} finally {
  session.close();
}
{% endhighlight %}

When the session is ready, here is how we get a list of all posts
from that database table:

{% highlight java %}
List posts = session.createQuery("FROM Post").list();
for (Post post : (List<Post>) posts){
  System.out.println("Title: " + post.getTitle());
}
{% endhighlight %}

I think it's clear what's going on here. Hibernate is a big powerful
engine that makes a connection to the database, executes necessary SQL
`SELECT` request and retrieves the data. Then, it makes instances
of class `Post` and stuff them with the data.
When the object comes to us, it is filled with data and we should
use getters to take them out, like we're using `getTitle()` above.

Once we want to do a reverse operation and send an object to the
database, we do all the same but in a reverse order. We make an instance
of class `Post`, stuff it with the data, and ask Hibernate to save it:

{% highlight java %}
Post post = new Post();
post.setDate(new Date());
post.setTitle("How to cook an omelette");
session.save(post);
{% endhighlight %}

This is how almost every ORM works. The basic principle is always the same &mdash;
ORM objects are anemic envelopes with data. We are talking with the ORM
framework and the framework is talking to the database. Objects only help
us to send our requests to the ORM framework and understand its response.
Besides getters and setters that objects have no other methods. They even don't know
which database they came from.

This is how object-relational mapping works.

What's wrong with it, you may ask? Everything!

## What's Wrong With ORM?

Seriously, what is wrong? Hibernate is one of the most popular Java library
for over ten years already. Almost every SQL-intensive application in the world
is using it. Each Java tutorial would mention Hibernate (or maybe
[some other ORM](https://en.wikipedia.org/wiki/List_of_object-relational_mapping_software),
like TopLink or OpenJPA) for a database-connected application. It's a standard
*de-facto* and still I'm saying that it's wrong?

Yes, I'm claiming that the entire idea of ORM is wrong. It was invented by
mistake. Let me explain why.

First,

## SQL Speaking Objects

What is the alternative? Let me show it, by example. Let's try to design that
class `Post` my way. We'll have to break it down into two classes: `Posts`
and `Post`, singular and plural. I already mentioned in one of my previous
[articles]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}) that
a good object is always an abstraction of a real-life entity. Here is how
this principle works in practice. We have two entities: database table
and table row. That's why we'll make two classes: `Posts` will represent the
table and `Post` will represent the row.

As I also mentioned in that [articles]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}),
every object should work by contract
and implement an interface. Let's start our design with two interfaces.
Of course, our objects will be immutable. Here is how `Posts` would look:

{% highlight java %}
@Immutable
interface Posts {
  Iterable<Post> iterate();
  Post add(Date date, String title);
}
{% endhighlight %}

This is how a single `Post` would look:

{% highlight java %}
@Immutable
interface Post {
  int id();
  Date date();
  String title();
}
{% endhighlight %}

Here is how we will list all posts in the database table:

{% highlight java %}
Posts posts = // we'll discuss this right now
for (Post post : posts.iterate()){
  System.out.println("Title: " + post.title());
}
{% endhighlight %}

Here is how we will create a new post:

{% highlight java %}
Posts posts = // we'll discuss this right now
posts.add(new Date(), "How to cook an omelette");
{% endhighlight %}

As you see, we have true objects now. They are in charge of all operations
and they perfectly hide their implementation details. There are no transactions,
sessions or factories. We don't even know whether these objects are actually
talking to the PostgreSQL or maybe they keep all the data in text files. All
we need from `Posts` is an ability to list all posts for us and to create
a new one. Implementation details are perfectly hidden inside. Now let's
see how we can implement these two classes.

I'm going to use [jcabi-jdbc](http://jdbc.jcabi.com) as a JDBC wrapper,
but you can use something else or just plain JDBC, if you like. It doesn't
really matter. What matters is that your database interactions are hidden
inside objects. Let's start with `Posts` and implement it in class
`PgPosts` ("pg" stands for PostgreSQL):

{% highlight java %}
@Immutable
final class PgPosts implements Posts {
  private final Source dbase;
  public PgPosts(DataSource data) {
    this.dbase = data;
  }
  public Iterable<Post> iterate() {
    return new JdbcSession(this.dbase)
      .sql("SELECT id FROM post")
      .select(
        new ListOutcome<Post>(
          new ListOutcome.Mapping<Post>() {
            @Override
            public Message map(final ResultSet rset) {
              return new PgPost(rset.getInteger(1));
            }
          }
        )
      );
  }
  public Post add(Date date, String title) {
    return new PgPost(
      this.dbase,
      new JdbcSession(this.dbase)
        .sql("INSERT INTO post (date, title) VALUES (?, ?)")
        .set(new Utc(date))
        .set(title)
        .insert(new SingleOutcome<Integer>(Integer.class))
    );
  }
}
{% endhighlight %}

Next, let's implement `Post` interface in class `PgPost`:

{% highlight java %}
@Immutable
final class PgPost implements Post {
  private final Source dbase;
  private final int number;
  public PgPost(DataSource data, int id) {
    this.dbase = data;
    this.number = id;
  }
  public int id() {
    return this.number;
  }
  public Date date() {
    return new JdbcSession(this.dbase)
      .sql("SELECT date FROM post WHERE id = ?")
      .set(this.number)
      .select(new SingleOutcome<Utc>(Utc.class));
  }
  public String title() {
    return new JdbcSession(this.dbase)
      .sql("SELECT title FROM post WHERE id = ?")
      .set(this.number)
      .select(new SingleOutcome<String>(String.class));
  }
}
{% endhighlight %}

This is how a full database interaction scenario will look like,
using the classes we just created:

{% highlight java %}
Posts posts = new PgPosts(dbase);
for (Post post : posts.iterate()){
  System.out.println("Title: " + post.title());
}
Post post = posts.add(new Date(), "How to cook an omelette");
System.out.println("Just added post #" + post.id());
{% endhighlight %}

You can see a full practical example [here](https://github.com/aintshy/hub/tree/0.7.2/src/main/java/com/aintshy/pgsql).
It's an open source
web app that works with PostgreSQL using exactly the approach explained
above &mdash; SQL speaking objects.

## What About Performance?

I can hear you screaming &mdash; what about performance? In that script
a few lines above we're making many redundant round trips to the database.
First, we retrieve post IDs with `SELECT id` and then, in order to get their titles,
we make extra `SELECT title` call for each post. This is inefficient or, simply
put, too slow.

No worries, it is object-oriented programming, it is flexible! Let's create
a decorator of `PgPost`, which will accept all data in its constructor
and cache them internally, forever:

{% highlight java %}
@Immutable
final class ConstPost implements Post {
  private final Post origin;
  private final Date dte;
  private final String ttl;
  public PgPost(Post post, Date date, String title) {
    this.origin = post;
    this.dte = date;
    this.ttl = title;
  }
  public int id() {
    return this.origin.id();
  }
  public Date date() {
    return this.dte;
  }
  public String title() {
    return this.ttl;
  }
}
{% endhighlight %}

Pay attention, this decorator doesn't know anything about PostgreSQL or
JDBC. It just decorates an object of type `Post` and pre-caches the date
and title. As usual, this decorator is also immutable.

Then, let's create another implementation of `Posts`, which is returning
that "constant" objects:

{% highlight java %}
@Immutable
final class ConstPgPosts implements Posts {
  // ...
  public Iterable<Post> iterate() {
    return new JdbcSession(this.dbase)
      .sql("SELECT * FROM post")
      .select(
        new ListOutcome<Post>(
          new ListOutcome.Mapping<Post>() {
            @Override
            public Message map(final ResultSet rset) {
              return new ConstPost(
                new PgPost(rset.getInteger(1)),
                Utc.getTimestamp(rset, 2),
                rset.getString(3)
              );
            }
          }
        )
      );
  }
}
{% endhighlight %}

Now, all posts returned by `iterate()` of this new class are pre-equipped with date and title
fetched in one round-trip to the database.

Using decorators and multiple implementations of the same interface, you
can compose any functionality you wish. What is the most important, that
while functionality is being extended, the complexity of the design is
not growing up. Because classes don't grow in size. Instead, we're introducing
new classes, which stay cohesive and solid. Because they are small.

## What About Transactions?
