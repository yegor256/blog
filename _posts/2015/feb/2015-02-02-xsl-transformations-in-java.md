---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "XSL Transformation in Java: An Easy Way"
date: 2015-02-02
tags: xml java jcabi
categories: jcg
description: |
  XSL transformations can be accomplished in Java through a single method
  call with the help of jcabi-xml.
keywords:
  - xml transformation java
  - xslt java
  - transform xml java
  - java xslt example
  - java xslt code example
---

{% badge https://www.jcabi.com/logo-square.svg 64 https://http.jcabi.com %}

[XSL transformation](https://www.w3.org/TR/xslt20/)
(XSLT) is a powerful mechanism for converting one
XML document into another. However, in Java, XML manipulations
are rather verbose and complex. Even for a simple XSL transformation,
you have to write a few dozen lines of code---and maybe even more
than that if proper exception handling and logging is needed.
[jcabi-xml]({% pst 2014/apr/2014-04-24-java-xml-parsing-and-traversing %}) is
a small open source library that makes life much easier by enabling
XML parsing and XPath traversing with
[a few simple methods]({% pst 2014/apr/2014-04-24-java-xml-parsing-and-traversing %}). Let's
see how this library helps in XSL transformations.

<!--more-->

First, take a look at a practical example---[rultor.com](https://www.rultor.com)---a hosted DevOps assistant that
[automates]({% pst 2014/jul/2014-07-24-rultor-automated-merging %})
release, merge, and deploy operations. Rultor keeps each conversation session with an end user (a.k.a. "talk")
in a DynamoDB record. There are multiple situations to handle
in each talk; that's why using multiple columns of a record is not
really feasible. Instead, we're keeping only a few parameters of each talk
in record columns (like ID and name) and putting all the rest in a single
XML column.

This is approximately how our DynamoDB table looks:

```text
+----+---------------+--------------------------------------+
| id | name          | xml                                  |
+----+---------------+--------------------------------------+
| 12 | jcabi-xml#54  | <?xml version='1.0'?>                |
|    |               | <talk public="true">                 |
|    |               |   <request id="e5f4b3">...</request> |
|    |               | </talk>                              |
+----+---------------+--------------------------------------+
| 13 | jcabi-email#2 | <?xml version='1.0'?>                |
|    |               | <talk public="true">                 |
|    |               |   <daemon id="f787fe">...</daemon>   |
|    |               | </talk>                              |
+----+---------------+--------------------------------------+
```

Once a user posts `@rultor status` into a GitHub ticket, Rultor
has to answer with a full status report about the current talk. In order
to create such a text answer (a regular user would not appreciate an XML response),
we have to fetch that `xml` column from the necessary DynamoDB record and convert
it to plain English text.

Here is how we're doing that with the help of
[jcabi-xml]({% pst 2014/apr/2014-04-24-java-xml-parsing-and-traversing %})
and its class,
[`XSLDocument`](https://xml.jcabi.com/apidocs-0.15/com/jcabi/xml/XSLDocument.html).

```java
final String xml = // comes from DynamoDB
final XSL xsl = new XSLDocument(
  this.getClass().getResourceAsStream("status.xsl")
);
final String text = xsl.applyTo(xml);
```

That's it. Now let's see what's there in that `status.xsl` file
(this is just a skeleton of it; the full version is [here](https://github.com/yegor256/rultor/blob/1.48/src/main/resources/com/rultor/agents/github/qtn/status.xsl)):

```xml
<xsl:stylesheet xmlns:xsl="https://www.w3.org/1999/XSL/Transform"
  version="2.0">
  <xsl:output method="text"/>
  <xsl:template match="/talk">
    <xsl:text>Hi, here is your status report:</xsl:text>
    ...
  </xsl:template>
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
```

It is good practice to create XSL documents only once per application
run. We have a static utility method [`XSLDocument.make()`](https://xml.jcabi.com/apidocs-0.15/com/jcabi/xml/XSLDocument.html#make%28java.io.InputStream%29) for this:

```java
final class Foo {
  private static final XSL STYLESHEET = XSLDocument.make(
    Foo.class.getResourceAsStream("stylesheet.xsl")
  );
  public XML style(final XML xml) {
    return Foo.STYLESHEET.transform(xml);
  }
}
```

Pay attention to the fact we're using XSLT 2.0. Built-in Java implementation of XSLT
doesn't support version 2.0, and in order to make it work, we're using
these two Maven Saxon dependencies:

```xml
<dependency>
  <groupId>net.sourceforge.saxon</groupId>
  <artifactId>saxon</artifactId>
  <version>9.1.0.8</version>
  <scope>runtime</scope>
</dependency>
<dependency>
  <groupId>net.sourceforge.saxon</groupId>
  <artifactId>saxon</artifactId>
  <version>9.1.0.8</version>
  <classifier>xpath</classifier>
  <scope>runtime</scope>
</dependency>
```

All you need to do to start using `jcabi-xml` for XSL transformations is
add this dependency to your `pom.xml`:

```xml
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-xml</artifactId>
</dependency>
```

If you have any problems or suggestions, don't hesitate to submit an issue
to the GitHub [issue tracker](https://github.com/jcabi/jcabi-xml/issues).
