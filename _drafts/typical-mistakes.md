---
layout: post
title: "Typical Mistakes in OOP Code"
date: 2014-04-24
tags: mistakes quality
description:
  The article lists most common programming mistakes
  I catch during code reviews, which can't be caught by
  static analysis
keywords:
  - java programming good practices
  - object oriented typical mistakes
  - mistakes in OOP
  - bad practices
  - bad practices in programming
  - good practices in programming
  - bad practices in java
  - proper variable names
  - variable naming convention
  - class names
  - good name of a class
  - good class name
  - name of class in java
  - java class name
---

This page contains most typical mistakes I see in Java code of people working
with me. Static analysis (we're using
[qulice](http://www.qulice.com) can't catch them for obvious reasons,
that's why I decided to list them all here.
Let me know if you want to see something else here, I'll be happy to add.

All of this mistakes are related to object-oriented programming in general
and to Java in particular.

## Class Names

Read this short ["What is an Object?"](https://github.com/yegor256/d29/wiki/What-is-an-Object%3F)
article. Your class should be an abstraction of a real life entity.
No "validators", "controllers", "managers", etc.
If your class name ends with an "-er" &mdash;
it's [a bad design](http://c2.com/cgi/wiki?DontNameClassesObjectManagerHandlerOrData).

And, of course, utility classes are anti-patterns, like that
[`StringUtils`](http://commons.apache.org/proper/commons-lang/javadocs/api-2.6/org/apache/commons/lang/StringUtils.html),
[`FileUtils`](http://commons.apache.org/proper/commons-io/apidocs/org/apache/commons/io/FileUtils.html), and
[`IOUtils`](http://commons.apache.org/proper/commons-io/apidocs/org/apache/commons/io/IOUtils.html) from Apache.
They are perfect examples of a terrible design.

Of course, never add suffixes or prefixes to distinguish between
[interfaces and classes](http://c2.com/cgi/wiki?DontDistinguishBetweenClassesAndInterfaces).
All these names are terribly wrong: `IRecord`, `IfaceEmployee`, or `RecordInterface`.
Usually, interface name is the name of a real-life entity,
while class name should explain its implementation details.
If there is nothing specific to say about implementation,
name it `Default` or `Simple`, for example:

```java
class SimpleUser implements User {};
class DefaultRecord implements Record {};
class Suffixed implements Name {};
class Validated implements Content {};
```

## Method Names

Method can either return something or return `void`.
If it returns something than its name should
explain *what it returns*, for example (don't use `get` prefix ever):

```java
boolean isValid(String name);
String content();
int ageOf(File file);
```

If it returns `void` than its name should explain *what it does*, for example:

```java
void save(File file);
void process(Work work);
void append(File file, String line);
```

There is only one exception to the rule just mentioned &mdash;
test methods for JUnit. They are explained below. 7890-

## Test Method Names

Method names in JUnit tests should be created as English sentences
without spaces. It's easier to explain by example:

```java
/**
 * HttpRequest can return its content in Unicode.
 * @throws Exception If test fails
 */
public void returnsItsContentInUnicode() throws Exception {
}
```

It's important to start your JavaDoc first sentence with the name of the class
you're testing followed by `can`. So, your first and the only sentence will
always sound like "somebody _can_ do something". Method name will say exactly
the same, but without the subject. If I add a subject at the beginning of the
method name I should get a complete English sentence, as in example above:
"HttpRequest returns its content in unicode".

Pay attention that test method doesn't start with `can`.
Only JavaDoc comment starts so. Method name doesn't need starts with a verb.

It's a good practice to always declare test methods as throwing `Exception`.

## Variable Names

Avoid composite names of variables, like `timeOfDay`, `firstItem`, or
`httpRequest`. I mean both &mdash; class variables and in-method ones. A
variable name should be long enough to avoid ambiguity in its scope of
visibility, but not longer. A name should be a noun in singular or plural form,
or its abbreviation, for example:

```java
final List<String> names;
void sendThroughProxy(File file, Protocol proto);
private File content;
public HttpRequest request;
```

Sometimes you may have collisions between constructor parameters and in-class
properties, when your constructor is saving incoming data into an instantiated
object. In this case I recommend to use abbreviate by removing vowels (see how
[USPS abbreviates street names](https://www.usps.com/send/official-abbreviations.htm)),
for example:

```java
public final class Message {
  private String recipient;
  public Message(final String rcpt) {
    this.recipient = rcpt;
  }
}
```

In many cases, the best hint for a name of a variable you can get by reading its
class name. Just write it with a small letter and you're good:

```java
File file;
User user;
Branch branch;
```

But *never* do the same for primitive types, like `Integer number` or `String
string`.

You can also use an adjective, when there are more than one variable of
different characteristics, for example:

```
String contact(String left, String right);
```

## Constructors

Without exceptions, there should be only _one_ constructor that stores data into
object variables. All other constructors should call this one with different
arguments. For example:

```java
public class Server {
  private final String address;
  public Server(String uri) {
    this.address = uri;
  }
  public Server(URI uri) {
    this(uri.toString());
  }
}
```

## One-time Variables

Avoid one-time variables at all cost. By one-time I mean variables that are used
only once, for example:

```java
final String name = "data.txt";
return new File(name);
```

This variable is used only once and this code should be refactored to:

```java
return new File("data.txt");
```

Sometime, in very rare cases, mostly because of better formatting, one-time
variables may be used. But try to avoid such situations at all cost.

## Exceptions

Needless to say that you should **never** swallow exceptions, but let them
bubble up as high as possible. Private methods should always let checked
exceptions go out.

Never use exceptions for flow control, for example this code is wrong:

```java
int size;
try {
  size = this.fileSize();
} catch (IOException ex) {
  size = 0;
}
```

Seriously, what if that `IOException` says "disk is full"? You will still assume
that the size of the file is zero and move on?

## Time Constants

Don't calculate time with constants, like:

```java
final long millis = min * 60 * 1000;
```

Instead, use [`TimeUnit`](http://docs.oracle.com/javase/7/docs/api/java/util/concurrent/TimeUnit.html):

```java
final long millis = TimeUnit.MINUTES.toMillis(2);
final long sec = TimeUnit.HOURS.toMinutes(1);
```

## Lombok

Don't forget to use `@ToString` and `@EqualsAndHashCode` annotations from
[Lombok](http://projectlombok.org/). They add `toString()` and `equals()` and
`hashCode()` methods to your class during compilation. Why it's important?
Because without them you will either 1) have default methods that don't do anything
good, or 2) will have to create your own in every class, which is ineffective.

But don't forget to specify a list of private properties for
`@EqualsAndHashCode`, for example:

```java
@ToString
@EqualsAndHashCode(of = { "name", "age" })
public final class User {
  private final transient String name;
  private final transient long age;
}
```

## Indentation

The main simple rule is that a bracket should either end a line or be closed on the
same line (reverse rule applies to a closing bracket). For example, this is not
correct, because the first bracket is not closed on the same line and there are
symbols after it. The second bracket is also in trouble, because there are
symbols in front of it and it is not opened at the same line:

```
final File file = new File(directory,
  "file.txt");
```

Correct indentation should look like:

```
StringUtils.join(
  Arrays.asList(
    "first line",
    "second line",
    StringUtils.join(
      Arrays.asList("a", "b")
    )
  ),
  "separator"
);
```

The second important rule says that you should put as much as possible on one
line, within the limit of 80 characters. The example above is not valid, since
it can be compacted:

```
StringUtils.join(
  Arrays.asList(
    "first line", "second line",
    StringUtils.join(Arrays.asList("a", "b"))
  ),
  "separator"
);
```

## Redundant Constants

Class constants should be used when you want to share some information between
class methods, and this information is a characteristic (!) of your class. Don't
use constants as a replacement of string or numeric literals &mdash; very bad
practice that leads to code pollution. Constant (as any object in OOP) should
have a meaning in a real world. What meaning do these constants have in the real
world:

```java
class Document {
  private static final String D_LETTER = "D"; // bad practice
  private static final String EXTENSION = ".doc"; // good practice
}
```

Another typical mistake is to use constants in unit tests in order to avoid
duplicate string/numeric literals in test methods. Don't do this! Every test
method should work with its own set of input values. Use new texts and numbers
in every new test method. They are independent, so why do they have to share
same input constants?

## Test Data Coupling

This is an example of [data coupling](http://en.wikipedia.org/wiki/Coupling_%28computer_programming%29)
in a test method:

```java
User user = new User("Jeff");
// maybe some other code here
MatcherAssert.assertThat(user.name(), Matchers.equalTo("Jeff"));
```

On the last line we couple `"Jeff"` with the same string literal from the first
line. If, a few months later, someone wants to change the value on the third
line he/she has to spend extra time finding where else this `"Jeff"` is used in
the same method. To avoid this data coupling you should introduce a variable.
