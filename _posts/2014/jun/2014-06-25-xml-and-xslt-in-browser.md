---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "XML+XSLT in a Browser"
date: 2014-06-25
tags: xml java restful
description: |
  XML+XSLT is a useful combination for web interfaces
  and RESTful API-s at the same time. This article explains
  how it works and argues in favor of its use.
keywords:
  - web framework
  - java web framework
  - rexsl framework
  - xml xsl web page
  - xml xsl html web
  - xml xslt web framework
  - xml xslt java web framework
  - xslt java web framework
---

[Separating data and their presentation](https://en.wikipedia.org/wiki/Separation_of_presentation_and_content)
is a great concept. Take HTML and CSS for example. HTML is supposed to have pure data and
CSS is supposed to format that data in order to make it readable by a human. Years ago,
that was probably the intention of HTML/CSS, but in reality it doesn't work like that.
Mostly because CSS is not powerful enough.

We still have to format our data using HTML tags, while
[CSS]({% pst 2014/jun/2014-06-26-sass-in-java-webapp %})
can help slightly with positioning and decorating.

On the other hand, XML with [XSLT](https://en.wikipedia.org/wiki/XSLT)
implements perfectly the idea of separating data and presentation. XML documents,
like HTML, are supposed to contain data only without any information about
positioning or formatting. XSL stylesheets position and decorate the data.
XSL is a much more powerful language. That's why it's possible to avoid
any formatting inside XML.

The latest versions of Chrome, Safari, Firefox and IE all support
this mechanism. When a browser retrieves an XML document from a server,
and the document has an XSL stylesheet [associated](https://www.w3.org/TR/xml-stylesheet/)
with it---the browser transforms XML into HTML on-fly.

<!--more-->

## Working Example

Let's review a simple Java web application that works
this way. It is using [Takes Framework](https://www.takes.org)
that makes this mechanism possible. In the next post, I'll explain
how ReXSL works. For now, though, let's focus on the idea of delivering
bare data in XML and formatting it with an XSL stylesheet.

Open [https://www.stateful.co](https://www.stateful.co)---it is
a collection of stateful web primitives, explained in the
[Atomic Counters at Stateful.co]({% pst 2014/may/2014-05-18-cloud-autoincrement-counters %}) article.

Open it in Chrome or Safari. When you do, you should
see a normal web page with a logo, some text, some links, a footer, etc.
Now check its sources (I assume you know how to do this).

This is approximately what you will see
(I assume you understand XML, if not, start learning it immediately):

```xml
<?xml-stylesheet type='text/xsl' href='/xsl/index.xsl'?>
<page date="2014-06-15T15:30:49.521Z" ip="10.168.29.135">
  <menu>home</menu>
  <documentation>.. some text here ..</documentation>
  <version>
    <name>1.4</name>
    <revision>5c7b5af</revision>
    <date>2014-05-29 07:58</date>
  </version>
  <links>
    <link href="..." rel="rexsl:google" type="text/xml"/>
    <link href="..." rel="rexsl:github" type="text/xml"/>
    <link href="..." rel="rexsl:facebook" type="text/xml"/>
  </links>
  <millis>70</millis>
</page>
```

As you see, it is a proper XML document with attributes,
elements and data. It contains absolutely no information about how
its elements have to be presented to an end-user. Actually,
this document is more suitable for machine parsing instead of reading by a human.

The document contains data, which is important for its requester.
It's up to the requester on how to render the data or to not render it at all.

Its second line [associates](https://www.w3.org/TR/xml-stylesheet/)
the document with the XSL stylesheet `/xsl/index.xsl` that
is loaded by the browser separately:

```xml
<?xml-stylesheet type='text/xsl' href='/xsl/index.xsl'?>
```

Open developer tools in Chrome and you will see that right
after the page is loaded, the browser loads the XSL stylesheet
and then all other resources including a few CSS stylesheets,
jQuery and an SVG logo:

{% figure /images/2014/06/xslt-loading-order-in-chrome.png 600 %}

`index.xsl` includes `layout.xsl`, that's why it is loaded right after.

Let's consider an example of `index.xsl` (in reality
it is much more complex, check [`layout.xsl`](https://github.com/sttc/stateful/blob/master/src/main/webapp/xsl/layout.xsl).
For example:

```xml
<xsl:stylesheet version="2.0"
  xmlns:xsl="https://www.w3.org/1999/XSL/Transform"
  xmlns="https://www.w3.org/1999/xhtml">
  <xsl:template match="page">
    <html>
      <body>
        <p>
          Current version of the application is
          <xsl:value-of select="version/name"/>
        </p>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
```

I think it's obvious how the HTML page will look like
after applying this XSL stylesheet to our XML document.

For me, this XSL looks clean and easy to understand. However,
I often hear people say that XSLT is a hard-to-understand programming language.
I don't find it hard to understand at all. Of course, I'm not using
all of its features. But, for simple page rendering, all I need
to know are a few simple commands and the principle of XML transformation.

## Why Not a Templating Engine?

Now, why is this approach better than all that widely use Java templating engines, including
[JSP](https://en.wikipedia.org/wiki/JavaServer_Pages),
[JSF](https://en.wikipedia.org/wiki/JavaServer_Faces),
[Velocity](http://velocity.apache.org/engine/devel/),
[FreeMarker](http://freemarker.org/),
[Tiles](http://tiles.apache.org/), etc?

Well, I see a number of reasons. But, the most important are:

  1. **Web UI and API are same pages**.
    There is no need to develop separate pages for RESTful API---Web user interface, being accessed by a computer, is an API.
    In my experience, this leads to massive avoidance of code duplication.

  2. **XSL is testable by itself without a server**.
    In order to test how our web site will look with certain data,
    we just create a new XML document with necessary test data,
    associate it with an XSL and open it in a browser. We can also
    modify XML and refresh the page in browser. This makes the work
    of HTML/CSS designer much easier and independent of programmers.

  3. **XSL is a powerful functional language**.
    Compared with all other templating engines, which look mostly like
    workarounds, XSL is a complete and well-designed environment.
    Writing XSL (after you get used to its syntax and programming concepts)
    is a pleasure in itself. You're not injecting instructions into
    a HTML document (like in JSP and all others). Instead, you are
    programming transformation of data into presentation---a different mindset and much better feeling.

  4. **XML output is perfectly testable**.
    A controller in MVC that generates an XML document with all data
    required for the XSL stylesheet can easily be tested in a single unit
    test using simple XPath expressions. Testing of a controller that injects
    data into a templating engine is a much more complex operation---even impossible sometimes.
    I'm also writing in PHP and Ruby. They have exactly the same problems---even though their templating engines are much more powerful
    due to the interpretation nature of the languages.

## Is It Fully Supported?

Everything would be great if all browsers would support XML+XSL rendering.
However, this is far from being true. Only the latest versions of modern
browsers support XSL. Check [this comparison](http://greenbytes.de/tech/tc/xslt/)
done by Julian Reschke. Besides that, XSLT 2.0 is
[not supported](http://stackoverflow.com/questions/6282340/which-browsers-support-xslt-2-0-already) at all.

There is a workaround, though. We can understand which browser
is making a request (via its [`User-Agent`](https://en.wikipedia.org/wiki/User_agent) HTTP header)
and transform XML into HTML on the server side. Thus, for modern browsers that support XSL,
we will deliver XML and for all others---HTML.

This is exactly how [ReXSL framework](https://github.com/yegor256/rexsl) works.
Open [https://www.stateful.co](https://www.stateful.co) in Internet Explorer
and you will see an HTML document, not an XML document as is the case with Chrome.

BTW, see how all this is implemented:
[XML Data and XSL Views in Takes Framework]({% pst 2015/jun/2015-06-25-xml-data-xsl-views-takes-framework %}).

Read this one, it continues the discussion of this subject:
[RESTful API and a Web Site in the Same URL]({% pst 2014/sep/2014-09-09-restful-web-sites %})
