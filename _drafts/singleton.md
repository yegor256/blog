---
layout: post
title: "Singletons Must Die"
date: 2016-06-20
place: Los Angeles, CA
tags: oop
description: |
  A singleton is a well-known anti-pattern, though it's
  often not clear what could be used instead
  to access global things.
keywords:
  - singleton
  - singleton java
  - singleton anti-pattern
  - singleton replacement
  - singleton is bad
---

I think it would be too obvious to say that a singleton is an anti-pattern.
There are tons of articles about that. However, very often the question
is how to define global things without a singleton, and that answer is not
so obvious for many of us. There are many examples: a database connection
pool, a repository, a configuration map, etc. They all naturally seem to
be "global". What do we do with them?

<!--more-->

I assume you know what a singleton is and why it's an anti-pattern.
If not, I recommend these articles:

So we agree that it's a bad deal. But what do we do if we need to, let's say,
have access to a database connection pool in many different places within the
application. We simply need something like this:

{% highlight java %}
class Database {
  public static Database INSTANCE = new Database();
  private Database() {
    // create a connection pool
  }
  public java.sql.Connection connect() {
    // Get new connection from the pool
    // and return
  }
}
{% endhighlight %}

Later in at, say, the JAX-RS REST method, we need to retrieve something
from the database:

{% highlight java %}
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
{% endhighlight %}

If you're not familiar with JAX-RS, it's a simple MVC architecture,
and this `text()` method is a "controller". Also, I'm using `SqlSession`,
a simple JDBC wrapper from [jcabi-jdbc](http://jdbc.jcabi.com).

We need that `Database.INSTANCE` to be a singleton, right? We need it to
be globally available so _any_ MVC controller can get direct
access to it. Even if we understand and agree that a singleton is an evil
thing, what do we replace it with?

A [dependency injection]({% pst 2014/oct/2014-10-03-di-containers-are-evil %})
is the answer.

We need to make this database connection pool a dependency of the controller
and ensure it is provided through a constructor. In this particular
case, for JAX-RS, we can't do it through a constructor thanks to its 
ugly architecture. But we can create a `ServletContextListener`,
instantiate a `Database` in its `contextInitialized()` method,
and add that instance as an attribute of `servletContext`. Then, inside
the controller, we retrieve the servlet context by adding the 
`javax.ws.rs.core.Context` annotation to a setter and using `getAttribute()`
on it. It is absolutely terrible and procedural, but it's better
than a singleton.

A proper object-oriented design would pass an instance of `Database`
to _all_ objects that may need it through their constructors.

What do we do if there are many dependencies? Do we make a 10-argument
constructor? No, we don't. If our objects really need 10 dependencies to do
their work, we need to break them down into smaller ones.

That's it. Forget about singletons; never use them. Turn them into dependencies
and pass them from object to object through the operator `new`.
