---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Singletons Must Die"
date: 2016-06-27
place: Los Angeles, CA
tags: oop
description: |
  A singleton is a well-known anti-pattern; however, it's
  often not clear what could be used instead,
  to access global things.
keywords:
  - singleton
  - singleton java
  - singleton anti-pattern
  - singleton replacement
  - singleton is bad
social:
  - dzone: https://dzone.com/articles/singletons-must-die
image: /images/2016/06/perdita-durango.jpg
jb_picture:
  caption: Perdita Durango (1997) by Álex de la Iglesia
buffer:
  - "Forget about singletons; never use them; turn them into dependencies"
  - "A proper object-oriented design would pass an instance to all objects that may need it through their constructors."
---

I think it's too obvious to say that a singleton is an anti-pattern as
there are tons of articles about that (singleton being an anti-pattern).
However, more often than not, the question
is how to define global things without a singleton; and the answer to that is not
obvious for many of us. There are several examples: a database connection
pool, a repository, a configuration map, etc. They all naturally seem to
be "global"; but what do we do with them?

<!--more-->

{% jb_picture_body %}

I assume you already know what a singleton is and why it's an anti-pattern.
If not, I recommend you read this Stack Overflow thread:
[What is so bad about singletons?](http://stackoverflow.com/questions/137975/what-is-so-bad-about-singletons)

Now that we agree it's a bad deal, what do we do if we need to, let's say,
have access to a database connection pool in many different places within the
application? We simply need something like this:

```java
class Database {
  public static Database INSTANCE = new Database();
  private Database() {
    // Create a connection pool
  }
  public java.sql.Connection connect() {
    // Get a new connection from the pool
    // and return it
  }
}
```

Later in at, say, the JAX-RS REST method, we need to retrieve something
from the database:

```java
@Path("/")
class Index {
  @GET
  public String text() {
    java.sql.Connection connection =
      Database.INSTANCE.connect();
    return new JdbcSession(connection)
      .sql("SELECT text FROM table")
      .fetch(new SingleOutcome(String.class))
  }
}
```

In case you're not familiar with JAX-RS, it's a simple
[MVC]({% pst 2016/dec/2016-12-13-mvc-vs-oop %}) architecture,
and this `text()` method is a "controller." Additionally, I'm using
[`JdbcSession`](https://jdbc.jcabi.com/apidocs-0.16/com/jcabi/jdbc/JdbcSession.html),
a simple JDBC wrapper from [jcabi-jdbc](https://jdbc.jcabi.com).

We need that `Database.INSTANCE` to be a singleton, right? We need it to
be globally available so that _any_ MVC controller can have direct
access to it. Since we all understand and agree that a singleton is an evil
thing, what do we replace it with?

A [dependency injection]({% pst 2014/oct/2014-10-03-di-containers-are-evil %})
is the answer.

{% quote Forget about singletons; never use them; turn them into dependencies. %}

We need to make this database connection pool dependency of the controller
and ensure it's provided through a constructor. However, in this particular
case, for JAX-RS, we can't do it through a constructor thanks to its
ugly architecture. But we can create a [`ServletContextListener`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletContextListener.html),
instantiate a `Database` in its [`contextInitialized()`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletContextListener.html#contextInitialized-javax.servlet.ServletContextEvent-) method,
and add that instance as an attribute of
[`servletContext`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletContext.html). Then, inside
the controller, we retrieve the servlet context by adding the
[`javax.ws.rs.core.Context`](http://docs.oracle.com/javaee/7/api/javax/ws/rs/core/Context.html)
annotation to a setter and using
[`getAttribute()`](https://docs.oracle.com/javaee/7/api/javax/servlet/ServletContext.html#getAttribute-java.lang.String-)
on it. This is absolutely terrible and procedural, but it's better
than a singleton.

A proper object-oriented design would pass an instance of `Database`
to _all_ objects that may need it through their constructors.

Nonetheless, what do we do if there are many dependencies? Do we make a 10-argument
constructor? No, we don't. If our objects really need 10 dependencies to do
their work, we need to break them down into smaller ones.

That's it. Forget about singletons; never use them. Turn them into dependencies
and pass them from object to object through the operator `new`.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Do you use Singletons in your code? <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1152983961674702848?ref_src=twsrc%5Etfw">July 21, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
