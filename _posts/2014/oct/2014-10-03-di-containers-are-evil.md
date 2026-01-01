---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Dependency Injection Containers are Code Polluters"
date: 2014-10-03
tags: oop
description: |
  While dependency injection is a natural object-oriented
  mechanism, DI frameworks turn it into an anti-pattern.
keywords:
  - dependency injection
  - dependency injection is evil
  - downsides of dependency injection
  - dependency injection framework
  - drawbacks of dependency injection
  - setter injection
  - constructor injection
  - field injection
book: elegant-objects-2 6.3
---

While [dependency injection](https://martinfowler.com/articles/injection.html) (aka, "DI")
is a natural technique of composing objects in OOP
(known long before the term was [introduced by Martin Fowler](https://www.martinfowler.com/articles/injection.html)),
[Spring IoC](https://www.spring.io),
[Google Guice](https://code.google.com/p/google-guice/),
[Java EE6 CDI](http://docs.oracle.com/javaee/6/tutorial/doc/giwhl.html),
[Dagger](http://square.github.io/dagger/) and other
[DI frameworks](https://en.wikipedia.org/wiki/Dependency_injection)
turn it into an _anti-pattern_.

<!--more-->

{% youtube MNxG1xcA2uA %}

I'm not going to discuss obvious arguments against
"setter injections"
(like in [Spring IoC](https://www.springbyexample.org/examples/intro-to-ioc-basic-setter-injection.html))
and
"field injections"
(like in [PicoContainer](http://picocontainer.codehaus.org/annotated-field-injection.html)).
These mechanisms simply violate basic principles
of object-oriented programming and encourage us to create
incomplete, mutable objects, that get stuffed with data during the course
of application execution. Remember: ideal objects
[must be immutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %})
and [may not contain setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}).

Instead, let's talk about "constructor injection"
(like in [Google Guice](https://github.com/google/guice/wiki/Injections#constructor-injection))
and its use with dependency injection _containers_.
I'll try to show why I consider these containers a redundancy, at least.

## What is Dependency Injection?

This is what dependency injection is (not really different
from a plain old object [composition]({% pst 2015/feb/2015-02-26-composable-decorators %})):

```java
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
```

The object `data` is called a "dependency."

A `Budget` doesn't know what kind of database it is working with. All it
needs from the database is its ability to fetch a cell, using an
arbitrary SQL query, via method `cell()`. We can instantiate a `Budget` with a PostgreSQL
implementation of the `DB` interface, for example:

```java
public class App {
  public static void main(String... args) {
    Budget budget = new Budget(
      new Postgres("jdbc:postgresql:5740/main")
    );
    System.out.println("Total is: " + budget.total());
  }
}
```

In other words, we're "injecting" a dependency into a new object `budget`.

An alternative to this "dependency injection" approach would be
to let `Budget` decide what database it wants to work with:

```java
public class Budget {
  private final DB db =
    new Postgres("jdbc:postgresql:5740/main");
  // class methods
}
```

This is very dirty and leads to 1) code duplication, 2) inability
to reuse, and 3) inability to test, etc. No need to discuss
why. It's [obvious](http://programmers.stackexchange.com/questions/19203).

Thus, dependency injection via a constructor is an amazing technique.
Well, not even a technique, really. More like a feature of Java and all other object-oriented
languages. It's expected that almost any object will want to
[encapsulate]({% pst 2014/dec/2014-12-15-how-much-your-objects-encapsulate %})
some knowledge (aka, a "state"). That's what
[constructors]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %}) are for.

## What is a DI Container?

So far so good, but here comes the dark side---a dependency
injection container. Here is how it works (let's use
[Google Guice](https://github.com/google/guice)
as an example):

```java
import javax.inject.Inject;
public class Budget {
  private final DB db;
  @Inject
  public Budget(DB data) {
    this.db = data;
  }
  // same methods as above
}
```

Pay attention: the constructor is annotated with
[`@Inject`](http://docs.oracle.com/javaee/6/api/javax/inject/Inject.html).

Then, we're supposed to configure a container
somewhere, when the application starts:

```java
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
```

Some frameworks even allow us to configure the injector in an XML file.

From now on, we are not allowed to instantiate `Budget` through the `new` operator,
like we did before. Instead, we should use the injector we just created:

```java
public class App {
  public static void main(String... args) {
    Injection injector = // as we just did in the previous snippet
    Budget budget = injector.getInstance(Budget.class);
    System.out.println("Total is: " + budget.total());
  }
}
```

The injection automatically finds out that in order to instantiate
a `Budget` it has to provide an argument for its constructor. It will
use an instance of class `Postgres`, which we instantiated in the injector.

{% youtube oV6Utb5Jows %}

This is the right and recommended way to use Guice. There are
a few even darker patterns, though, which are possible but not recommended. For example,
you can make your injector a
[singleton]({% pst 2016/jun/2016-06-27-singletons-must-die %}) and use it right inside the `Budget` class.
However, these mechanisms are considered wrong even by DI container makers.
Let's ignore them and focus on the recommended scenario.

## What Is This For?

Let me reiterate and summarize the scenarios of _incorrect usage_ of dependency
injection containers:

 * Field injection

 * Setter injection

 * Passing injector as a dependency

 * Making injector a global [singleton]({% pst 2016/jun/2016-06-27-singletons-must-die %})

If we put all of them aside, all we have left is the constructor
injection explained above. And how does that help us? Why do we need it?
Why can't we use plain old `new` in the main class of the application?

The container we created simply adds more lines to the code base,
or even more files, if we use XML. And it doesn't add anything, except
an additional _complexity_. We should always remember this
if we have the question: "What database is used as an argument of a Budget?"

## The Right Way

Now, let me show you a real life example of using `new` to construct
an application. This is how we create a "thinking engine" in
[rultor.com](https://www.rultor.com) (full class is in
[`Agents.java`](https://github.com/yegor256/rultor/blob/1.34/src/main/java/com/rultor/agents/Agents.java)):

<script src="https://gist.github.com/c76c06baee1f74e3100e.js?file=Agents.java"> </script>

Impressive? This is a true
[object composition]({% pst 2015/feb/2015-02-26-composable-decorators %}).
I believe this is how a proper object-oriented application
should be instantiated.

And DI containers? In my opinion, they just add unnecessary noise.
