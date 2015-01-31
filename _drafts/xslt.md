---
layout: post
title: "XSL Transformation In Java, an Easy Way"
date: 2015-02-10
tags: xml java jcabi xslt
description:
  XSL transformations can be accomplished in Java with a single method
  call, with the help of jcabi-xml
keywords:
  - xml transformation java
  - xslt java
  - transform xml java
  - java xslt example
  - java xslt code example
---

{% badge http://img.jcabi.com/logo-square.svg 64 http://http.jcabi.com %}

[XSL tranformations](http://www.w3.org/TR/xslt20/)
(XSLT) is a powerful mechanism of converting one
XML document into another. However, in Java, XML manipulations
are rather verbose and complex. Even for a simple XSL transformation,
one has to write a few dozens of code lines, and maybe even more
than that if a proper exception handling and logging is needed.
[jcabi-xml](http://xml.jcabi.com) is
a small open source library that makes life much easier, enabling
XML parsing and XPath traversing with
[a few simple methods]({% pst 2014/apr/2014-04-24-java-xml-parsing-and-traversing %}). Let's
now how this library helps in XSL transformations.

<!--more-->

Let's take a look at a practical example &mdash; [rultor.com](http://www.rultor.com) &mdash;
a hosted DevOps assistant that
[automates]({% pst 2014/jul/2014-07-24-rultor-automated-merging.md %})
release, merge and deploy operations. Each conversation session with an end-user (a.k.a. "talk")
Rultor keeps in a DynamoDB record. There are multiple situations to handle
in each talk, that's why using multiple columns of a record is not
really feasible. Instead, we're keeping only a few parameters of each talk
in record columns (like ID and name) and persist all the rest in a single
XML column.

This is approximately how our DynamoDB table looks like:

{% highlight text %}
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
{% endhighlight %}

Once a user posts `@rultor status` into a Github ticket, Rultor
has to answer with a full status information about current talk. In order
to create such a text answer (a regular user would not appreciate an XML response)
we have to fetch that `xml` column from the necessary DynamoDB record and covert
it to a plain English text.

Here is how we're doing that with the help of [jcabi-xml](http://xml.jcabi.com) and its
class [`XSLDocument`](http://xml.jcabi.com/apidocs-0.15/com/jcabi/xml/XSLDocument.html).

{% highlight java %}
final String xml = // comes from DynamoDB
final XSL xsl = new XSLDocument(
  this.getClass().getResourceAsStream("status.xsl")
);
final String text = xsl.applyTo(xml);
{% endhighlight %}

That's it. Let's see what is there, in that `status.xsl` file
(it is just a skeleton of it, full version is [here](https://github.com/yegor256/rultor/blob/1.48/src/main/resources/com/rultor/agents/github/qtn/status.xsl)):

{% highlight xml %}
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
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
{% endhighlight %}

It's a good practice to create XSL documents only once per application
run. We have a static utility method [`XSLDocument.make()`](http://xml.jcabi.com/apidocs-0.15/com/jcabi/xml/XSLDocument.html#make%28java.io.InputStream%29) for this:

{% highlight java %}
final class Foo {
  private static final XSL STYLESHEET = XSLDocument.make(
    Foo.class.getResourceAsStream("stylesheet.xsl")
  );
  public XML style(final XML xml) {
    return Foo.STYLESHEET.transform(xml);
  }
}
{% endhighlight %}

Pay attention, we're using XSLT 2.0. Built-in Java implementation of XSLT
doesn't support version 2.0 and in order to make it working we're using
these two Maven Saxon dependencies:

{% highlight xml %}
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
{% endhighlight %}

All you need to do in order to start using `jcabi-xml` for XSL transformations is
to add this dependency to your `pom.xml`:

{% highlight xml %}
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-xml</artifactId>
</dependency>
{% endhighlight %}

If any problems or suggestions, don't hesitate to submit an issue
to the Github [issue tracker](https://github.com/jcabi/jcabi-xml/issues).
