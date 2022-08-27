---
layout: post
title: "Don't Group Exception Catchers"
date: 2022-09-15
place: Moscow, Russia
tags: oop java
description: |
  Catching multiple exceptions thrown by different originator
  in a single "catch" block is a bad practice because it
  reduces the ability to provide context of the problem occured.
keywords:
  - exceptions in oop
  - try catch errors
  - java try catch
  - groupping exceptions
  - exception types
image: /images/2022/09/elephant.jpg
jb_picture:
  caption: Elephant (2003) by Gus Van Sant
---

Sometimes we [rethrow]({% pst 2015/dec/2015-12-01-rethrow-exceptions %}) exceptions.
In Java we do this more often than in other languages, because it has
[checked]({% pst 2015/jul/2015-07-28-checked-vs-unchecked-exceptions %}) ones.
Sometimes we must catch and rethrow a few exceptions originated
from different places in a method.
Java&nbsp;7 introduced [groupping](https://docs.oracle.com/javase/7/docs/technotes/guides/language/catch-multiple.html)
of different types of exceptions in a single `catch` block.
But even without the groupping, it is possible to just catch `IOException` or
even `Exception` and provide a single `catch` block for all types and all
originators (methods that throw).
Recently, I realized that it's a bad practice. Here is why.

<!--more-->

{% jb_picture_body %}

Consider this Java method (I'm using [Apache Commons IO](https://commons.apache.org/proper/commons-io/)):

```java
byte[] read(String uri) {
  try {
    return IOUtils.toByteArray(
      new URL(uri).openStream()
    );
  } catch (IOException ex) {
    throw new IllegalArgumentException(ex);
  }
}
```

It's not perfect. Let's rewrite it to provide more error context,
as [was suggested]({% pst 2015/dec/2015-12-01-rethrow-exceptions %}) earlier:

```java
byte[] read(String uri) {
  try {
    return IOUtils.toByteArray(
      new URL(uri).openStream()
    );
  } catch (IOException ex) {
    throw new IllegalArgumentException(
      String.format(
        "Failed to read from '%s'",
        uri
      ),
      ex
    );
  }
}
```

Here, the exception may be thrown at three places:

  * By the [constructor]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %})
    of [`java.net.URL`](https://docs.oracle.com/javase/7/docs/api/java/net/URL.html)
  * By the method [`openStream()`](https://docs.oracle.com/javase/7/docs/api/java/net/URL.html#openStream%28%29)
  * By the method [`toByteArray`](https://commons.apache.org/proper/commons-io/apidocs/org/apache/commons/io/IOUtils.html#toByteArray-java.io.InputStream-)

No matter who throws, we catch it by the same `catch` block and rethrow
with the same message. I believe, this is bad because the [context]({% pst 2015/dec/2015-12-01-rethrow-exceptions %})
of the error provided by rethrowing is less focused on the issue occured.

I would suggest this refactoring
(I don't close the input stream, which is wrong,
but that's a topic for a separate discussion):

```java
byte[] read(String uri) {
  URL url;
  try {
    url = new URL(uri);
  } catch (MalformedURLException ex) {
    throw new IllegalArgumentException(
      String.format(
        "Failed to parse the URI '%s'",
        uri
      ),
      ex
    );
  }
  InputStream stream;
  try {
    stream = url.openStream();
  } catch (IOException ex) {
    throw new IllegalArgumentException(
      String.format(
        "Failed to open the stream for '%s'",
        uri
      ),
      ex
    );
  }
  try {
    return IOUtils.toByteArray(stream);
  } catch (IOException ex) {
    throw new IllegalArgumentException(
      String.format(
        "Failed to read the stream for '%s'",
        uri
      ),
      ex
    );
  }
}
```

This code is much longer, but at the same time more convenient to
[debug]({% pst 2016/feb/2016-02-09-are-you-still-debugging %}),
test, and use in production mode. The `catch` block
is able to explains the situation better and provide better
context in the rethrown exception, because it deals only with
a single case.

Thus, the rule I'm suggesting: if an exception is rethrown,
each originator must have its own `catch` block.

Obviously, I believe that
[groupping exceptions](https://docs.oracle.com/javase/7/docs/technotes/guides/language/catch-multiple.html)
in a single `catch` block is a bad practice.
