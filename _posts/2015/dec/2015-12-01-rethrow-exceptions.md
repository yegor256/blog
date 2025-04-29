---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Throwing an Exception Without Proper Context Is a Bad Habit"
date: 2015-12-01
place: San Jose, CA
tags: java
category: jcg
description: |
  One of the most helpful things you can do is add a contextual
  message to an exception on each re-throw &dash; and
  actually, in all other situations.
keywords:
  - rethrow exception
  - rethrow exception java
  - rethrow exception c++
  - rethrow exception scala
  - rethrow exception with new message
image: /images/2015/12/four-rooms.jpg
jb_picture:
  caption: Four Rooms (1995) by Allison Anders et al.
---

I keep repeating the same mistake again and again. So it's time to
stop and make a rule to prevent this from happening anymore. The mistake
is not fatal, but it's very annoying. When I look at production logs, I often see
something like `"File doesn't exist"`, and I ask myself:
What file? Where is it supposed to exist? What did the server try to do with it?
What was going on a second before it crashed?
There is no answer in the log, and it's totally my fault.
I either 1) don't re-throw or 2) re-throw without providing context.
Both are wrong.

<!--more-->

{% jb_picture_body %}

This is how the code may look:

```java
if (!file.exists()) {
  throw new IllegalArgumentException(
    "File doesn't exist"
  );
}
```

It may also look like this:

```java
try {
  Files.delete(file);
} catch (IOException ex) {
  throw new IllegalArgumentException(ex);
}
```

Both examples demonstrate an inadequate style of handling situations that
involve exceptions and reporting them. What's wrong here? The exception messages
are not thorough enough. They simply don't contain any information
from the place where they originated from.

This is how they should look instead:

```java
if (!file.exists()) {
  throw new IllegalArgumentException(
    String.format(
      "User profile file %s doesn't exist",
      file.getAbsolutePath()
    )
  );
}
```

And the second example should look like this:

```java
try {
  Files.delete(file);
} catch (IOException ex) {
  throw new IllegalArgumentException(
    String.format(
      "Can't delete user profile data file %s",
      file.getAbsolutePath()
    ),
    ex
  );
}
```

See the difference? This may look like redundant code, but it's not.
Of course, when I'm writing all this, I don't really care about
logs and exceptions. I'm not really expecting this file
to be absent.

But I should.

There should be a rule: Every time we throw or re-throw, an
exception message must describe the problem with as much
detail as possible.

Of course, we can't forget about security and risk putting any
sensitive information into the exception message, like passwords,
credit card numbers, etc. Besides that, as much as possible
must be exposed to the exception catcher at a higher level.

Throwing an exception is literally an escalation of a problem
to a higher level of management. Imagine that my boss is asking
me to install a new server. I come back to him in a few hours
and say, "I failed; sorry." That would sound strange. He
would ask for more details. Why did I fail? What exactly went wrong?
Is it possible to do it differently? Etc.

Such code is literally a sign of disrespect to the client:

```java
throw new IllegalArgumentException(
  "File doesn't exist"
);
```

I have to be more verbose and give more details.

And I'm not alone in this mistake. I see it everywhere, and it really
makes [debugging]({% pst 2016/feb/2016-02-09-are-you-still-debugging %})
difficult, especially in production, where it's
almost impossible to reproduce the problem right away.

Thus, please be more verbose in your exception messages. I will do the same
in my code.

And one more thing before you go. In most OOP languages, exceptions
are unchecked, which means that catching them is not a mandatory
operation, [unfortunately]({% pst 2015/jul/2015-07-28-checked-vs-unchecked-exceptions %}).
Nevertheless, I recommend you catch, add context, and
re-throw them all, _always_. This may seem like pure noise, but it's not!
Just make your methods smaller and ensure all exceptions
sent out of them have enough information about their origins.
You will do yourself and everybody else a big favor.
