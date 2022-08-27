---
layout: post
title: "Avoid String Concatenation"
date: 2014-06-19
tags: java
description: |
  String concatenation in Java is a bad practice;
  this article explains why and how to avoid it to create cleaner code
keywords:
  - java string concatenation
  - avoid string concatenation
  - bad practice java
  - best practice string concatenation
  - how to avoid string concatenation
  - replacement of string concatenation
---

This is "string concatenation," and it is a bad practice:

```java
// bad practice, don't reuse!
String text = "Hello, " + name + "!";
```

Why? Some may say that it is slow, mostly because parts of
the resulting string are copied multiple times. Indeed, on every `+` operator,
`String` class allocates a new block in memory and copies everything
it has into it; plus a suffix being concatenated. This is true,
but this is not the point here.

<!--more-->

Actually, I don't think performance in this case is a big issue.
Moreover, there were [multiple experiments](http://stackoverflow.com/questions/925423)
showing that concatenation is not that slow when compared to other
string building methods and sometimes is even faster.

Some say that concatenated strings are not localizable because in
different languages text blocks in a phrase may be positioned
in a different order. The example above can't be translated to,
say, Russian, where we would want to put a name in front of
"привет." We will need to localize the entire block of code,
instead of just translating a phrase.

However, my point here is different. I strongly recommend
avoiding string concatenation because it is **less readable**
than other methods of joining texts together.

Let's see these alternative methods. I'd recommend three of them (in order of preference):
`String.format()`,
Apache `StringUtils` and
Guava `Joiner`.

There is also a [`StringBuilder`](http://docs.oracle.com/javase/7/docs/api/java/lang/StringBuilder.html),
but I don't find it as attractive as `StringUtils`. It is a useful
builder of strings, but not a proper replacer or string
concatenation tool when readability is important.

## String.format()

[`String.format()`](http://docs.oracle.com/javase/7/docs/api/java/lang/String.html#format%28java.lang.String,%20java.lang.Object...%29)
is my favorite option. It makes text phrases easy to understand
and modify. It is a static utility method that mirrors
[`sprintf()`](http://www.cplusplus.com/reference/cstdio/sprintf/) from C.
It allows you to build a string using a pattern and substitutors:

```java
String text = String.format("Hello, %s!", name);
```

When the text is longer, the advantages of the formatter become
much more obvious. Look at this ugly code:

```java
String msg = "Dear " + customer.name()
  + ", your order #" + order.number()
  + " has been shipped at " + shipment.date()
  + "!";
```

This one looks much more beautiful doesn't it
(jSparrow even has [a rule](https://jsparrow.github.io/rules/avoid-concatenation-in-logging-statements.html) for this):

```java
String msg = String.format(
  "Dear %1$s, your order #%2$d has been shipped at %3$tR!",
  customer.name(), order.number(), shipment.date()
);
```

Please note that I'm using argument indexes in order to make
the pattern even more localizable. Let's say, I want
to translate it to Greek. This is how will it look:

```text
Αγαπητέ %1$s, στις %3$tR στείλαμε την παραγγελία σου με αριθμό #%2$d!
```

I'm changing the order of substitutions in the pattern,
but not in the actual list of methods arguments.

## Apache `StringUtils.join()`

When the text is rather long (longer than your screen width),
I would recommend that you use the utility class
[`StringUtils`](http://commons.apache.org/proper/commons-lang/javadocs/api-2.6/org/apache/commons/lang/StringUtils.html)
from Apache [commons-lang3](http://commons.apache.org/proper/commons-lang/):

```java
import org.apache.commons.lang3.StringUtils;
String xml = StringUtils.join(
  "<?xml version='1.0'?>",
  "<html><body>",
  "<p>This is a test XHTML document,",
  " which would look ugly,",
  " if we would use a single line,"
  " or string concatenation or String format().</p>"
  "</body></html>"
);
```

The need to include an additional JAR dependency
to your classpath may be considered a downside with this method
(get its latest versions in [Maven Central](http://search.maven.org/)):

```xml
<dependency>
  <groupId>org.apache.commons</groupId>
  <artifactId>commons-lang3</artifactId>
</dependency>
```

## Guava Joiner

Similar functionality is provided by
[`Joiner`](http://google.github.io/guava/releases/16.0/api/docs/com/google/common/base/Joiner.html)
from Google [Guava](https://code.google.com/p/guava-libraries/):

```java
import com.google.common.base.Joiner;
String text = Joiner.on('').join(
  "WE HAVE BUNNY.\n",
  "GATHER ONE MILLION DOLLARS IN UNMARKED ",
  "NON-CONSECUTIVE TWENTIES.\n",
  "AWAIT INSTRUCTIONS.\n",
  "NO FUNNY STUFF"
);
```

It is a bit less convenient than `StringUtils` since you always
have to provide a joiner (character or a string placed between text blocks).

Again, a dependency is required in this case:

```xml
<dependency>
  <groupId>com.google.guava</groupId>
  <artifactId>guava</artifactId>
</dependency>
```

Yes, in most cases, all of these methods work slower than
a plain simple concatenation. However, I strongly believe
that **computers are cheaper than people**. What I mean is that
the time spent by programmers understanding and modifying ugly
code is much more expensive than a cost of an additional server
that will make beautifully written code work faster.

If you know any other methods of avoiding string concatenation,
please comment below.
