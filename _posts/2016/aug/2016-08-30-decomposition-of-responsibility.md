---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Vertical vs. Horizontal Decomposition of Responsibility"
date: 2016-08-30
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
image: /images/2016/08/once-upon-a-time-in-america.jpg
jb_picture:
  caption: Once Upon a Time in America (1984) by Sergio Leone
---

Objects responsible for too many things are a problem. Because their
complexity is high, they are difficult to maintain and extend.
_Decomposition of responsibility_ is what we do in order to break
these overly complex objects into smaller ones. I see two types of this
refactoring operation: vertical and horizontal. And I believe
the former is better than the latter.

<!--more-->

{% jb_picture_body %}

Let's say this is our code (it is Ruby):

```ruby
class Log
  def initialize(path)
    @file = IO.new(path, 'a')
  end
  def put(text)
    line = Time.now.strftime("%d/%m/%Y %H:%M ") + text
    @file.puts line
  end
end
```

Obviously, objects of this class are doing too much.
They save log lines to the
file and also format them---an obvious violation of
a famous
[single responsibility principle](https://en.wikipedia.org/wiki/Single_responsibility_principle).
An object of this class would be _responsible_ for too many things.
We have to extract some functionality out of it and put that
into another object(s). We have to _decompose_ its responsibility.
No matter where we put it, this is how the
`Log` class will look after the extraction:

```ruby
class Log
  def initialize(path)
    @file = IO.new(path, 'a')
  end
  def put(line)
    @file.puts line
  end
end
```

Now it only saves lines to the file, which is perfect. The class
is cohesive and small. Let's make an instance of it:

```ruby
log = Log.new('/tmp/log.txt')
```

Next, where do we put the lines with formatting functionality that were just extracted?
There are two approaches to decompose responsibility: horizontal and
vertical. This one is _horizontal_:

```ruby
class Line
  def initialize(text)
    @line = text
  end
  def to_s
    Time.now.strftime("%d/%m/%Y %H:%M ") + text
  end
end
```

In order to use `Log` and `Line` together, we have to do this:

```ruby
log.put(Line.new("Hello, world"))
```

See why it's horizontal? Because this script sees them
both. They both are on the same level of visibility. We will always have
to communicate with both of them when we want to log a line. Both
objects of `Log` and `Line` are in front of us. We have to deal with
two classes in order to log a line:

{% plantuml style="width:30%" %}
[script] -down-> [log]
[script] -down-> [Line]
{% endplantuml %}

To the contrary, this decomposition of responsibility is _vertical_:

```ruby
class TimedLog
  def initialize(log)
    @origin = log
  end
  def put(text)
    @origin.put(Time.now.strftime("%d/%m/%Y %H:%M ") + text)
  end
end
```

Class `TimedLog` is a decorator, and this is how we use them together:

```ruby
log = TimedLog.new(log)
```

Now, we just put a line in the log:

```ruby
log.put("Hello, world")
```

The responsibility is decomposed vertically. We still have one entry point
into the `log` object, but the object "consists" of two objects, one wrapped
into another:

{% plantuml style="width:20%" %}
[script] -down-> [TimedLog]
[TimedLog] -down-> [Log]
{% endplantuml %}

In general, I think horizontal decomposition of responsibility is a bad idea,
while vertical is a much better one. That's because a vertically
decomposed object decreases complexity, while a horizontally decomposed
one actually makes things more complex because its clients have to deal with
more dependencies and more points of contact.
