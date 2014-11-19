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
manipulations on them. What is the alternative? Objects talking SQL. Read on.

<!--more-->

## What's Wrong With ORM?

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

  public void setTitle(String txt) {
    this.title = txt;
  }
}
{% endhighlight %}

Next, we want to list all posts in the table:

{% highlight java %}
SessionFactory factory = new AnnotationConfiguration()
  .configure()
  .addAnnotatedClass(Post.class)
  .buildSessionFactory();
Session session = factory.openSession();
try {
  session.beginTransaction();
  List posts = session.createQuery("FROM Post").list();
  for (Post post : (List<Post>) posts){
    System.out.println("Title: " + post.getTitle());
  }
  session.getTransaction().commit();
} finally {
  session.close();
}
{% endhighlight %}

Finally, we want to create a new post:

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
