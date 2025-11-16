---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "How to Cache an SQL-Speaking Object?"
date: 2025-11-23
place: St. Petersburg, Russia
tags: oop
description: |
  ...
keywords:
  - OOP cache
  - sql-speaking object
  - cache in OOP
  - how to cache an object
  - object caching
image: /images/2025/11/...
jb_picture:
  caption: ...
---

...

<!--more-->

{% jb_picture_body %}

Let's say we design an online bookstore, with two tables in PostgreSQL:

{% plantuml %}
cart -- item
{% endplantuml %}

Then, we want to calculate the price of the shopping cart, take one book, set a different price to it, and calculate the price of the cart again.
This is how our user-facing code may look like, in Java:

```java
Cart c = new Cart(pg);
float p1 = c.price();  // SELECT SUM(cost) FROM item
Book b = c.get(42);
b.discount(9.95);      // UPDATE item SET cost=9.95
float p2 = c.price();  // SELECT SUM(cost) FROM item
print("The total cart price is %.2f\n", p2);
```

Important to notice: both `cart` and `book` use the same table `item`.
In SQL-speaking objects pattern, we don't map objects to tables, as we do in the ORM pattern.
Instead, every object is free to talk to any tables.

Now, let's try to reduce the number of SQL roundtrips made by the `.price()` method of the `Cart` class.
Let's use read-through cache to persist the result of the first call and reuse it in all consecutive calls:

```java
class Cart {
  private float cache;
  float price() {
    if (cache == null) {
      cache = pg.exec(
        "SELECT SUM(cost) FROM item"
      );
    }
    return cache;
  }
}
```

This works great, until `Book` modifies the `item` table:

```java
class Book {
  void discount(float price) {
    pg.exec(
      "UPDATE item SET cost=$1",
      price
    );
    // Here we must somehow invalidate
    // the cache in the Cart class!
  }
}
```

We must somehow let `Cart` know that its cache must be invalidated.
With a single `Cart` this may not be a challenge.
However, what do we do in a system with dozens or hundreds of classes?
How can `Book` know who of them must be invalidated?

We can use cache-aside pattern, making cache a singleton accessible by `Book` and `Cart`: