---
layout: post
title: "Logging Without a Static Logger"
date: 2019-03-19
place: Moscow, Russia
tags: oop
description: |
  Traditionally in Java and many other languages we
  use static loggers, which are in essence global variables
  or singletons; there is a better way to log.
keywords:
  - static logger
  - logger static
  - java static logger
  - java logger
  - ruby logger
image: /images/2019/03/the-square.jpg
jb_picture:
  caption: The Square (2017) by Ruben Östlund
---

How do you organize logging in your applications? I mean web applications
or command line apps, or even mobile apps. I bet you have some global
variable or a singleton, known as `Logger`, which has a few methods
like `info()`, `error()`, and `debug()`. You configure it when the app
starts, or it configures itself via something like `log4j.properties`,
and logs everything to the console or a file, or even a database. I was
doing exactly that, or [something very similar]({% pst 2014/may/2014-05-23-avoid-java-static-logger %}),
for many years, until I finally realized how wrong
this approach was. In one of my recent Ruby applications I did it all
differently, and since then I'm much happier than I was before.

<!--more-->

{% jb_picture_body %}

Well, if your application is simple and has almost no unit or integration
tests, you will be doing just fine with a static logger, which in essence
is a global variable. However, as we [discussed before]({% pst 2018/jul/2018-07-03-global-variables %}),
global variables are evil. What can go wrong if we use a static logger?
Or, in other words, as one of my friends used to say, what exactly is the problem
we are going to solve? Basically, there are two problems:

  * First, with a single global logger you will have a hard time
    writing a unit test to check whether your app is actually logging
    things correctly. Even if you intercept the log stream, there will be
    a lot of noise, coming from other threads and other tests. It's not
    an unsolvable problem, but its solution adds complexity to your tests.

  * Second, when you decide to show a selected part of the log to your
    end-user, you will have to do a lot of coding just in order to separate
    what belongs to the user and what does not, especially in a multi-threaded
    environment. You're lucky if it's Java and you have thread groups,
    but in Ruby, for example, there is no such thing and you will have to
    find some workaround.

To overcome them both, in [Zold](https://github.com/zold-io/zold),
a Ruby command line application, I decided to pass `log` as a variable
to all classes that need any logging. In Ruby it's easier than in Java,
because they have [optional](https://stackoverflow.com/questions/35747905)
parameters. Look at [this class](https://github.com/zold-io/zold/blob/0.26.17/lib/zold/commands/list.rb),
for example (it's a simplified version, of course):

```ruby
class Zold::List
  def initialize(wallets:, log: Log::NULL)
    @wallets = wallets
    @log = log
  end
  def run
    @wallets.all.sort.each do |id|
      @wallets.acq(id) do |wallet|
        @log.info("#{id}: #{wallet.balance}")
      end
    end
  end
end
```

This class is supposed to list all wallets in the current directory and print
their balances to the log, which _in some cases_ will be the console. However,
when this class is called from a web application, the destination of the
print is a temporary file, which is later rendered on the web page. In unit
tests it can be something else, which has to capture everything that is sent
to the log and then delivered to the unit test.

{% youtube SoXV_scCMNY %}

As you see, the default value of the `log` is `Log::NULL`, which is the
constant I had to define myself, as a default logger, which doesn't log
anything anywhere. By default, this class will log nothing. It will quietly
check all the balances of all the wallets and print nothing. Well, it will print,
but nobody will see that.

In a unit test I create an object with a few methods like `debug()`, `info()`,
etc. and pass it to the instance of class `Zold::List`, which I'm testing.
In other words, it's a fake/mock version of the logger, which I use to
capture everything that `Zold::List` sends out. Then I can check what's there.

Am I saying obvious things here? If so, why do we
[still have]({% pst 2014/may/2014-05-23-avoid-java-static-logger %}) static
loggers everywhere in Java, Ruby, PHP, C#, etc?
Anyway, I recommend you use an injectable logging dependency instead.

And yeah, by the way, I'm sure you noticed the change in the name. It's not
a `logger` anymore, it's `log`. I'm sure you know
[why]({% pst 2015/mar/2015-03-09-objects-end-with-er %}).

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">How do you log a message from an object of class Book? <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1122381490480930817?ref_src=twsrc%5Etfw">April 28, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
