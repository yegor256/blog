---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Each Private Static Method Is a Candidate for a New Class"
date: 2017-02-07
place: Kharkiv, Ukraine
tags: oop java
description: |
  Private static methods are perfect instruments to avoid
  code duplication inside a class, but they introduce
  duplication between classes and are not testable.
keywords:
  - private static method
  - private method
  - static method
  - private static
  - java private method
image: /images/2017/02/the-master.jpg
jb_picture:
  caption: The Master (2012) by Paul Thomas Anderson
---

Do you have private static methods that help you break
your algorithms down into smaller parts? I do. Every time I write
a new method, I realize that it can be a new class instead. Of course,
I don't make classes out of all of them, but that has to be the
goal. Private static methods are not reusable, while classes are---that
is the main difference between them, and it is crucial.

<!--more-->

{% jb_picture_body %}

Here is an example of a simple class:

```java
class Token {
  private String key;
  private String secret;
  String encoded() {
    return "key="
      + URLEncoder.encode(key, "UTF-8")
      + "&secret="
      + URLEncoder.encode(secret, "UTF-8");
  }
}
```

There is an obvious code duplication, right? The easiest way to resolve
it is to introduce a private static method:

```java
class Token {
  private String key;
  private String secret;
  String encoded() {
    return "key="
      + Token.encoded(key)
      + "&secret="
      + Token.encoded(secret);
  }
  private static String encoded(String text) {
    return URLEncoder.encode(text, "UTF-8");
  }
}
```

Looks much better now. But what will happen if we have another class
that needs the exact same functionality? We will have to copy and paste
this private static method `encoded()` into it, right?

A better alternative would be to introduce a new class `Encoded` that
implements the functionality we want to share:

```java
class Encoded {
  private final String raw;
  @Override
  public String toString() {
    return URLEncoder.encode(this.raw, "UTF-8");
  }
}
```

And then:

```java
class Token {
  private String key;
  private String secret;
  String encoded() {
    return "key="
      + new Encoded(key)
      + "&secret="
      + new Encoded(secret);
  }
}
```

Now this functionality is 1) reusable, and 2) testable. We can easily
use this class `Encoded` in many other places, and we can create a unit
test for it. We were not able to do that with the private static method before.

See the point? The rule of thumb I've already figured for myself is that
_each_ private static method is a perfect candidate for a new class. That's
why we don't have them at all in [EO](https://www.eolang.org).

By the way, _public_ static methods are a different story. They are also evil,
but for [different reasons]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}).

P.S. Now I think that the reasons in this article are applicable to _all_ private
methods, not only static ones.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">In OOP, private static methods are...</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1317719171480825856?ref_src=twsrc%5Etfw">October 18, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
