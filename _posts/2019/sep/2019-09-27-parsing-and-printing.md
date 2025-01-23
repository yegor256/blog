---
layout: post
title: "Date/Time Printing Can Be Elegant Too"
date: 2019-09-27
place: St. Petersburg, Russia
tags: oop java
description: |
  Printing and parsing dates in Java is the territory of horror,
  with dozens of libraries, which don't make life easier;
  there is an elegant solution, however.
keywords:
  - parse date and time
  - java time and date
  - java print time
  - java parse time
  - java time
image: /images/2019/09/fargo-2.jpg
jb_picture:
  caption: Fargo, Season 2 (2014) by Noah Hawley
---

I owe my [pretty high](https://stackoverflow.com/users/187141/yegor256)
Stack Overflow reputation to [this question](https://stackoverflow.com/questions/3914404)
in particular, which I asked a few years ago: How do you print an
[ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) date in Java?
It managed to collect a lot of upvotes since then and 20+ answers, including
[my own one](https://stackoverflow.com/a/14274358/187141). Seriously,
why didn't Java, such a rich ecosystem, have a built-in out-of-the-box _simple_
solution for this primitive task? I believe this is because the designers
of the Java SDK were 1) smart enough not to create a `print()` method right in the
class `Date`, and 2) not smart enough to give us an extendable set of classes
and interfaces to parse and print dates in an elegant way.

<!--more-->

{% jb_picture_body %}

There are basically three ways to split the responsibility
of parsing and printing in JDK (to my knowledge):

## DTO + Utility Class

The first one is when _something_ is responsible for printing and parsing
while the object is just a data holder.
There is a class `SimpleDateFormat`, which
has to be configured first, with the right time zone and the formatting pattern.
Then it has to be used to print:

```java
DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm'Z'");
df.setTimeZone(TimeZone.getTimeZone("UTC"));
String iso = df.format(new Date());
```

To parse it back, there is the method `parse()`:

```java
Date date = df.parse("2007-12-03T10:15Z");
```

It's a classic combination of a
[DTO]({% pst 2016/jul/2016-07-06-data-transfer-object %})
and a
[utility class]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}).
The DTO is the [`Date`](https://docs.oracle.com/javase/8/docs/api/java/util/Date.html)
object and the utility class is the `SimpleDateFormat`. The date-object
[exposes]({% pst 2016/nov/2016-11-21-naked-data %})
all required data attributes through a number of
[getters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}) and the utility
class prints the date. The date-object has no influence on this process.
It's not actually an object, but merely a data container.
This is not object-oriented programming at all.

## The Object

Java 8 introduced the class [`Instant`](https://docs.oracle.com/javase/8/docs/api/java/time/Instant.html)
with the method [`toString()`](https://docs.oracle.com/javase/8/docs/api/java/time/Instant.html#toString--),
which returns time in
[ISO-8601](https://en.wikipedia.org/wiki/ISO_8601) format:

```java
String iso = Instant.now().toString();
```

To parse it back there is a static method
[`parse()`](https://docs.oracle.com/javase/8/docs/api/java/time/Instant.html#parse-java.lang.CharSequence-)
in the same class [`Instant`](https://docs.oracle.com/javase/8/docs/api/java/time/Instant.html):

```java
Instant time = Instant.parse("2007-12-03T10:15:30Z");
```

This approach looks more object-oriented, but
the problem here is that it's impossible to modify the printing
pattern in any way (for example, remove the milliseconds or
change the format entirely). Moreover, the method `parse()` is
[static]({% pst 2017/nov/2017-11-14-static-factory-methods %}),
which means that there can be no polymorphism---we can't change the
logic of parsing either. We also can't change the printing logic,
since `Instant` is a final class, not an interface.

This design sounds OK if all we need is ISO 8601 date/time strings.
The moment we decide to extend it in some way, we are in trouble.

## The Ugly Mix

There is also
[`DateTimeFormatter`](https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html)
in [Java 8]({% pst 2017/nov/2017-11-07-five-new-java-features %}),
which introduces the third way of dealing with date/time objects.
To print a date to a `String` we make an instance of the "formatter" and
pass it to the time-object:

```java
LocalDateTime date = LocalDateTime.now(ZoneId.of("UTC"));
DateTimeFormatter formatter = DateTimeFormatter.ofPattern(
  "yyyy-MM-dd'T'HH:mm:ss'Z'"
);
String iso = time.format(formatter);
```

To parse back, we have to send the `formatter` to the static method
[`parse()`](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDate.html#parse-java.lang.CharSequence-java.time.format.DateTimeFormatter-)
together with the text to parse:

```java
LocalDateTime time = LocalDateTime.parse(
  "2007-12-03T10:15:30Z", formatter
);
```

How do they communicate, `LocalDateTime` and `DateTimeFormatter`?
The time-object is a
[`TemporalAccessor`](https://docs.oracle.com/javase/8/docs/api/java/time/temporal/TemporalAccessor.html),
with a method [`get()`](https://docs.oracle.com/javase/8/docs/api/java/time/temporal/TemporalAccessor.html#get-java.time.temporal.TemporalField-)
allowing anyone to extract whatever is inside. In other words, again, a
[DTO]({% pst 2016/jul/2016-07-06-data-transfer-object %}).
The formatter is still a
[utility class]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}) (not even an interface),
which expects the DTO to arrive, extracts what's inside, and prints.

How do they parse? The method
[`parse()`](https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html#parse-java.lang.CharSequence-)
reads the template, and builds and returns another
[`TemporalAccessor`](https://docs.oracle.com/javase/8/docs/api/java/time/temporal/TemporalAccessor.html)
DTO.

What about encapsulation? "Not this time," JDK designers say.

## The Right Way

Here is how I would design it instead. First, I would make a generic
immutable `Template` with this interface:

```java
interface Template {
  Template with(String key, Object value);
  Object read(String key);
}
```

It would be used like this:

```java
String iso = new DefaultTemplate("yyyy-MM-dd'T'HH:mm'Z'")
  .with("yyyy", 2007)
  .with("MM", 12)
  .with("dd", 03)
  .with("HH", 10)
  .with("mm", 15)
  .with("ss", 30)
  .toString(); // returns "2007-12-03T10:15Z"
```

This template internally decides how to print the data coming in,
depending on the encapsulated pattern. Here is how the `Date` would be
able to print itself:

```java
class Date {
  private final int year;
  private final int month;
  private final int day;
  private final int hours;
  private final int minutes;
  private final int seconds;
  Template print(Template template) {
    return template
      .with("yyyy", this.year)
      .with("MM", this.month)
      .with("dd", this.day)
      .with("HH", this.hours)
      .with("mm", this.minutes)
      .with("ss", this.seconds);
  }
}
```

This is how parsing would work
(it's a [bad idea]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %})
in general to put code into the constructor, but for this experiment it's OK):

```java
class Date {
  private final int year;
  private final int month;
  private final int day;
  private final int hours;
  private final int minutes;
  private final int seconds;
  Date(Template template) {
    this.year = template.read("yyyy");
    this.month = template.read("MM");
    this.day = template.read("dd");
    this.hours = template.read("HH");
    this.minutes = template.read("mm");
    this.seconds = template.read("ss");
  }
}
```

Let's say we want to print time as "13-е января 2019 года" (it's in Russian).
How we would do this? We don't create a new `Template`, we
[decorate]({% pst 2015/feb/2015-02-26-composable-decorators %}) the
existing one, a few times. First, we make an instance of what we have:

```java
new DefaultTemplate("dd-е MMMM yyyy-го года")
```

This one will print something like this:

```text
12-е MMMM 2019-го года
```

The `Date` doesn't send the value of `MMMM` into it, that's why it doesn't
replace the text correctly. We have to decorate it:

```java
class RussianTemplate {
  private final Template origin;
  RussianTemplate(Template t) {
    this.origin = t;
  }
  @Override
  Template with(String key, Object value) {
    Template t = this.origin.with(key, value);
    if (key.equals("MM")) {
      String name = "";
      switch (value) {
      case 0:
        name = "января";
        break;
      case 1:
        name = "февраля";
        break;
        // etc...
      }
      t = t.with("MMMM", name);
    }
    return t;
  }
}
```

Now, to get a Russian date from a `Date` object we do this:

```java
String txt = time.print(
  new RussianTemplate(
    new DefaultTemplate("dd-е MMMM yyyy-го года")
  )
);
```

Let's say we want to print the date in a different time zone. We create another
decorator, which intercepts the call with the `"HH"` and deducts (or adds)
the time difference:

```java
class TimezoneTemplate {
  private final Template origin;
  private final int zone;
  TimezoneTemplate(Template t, int z) {
    this.origin = t;
    this.zone = z;
  }
  @Override
  Template with(String key, Object value) {
    Template t = this.origin.with(key, value);
    if (key.equals("HH")) {
      t = t.with("MM", Integer.cast(value) + this.z);
    }
    return t;
  }
}
```

This code will print Moscow (UTC+3) time in Russian:

```java
String txt = time.print(
  new TimezoneTemplate(
    new RussianTemplate(
      new DefaultTemplate("dd-е MMMM yyyy-го года")
    ),
    +3
  )
);
```

We can decorate as much as we need, making the `Template` as powerful
as it needs to be. The elegance of this approach is that the class
`Date` is completely decoupled from the `Template`, which makes them
both replaceable and polymorphic.

Maybe someone will be interested in creating an open source
date and time printing and parsing library for Java with these
principles in mind?
