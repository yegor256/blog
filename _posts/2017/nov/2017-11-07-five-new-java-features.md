---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Five Features to Make Java Even Better"
date: 2017-11-07
place: Odessa, Ukraine
tags: java sarcasm
description: |
  Even though Java is a great language, it obviously could
  be better; there are a number of areas where I see
  room for improvement.
keywords:
  - java dto
  - java data classes
  - data classes in java
  - data structures in java
  - java getters setters
social:
  - dzone: https://dzone.com/articles/five-features-to-make-java-even-better
image: /images/2017/11/idiocracy.jpg
jb_picture:
  caption: Idiocracy (2006) by Mike Judge
buffer:
  - "Wouldn't it be great to enable global variables in Java and get rid of Singletons. PHP, JavaScript, Ruby and many other languages have them, why doesn't Java?"
  - "I'm suggesting we add global functions to Java and optional \"namespaces\" to group them"
  - "I'm suggesting we allow any object to access any of the attributes and methods of another object. Of course, if they are private, the compiler should issue a warning..."
  - "It would be convenient to let us call constructors and methods with an incomplete set of arguments. The arguments we don't provide will be set to null by default"
  - "I think it's only obvious that we need this feature: every private attribute must automatically have a setter and a getter"
---

I stumbled upon [this proposal](http://cr.openjdk.java.net/~briangoetz/amber/datum.html)
by [Brian Goetz](https://twitter.com/BrianGoetz)
for data classes in Java, and immediately
realized that I too have a few ideas about how to make Java better
as a language. I actually have many of them, but this is a short list of the five most
important.

<!--more-->

{% jb_picture_body %}

**Global Variables**.
There are [Singletons](https://en.wikipedia.org/wiki/Singleton_pattern)
in Java,
which, as we all know, are nothing but
[global variables](https://en.wikipedia.org/wiki/Global_variable).
Wouldn't it be great to enable global variables in Java and get rid of
Singletons. PHP, JavaScript, Ruby and many other languages
have them, why doesn't Java? Look at this code:

```java
class User {
  private static User INSTANCE;
  private User() {}
  public static User getInstance() {
    synchronized (User.INSTANCE) {
      if (User.INSTANCE == null) {
        User.INSTANCE = new User();
      }
    }
    return User.INSTANCE;
  }
  public String getName() {
    // return user's name
  }
}
```

Then, to access it we have to use:

```java
String name = User.getInstance().getName();
```

This is a Singleton. See how verbose it is?
We can simply replace it with a global variable (`global` is the keyword
I'm suggesting we use):

```java
global User user;
```

And then:

```java
user.getName();
```

Much less code to write, and way easier to read!

## Global Functions and Namespaces

To group static methods together we create
[utility classes]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}),
where we have to define private constructors to prevent their instantiation.
Also, we have to remember which particular utility class a static method is in.
It's just extra hassle. I'm suggesting we add global functions
to Java and optional "namespaces" to group them. Take a look at this
utility class:

```java
class TextUtils {
  private TextUtils() {}
  public static String trim(String text) {
    if (text == null) {
      return "";
    }
    return text.trim();
  }
}
```

Now look at this global function with a namespace:

```java
namespace TextUtils {
  String trim(String text) {
    if (text == null) {
      return "";
    }
    return text.trim();
  }
}
```

My point is that since we are already using classes as collections
of functions, let's make it more convenient. In some applications we
won't even need namespaces, just global functions, like in C and C++.

## Full Access to Private Attributes and Methods

In order to access a private attribute or a method of an object from outside we
have to use the [Reflection API](https://docs.oracle.com/javase/tutorial/reflect/).
It's not particularly difficult, but it does take a few lines
of code, which are not so easy to read and understand:

```java
class Point {
  private int x;
  private int y;
}
Point point = new Point();
Field field = point.getClass().getDeclaredField("x");
field.setAccessible(true);
int x = (int) field.get(point);
```

I'm suggesting we allow any object to access any of the attributes and methods
of another object:

```java
Point point = new Point();
int x = point.x;
```

Of course, if they are private, the compiler will issue a warning.
At compile time you simply ignore the warning and move on. If you really care
about encapsulation, pay attention to the warning and do something else. But
in most cases programmers will ignore it, since they would happily use
the Reflection API anyway.

## NULL by Default

It would be convenient to let us call constructors and methods with an
incomplete set of arguments. The arguments we don't provide will be set
to `null` by default. Also, when a method has to return something, but
there is no `return` statement, Java should return `null`. This is almost exactly how
it works in PHP, Ruby, and many other languages. I believe
it would be a convenient feature for Java ~~monkeys~~ developers too.

We won't need to define so many methods when some of the arguments are optional.
[Method overloading](https://docs.oracle.com/javase/tutorial/java/javaOO/methods.html)
is very verbose and difficult to understand. Instead, we
should have one method with a long list of arguments. Some of them will be
provided by the caller, others will be set to `null`. The method will
decide what to do, for example:

```java
void save(File file, String encoding) {
 if (encoding == null) {
   encoding = "UTF-8";
 }
}
```

Then we just call either `save(f)` or `save(f, "UTF-16")`. The method will
understand what we mean. We can also make it even more convenient, like it's
done in Ruby, providing method arguments by names:

```java
save(file: f, encoding: "UTF-16");
```

Also, when there is nothing to return, the method must return `null` by default.
Writing `return null` is just a waste of a code line and doesn't really
improve readability. Take a look:

```java
String load(File file) {
 if (file.exists()) {
   return read_the_content();
 }
}
```

It's obvious from this code that if the file exists, the method loads
and returns its content. If not, it returns `null`, which will be a good
indicator for the caller that something is not right and the content
of the file is not available.

## Getters and Setters

I think it's only obvious that we need this feature: every private attribute
must automatically have
[a setter and a getter]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}).
There should be no need
to create them, Java will provide them out-of-the-box, just like
[Kotlin](https://kotlinlang.org/docs/reference/properties.html)
and [Ruby](https://www.rubyist.net/~slagell/ruby/accessors.html) do.
What is the point of having an attribute if there are no getters and setters
to read it and to modify it, right?

With this new feature we'll no longer need the help of
[Lombok](https://projectlombok.org/features/GetterSetter),
or [IntelliJ IDEA](https://www.jetbrains.com/help/idea/generating-getters-and-setters.html).

<hr/>

Maybe I should turn my ideas into official proposals to
[JCP](https://jcp.org/en/participation/committee). What do you think?

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Programming languages are...</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1398900025145671680?ref_src=twsrc%5Etfw">May 30, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
