---
layout: post
title: "OOP Garbage: Traits and Mixins"
date: 2017-01-10
place: Odessa, Ukraine
tags: oop java
description: |
  ...
keywords:
  - traits
  - oop traits
  - mix-in oop
  - OOP
  - trait in programming
image: https://cf.jare.io/?u=http://www.yegor256.com/images/2017/02/...
jb_picture:
  caption:
---

Let me say right off the bat that the features we will discuss now are
pure _garbage_ brought to object-oriented programming by those who desperately
needed a lobotomy, just like David West suggested in his
[Object Thinking](http://amzn.to/2ass77O) book.
The features have different names, while most common ones are
[traits](https://en.wikipedia.org/wiki/Trait_%28computer_programming%29) and
[mixins](https://en.wikipedia.org/wiki/Mixin). I seriously can't understand
how we can still call programming object-oriented when it has these features.

<!--more-->

{% jb_picture_body %}

First, in a nutshell, how they work. Let's use
[Ruby modules](http://phrogz.net/programmingruby/tut_modules.html)
as a sample implementation. Say, we have a class `Book`:

{% highlight ruby %}
class Book
  def initialize(title)
    @title = title
  end
end
{% endhighlight %}

{% highlight ruby %}
module Debug
  def whoAmI?
    "#{self.type.name} (\##{self.id}): #{self.to_s}"
  end
end
class Book
  include Debug
  # ...
end
{% endhighlight %}
