---
layout: post
title: "Public Static Literals... is Not A Solution for Data Duplication"
date: 2015-06-18
tags: oop java
description:
  It's a common practice to make constants public
  in order to avoid duplication; it's a bad
  practice, use objects instead.
keywords:
  - static constants java
  - static literals java
  - public static java
  - public static
  - public static literals
---

I have `new String(array,"UTF-8")` in one place and exactly
the same code in another place of the app. Actually, I mave have
it in many places. Every time I have to use that `"UTF-8"` constant
in order to create a `String` from a byte array. Would be very
convenient to define it once somewhere and reuse, just like Apache Commons
is doing it, see [`CharEncoding.UTF_8`]() (there are many other static
literals there). These guys are giving us a bad example! These `public` `static`
"properties" are as bad as
[utility classes]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}).

<!--more-->

Here is specifically what I'm talking about:

{% highlight java %}
package org.apache.commons.lang3;
public class CharEncoding {
  public static final String UTF_8 = "UTF-8";
  // some other methods and properties
}
{% endhighlight %}

Now, when I need to create a `String` from a byte array I'm using this:

{% highlight java %}
import org.apache.commons.lang3.CharEncoding;
String text = new String(array, CharEncoding.UTF_8);
{% endhighlight %}

Say, I want to convert a `String` into a byte array:

{% highlight java %}
import org.apache.commons.lang3.CharEncoding;
byte[] array = text.getBytes(CharEncoding.UTF_8);
{% endhighlight %}

Looks convenient, right? This is what the designers of Apache Commons think
(one the most popular and the most _terrible_ library
in Java world). I encourage you to think differently.
I can't tell you to stop using Apache Commons, since we simply don't have
a better alternative (yet!). But in your own code, don't use public
static properties, ever. Even if this code may look convenient to you,
it's a very bad design.

The reason here is very similar to
[utility classes]({% pst 2015/feb/2015-02-26-composable-decorators %})
with public static
methods &mdash; they are unbreakable hard-coded dependencies. Once you
use that `CharEncoding.UTF_8`, your object starts to depend on this
data and its user (the user of your object) can't break this dependency. You may say that
this is your intention, in case of `"UTF-8"` constant &mdash; to make
sure that specifically Unicode is being used and nothing else. In this particular
example this may be true, but look at this from a more global perspective.

Let me show the alternative I have mind, before we continue.
Here is what I'm suggesting instead, to convert a byte array
to a `String`:

{% highlight java %}
String text = new UTF8String(array);
{% endhighlight %}

It's a pseudo-code, since Java designers made class `String` final and we
can't really extend it and create `UTF8String`, but you get the idea. In a real
world this would look like this:

{% highlight java %}
String text = new UTF8String(array).toString();
{% endhighlight %}

As you see, we encapsulate the "UTF-8" constant somewhere inside the class
`UTF8String` and its users have no idea how exactly this "byte array to string"
conversion is happening.

By introducing `UTF8String` we solved the problem of "UTF-8"
literal duplication. But we did it in a proper object-oriented way &mdash;
we encapsulated the functionality inside a class and let everybody
instantiate its objects and use them. We resolved the problem of functionality
duplication, not just data duplication.

Instead, placing data into one shared place (`CharEncoding.UTF_8`)
doesn't really solve the duplication problem but is making it even worse. Mostly
because it encourages everybody to duplicate functionality using the same
piece of shared data.

My point here is that every time you see that you have some data duplication
in your application, start thinking about the functionality you're duplicating.
You will easily find the code that is repeated again and again. Make a new
class for this code and place the data there, as a `private` property (or private
`static` property). That's how you will improve your design and truly get rid
of duplication.
