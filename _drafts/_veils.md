---
layout: post
title: "Veil Objects to Replace DTOs"
date: 2020-05-12
place: Moscow, Russia
tags: oop ruby
description: |
  Using DTOs for high-performance data transfers
  between objects is very effective, but not elegant;
  veil objects are the elegant alternative.
keywords:
  - ruby cache
  - oop ruby
  - cache objects
  - duck typing oop
  - elegant objects
image: /images/2020/05/
jb_picture:
  caption: ...
---

Here is a new idea I discovered just a few days ago while working
with [Codexia](https://github.com/yegor256/codexia),
a Ruby web app. I had to fetch data rows from PostgreSQL and return
objects to the client. It's was always a problem for me, how to do it
without turning objects into DTOs. Here is the solution I found and gave
it a name: Veil Objects.

<!--more-->

{% jb_picture_body %}

Say, I fetch the list of projects from PostgreSQL:

{% highlight ruby %}
class Projects
  def fetch
    @pgsql.exec('SELECT * FROM project')
  end
end
{% endhighlight %}

The method `exec()` of `@pgsql` (I'm using [pgtk](https://rubygems.org/gems/pgtk) gem)
returns an array of [Hashes](https://ruby-doc.org/core-2.7.0/Hash.html),
which would look like this, if we would convert it to JSON:

{% highlight text %}
[
  {"id": 1, "name": "foo", "author": "yegor256"},
  {"id": 2, "name": "bar", "author": "yegor256"},
  {"id": 3, "name": "zoo", "author": "yegor256"}
]
{% endhighlight %}

It would be great to make the method `fetch()` return an array
of objects, not an array of Hashes. My class `Project` looks like this:

{% highlight ruby %}
class Project
  def initialize(pgsql, id)
    @pgsql = pgsql
    @id = id
  end
  def name
    pgsql.exec(
      'SELECT name FROM project WHERE id=$1',
      [@id]
    )[0]['name']
  end
  def author
    pgsql.exec(
      'SELECT author FROM project WHERE id=$1',
      [@id]
    )[0]['author']
  end
end
{% endhighlight %}

It is perfectly designed for single-project manipulations:

{% highlight ruby %}
p = Project.new(pgsql, 123)
name = p.name
author = p.author
{% endhighlight %}

Two SQL requests here is not a big deal. However, if I convert
the list of Hashes to Projects like this, I will have serious
performance problems:

{% highlight ruby %}
class Projects
  def fetch
    @pgsql.exec('SELECT * FROM project').map do |r|
      Project.new(@pgsql, r['id'].to_i)
    end
  end
end
{% endhighlight %}

This is what will kill me, performance wise:

{% highlight ruby %}
projects.fetch do |p|
  puts "#{p.name} is created by #{p.author}"
end
{% endhighlight %}

This code will generate too many redundant SQL request. We will do round-trips
to PostgreSQL to fetch the data we had a few milliseconds ago, while
we were doing `SELECT * FROM project`.

The easiest and the most obvious solution, which many of you may suggest,
is to encapsulate the retrieved Hash into the `Project` object. In other
words, turn `Project` into a [DTO]({% pst 2016/jul/2016-07-06-data-transfer-object %}),
a holder of data. Well, in this case we may
not even need an object, but can return the Hash with the data. However,
this is not how we want our object-oriented software to be designed. We want
to deal with objects, not data structures. And, at the same time, we don't want objects to
be stupid enough to go back to the database for the same data we had
a second ago. Here is the solution I'm proposing:

{% highlight ruby %}
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
{% endhighlight %}

This new `Veil` objects is a decorator of `Project`. It behaves like
a `Project`, but some methods of it are re-defined: `name()` and `author()`.
When they will be called, the calls won't reach the encapsulated `Project`.
Instead, the data stored in the `Veil` will be returned.

It is called the "veil" because it acts like one: the pre-set data is
returned only until some other method is called, which was not pre-set.
If this happens, the veil is pierced and the `Veil` object becomes fully
transparent, sending all method calls through.

Thus, the efficiency of DTO is combined with the elegancy of OOP.

I'm using these new veil objects in
[yegor256/codexia](https://github.com/yegor256/codexia),
you can see how.

