---
layout: post
title: "Dependency Injection"
date: 2014-09-25
tags: oop anti-pattern
description:
  While dependency injection is a natural object-oriented
  mechanism, DI frameworks turned it into an anti-pattern
keywords:
  - dependency injection
  - dependency injection is evil
  - downsides of dependency injection
  - dependency injection framework
  -
---

While [dependency injection](http://martinfowler.com/articles/injection.html)
is a natural technique of composing objects in OOP
(known long before the term was introduced by Martin Fowler),
[Spring DI](http://www.spring.io),
[Google Guice](https://code.google.com/p/google-guice/),
[Java EE6 CDI](http://docs.oracle.com/javaee/6/tutorial/doc/giwhl.html),
[Dagger](http://square.github.io/dagger/) and other
[frameworks](https://en.wikipedia.org/wiki/Dependency_injection)
based on anything else besides
["Constructor Injection"](https://en.wikipedia.org/wiki/Dependency_injection#Constructor_injection),
is a terrible violation of basic principles of object-oriented programming.

These frameworks (not only in Java) encourage us to create
incomplete mutable objects, stuffed with data during the course
of application execution. I already mentioned in previous
articles, that, in a perfect OOP world, objects
[must be immutable]({% post_url 2014/jun/2014-06-09-objects-should-be-immutable %})
and [may not contain setters]({% post_url 2014/sep/2014-09-16-getters-and-setters-are-evil %}).

Dependency injection frameworks only makes code dirtier and messy.

<!--more-->

## What is Dependency Injection?

This is what dependency injection (is not really different
from a plain old object composition):

{% highlight java %}
public class Budget {
  private final DB db;
  public Budget(DB data) {
    this.db = data;
  }
  public long total() {
    return this.db.cell(
      "SELECT SUM(cost) FROM ledger"
    );
  }
}
{% endhighlight %}

Object `data` is a dependency.

A `Budget` doesn't know what kind of database it is working with. All he
needs from the database is its ability to fetch a cell, using an
arbitrary SQL query, via method `cell()`. We can instantiate an `Budget` with a PostgreSQL
implementation of the `DB` interface, for example:

{% highlight java %}
Budget budget = new Budget(
  new Postgres("jdbc:postgresql:5740/main")
);
System.out.println("Total budget: " + budget.total());
{% endhighlight %}

An alternative to this "dependency injection" approach would be
to let `Budget` to decide what database he wants to work with:

{% highlight java %}
public class Budget {
  private final DB db = new Postgres("jdbc:postgresql:5740/main");
  // class methods
}
{% endhighlight %}

This is very dirty and leads to 1) code duplication, 2) inability
to reuse, 3) inability to test, etc. No need to discuss, it is obvious.

Thus, dependency injection via constructor is an amazing technique.
Not even a technique, but a feature of Java and all other object-oriented
languages. It is expected than almost any object wants to encapsulate
some knowledge (aka "state). That's what constructors are for.

## Setter Injector

Here comes the dark side:

{% highlight java %}
public class Budget {
  private final DB db;
  @Inject
  public void setDb(DB data) {
    this.db = data;
  }
  // class methods
}
{% endhighlight %}

And then we're supposed to configure a dependency injection container
somewhere, when the application starts (I'm using Google Guice):

{% highlight java %}
Injector injector = Guice.createInjector(
  new AbstractModule() {
    @Override
    public void configure() {
      this.bind(DB.class).toInstance(
        new Postgres("jdbc:postgresql:5740/main")
      );
    }
  }
);
{% endhighlight %}

And finally, magic happens:

{% highlight java %}
Budget budget = injector.getInstance(Budget.class);
{% endhighlight %}

Boom! Right at this point, after `new` operator's execution,
a dependency injection engine calls our setter `setDB()` and injects
`postegres` into `jeff`. It happens behind the scene and is
supposed to simplify our code and let it focus on solving
business problems.

