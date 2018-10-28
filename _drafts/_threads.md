---
layout: post
title: "Do You Test Ruby Code for Thread-Safety?"
date: 2018-10-01
place: Moscow, Russia
tags: ruby
description: |
  Do you test your Ruby classes for thread-safety? If you do,
  you may find this new Ruby gem useful, it helps you start
  multiple threads, run the code inside, and validate the output.
keywords:
  - ruby threads
  - ruby thread-safety
  - ruby concurrency
  - test thread safety ruby
  - ruby tests
---

Are you a Ruby developer? If you are, I'm pretty sure you have a very
vague idea of what concurrency and thread-safety is. No offense, but this
is what I figured after dealing with Ruby code and speaking with Ruby
programmers over the last half a year. I'm writing in Ruby pretty actively
recently and I do like the language and the eco-system around it.
Zold, the experimental cryptocurrency we are creating now, is written almost
entirely in Ruby. What does it tell you? I like Ruby. But when it comes
to concurrency, there are white spots. Big time.

<!--more-->

Look at this Ruby class:

{% highlight ruby %}
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
{% endhighlight %}

It's a simple web server. It does work, try to run it like this
(you will need Ruby 2.3+ installed):

{% highlight ruby %}
$ gem install sinatra
$ ruby server.rb
{% endhighlight %}

Then, open `http://localhost:4567` and you will see the counter. Refresh
the page and the counter will increment. Try again. It works. The counter
is in the file `idx.txt` and it's essentially is
a [global variable]({% pst 2018/jul/2018-07-03-global-variables %}),
which we increment on every HTTP request.

Let's create a unit test for it, to make sure it is automatically tested:

{% highlight ruby %}
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
{% endhighlight %}

OK, it's not a unit test, but more like an integration test.
First, we start a web server in a background thread. Then,
we wait for a second, to give that thread enough time to bootstrap
the server. I know, it's a very ugly approach, but I don't know anything
better for this small example. Then, we make an HTTP request and
compare it with the expected number 1. Finally, we stop the web server.

So far so good. Now, the question is what will happen when may
requests will be sent to the server? Will it still return correct and
consecutive numbers? Let's try:

{% highlight ruby %}
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
{% endhighlight %}

Here we make a thousand requests and put all returned numbers into an
array. Then, we `uniq` the array and `count` its elements. If there is
a thousand of them---everything works fine, we received a correct list
of consecutive numbers. I just tested it, it works.

But we are making them one by one, that's why our server doesn't have
any problems. We don't do them concurrenctly. They go strictly one
after another. Let's try to use a few additional threads to simulate
parallel execution of HTTP requests:

{% highlight ruby %}
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
  assert_equal(1000, numbers.to_a.uniq.count)
  Front.stop!
end
{% endhighlight %}

First of all, the list of numbers we keep in a
[`Concurrent::Set`](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Set.html), which
is a thread-safe version of Ruby [`Set`](http://ruby-doc.org/stdlib-2.4.0/libdoc/set/rdoc/Set.html).
Second, we start five background threads, each of which makes 200 HTTP requests.
They all run parallel and we wait for their finish by calling `join` at
each of them. Finally, we take the numbers out of the Set and validate
the correctness of the list.

No surprise, it fails.

Of course, you know why. Because the implementation is not _thread-safe_. When
one thread is reading the file, another one is writing it. Eventually, and very
soon, they clash and the content of the file gets broken. The more threads
we put into test, the less accurate will be the result.

In order to make this type of testing easier, I created
[threads](https://github.com/yegor256/threads),
a simple Ruby gem. Here is how it works:

{% highlight ruby %}
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
  assert_equal(1000, numbers.to_a.uniq.count)
  Front.stop!
end
{% endhighlight %}

That's it. This single line with `Threads.new()` replaces all other lines,
where we have to create threads, make sure they start at the same time,
and then collect their results and make sure their stacktraces are visible
in the console, if they crash (by default, the error log of a background
thread is not visible).

Try this gem in your projects, it's pretty well tested already and I
already use it in all my concurrency tests.
