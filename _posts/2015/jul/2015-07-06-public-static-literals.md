---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Public Static Literals ... Are Not a Solution for Data Duplication"
date: 2015-07-06
tags: oop java
place: Palo Alto, CA
description: |
  It's a common practice to make constants public
  in order to avoid duplication, but it's a bad
  practice, so use objects instead.
keywords:
  - static constants java
  - static literals java
  - public static java
  - public static
  - public static literals
book: elegant-objects-1 2.5
image: /images/2015/07/the-shining.jpg
jb_picture:
  caption: The Shining (1980) by Stanley Kubrick
---

I have a `new String(array,"UTF-8")` in one place and exactly
the same code in another place in my app. Actually, I may have
it in many places. And every time, I have to use that `"UTF-8"` constant
in order to create a `String` from a byte array. It would be very
convenient to define it once somewhere and reuse it, just like Apache Commons
is doing; see [`CharEncoding.UTF_8`](https://commons.apache.org/proper/commons-lang/javadocs/api-2.6/org/apache/commons/lang/CharEncoding.html#UTF_8)
(There are many other static literals there).
These guys are setting a bad example! `public` `static`
"properties" are as bad as
[utility classes]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}).

<!--more-->

{% jb_picture_body %}

Here is what I'm talking about, specifically:

```java
package org.apache.commons.lang3;
public class CharEncoding {
  public static final String UTF_8 = "UTF-8";
  // some other methods and properties
}
```

Now, when I need to create a `String` from a byte array, I use this:

```java
import org.apache.commons.lang3.CharEncoding;
String text = new String(array, CharEncoding.UTF_8);
```

Let's say I want to convert a `String` into a byte array:

```java
import org.apache.commons.lang3.CharEncoding;
byte[] array = text.getBytes(CharEncoding.UTF_8);
```

Looks convenient, right? This is what the designers of Apache Commons think
(one of the most popular but simply _terrible_ libraries
in the Java world). I encourage you to think differently.
I can't tell you to stop using Apache Commons, because we just don't have
a better alternative ([yet!](https://www.cactoos.org)). But in your own code, don't use public
static properties---ever. Even if this code may look convenient to you,
it's a very bad design.

{% quote Every time you see data duplication, start thinking about the functionality you're duplicating. %}

The reason why is very similar to
[utility classes]({% pst 2015/feb/2015-02-26-composable-decorators %})
with public static
methods---they are unbreakable hard-coded dependencies. Once you
use that `CharEncoding.UTF_8`, your object starts to depend on this
data, and its user (the user of your object) can't break this dependency. You may say that
this is your intention, in the case of a `"UTF-8"` constant---to make
sure that Unicode is specifically and exclusively being used. In this particular
example, this may be true, but look at it from a more global perspective.

Let me show you the alternative I have in mind before we continue.
Here is what I'm suggesting instead to convert a byte array
into a `String`:

```java
String text = new UTF8String(array);
```

It's pseudo-code, since Java designers made class `String` final and we
can't really extend it and create `UTF8String`, but you get the idea. In the real
world, this would look like this:

```java
String text = new UTF8String(array).toString();
```

As you see, we encapsulate the "UTF-8" constant somewhere inside the class
`UTF8String`, and its users have no idea how exactly this "byte array to string"
conversion is happening.

{% youtube 3blBn65iQmU %}

By introducing `UTF8String`, we solved the problem of "UTF-8"
literal duplication. But we did it in a proper object-oriented way---we encapsulated the functionality inside a class and let everybody
instantiate its objects and use them. We resolved the problem of functionality
duplication, not just data duplication.

Placing data into one shared place (`CharEncoding.UTF_8`)
doesn't really solve the duplication problem; it actually makes it _worse_, mostly
because it encourages everybody to duplicate functionality using the same
piece of [shared data]({% pst 2016/nov/2016-11-21-naked-data %}).

My point here is that every time you see that you have some data duplication
in your application, start thinking about the functionality you're duplicating.
You will easily find the code that is repeated again and again. Make a new
class for this code and place the data there, as a `private` property (or private
`static` property). That's how you will improve your design and truly get rid
of duplication.

PS. You can use a method instead of a class, but not a static literal.

PPS. You can also use enums, but only
[this way](https://www.g4s8.wtf/posts/2020-12-26-enum-objects/#comment-5205846133).

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">How do you get rid of the duplication of magic numbers (it&#39;s Ruby)? <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a><br><br>class Time<br> def hours<br> msec / (60 * 60 * 1000)<br> end<br> def days<br> msec / (24 * 60 * 60 * 1000)<br> end<br>end</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1221378774618595329?ref_src=twsrc%5Etfw">January 26, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
