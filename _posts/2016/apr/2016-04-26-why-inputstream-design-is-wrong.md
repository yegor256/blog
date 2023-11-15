---
layout: post
title: "Why InputStream Design Is Wrong"
date: 2016-04-26
place: Washington, D.C.
tags: java oop
category: jcg
description: |
  Class InputStream in Java has three methods read(),
  this is what I think is very wrong. Not only in
  this class, but in general in OOP.
keywords:
  - why InputStream is a class
  - InputStream
  - InputStream java
  - method overloading
  - method overloading java
book: elegant-objects-1 2.9
image: /images/2016/04/a-serious-man.jpg
jb_picture:
  caption: A Serious Man (2009) by Coen Brothers
---

It's not just about `InputSteam`, this class is a good
example of a bad design. I'm talking about three overloaded
methods `read()`. I've mentioned this problem in Section 2.9
of [Elegant Objects](/elegant-objects.html). In a few words,
I strongly believe that interfaces must be "functionality poor."
`InputStream` should have been an interface in the first place
and it should have had a single method `read(byte[])`. Then if
its authors wanted to give us extra functionality, they should have
created supplementary "smart" classes.

<!--more-->

{% jb_picture_body %}

This is how it looks now:

```java
abstract class InputStream {
  int read();
  int read(byte[] buffer, int offset, int length);
  int read(byte[] buffer);
}
```

What's wrong? It's very convenient to have the ability to read
a single byte, an array of bytes or even an array of bytes
with a direct positioning into a specific place in the buffer!

{% youtube Xk9tIqwca3k %}

However, we are still lacking a few methods: for reading the bytes and
immediately saving into a file, converting to a text with a selected
encoding, sending them by email and posting on Twitter. It would be
great to have the features too, right in the poor `InputStream`.
I hope the Oracle Java team is working on them now.

In the mean time, let's see what exactly is wrong with what these
bright engineers designed for us already. Or maybe let me show
how I would design `InputStream` and we'll compare:

```java
interface InputStream {
  int read(byte[] buffer, int offset, int length);
}
```

This is my design. The `InputStream` is responsible for reading
bytes from the stream. There is one single method for this
feature. Is it convenient for everybody? Does it read and post
on Twitter? Not yet. Do we need that functionality? Of course we do,
but it doesn't mean that we will add it to the interface. Instead,
we will create supplementary "smart" class:

```java
interface InputStream {
  int read(byte[] buffer, int offset, int length);
  class Smart {
    private final InputStream origin;
    public Smart(InputStream stream) {
      this.origin = stream;
    }
    public int read() {
      final byte[] buffer = new byte[1];
      final int read = this.origin.read(buffer, 0, 1);
      final int result;
      if (read < 1) {
        result = -1;
      } else {
        result = buffer[0];
      }
      return result;
    }
  }
}
```

Now, we want to read a single byte from the stream. Here is how:

```java
final InputStream input = new FileInputStream("/tmp/a.txt");
final byte b = new InputStream.Smart(input).read();
```

The functionality of reading a single byte is outside of `InputStream`,
because this is not its business. The stream doesn't need to know
how to manage the data after it is read. All the stream
is _responsible_ for is reading, not parsing or manipulating afterwards.

Interfaces must be small.

Obviously, [method overloading]({% pst 2023/aug/2023-08-01-method-overloading %}) 
in interfaces is a code smell. An interface
with more than _three methods_ is a good candidate for refactoring. If methods
overload each other---it's serious trouble.

Interfaces must be small!

You may say that the creators of `InputStream` cared about performance, that's
why allowed us to implement `read()` in three different forms. Then I have
to ask again, why not create a method for reading and immediately post it
on Twitter? That would be fantastically fast. Isn't it what we all want?
A fast software which nobody has any desire to read or maintain.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Most likely, what is wrong with this Java interface? <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a> <a href="https://twitter.com/hashtag/java?src=hash&amp;ref_src=twsrc%5Etfw">#java</a><br><br>interface Storage {<br>  int readInt();<br>  String readString();<br>  float readFloat();<br>}</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1114801713964355584?ref_src=twsrc%5Etfw">April 7, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
