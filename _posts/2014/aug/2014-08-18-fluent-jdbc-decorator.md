---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Fluent JDBC Decorator"
date: 2014-08-18
tags: java jcabi
description: |
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

{% badge https://www.jcabi.com/logo-square.svg 64 https://aspects.jcabi.com %}

This is how you fetch text from a SQL table
with [jcabi-jdbc](https://jdbc.jcabi.com):

```java
String name = new JdbcSession(source)
  .sql("SELECT name FROM employee WHERE id = ?")
  .set(1234)
  .select(new SingleOutcome<String>(String.class));
```

Simple and straight forward, isn't it? The library
simplifies interaction with relational databases
via JDBC, avoiding the need to use
[ORM]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %}).

<!--more-->

[jcabi-jdbc](https://jdbc.jcabi.com) is a lightweight wrapper of
[JDBC](https://www.oracle.com/technetwork/java/javase/jdbc/index.html).
It is very convenient to use when you don't need a full-scale
[ORM]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %})
(like Hibernate), but want just to select, insert, or update
a few rows in a relational database.

Every instance of `JdbcSession` is a "transaction" in a database.
You start it by instantiating the class with a single parameter---data source.

You can obtain the data source from your connection pool. There are many
implementations of connection pools. I would recommend that you use
[BoneCP](https://www.jolbox.com/). Below is an example of how you would connect to PostgreSQL:

```java
@Cacheable(forever = true)
private static DataSource source() {
  BoneCPDataSource src = new BoneCPDataSource();
  src.setDriverClass("org.postgresql.Driver");
  src.setJdbcUrl("jdbc:postgresql://localhost/db_name");
  src.setUser("jeff");
  src.setPassword("secret");
  return src;
}
```

Be sure to pay attention to the `@Cacheable` annotation.
[This post]({% pst 2014/aug/2014-08-03-cacheable-java-annotation %})
explains how it can help you to cache Java method results for some time.
Setting the `forever` attribute to `true` means that we don't want this
method to be called more than once. Instead, we want the connection pool
to be created just once, and every second call should return its
existing instance (kind of like a
[Singleton pattern]({% pst 2016/feb/2016-02-03-design-patterns-and-anti-patterns %})).

[jcabi-jdbc](https://jdbc.jcabi.com) website explains how you
can [insert](https://jdbc.jcabi.com/example-insert.html),
[update](https://jdbc.jcabi.com/example-update.html), or
delete a row. You can also
[execute any SQL statement](https://jdbc.jcabi.com/example-execute.html).

By default, `JdbcSession` closes the JDBC connection right after the
first select/update/insert operation. Simply put, it is designed
to be used mainly for single atomic transactions. However, it is
possible to leave the connection open and continue, for example:

```java
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
```

In this example we're executing three SQL statements one by one, leaving
connection (and transaction) open until `commit()` is called.
