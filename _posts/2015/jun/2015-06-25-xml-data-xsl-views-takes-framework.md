---
layout: post
title: "XML Data and XSL Views in Takes Framework"
date: 2015-06-25
tags: java xml pets
place: Palo Alto, CA
description: |
  XML+XSLT rendering for a web page is a powerful mechanism that
  is intensively used in the Takes framework; this post explains
  it in detail.
keywords:
  - xml xsl web page
  - xsl web framework java
  - xslt java web framework
  - xslt web page
  - xslt for web app
---

{% badge http://www.takes.org/logo.png 96 http://www.takes.org %}

A year ago, I [tried to explain]({% pst 2014/jun/2014-06-25-xml-and-xslt-in-browser %})
how effectively data and its presentation can be separated
in a web application with the help of XML and XSL. In a few words,
instead of using [templating](https://en.wikipedia.org/wiki/Comparison_of_web_template_engines)
(like JSP, Velocity, FreeMarker, etc.) and injection of data into HTML,
we compose them in the form of an XML document and then let
the XSL stylesheet transform them into HTML. Here is a brief example
of how all this can be used together with the [Takes framework](http://www.takes.org).

<!--more-->

First, let's agree that templating is a bad idea in the first place. Yes, I mean
it. The entire design of JSP is wrong, with all due respect to its creators.
Here is how it works: Let's say my website has to fetch the current exchange rate of
the euro from a database and show it on the home page. Here's how my `index.jsp`
would look:

```jsp
<html>
  <body>
    <p>EUR/USD: <%= rates.get() %></p>
  </body>
</html>
```

In order to create HTML, the JSP engine will have to call `get()` on object
`rates` and render what's returned through `toString()`. It's a terrible
design for a few reasons. First, the view is tightly coupled with the model.
Second, the flexibility of rendering is very limited. Third, the result of
rendering is not reusable, and views are not stackable. There are many other
reasons ... more about them in one of the next articles.

{% youtube nheD2LNYrpk %}

Let's see how this should be done right. First, we let our model generate
the output in XML format, for example:

```xml
<?xml version="1.1"?>
<page>
  <rate>1.1324</rate>
</page>
```

This is what the model will produce, having no knowledge of the view. Then,
we create the view as an XSL stylesheet, which will transform XML into HTML:

```xml
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">
  <xsl:template match="page">
    <html>
      <body>
        <p>
          <xsl:text>EUR/USD: </xsl:text>
          <xsl:value-of select="rate"/>
        </p>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
```

As you see, the view doesn't know anything about the model in terms of
implementation. All it knows is the format of XML data output produced
by the model. Here is how you design it in the [Takes framework](http://www.takes.org).
Let's start with a simple example:

```java
import org.takes.http.Exit;
import org.takes.http.FtCli;
public final class Entry {
  public static void main(final String... args) throws Exception {
    new FtCli(new TkApp(), args).start(Exit.NEVER);
  }
}
```

It's a simple web application that starts a web server
and never ends (it waits for connections in daemon mode). To make it work,
we should create a simple "take" named `TkApp`:

```java
import org.takes.Take;
import org.takes.tk.TkWrap;
final class TkApp extends TkWrap {
  @Override
  public Response act() {
    return new RsWithType(
      new RsText(
        "<page><rate>1.1324</rate></page>"
      ),
      "application/xml"
    );
  }
}
```

This "take" always returns the same XML response, but it doesn't
do any XSL transformation yet. We need to add the `RsXSLT` class to the picture:

```java
@Override
public Response act() {
  return new RsXSLT(
    new RsWithType(
      new RsText(
        "<?xml-stylesheet type='text/xsl' href='/xsl/index.xsl'?>"
        + "<page><rate>1.1324</rate></page>"
      ),
      "application/xml"
    )
  );
}
```

Excuse me for using string concatenation, which is a
[bad practice]({% pst 2014/jun/2014-06-19-avoid-string-concatenation %});
it's merely for the simplicity of the example.

As you see, I also added an XML stylesheet processing instruction to
the XML. `RsXSLT` will understand it and try to find the `/xsl/index.xsl`
resource on classpath. You see the content of that file above.

That's it.

Well, not really. Building XML from strings is not a good idea. We
have a better instrument in the Takes framework. We use [Xembly](http://www.xembly.org),
which is a simple imperative language for building and modifying
XML documents. More about it here:
[Xembly, an Assembly for XML]({% pst 2014/apr/2014-04-09-xembly-intro %}).

Here is how our `TkApp` would look:

```java
@Override
public Response act() {
  return new RsXSLT(
    new RsWithType(
      new RsXembly(
        new XeChain(
          new XeStylesheet("/xsl/index.xsl"),
          new XeAppend(
            "page",
            new XeDirectives(
              new Directives().add("rate").set("1.1324")
            )
          )
        )
      ),
      "application/xml"
    )
  );
}
```

The most important class here is
[`RsXembly`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/rs/xe/RsXembly.html).
The idea is to let
model classes expose their data through Xembly "directives," which
will later be applied to a DOM structure by `RsXembly`.

`XeChain`, `XeStylesheet`, `XeAppend`, and `XeDirectives` expose
directives but with different meanings
(they are all instances of an `XeSource` interface).
Their names describe their
intentions rather well.
[`XeChain`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/rs/xe/XeChain.html)
just chains everything that is
delivered by encapsulated "directive sources."
[`XeStylesheet`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/rs/xe/XeStylesheet.html)
returns directives that create a single XML processing instruction.
[`XeAppend`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/rs/xe/XeAppend.html)
creates an XML node and adds encapsulated directives to it.
[`XeDirectives`](http://static.javadoc.io/org.takes/takes/1.1/org/takes/rs/xe/XeDirectives.html)
simply returns what's inside.

In the end, this code will create exactly the same XML document
as I created above with string concatenation.

The beauty of this approach is in the perfect
[decoupling]({% pst 2018/sep/2018-09-18-fear-of-coupling %})
of data generation
and XML building and translation between XML and HTML. It is perfectly reusable
and "stackable." We can transform the data in XML format multiple times,
applying different XSL stylesheets to each one. We can even transform them into
[JSON]({% pst 2015/nov/2015-11-16-json-vs-xml %})
without changing a line of code in model classes.

Moreover, we can format them differently, using rather powerful XSLT 2.0
instruments. XSLT by itself is a powerful and purely functional language that
enables any possible data manipulations. No templating engine is even close
to it.

Take a look at how it works in the
[`RsPage`](https://github.com/yegor256/rultor/blob/1.55/src/main/java/com/rultor/web/RsPage.java)
class in Rultor, for example.
