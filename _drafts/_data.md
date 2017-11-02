---
layout: post
title: "Five Features to Make Java Even Better"
date: 2017-11-01
place: Odessa, Ukraine
tags: testing
description: |
  ...
keywords:
  - java dto
  - java data classes
  - data classes in java
  - data structures in java
  -
image: /images/2017/02/...
jb_picture:
  caption:
---

I stumbled upon [this proposal](http://cr.openjdk.java.net/~briangoetz/amber/datum.html)
of [Brian Goetz](https://twitter.com/BrianGoetz)
for data classes in Java, and immediately
realized that I also have a few ideas how to make Java better
as a language. I have many, but this is a short list of the most
important five.

<!--more-->

{% jb_picture_body %}

**Global Variables**.
There are [Singletons](https://en.wikipedia.org/wiki/Singleton_pattern) in Java,
which are actually nothing just
[global variables](https://en.wikipedia.org/wiki/Global_variable).
Would be great to just introduce global variables and get rid of
Singletons. PHP, JavaScript, Ruby and many other languages
have them, why Java doesn't? Look at this code:

{% highlight java %}
class User {
  private static final User INSTANCE;
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
{% endhighlight %}

Then, to access it we have to use:

{% highlight java %}
String name = User.getInstance().getName();
{% endhighlight %}

This is Singleton. See how verbose it is? We can just replace it with
a simple global variable:

{% highlight java %}
global User user;
{% endhighlight %}

And then:

{% highlight java %}
user.getName();
{% endhighlight %}

Less code to write, easier to read!

## Global Functions and Namespaces

In to group static methods together we create Utility classes. We also have
to add private constructors there, to prevent their instantiation. Also,
we have to remember where that static methods are, in which utility
classes. It's just extra hassle. I'm suggesting to add global functions
to Java and optional "namespaces" to group them. Take a look at this
Utility class:

{% highlight java %}
class TextUtils {
  private TextUtils();
  public static String trim(String text) {
    if (text == null) {
      return "";
    }
    return text.trim();
  }
}
{% endhighlight %}

And now look at this global function with a namespace:

{% highlight java %}
namespace TextUtils {
  String trim(String text) {
    if (text == null) {
      return "";
    }
    return text.trim();
  }
}
{% endhighlight %}

Less code, easier to write and read!

## Full Access to Private Attributes and Methods

In order to access a private attribute or a method of an object from outside we
have to use [Reflection API](https://docs.oracle.com/javase/tutorial/reflect/).
It's not so difficult, but takes a few lines
of code, which are not so easy to read and understand. I'm suggesting to
allow any object to access any attributes and methods of another object, but
if they are private, the compiler will give a warning.

At compile time you simply ignore the warning and move on. If you really care
about encapsulation, pay attention to the warning and do something else. But
in most cases programmers will ignore it, since they would use
Reflection anyway.

## NULL by Default

It would be convenient to let call constructors and methods with an
incomplete set of arguments. The arguments we don't provide will be set
to `null` by default. Also, when a method has to return something, but
there is no `return` statement, Java has to return `null`. This is almost exactly how
it works in PHP, Ruby, and many other languages. I believe,
it would be a convenient feature for Java <del>monkeys</del> developers too.

We won't need to define a few methods, when some arguments are optional. This
method overloading is very verbose and difficult to understand. Instead, we
will have one method with a long list of arguments. Some of them will be
provided by the caller, others will be set to `null`. The method will
decide what to do, for example:

{% highlight java %}
void save(File file, String encoding) {
 if (encoding == null) {
   encoding = "UTF-8";
 }
}
{% endhighlight %}

Then, we just either call `save(f)` or `save(f, "UTF-16")`. The method will
understand what we mean.

Also, when there is nothing to return, the method must return `null` by default.
Writing that `return null` is just a waste of a code line and doesn't really
improve readability. Take a look:

{% highlight java %}
String load(File file) {
 if (file.exists()) {
   return read_the_content();
 }
}
{% endhighlight %}

It's obvious from this code that if the file exists, the method loads
and returns its content. If not, it returns `null`, which will be a good
indicator for the caller that something is not right and the content
of the file is not available.

## Getters and Setters

I think it's only obvious that we need this feature: every private attribute
must automatically have a setter and a getter. There should be no need
to create them, Java will provide them out-of-the-box, just like
[Kotlin does](https://kotlinlang.org/docs/reference/properties.html).
What is the point of having an attribute if there are no getters and setters
to access it and modify, right?

With this new feature we won't need help of
[Lombok](https://projectlombok.org/features/GetterSetter),
or [IntelliJ IDEA](https://www.jetbrains.com/help/idea/generating-getters-and-setters.html).

<hr/>

A few more thoughts. We may want to get rid of
[checked exceptions]({% pst 2015/jul/2015-07-28-checked-vs-unchecked-exceptions %}),
[static typing](https://en.wikipedia.org/wiki/Type_system#Static_and_dynamic_type_checking_in_practice),
That will move Java even closer to other popular
object-oriented languages, like Ruby, JavaScript,
PHP <del>and Basic</del>, and will make our code shorter and easier
to write.
