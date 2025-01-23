---
layout: post
title: "Object Validation: to Defer or Not?"
date: 2018-05-29
place: Moscow, Russia
tags: oop
description: |
  There must be no code in object constructors, but
  what about validation of incoming parameters? They
  may be validated, on certain terms.
keywords:
  - oop validation
  - oop constructor
  - validation in constructor
  - when validate objects
  - validation in oop
image: /images/2018/05/punching-the-clown.jpg
jb_picture:
  caption: Punching the Clown (2009) by Gregori Viens
---

<!-- https://www.yegor256.com/2015/05/07/ctors-must-be-code-free.html#comment-3903379622 -->

I [said earlier]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %})
that constructors must be code-free and do
[nothing]({% pst 2023/aug/2023-08-08-two-step-initialization %})
aside from attribute initialization. Since then, the most frequently
asked [question](https://www.yegor256.com/2015/05/07/ctors-must-be-code-free.html#comment-3903379622)
is: What about validation of arguments? If they are "broken,"
what is the point of creating an object in an "invalid" state?
Such an object will fail later, at an unexpected moment. Isn't it
better to throw an exception at the very moment of instantiation? To fail fast,
so to speak? Here is what I think.

<!--more-->

{% jb_picture_body %}

Let's start with this Ruby code:

```java
class Users {
  def initialize(file)
    @file = file
  end
  def names
    File.readlines(@file).reject(&:empty?)
  end
}
```

We can use it to read a list of users from a file:

```java
Users.new('all-users.txt').names
```

There are a number of ways to abuse this class:

  * Pass `nil` to the ctor instead of a file name;

  * Pass something else, which is not `String`;

  * Pass a file that doesn't exist;

  * Pass a directory instead of a file.

Do you see the difference between these four mistakes we can make?
Let's see how our class can protect itself from each of them:

```java
class Users {
  def initialize(file)
    raise "File name can't be nil" if file.nil?
    raise 'Name must be a String' unless file.is_a?(String)
    @file = file
  end
  def names
    raise "#{@file} is absent" unless File.exist?(@file)
    raise "#{@file} is not a file" unless File.file?(@file)
    File.readlines(@file).reject(&:empty?)
  end
}
```

The first two potential mistakes were filtered out
in the constructor, while the other two---later, in the method.
Why did I do it this way? Why not put all of them into the constructor?

Because the first two compromise [object state]({% pst 2014/dec/2014-12-09-immutable-object-state-and-behavior %}),
while with the other two---its runtime behavior. You remember that an
[object]({% pst 2016/jul/2016-07-14-who-is-object %}) is a representative of
a set of other objects it encapsulates, called attributes. The object of
class `Users` can't _represent_ `nil` or a number. It can only represent
a file with a name of type `String`. On the other hand, what that file
contains and whether it really is a file---doesn't make the state invalid.
It only causes trouble for the behavior.

Even though the difference may look subtle, it's obvious. There are
two phases of interaction with the encapsulated object: _connecting_ and _talking_.

{% youtube -drZbHxydMc %}

First, we encapsulate the `file` and want to be sure that it really is
a file. We are not yet talking to it, we don't want it to work for us yet,
we just want to make sure it really _is_ an object that we will be able to talk
to in the near future. If it's `nil` or a `float`, we will have problems
in the future, for sure. That's why we raise an exception from the constructor.

Then the second phase is talking, where we delegate control to the object
and expect it to behave correctly. At this phase we may have other validation
procedures, in order to make sure our interaction will go smoothly.
It's important to mention that these validations are very situational.
We may call `names()` multiple times and every time have a different
situation with the file on disc. To begin with it may not exist, while in a few seconds
it will be ready and available for reading.

Ideally, a programming language should provide instruments for the first
type of validations, for example with [strict typing](https://en.wikipedia.org/wiki/Strong_and_weak_typing).
In Java, for example,
we would not need to check the type of `file`, the compiler would catch
that error earlier. In Kotlin we would be able to get rid of the NULL
check, thanks to their [Null Safety](https://kotlinlang.org/docs/reference/null-safety.html) feature.
Ruby is less powerful than those languages, that's why we have to validate "manually."

Thus, to summarize, validating in constructors is _not_ a bad idea, provided
the validations are _not touching the objects_ but only confirm that they are
good enough to work with later.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">How an ideal Java class BookInFile should react when this happens:<br><br>Book book = new BookInFile(null /* file name */);<a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a> <a href="https://twitter.com/hashtag/java?src=hash&amp;ref_src=twsrc%5Etfw">#java</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1099590296105639936?ref_src=twsrc%5Etfw">February 24, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
