# Zache: A Simple Ruby In-Memory Cache

Source: https://www.yegor256.com/2019/02/05/zache.html

A month ago I stumbled upon a problem: I wasn't able to find a Ruby
gem which would do in-memory caching with the capability to expire
on timeout. After some quick research I decided to implement my own and called
it Zache (as in "zero cache," since there is no back end). Here is how it works:


{% jb_picture_body %}

First, you create the cache:

```ruby
require 'zache'
zache = Zache.new
```

Then you fetch the value by the key, also providing the block which will
be executed if the key is absent or expired:

```ruby
x = zache.get(:x, lifetime: 15) do
  # Something very slow and expensive, which
  # we only want to execute once every 15 seconds.
end
```

Here, `:x` is the key and `15` is the number of seconds it will stay
in the cache, until it expires.

It's important to notice that the key won't be deleted from the cache
automatically. It will stay there until the next call to `get(:x)`. Only at
that moment will it be marked as "expired." In order to clean up the
cache, you can call `zache.clean()` and all expired keys will be deleted.

You can do it regularly in a separate thread, for example, every minute:

```ruby
Thread.start do
  sleep 60
  zache.clean
end
```

Also, Zache, of course, is thread-safe.

The gem is in this [GitHub repository](https://github.com/yegor256/zache).
Feel free to report bugs, if you find them, or help us with additional features.
