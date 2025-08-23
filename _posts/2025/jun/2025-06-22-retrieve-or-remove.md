---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "remove(42) vs. find(42).remove()"
date: 2025-06-22
place: Moscow, Russia
tags: oop
description: |
  Delegating behavior to objects rather than invoking utility
  methods leads to cleaner, more extensible, and properly
  encapsulated object-oriented design.
keywords:
  - retrieve vs remove
  - oop design
  - object-oriented
  - objects vs methods
  - objects vs procedures
image: /images/2025/06/8-femmes.jpg
jb_picture:
  caption: 8 Femmes (2002) by François Ozon
---

We have a list of books in the `books` object.
How do we remove a single book from it, given that we know its ID?
We can do `books.removeById(42)`.
Alternatively, we can find it with `books.findById(42)` and then call `b.remove()`.
Which option should we prefer, and why?
The second choice is the better one.
Not only because it's more object-oriented, but also due to several practical advantages.

<!--more-->

{% jb_picture_body %}

## Extending the Deletion Behavior

What if we want to extend the deletion algorithm?
For example, suppose we want to print a log message every time a book is deleted.

If we follow the [open-closed principle], we should avoid modifying the existing `Book` or `Books` classes.
Instead, we want to either [extend]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %}) or [decorate]({% pst 2015/feb/2015-02-26-composable-decorators %}) them.
A decorator is the ideal choice if we want to avoid [implementation inheritance]({% pst 2016/sep/2016-09-13-inheritance-is-procedural %}).

If we use `removeById()`, we must decorate the `books` object.
If we use `remove()`, we can decorate the individual book retrieved via `findById()`.
The latter approach may be more **cohesive**, since its decoratee is likely **smaller** and more **focused**:

```ruby
b = books.findById(42)
b = Logged.new(b)
b.remove!
```

## Handling Missing or Non-Deletable Books

What if the book isn't found, or can't be deleted?
The `removeById()` approach doesn't support the [Null Object] pattern well.
It forces us to throw an exception---or worse, return `false`, which goes [against]({% pst 2018/aug/2018-08-22-builders-and-manipulators%}) the [CQS] principle.

On the other hand, returning an object, even a [null][Null Object] or [fake]({% pst 2014/sep/2014-09-23-built-in-fake-objects %}) object, offers more **flexible error handling**.
For instance, we can access `title()` safely, knowing that the book was found successfully---or catch and [re-raise exceptions][exception chaining] with [more context]({% pst 2015/dec/2015-12-01-rethrow-exceptions %}):

```ruby
b = books.findById(42)
begin
  b.remove!
rescue e
  raise e, "Can't delete book #{b.title}"
end
```

## Decoupling Retrieval and Deletion

What if the retrieval and deletion of the object happen far apart in the code?

If `books` knows how to find, and a `book` knows how to delete, we keep responsibilities nicely separated.
It also allows the book to be immutable and encapsulate its own ID, reducing [leakage]({% pst 2016/nov/2016-11-21-naked-data %}) of internal data:

```ruby
b = books.findById(42)
# +100 lines here...
b.remove!  # DELETE FROM book WHERE id = 42
# +200 lines here...
if b.exists?  # SELECT * FROM book WHERE id = 42
  puts "The book is back to the library!"
end
```

Once the ID is wrapped inside the book by `findById()`, it never has to **leak out** again.
This reduces the amount of [naked data]({% pst 2016/nov/2016-11-21-naked-data %}) exposed to parts of the code that don't need it.

The less data is visible, the [better]({% pst 2016/nov/2016-11-21-naked-data %}) the design---at least from an OOP perspective.

Thus, using `findById()` followed by `remove()` embraces object-oriented principles more fully.
It allows for cleaner extension, better error handling, and tighter encapsulation.

[open-closed principle]: https://en.wikipedia.org/wiki/Open%E2%80%93closed_principle
[Null Object]: https://en.wikipedia.org/wiki/Null_object_pattern
[exception chaining]: https://en.wikipedia.org/wiki/Exception_chaining
[CQS]: https://en.wikipedia.org/wiki/Command%E2%80%93query_separation
