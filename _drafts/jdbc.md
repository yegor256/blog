---
layout: post
title: "Fluent JDBC Decorator"
date: 2014-08-12
tags: jcabi java jdbc
description:
  jcabi-jdbc is a fluent wrapper of JDBC, making
  interaction with relational databases easier and
  much less verbose
keywords:
  - jdbc wrapper
  - jdbc fluent wrapper
  - jdbc wrapper library
  - jdbc wrapper tool
  - lightweight jdbc wrapper
---

{% badge http://img.jcabi.com/logo-square.svg 64 http://aspects.jcabi.com %}

This is how you fetch a text from an SQL table
with [jcabi-jdbc](http://jdbc.jcabi.com):

{% highlight java %}
String name = new JdbcSession(source)
  .sql("SELECT name FROM employee WHERE id = ?")
  .set(1234)
  .select(new SingleOutcome<String>(String.class));
{% endhighlight %}

Simple and straight forward, isn't it? The library
simplifies interaction with relational databases
via JDBC, avoiding the need to use ORMs.

<!--more-->

[jcabi-jdbc](http://jdbc.jcabi.com) is a lightweight wrapper of
[JDBC](http://www.oracle.com/technetwork/java/javase/jdbc/index.html).
It is very convenient to use it, when you don't need a full-scale
ORM (like Hibernate), but want just to select, insert, or update
a few rows in a relational database.

Every instance of `JdbcSession` is a "transaction" in a database.
You start it via the instantiating of the class, with a single parameter
&mdash; data source.

You get the data source from your connection pool. There are many
implementations of a connection pool, I would recommend to use
[BoneCP](http://jolbox.com/). This is how you connect to, say, PostgreSQL:

{% highlight java %}
@Cacheable(forever = true)
private static DataSource source() {
  BoneCPDataSource src = new BoneCPDataSource();
  src.setDriverClass("org.postgresql.Driver");
  src.setJdbcUrl("jdbc:postgresql://localhost/db_name");
  src.setUser("jeff");
  src.setPassword("secret");
  return src;
}
{% endhighlight %}

Pay attention to the `@Cacheable` annotation.
[This post]({% post_url 2014/aug/2014-08-03-cacheable-java-annotation %})
explains how it can help you to cache Java method result, for some time.
Attribute `forever` set to `true` means that we don't want this
method to be called more than once. Indeed, we want connection pool
to be created just once, and every second call should return its
existing instance (kind of like a Singleton pattern).

[jcabi-jdbc](http://jdbc.jcabi.com) website explains how you
can [insert](http://jdbc.jcabi.com/example-insert.html),
[update](http://jdbc.jcabi.com/example-update.html), or
delete a row. Besides that, you can
[execute any SQL statement](http://jdbc.jcabi.com/example-execute.html).

By default, `JdbcSession` closes JDBC connection right after the
first select/update/insert operation. Simply put, it is designed
to be used mainly for single atomic transactions. However, it is
possible to leave the connection open and continue, for example:

{% highlight java %}
new JdbcSession(source)
  .autocommit(false)
  .sql("START TRANSACTION")
  .update()
  .sql("DELETE FROM employee WHERE name = ?")
  .set("Jeff Lebowski")
  .update()
  .sql("INSERT INTO employee VALUES (?)")
  .set("Walter Sobchak")
  .insert(Outcome.VOID)
  .commit();
{% endhighlight %}

In this example we're executing three SQL statements one by one, leaving
connection (and transaction) open unti `commit()` is called.

