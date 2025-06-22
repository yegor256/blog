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

We have a list of books in the `books` object.
How do we remove a single book from it provided we know its ID?
We can do `books.removeById(42)`.
Alternatively, we can find it with `books.findById(42)` and then `b.remove()`.
Which option do we prefer and why?
The second choice is the right one.
Not only because it's more object-oriented.
There are a few practical benefits.

<!--more-->

{% jb_picture_body %}

First, what if we want to extend the deletion algorithm?
Let's say, we want to print a log message every time a book is deleted.
If we respect the open-closed principle, we don't want to modify the existing `Book` or `Books` classes.
Instead, we want to either extend or decorate them.
A decorator is the only right choice if we don't appreciate implementation inheritance.
If it's `removeById()`, we have to decorate the `books`.
If it's `remove()` we decorate the `book` retrieved by the `findById()`.
The former may be more **cohesive** since its decoratee is probably **smaller**:

```ruby
b = books.findById(42)
b = Logged.new(b)
b.remove!
```

Second, what if it's not found or can't be deleted?
The `removeById()` doesn't allow us to use NullObject pattern.
We can only throw an exception.
We may return `false` but we shouldn't, since we respect the CQRS principle.
To the contrary, returning an object, even if the book is not found, gives us more flexibility of **error handling**.
For example, we can use `title()` safely because we know that book was found successfully, while chaining exception:

```ruby
b = books.findById(42)
begin
  b.remove!
rescue e
  raise e, "Can't delete book #{b.title}"
end
```

Third, what if finding an object is far away from its deletion?
If books know how to find and a book knows how to delete, the book may be immutable.
Moreover, it encapsulates the ID, thus hiding it better:

```ruby
b = books.findById(42)
# +100 lines here...
b.remove!  # DELETE FROM book WHERE id = 42
# +200 lines here...
if b.exists?  # SELECT * FROM book WHERE id = 42
  puts "The book is back to the library!"
end
```

Once the ID is encapsulated into the book by `findById()`, it never gets out.
