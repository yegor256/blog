---
layout: post
title: "Parsing and Printing"
date: 2016-09-24
place: Kyiv, Ukraine
tags: oop
description: |
  ...
keywords:
  - ...
  - ...
  - ...
  - ...
  - ...
image: /images/2019/09/
jb_picture:
  caption: ...
---

I owe my [pretty high](https://stackoverflow.com/users/187141/yegor256)
StackOverflow reputation to [this question](https://stackoverflow.com/questions/3914404)
in particular, which I asked a few years ago: How do you print an ISO 8601 date in Java?
It managed to collect a lot of upvotes since then and 20+ answers, including
[my own one](https://stackoverflow.com/a/14274358/187141). Seriously,
why Java, such a rich eco-system, doesn't have a built-in out-of-the-box
solution for this primitive task? I believe, this is because the designers
of Java SDK were 1) smart enough not to create `print()` method right in the
class `Date`, and 2) not smart enough to give us an extendable set of classes
and interfaces to parse and print dates. How would you design them?

<!--more-->

{% jb_picture_body %}

There are basically three options of how to split the responsibility
of parsing and printing. The first one is when the engine is responsible
for printing and parsing and the object is just a data holder. The second
one is when the object knows how to print and parse and no other objects
are involved. The third option is a mix.

## The DTO

There was a thread-unsafe class `SimpleDateFormat`, which
had to be configured first, with the right time zone and the formatting pattern.
Then, it had to be used to print:

{% highlight java %}
df.setTimeZone(TimeZone.getTimeZone("UTC"));
DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm'Z'");
String iso = df.format(new Date());
{% endhighlight %}

To parse it back I had to use the method `parse()` of the same object:

{% highlight java %}
Date date = df.parse("2007-12-03T10:15Z");
{% endhighlight %}

## The Object

Java 8 introduced the class [`Instant`](https://docs.oracle.com/javase/8/docs/api/java/time/Instant.html)
with the method [`toString()`](https://docs.oracle.com/javase/8/docs/api/java/time/Instant.html#toString--),
which returns time in ISO-8601 format:

{% highlight java %}
String iso = Instant.now().toString();
{% endhighlight %}

To parse it back there is a static method [`parse()`](https://docs.oracle.com/javase/8/docs/api/java/time/Instant.html#parse-java.lang.CharSequence-):

{% highlight java %}
Instant time = Instant.parse("2007-12-03T10:15:30Z");
{% endhighlight %}

The problem here is that it's impossible to modify the printing
pattern anyhow (for example, remove the milliseconds or
change the format entirely).

## The Printer

There is also [`DateTimeFormatter`](https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html)
in Java 8, which introduces the third way of dealing with date/time objects.
To print a date to a `String` you make an instance of the formatter and
pass it to the time object:

{% highlight java %}
LocalDateTime date = LocalDateTime.now(ZoneId.of("UTC"));
DateTimeFormatter formatter = DateTimeFormatter.ofPattern(
  "yyyy-MM-dd'T'HH:mm:ss'Z'"
);
String iso = time.format(formatter);
{% endhighlight %}

To parse back, we have to send the `formatter` to the static method
[`parse()`](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDate.html#parse-java.lang.CharSequence-java.time.format.DateTimeFormatter-):

{% highlight java %}
LocalDateTime time = LocalDateTime.parse("2007-12-03T10:15:30Z", formatter);
{% endhighlight %}












