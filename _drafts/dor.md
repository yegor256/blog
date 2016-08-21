---
layout: post
title: "Vertical vs Horizontal Decomposition of Responsibility"
date: 2016-08-23
tags: oop
place: Palo Alto, CA
description: |
  Decomposition of responsibility is what we do in order
  to break a complex object into smaller ones, and we
  can do it right or wrong.
keywords:
  - decomposition of responsibility
  - decomposition of responsibility in oop
  - god object
  - single responsibility principle
  - SRP in OOP
---

Objects responsible for too many things are a problem, because their
complexity is high, they are difficult to maintain and extend.
**Decomposition of responsibility** is what we do in order to break
too complex objects into smaller ones. I see two types of this
refactoring operation: vertical and horizontal. I believe that
the former is better than the latter.

<!--more-->

Let's say, this is our code (it is Ruby):

{% highlight ruby %}
class Log
  def initialize(path)
    @file = IO.new(path, 'a')
  end
  def put(text)
    line = Time.now.strftime("%d/%m/%Y %H:%M ") + text
    @file.puts line
  end
end
{% endhighlight %}

Obviously, objects of this class are doing too much.
They save log lines to the
file and also forwat them &mdash; an obvious violation of
a famous
[single responsibility principle](https://en.wikipedia.org/wiki/Single_responsibility_principle).
An object of this class would be **responsible** for too many things.
We have to extract some functionality out of it and put it
into other object(s). We have to **decompose** its responsibility.
No matter where we put it, this is how
`Log` class will look like after the extraction:

{% highlight ruby %}
class Log
  def initialize(path)
    @file = IO.new(path, 'a')
  end
  def put(text)
    @file.puts line
  end
end
{% endhighlight %}

Now it only saves lines to the file, which is perfect. The class
is cohesive and small. Let's make an instance of it:

{% highlight ruby %}
log = Log.new('/tmp/log.txt')
{% endhighlight %}

Next, where do we put that lines formatting functionality just extracted?
There are two approaches to decompose responsibility: horizontal and
vertical. This one is **horizontal**:

{% highlight ruby %}
class Line
  def initialize(text)
    @line = text
  end
  def to_s
    Time.now.strftime("%d/%m/%Y %H:%M ") + text
  end
end
{% endhighlight %}

In order to use `Log` and `Line` together we have to do this:

{% highlight ruby %}
log.put(Line.new("hello, world"))
{% endhighlight %}

See why it's horizontal? Because this script sees them
both. They both are on the same level of visibility. We will always have
to communicate with both of them when we want to log a line. Both
objects of `Log` and `Line` are in front of us. We have to deal with
two classes in order to log a line:

{% plantuml %}
[script] -down- [log]
[script] -down- [Line.new()]
{% endplantuml %}

To the contrary, this decomposition of responsibility is **vertical**:

{% highlight ruby %}
class TimedLog
  def initialize(log)
    @origin = log
  end
  def put(text)
    @origin.put(Time.now.strftime("%d/%m/%Y %H:%M ") + text)
  end
end
{% endhighlight %}

Class `TimedLog` is a decorator, this is how we use them together:

{% highlight ruby %}
log = TimeLog.new(log)
{% endhighlight %}

Now, we just put a line to the log:

{% highlight ruby %}
log.put("hello, world")
{% endhighlight %}

The responsibility is decomposed vertically. We still have one entry point
to the `log` object, but the object "consists" of two objects, wrapped
one into another:

{% plantuml %}
[script] -down- [TimedLog]
[TimedLog] -down- [Log]
{% endplantuml %}

I think that horizontal decomposition of responsibility is in general a bad idea,
while vertical one is a much better one. Mostly because a vertically
decomposed object decreases complexity, while horizontally decomposed
one actually makes things more complex. Because its clients have to deal with
more dependencies and more points of contact.

