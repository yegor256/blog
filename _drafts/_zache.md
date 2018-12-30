---
layout: post
title: "Zache: A Simple Ruby In-Memory Cache"
date: 2019-01-01
place: Moscow, Russia
tags: ruby
description: |
  Zache is a simple Ruby Gem for thread-safe in-memory caching,
  which, I was suprised to find out, hasn't been implemented so far
  in any other Gems.
keywords:
  - ruby cache
  - ruby in-memory cache
  - ruby caching
  - memory caching ruby
  - ruby simple cache
---

A month ago I stumbled upon a problem: I wasn't able to find a Ruby
gem, which would do in-memory caching, with the possibility to expire
on timeout. After a quick research I decided to implement my own and called
it zache (as in "zero cache," since there is no backend). Here is how it works:

<!--more-->

{% jb_picture_body %}

First, you create a storage:

{% highlight ruby %}
require 'zache'
zache = Zache.new
{% endhighlight %}

Then, you fetch the value by the key, providing the block, which will
be executed if the key is absent or is expired:

{% highlight ruby %}
x = zache.get(:x, lifetime: 15) do
  # Something very slow and expensive, which
  # we only want to execute once every 15 seconds.
end
{% endhighlight %}

Here, `:x` is the key and `15` is the amount of seconds it will stay
in the cache, until it becomes expired.

It's important to notice that the key won't be deleted from the cache
automatically. It will stay there until the next call to `get(:x)`. Only at
that moment it will be deleted as "expired." In order to clean up the
cache, you can call `zache.clean()` and all expired keys will be deleted.

You can do it regularly in a separate thread, for example, every minute:

{% highlight ruby %}
Thread.start do
  sleep 60
  zache.clean
end
{% endhighlight %}

Also, Zache, of course, is thread-safe.

The Gem is in this [GitHub repository](https://github.com/yegor256/zache),
feel free to file bugs, if you find them, or help us with additional features.
