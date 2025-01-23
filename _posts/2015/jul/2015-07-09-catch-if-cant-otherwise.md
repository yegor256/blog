---
layout: post
title: "Catch Me If You ... Can't Do Otherwise"
date: 2015-07-09
tags: oop
place: Dallas, TX
description: |
  Catching an exception must be your last resort;
  a properly designed application would catch
  exceptions in one place only.
keywords:
  - exception catching
  - catch exception
  - when to catch exceptions
  - catch exception java
  - exceptions java
image: /images/2015/07/catch-me-if-you-can.jpg
jb_picture:
  caption: Catch Me If You Can (2002) by Steven Spielberg
---

I don't know whether it's an anti-pattern or just a common and very popular
mistake, but I see it everywhere and simply must write about it. I'm talking
about **exception catching without
[re-throwing]({% pst 2015/dec/2015-12-01-rethrow-exceptions %})**. I'm talking about something like
this Java code:

```java
try {
  stream.write(data);
} catch (IOException ex) {
  ex.printStackTrace();
}
```

<!--more-->

{% jb_picture_body %}

Pay attention: I don't have anything against this code:

```java
try {
  stream.write('X');
} catch (IOException ex) {
  throw new IllegalStateException(ex);
}
```

This is called [_exception chaining_](https://en.wikipedia.org/wiki/Exception_chaining)
and is a perfectly valid construct.

So what is wrong with catching an exception and logging it? Let's try to
look at the bigger picture first. We're talking about object-oriented
programming---this means we're dealing with objects. Here is
how an object (its class, to be exact) would look:

```java
final class Wire {
  private final OutputStream stream;
  Wire(final OutputStream stm) {
    this.stream = stm;
  }
  public void send(final int data) {
    try {
      this.stream.write(x);
    } catch (IOException ex) {
      ex.printStackTrace();
    }
  }
}
```

Here is how I'm using this class:

```java
new Wire(stream).send(1);
```

Looks nice, right? I don't need to worry about that `IOException` when I'm
calling `send(1)`. It will be handled internally, and if it occurs, the stacktrace
will be logged. But this is a totally wrong way of thinking, and it's inherited
from languages without exceptions, like C.

{% quote An exception collects as much information as possible about the error and floats it up %}

Exceptions were invented to simplify our design by moving the entire
error handling code away from the main logic. Moreover, we're not just moving it away but
also concentrating it in one place---in the `main()` method, the entry
point of the entire app.

The primary purpose of an exception is to collect as much information as possible
about the error and float it up to the highest level, where the user
is capable of doing something about it. Exception chaining helps even
further by allowing us to extend that information on its way up. We are basically
putting our bubble (the exception) into a bigger bubble every time we
catch it and
[re-throw]({% pst 2015/dec/2015-12-01-rethrow-exceptions %}).
When it hits the surface, there are many bubbles, each remaining
inside another like a Russian doll. The original exception is the
smallest bubble.

When you catch an exception without re-throwing it, you basically pop the bubble.
Everything inside it, including the original exception and all other bubbles
with the information inside them, are in your hands.
You don't let me see them. You use them somehow, but I don't know how. You're
doing something behind the scenes, hiding potentially important information.

If you're hiding that from me, I can't promise my user that I will be honest
with him and openly report a problem when it occurs. I simply can't
trust your `send()` method anymore, and my user will not trust me.

By catching exceptions without re-throwing them, you're basically breaking the
chain of trust between objects.

My suggestion is to catch exceptions as seldom as possible, and every time
you catch them,
[re-throw]({% pst 2015/dec/2015-12-01-rethrow-exceptions %}).

Unfortunately, the design of Java goes against this principle in many places.
For example, Java has checked and un-checked exceptions, while there should only
be checked ones in my opinion (the ones you must catch or declare
as throwable). Also, Java allows multiple exception types to be declared
as throwable in a single method---yet another mistake; stick to declaring just
one type. Also, there is a generic `Exception` class at the top of the hierarchy,
which is also wrong in my opinion. Besides that, some built-in classes don't
allow any checked exceptions to be thrown, like `Runnable.run()`. There
are many other problems with exceptions in Java.

But try to keep this principle in mind and your code will be cleaner: `catch` only if you have no other choice.

P.S. Here is how the class should look:

```java
final class Wire {
  private final OutputStream stream;
  Wire(final OutputStream stm) {
    this.stream = stm;
  }
  public void send(final int data)
    throws IOException {
    this.stream.write(x);
  }
}
```
