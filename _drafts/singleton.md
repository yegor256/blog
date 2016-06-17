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

So we agree that it's a bad deal. But what do we do if we need, let's say,
to have an access to a database connection pool in many places of the
application. We simply need something like this:

{% highlight java %}
class Database {
  public static Database INSTANCE = new Database();
  private Database() {
    // create a connection pool
  }
  public java.sql.Connection connect() {
    // get new connection from the pool
    // and return
  }
}
{% endhighlight %}

Later in, say, JAX-RS REST method we need to retrieve something
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

If you're not familiar with JAX-RS, it's a simple MVC architecture
and this `text()` method is a "controller". Also, I'm using `SqlSession`,
a simple JDBC wrapper from [jcabi-jdbc](http://jdbc.jcabi.com).

We need that `Database.INSTANCE` to be a Singleton, right? We need it to
be globally available so that _any_ MVC controller can get a direct
access to it. Even if we understand and agree that Singleton is an evil
thing, what to replace it with?

[Dependency injection]({% pst 2014/oct/2014-10-03-di-containers-are-evil %})
is the answer.

We need to make this database connection pool a dependency of the controller
and make sure it is provided through a constructor. In this particular
case, in JAX-RS, thanks to its ugly architecture, we can't
do it through a constructor. But we can create a `ServletContextListener`,
instantiate a `Database` in its `contextInitialized()` method
and put that instance as an attribute into `servletContext`. Then, inside
the controler, we retrieve the servlet context by adding
`javax.ws.rs.core.Context` annotation to a setter and using `getAttribute()`
on it. It is absolutely terrible and procedural, but it's better
than a Singleton.

A proper object-oriented design would be to pass an instance of `Database`
to _all_ objects that may need it through their constructors.

What to do if there are many of dependencies? Do we make a 10-arguments
constructor? No, we don't. If our objects really need 10 dependencies to do
their work, we need to break them down into smaller ones.

That's it. Forget about Singletons. Never use them. Turn them into dependencies
and pass from object to object through operator `new`.
