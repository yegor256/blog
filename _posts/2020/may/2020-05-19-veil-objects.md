---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Veil Objects to Replace DTOs"
date: 2020-05-19
place: Moscow, Russia
tags: oop ruby
description: |
  Using DTOs for high-performance data transfer
  between objects is very effective, but not elegant;
  veil objects are the elegant alternative.
keywords:
  - ruby cache
  - oop ruby
  - cache objects
  - duck typing oop
  - elegant objects
image: /images/2020/05/constantine.jpg
jb_picture:
  caption: Constantine (2005) by Francis Lawrence
---

Here is a new idea I discovered just a few days ago while working
with [Codexia](https://github.com/yegor256/codexia),
a Ruby web app. I had to fetch data rows from PostgreSQL and return
objects to the client. It's always been a problem for me, how to do that
without turning objects into DTOs. Here is the solution I found and gave
a name: Veil Objects.

<!--more-->

{% jb_picture_body %}

Let's say I fetch the list of projects from PostgreSQL:

```ruby
class Projects
  def fetch
    @pgsql.exec('SELECT * FROM project')
  end
end
```

The method `exec()` on `@pgsql` (I'm using the [pgtk](https://rubygems.org/gems/pgtk) gem)
returns an array of [Hashes](https://ruby-doc.org/core-2.7.0/Hash.html),
which look like this, if we convert them to JSON:

```text
[
  {"id": 1, "name": "foo", "author": "yegor256"},
  {"id": 2, "name": "bar", "author": "yegor256"},
  {"id": 3, "name": "zoo", "author": "yegor256"}
]
```

It would be great to make the method `fetch()` return an array
of objects, not an array of Hashes. So my class `Project` looks like this:

```ruby
class Project
  def initialize(pgsql, id)
    @pgsql = pgsql
    @id = id
  end
  def name
    @pgsql.exec(
      'SELECT name FROM project WHERE id=$1',
      [@id]
    )[0]['name']
  end
  def author
    @pgsql.exec(
      'SELECT author FROM project WHERE id=$1',
      [@id]
    )[0]['author']
  end
end
```

It's perfectly designed for single-project manipulations:

```ruby
p = Project.new(pgsql, 123)
name = p.name
author = p.author
```

Two SQL requests here is not a big deal. However, if I convert
the list of Hashes to Projects like this, I will have serious
performance problems:

```ruby
class Projects
  def fetch
    @pgsql.exec('SELECT * FROM project').map do |r|
      Project.new(@pgsql, r['id'].to_i)
    end
  end
end
```

This is what will kill me, performance-wise:

```ruby
projects.fetch do |p|
  puts "#{p.name} is created by #{p.author}"
end
```

This code will generate too many redundant SQL requests. We will do round-trips
to PostgreSQL to fetch the data we had a few milliseconds ago, while
we were doing `SELECT * FROM project`.

{% youtube nErn5G_JHhE %}

The easiest and the most obvious solution, which many of you might suggest,
is to encapsulate the retrieved Hash into the `Project` object. In other
words, turn `Project` into a [DTO]({% pst 2016/jul/2016-07-06-data-transfer-object %}),
a holder of data. Well, in this case we might
not even need an object, but can instead return the Hash with the data. But
this is not how we want our object-oriented software to be designed. We want
to deal with objects, not data structures. And, at the same time, we don't want objects to
be stupid enough to go back to the database for the same data we had
a second ago. Here is the solution I'm proposing:

```ruby
require 'veils'
class Projects
  def fetch
    @pgsql.exec('SELECT * FROM project').map do |r|
      Veil.new(
        Project.new(@pgsql, r['id'].to_i),
        name: r['name'],
        author: r['author']
      )
    end
  end
end
```

This new `Veil` object from [veils gem](https://rubygems.org/gems/veils)
is a decorator of `Project`. It behaves like
a `Project`, but some of the methods on it are redefined: `name()` and `author()`.
When they are called, the calls won't reach the encapsulated `Project`.
Instead, the data stored in the `Veil` will be returned.

It is called a "veil" because it acts like one: the preset data is
returned only until some other method is called, which was not preset.
If this happens, the veil is pierced and the `Veil` object becomes fully
transparent, sending all method calls through.

Thus the efficiency of DTO is combined with the elegance of OOP.

I'm using these new veil objects in
[yegor256/codexia](https://github.com/yegor256/codexia),
so you can see how they work.

P.S. I also create an `Unpiercable` class, which acts exactly like a `Veil`,
but can never be pierced. It is very useful, when you don't expect any
data-modifying interactions to happen with the object and just want some
of its methods to be pre-calculated.

P.P.S. This is the implementation for
[Kotlin](https://github.com/binkley/kotlin-veil).
