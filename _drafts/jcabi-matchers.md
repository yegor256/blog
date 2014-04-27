---
layout: post
title: "XML/XPath Matchers for Hamcrest"
date: 2014-04-27
tags: xml matchers junit xpath
description:
  jcabi-matchers is a new small library that extends
  Hamcrest arsenal with XML/XPath matchers
keywords:
  - xml
  - matchers
  - junit hamcrest xml matchers
  - xml matchers junit
  - xml matchers hamcrest
---

{% badge http://img.jcabi.com/logo-square.png 64 %}

[Hamcrest](https://github.com/hamcrest/JavaHamcrest)
is my favorite instrument in unit testing. It replaces
JUnit procedural assertions of `org.junit.Assert` with
a an object-oriented mechanism. More on that subject sometime later.

Now I want to demonstrate a new library published today on Github
and Maven Central: [jcabi-matchers](http://matchers.jcabi.com). It is
a collection of Hamcrest matchers to make XPath assertions on XML and XHTML
documents.

Let's say, a class under testing produces an XML that needs to contain
a single `<message>` element with `"hello, world!"` content.
This is how this would look in a unit test:

{% highlight java linenos=table %}
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
{% endhighlight %}

There are two alternatives I'm aware of, which are doing almost the same:
[xml-matchers](https://code.google.com/p/xml-matchers/) by
[David Ehringer](http://blog.davidehringer.com/testing/xmlmatchers-hamcrest-matchers-xml/)
and
[`hasXPath()`](http://hamcrest.org/JavaHamcrest/javadoc/1.3/org/hamcrest/Matchers.html#hasXPath%28java.lang.String%29)
method in Hamcrest itself.

I tried to use them both, but faced a number of problems.

Hamcrest `hasXPath()` works only with an instance of
[`Node`](http://docs.oracle.com/javase/7/docs/api/org/w3c/dom/Node.html). Converting
a `String` into `Node` becomes a repetitive and routine task in every unit test.
A really strange limitation of Hamcrest. In contrary to that,
[jcabi-matchers](http://matchers.jcabi.com) works with almost anything,
from a `String` to a
[`Reader`](http://docs.oracle.com/javase/7/docs/api/java/io/Reader.html)
and an
[`InputStream`](http://docs.oracle.com/javase/7/docs/api/java/io/InputStream.html).

`XmlMatchers` from [xml-matchers](https://code.google.com/p/xml-matchers/)
has a very inconvenient way of working with namespaces. Before you
can use an XPath query with a non-default namespace, you should
create an instance of `NamespaceContext`. The library provides
[a simple implementation](https://code.google.com/p/xml-matchers/source/browse/trunk/xml-matchers/src/main/java/org/xmlmatchers/namespace/SimpleNamespaceContext.java)
of this interface, but, still, it is an extra code in every unit test.

[jcabi-matchers](http://matchers.jcabi.com) simplifies
this namespace handling problem even further. It
pre-defines most popular namespaces, including `xtml`, `xs`, `xsl`, etc.
The following example works out-of-the-box without any extra configuration:

{% highlight java linenos=table %}
MatcherAssert.assertThat(
  new URL("http://www.google.com").getContent(),
  XhtmlMatchers.hasXPath("//xhtml:body")
);
{% endhighlight %}

To summarize, my primary objectives were the usage simplicity.
