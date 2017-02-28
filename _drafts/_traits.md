---
layout: post
title: "Traits and Mixins, OOP Garbage"
date: 2017-01-10
place: Odessa, Ukraine
tags: oop java
description: |
  Mixins and traits are becoming popular in OOP, but do
  they really have anything to do with proper object-oriented
  thinking and design?
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

Now, we want this class `Book` to use a static method (a procedure), which
does something useful. We may either define it in a
[utility class]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %})
and let `Book` call it:

{% highlight ruby %}
class TextUtils
  def self.caps(text)
    text.split.map(&:capitalize).join(' ')
  end
end
class Book
  def print
    puts "My title is #{TextUtils.caps(@title)}"
  end
end
{% endhighlight %}

Or we can make it even more "convenient," and `extend` our module
in order to access its methods directly:

{% highlight ruby %}
module TextModule
  def caps(text)
    text.split.map(&:capitalize).join(' ')
  end
end
class Book
  extend TextModule
  def print
    puts "My title is #{caps(@title)}"
  end
end
{% endhighlight %}

Seems nice, but only if you don't understand the
[difference]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %})
between
[object-oriented programming]({% pst 2016/aug/2016-08-15-what-is-wrong-object-oriented-programming %})
and static methods. Moreover, if we forget
[OOP purity]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %})
for a minute, this approach actually looks less readable to me, even though it has
less characters: It's difficult to understand where this method
`caps()` is coming from, when it's called just like `{#caps(@title)}` instead
of `#{TextUtils.caps(@title)}`. Don't you think?

Mixins start to play their role better when we `include` them. We can
combine them to construct the behavior of the class we're looking for. Let's
create two mixins. The first one called `PlainMixin` will print the title
of the book the way it is and the second one called `CapsMixin` will
capitalize what's already printed:

{% highlight ruby %}
module CapsMixin
  def to_s
    super.to_s.split.map(&:capitalize).join(' ')
  end
end
module PlainMixin
  def to_s
    @title
  end
end
class Book
  def initialize(title)
    @title = title
  end
  include CapsMixin, PlainMixin
  def print
    puts "My title is #{self}"
  end
end
{% endhighlight %}

Just `Book` without the included mixin will print its title the way
it is. Once we add the `include` statement, the behavior of `to_s` is
overridden and method `print` produces a different result. We can
combine mixins to produce the required functionality. For example,
we can add one more, which will
[abbreviate](http://stackoverflow.com/a/25136035/187141) the title to 16 characters:

{% highlight ruby %}
module AbbrMixin
  def to_s
    super.to_s.gsub(/^(.{16,}?).*$/m,'\1...')
  end
end
class Book
  def initialize(title)
    @title = title
  end
  include AbbrMixin, CapsMixin, PlainMixin
  def print
    puts "My title is #{self}"
  end
end
{% endhighlight %}

I'm sure you already understood that they both have access to
the private attribute `@title` of class `Book`. They actually have
full access to everything in the class. They litterally are
"pieces of code," which we can inject into the class to make it more powerful and complex.
What's wrong with this approach?

Traits are a bit [different](http://stackoverflow.com/questions/925609/mixins-vs-traits)
than mixins, but we must not really care. I believe we must just stay
away from all of them, no matter what their names are.
