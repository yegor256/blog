---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Why Do You Need Types?"
date: 2025-08-17
place: Moscow, Russia
tags: oop
description: |
  ...
keywords:
  - ...
  - ...
  - ...
  - ...
  - ...
image:
jb_picture:
  caption: ...
---

...

<!--more-->

{% jb_picture_body %}

Imagine a simple Java method:

```
Price costOfDelivery(Book book, City city) {
  Price price = book.price();
  Delivery delivery = new Delivery(price, city);
  return delivery.cost();
}
```

Why do we use `Book`, `City`, `Price`, and `Delivery` types?
Two reasons:

## Types Are Helpful

First, we help the compiler eliminate some dynamic dispatches in favor of static calls.
If the `Book` is a class, not an interface, the `book.price()` call may be compiled into a jump to an absolute address.
Without the information about `book` class, the `.price()` goes to a virtual table first, finds the address, and only then jumps.
The second scenario is more expensive.
Type annotation attached to the `book` helps avoid it.

Second, types help ourselves comprehend code better thus avoiding runtime ``method not found'' mistakes.
Without types, we may call `costOfDelivery()` with the `book` as a `Integer`, meaning book's Id in the database.
In compile time that would lead to no errors.
Later, in runtime, we get an error when `.price()` is not found in the virtual table of the `Integer` class.

Similar to us programmers, IDEs also benefit when they see type annotiations.
They rely on types to provide autocomplete and refactoring tools.
Without types, optimization and static analysis are far weaker.

##

```
costOfDelivery(book, city) {
  p = book.price();
  d = new Delivery(p, city);
  return d.cost();
}
```
