---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Don't Parse, Use Parsing Objects"
date: 2018-02-27
place: Moscow, Russia
tags: oop java
description: |
  When project scope is perfectly decomposed and management
  rules are clear and strict, the speed of delivery
  is a virtue, not the quality.
keywords:
  - quality vs speed
  - speed vs quality
  - perfection vs speed
  - speed or perfection
  - speed is king
image: /images/2018/02/la-science-des-reves.jpg
jb_picture:
  caption: La science des rêves (2006) by Michel Gondry
---

<!-- here: https://www.yegor256.com/2014/09/16/getters-and-setters-are-evil.html#comment-3438202653 -->

The traditional way of integrating object-oriented back-end with an external
system is through [data transfer objects]({% pst 2016/jul/2016-07-06-data-transfer-object %}),
which are serialized into JSON before going out
and deserialized when coming back. This way is as much popular as it is wrong. The
serialization part should be replaced by [printers]({% pst 2016/apr/2016-04-05-printers-instead-of-getters %}),
which I explained earlier.
Here is my take on deserialization, which should be done by---guess what---objects.

<!--more-->

{% jb_picture_body %}

Say there is a back-end entry point, which is supposed to register a new
book in the library, arriving in JSON:

```json
{
  "title": "Object Thinking",
  "isbn: "0735619654",
  "author: "David West"
}
```

Also, there is an object of class `Library`, which expects an object of type
`Book` to be given to its method `register()`:

```java
class Library {
  public void register(Book book) {
    // Create a new record in the database
  }
}
```

Say also, type `Book` has a simple method `isbn()`:

```java
interface Book {
  String isbn();
}
```

Now, here is the HTTP entry point
(I'm using [Takes]({% pst 2015/mar/2015-03-22-takes-java-web-framework %})
and [Cactoos]({% pst 2017/jun/2017-06-22-object-oriented-input-output-in-cactoos %})),
which is accepting
a POST [`multipart/form-data`](https://www.ietf.org/rfc/rfc2045.txt)
request and registering the book in the library:

```java
public class TkUpload implements Take {
  private final Library library;
  @Override
  public Response act(Request req) {
    String body = new RqPrint(
      new RqMtSmart(new RqMtBase(req)).single("book")
    ).printBody();
    JsonObject json = Json.createReader(
      new InputStreamOf(body)
    ).readObject();
    Book book = new BookDTO();
    book.setIsbn(json.getString("isbn"));
    library.register(book);
  }
}
```

What is wrong with this? Well, a few things.

First, it's not reusable. If we were to need something similar in a different
place, we would have to write this HTTP processing and JSON parsing again.

Second, error handling and
[validation]({% pst 2018/may/2018-05-29-object-validation %})
are not reusable either. If we add
it to the method above, we will have to copy it everywhere. Of course,
the DTO may encapsulate it, but that's not what DTOs are usually for.

Third, the code above is rather procedural and has a lot of
[temporal coupling]({% pst 2015/dec/2015-12-08-temporal-coupling-between-method-calls %}).

A better design would be to hide this parsing inside a new class `JsonBook`:

```java
class JsonBook implements Book {
  private final String json;
  JsonBook(String body) {
    this.json = body;
  }
  @Override
  public String isbn() {
    return Json.createReader(
      new InputStreamOf(body)
    ).readObject().getString("isbn");
  }
}
```

Then, the RESTful entry point will look like this:

```java
public class TkUpload implements Take {
  private final Library library;
  @Override
  public Response act(Request req) {
    library.register(
      new JsonBook(
        new RqPrint(
          new RqMtSmart(
            new RqMtBase(req)
          ).single("book")
        ).printBody()
      )
    );
  }
}
```

Isn't that more elegant?

Here are some examples from my projects:
[`RqUser`](https://github.com/zerocracy/farm/blob/0.21/src/main/java/com/zerocracy/tk/RqUser.java)
from [zerocracy/farm](https://github.com/zerocracy/farm/) and
[`RqUser`](https://github.com/yegor256/jare/blob/0.11.2/src/main/java/io/jare/tk/RqUser.java)
from [yegor256/jare](https://github.com/yegor256/jare/blob/0.11.2/src/main/java/io/jare/tk/RqUser.java).

As you can see from the examples above, sometimes we can't use `implements`
because some primitives in Java are not interfaces but `final` classes:
`String` is a "perfect" example. That's why I have to do this:

```java
class RqUser implements Scalar<String> {
  @Override
  public String value() {
    // Parsing happens here and returns String
  }
}
```

But aside from that, these examples perfectly demonstrate the principle
of "parsing objects" suggested above.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">How would you refactor this Ruby code?<br><br>book = JSON.parse(json)[&#39;books&#39;][3]<a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a> <a href="https://twitter.com/hashtag/oop?src=hash&amp;ref_src=twsrc%5Etfw">#oop</a> <a href="https://twitter.com/hashtag/ruby?src=hash&amp;ref_src=twsrc%5Etfw">#ruby</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1119841190051024896?ref_src=twsrc%5Etfw">April 21, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
