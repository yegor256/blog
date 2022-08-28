---
layout: post
title: "XML/XPath Matchers for Hamcrest"
date: 2014-04-28
tags: xml testing
description: |
  jcabi-matchers is a new small library that extends
  the Hamcrest arsenal with XML/XPath matchers; the article explains
  how to use the in Java projects
keywords:
  - xml hamcrest
  - xpath matchers
  - junit hamcrest xml matchers
  - xml matchers junit
  - xml matchers hamcrest
  - hamcrest xpath example
  - hamcrest xpath library
  - hamcrest xpath example code
---

{% badge http://img.jcabi.com/logo-square.svg 64 http://matchers.jcabi.com %}

[Hamcrest](https://github.com/hamcrest/JavaHamcrest) is my favorite instrument
in unit testing. It replaces the JUnit procedural assertions of
`org.junit.Assert` with an object-oriented mechanism. However, I will discuss
that subject in more detail sometime later.

Now, though, I want to demonstrate a new library published today on GitHub and
Maven Central: [jcabi-matchers](http://matchers.jcabi.com).
jcabi-matchers is a collection of
Hamcrest matchers to make XPath assertions in XML and XHTML documents.

Let's say, for instance, a class that is undergoing  testing produces an XML
that needs to contain a single `<message>` element with the content `"hello,
world!"`

This is how that code would look in a unit test:

```java
import com.jcabi.matchers.XhtmlMatchers;
import org.hamcrest.MatcherAssert;
import org.junit.Test;
public class FooTest {
  @Test
  public void hasWelcomeMessage() {
    MatcherAssert.assertThat(
      new Foo().createXml(),
      XhtmlMatchers.hasXPaths(
        "/document[count(message)=1]",
        "/document/message[.='hello, world!']"
      )
    );
  }
}
```

<!--more-->

There are two alternatives to the above that I'm aware of, which are do almost the same thing:
[xml-matchers](https://code.google.com/p/xml-matchers/) by
David Ehringer
and
[`hasXPath()`](https://github.com/hamcrest/JavaHamcrest/blob/hamcrest-java-1.3/hamcrest-library/src/main/java/org/hamcrest/xml/HasXPath.java)
method in Hamcrest itself.

I have tried them both, but faced a number of problems.

First, Hamcrest `hasXPath()` works only with an instance of
[`Node`](http://docs.oracle.com/javase/7/docs/api/org/w3c/dom/Node.html). With
this method, converting a `String` into `Node` becomes a repetitive and routine
task in every unit test.

The above is a very strange limitation of Hamcrest in contrast to
[jcabi-matchers](http://matchers.jcabi.com), which works with almost anything, from a
`String` to a
[`Reader`](http://docs.oracle.com/javase/7/docs/api/java/io/Reader.html) and
even an [`InputStream`](http://docs.oracle.com/javase/7/docs/api/java/io/InputStream.html).

Second, `XmlMatchers` from [xml-matchers](https://code.google.com/p/xml-matchers/)
provides a very inconvenient way for working with namespaces. Before you can
use an XPath query with a non-default namespace, you should create an instance
of `NamespaceContext`.

The library provides
[a simple implementation](https://code.google.com/p/xml-matchers/source/browse/trunk/xml-matchers/src/main/java/org/xmlmatchers/namespace/SimpleNamespaceContext.java) of this interface,
but, still, it is requires extra code in every unit test.

[jcabi-matchers](http://matchers.jcabi.com) simplifies namespace handling
problems even further, as it pre-defines most popular namespaces, including
`xhtml`, `xs`, `xsl`, etc.

The following example works right out-of-the-box---without any extra configuration:

```java
MatcherAssert.assertThat(
  new URL("http://www.google.com").getContent(),
  XhtmlMatchers.hasXPath("//xhtml:body")
);
```

To summarize, my primary objective with the library was its simplicity of usage.
