---
layout: post
title: "Fluent JDBC Decorator"
date: 2014-08-07
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

This is how you fetch rows from an SQL table
with [jcabi-jdbc](http://jdbc.jcabi.com):

{% highlight java %}
Collection<String> names = new JdbcSession(source)
  .sql("SELECT name FROM employee WHERE salary > 35000")
  .select(
    new Outcome<Collection<String>>() {
      @Override
      public Collection<String> handle(ResultSet rset) throws SQLException {
        Collection<String> names = new LinkedList<>();
        while (rset.next()) {
          names.add(rset.getString(1));
        }
        return names;
      }
    }
  );
{% endhighlight %}

<!--more-->

[jcabi-jdbc](http://jdbc.jcabi.com) is a lightweight wrapper of
[JDBC](http://www.oracle.com/technetwork/java/javase/jdbc/index.html).
It is very convenient to use when you don't need a full-scale
ORM (like Hibernate), but just need to select, insert, or update
a few rows in a relational database.
