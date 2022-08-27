---
layout: post
title: "Do You Test Ruby Code for Thread Safety?"
date: 2018-11-06
place: Moscow, Russia
tags: ruby
description: |
  Do you test your Ruby classes for thread safety? If you do,
  you may find this new Ruby gem useful. It helps you start
  multiple threads, run the code inside, and validate the output.
keywords:
  - ruby threads
  - ruby thread-safety
  - ruby concurrency
  - test thread safety ruby
  - ruby tests
---

Are you a Ruby developer? If you are, I'm pretty sure you have a very
vague idea of what concurrency and thread safety are. No offense, but this
is what I've figured out after dealing with Ruby code and speaking with Ruby
programmers over the last half a year. I've been writing in Ruby pretty actively
recently and I do like the language and the ecosystem around it.
Zold, the experimental cryptocurrency we are creating, is written almost
entirely in Ruby. What does that tell you? I like Ruby. But when it comes
to concurrency, there are blank spots. Big time.

<!--more-->

Look at this Ruby class:

```ruby
require 'sinatra'
class Front < Sinatra::Base
  configure do
    IO.write('idx.txt', '0')
  end
  get '/' do
    idx = IO.read('idx.txt').to_i + 1
    IO.write('idx.txt', idx.to_s)
    idx.to_s
  end
end
Front.run!
```

It's a simple web server. It does work---try to run it like this
(you will need Ruby 2.3+ installed):

```ruby
$ gem install sinatra
$ ruby server.rb
```

Then, open `http://localhost:4567` and you will see the counter. Refresh
the page and the counter will increment. Try again. It works. The counter
is in the file `idx.txt` and it's essentially
a [global variable]({% pst 2018/jul/2018-07-03-global-variables %}),
which we increment on every HTTP request.

Let's create a unit test for it, to make sure it is automatically tested:

```ruby
require 'minitest/autorun'
require 'net/http'
require 'uri'
class FrontTest < Minitest::Test
  def test_works
    front = Thread.start do
      Front.run!
    end
    sleep 1
    count = Net::HTTP.get(URI('http://localhost:4567/')).to_i
    assert_equal(1, count)
    Front.stop!
  end
end
```

OK, it's not a unit test, but more like an integration test.
First we start a web server in a background thread. Then
we wait for a second, to give that thread enough time to bootstrap
the server. I know, it's a very ugly approach, but I don't have anything
better for this small example. Next we make an HTTP request and
compare it with the expected number 1. Finally, we stop the web server.

So far so good. Now, the question is, what will happen when many
requests are sent to the server? Will it still return the correct,
consecutive numbers? Let's try:

```ruby
def test_works
  front = Thread.start do
    Front.run!
  end
  sleep 1
  numbers = []
  1000.times do
    numbers << Net::HTTP.get(URI('http://localhost:4567/')).to_i
  end
  assert_equal(1000, numbers.uniq.count)
  Front.stop!
end
```

Here we make a thousand requests and put all the returned numbers into an
array. Then we `uniq` the array and `count` its elements. If there is
a thousand of them---everything worked fine, we received a correct list
of consecutive, unique numbers. I just tested it, and it works.

But we are making them one by one, that's why our server doesn't have
any problems. We aren't making them concurrently. They go strictly one
after another. Let's try to use a few additional threads to simulate
parallel execution of HTTP requests:

```ruby
require 'concurrent/set'
def test_works
  front = Thread.start do
    Front.run!
  end
  sleep 1
  numbers = Concurrent::Set.new
  threads = []
  5.times do
    threads << Thread.start do
      200.times do
        numbers << Net::HTTP.get(URI('http://localhost:4567/')).to_i
      end
    end
  end
  threads.each { |t| t.join }
  assert_equal(1000, numbers.to_a.count)
  Front.stop!
end
```

First of all, we keep the list of numbers in a
[`Concurrent::Set`](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Set.html), which
is a thread-safe version of Ruby [`Set`](http://ruby-doc.org/stdlib-2.4.0/libdoc/set/rdoc/Set.html).
Second, we start five background threads, each of which makes 200 HTTP requests.
They all run in parallel and we wait for them to finish by calling `join` on
each of them. Finally, we take the numbers out of the Set and validate
the correctness of the list.

No surprise, it fails.

Of course, you know why. Because the implementation is not _thread-safe_. When
one thread is reading the file, another one is writing it. Eventually, and very
soon, they clash and the contents of the file is broken. The more threads
we put into the test, the less accurate will be the result.

In order to make this type of testing easier I created
[threads](https://github.com/yegor256/threads),
a simple Ruby gem. Here is how it works:

```ruby
require 'threads'
def test_works
  front = Thread.start do
    Front.run!
  end
  sleep 1
  numbers = Concurrent::Set.new
  Threads.new(5).assert(1000) do
    numbers << Net::HTTP.get(URI('http://localhost:4567/')).to_i
  end
  assert_equal(1000, numbers.to_a.count)
  Front.stop!
end
```

That's it. This single line with `Threads.new()` replaces all other lines,
where we have to create threads, make sure they start at the same time,
and then collect their results and make sure their stack traces are visible
in the console if they crash (by default, the error log of a background
thread is not visible).

Try this gem in your projects, it's pretty well tested already and I
use it in all my concurrency tests.
