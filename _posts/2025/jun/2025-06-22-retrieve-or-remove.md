---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "removeById(42) vs findById(42).remove()"
date: 2025-06-08
place: Moscow, Russia
tags: oop
description: |
  ...
keywords:
  - retrieve vs remove
  - oop design
  - object-oriented
  - objects vs methods
  - objects vs procedures
image: /images/2025/06/
jb_picture:
  caption:
---

You have a list of books in the `books` object.
How do you remove a single book from it provided you know its ID?
You can do `books.removeById(42)`.
Alternatively, you can find it with `books.findById(42)` and then `b.remove()`.
Which option do you prefer and why?
The second choice is the right one.
Not only because it's more object-oriented.
There are a few practical benefits.

<!--more-->

{% jb_picture_body %}

First, what if you want to extend the deletion algorithm?
Let's say, you want to print a log message every time a book is deleted.
If you respect the open-closed principle, you don't want to modify the existing `Book` or `Books` classes.
Instead, you want to either extend or decorate them.
A decorator is the only right choice if you don't appreciate implementation inheritance.
If it's `removeById()`, you have to decorate the `books`.
If it's `remove()` you decorate the `book` retrieved by the `findById()`.
The former may be more **cohesive** since its decoratee is probably **smaller**.

```ruby
b = books.findById(42)
b = Logged.new(b)
b.remove!
```

Second, what if it's not found or can't be deleted?
The `removeById()` doesn't allow you to use NullObject pattern.
You can only throw an exception.
You may return `false` but you shouldn't, respecting the CQRS principle.
To the contrary, returning an object, even if the book is not found, gives you more flexibility of **error handling**.
For example, exception chaining looks neat:

```ruby
b = books.findById(42)
begin
  b.remove!
rescue => e
  raise e, "Can't delete book ##{b.id}"
end
```
