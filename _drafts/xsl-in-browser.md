---
layout: post
title: "XML+XSLT in a Browser"
date: 2014-06-15
tags: mistakes quality
description:
  XML+XSLT is a useful combination for web interfaces
  and RESTful APIs at the same time; the article explains
  how it works and argues in favor of this approach
keywords:
  - web framework
  - java web framework
  - rexsl framework
  - xml xsl web page
  - xml xsl html web
  - xml xslt web framework
  - xml xslt java web framework
  - xslt java web framework
  - xsl web framework java
  - xsl web framework
  - xsl web java
  - xsl web framework java
---

[Separating data and their presentation](http://en.wikipedia.org/wiki/Separation_of_presentation_and_content)
is a great concept. Take HTML and CSS for example.
HTML is supposed to have pure data and CSS
is supposed to format them in order to make readable by a human.
Years ago that was, probably, the intention of HTML/CSS, but in reality it
doesn't work like that. Mostly because CSS is not powerful enough.

We still have to format our data using HTML tags, while CSS can
slightly help in their positioning and decorating.

On the other hand, XML with [XSLT](http://en.wikipedia.org/wiki/XSLT)
perfectly implements the idea of separation data and presentation. XML document,
like HTML, is supposed to contain data only, without any information about
their positioning or formatting. XSL stylesheet positions and decorates them.
XSL is a much more powerful language, that's why it's possible to avoid
any formatting inside XML.

Latest versions of Chrome, Safari, FireFox and IE support this mechanism.
When a browser gets an XML document from a server, and the document has
an XSL stylesheet [associated](http://www.w3.org/TR/xml-stylesheet/)
with it &mdash; the browser transforms XML into HTML on-fly.

## Working Example

Let's review a simple Java web application that works that way. It is using
[ReXSL framework](http://www.rexsl.com) that makes this mechanism possible. In the next post
I'll explain how ReXSL works. Now let's focus on the idea of delivering
bare data in XML and formatting them with XSL stylesheet.

Open [http://www.stateful.co](http://www.stateful.co) &mdash; it is a collection
of stateful web primitive, explained in
[Atomic Counters at Stateful.co]({% post_url 2014/may/2014-05-18-cloud-autoincrement-counters %}) article.
Open it in Chrome or Safari.
You should see a normal web page, with a logo, some text, some links, a footer, etc.
Now check its sources (I assume you know how to).

This is approximately what you will see (I assume you understand XML,
if not, start learning it immediately):

{% highlight xml %}
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
{% endhighlight %}

As you see, it is a proper XML document, with attributes, elements,
and data. It contains absolutely no information about how its
elements have to be presented to an end-user. Actually, this
document is more suitable for machine parsing instead of reading
by a human.

The document contains data, which are important for its
requestor. It's up to the requestor, how to render them or
don't render at all.

Its second line
[associates](http://www.w3.org/TR/xml-stylesheet/)
the document with XSL stylesheet `/xsl/index.xsl` that is
loaded by the browser separately:

{% highlight xml %}
<?xml-stylesheet type='text/xsl' href='/xsl/index.xsl'?>
{% endhighlight %}

Open developer tools in Chrome and you will see that right after the
page is loaded Chrome loads XSL stylesheet and then all other resources,
including a few CSS stylesheets, jQuery and an SVG logo:

{% figure http://img.yegor256.com/2014/06/xslt-loading-order-in-chrome.png 600 %}

`index.xsl` includes `layout.xsl`, that's why it is loaded right after.

Let's consider an example of `index.xsl`
(in reality it is much more complex, check
[`layout.xsl`](https://github.com/sttc/stateful/blob/master/src/main/webapp/xsl/layout.xsl),
for example):

{% highlight xml %}
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">
  <xsl:template match="page">
    <html>
      <body>
        <p>
          Current version of the application is
          <xsl:value-of select="version/revision"/>
        </p>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
{% endhighlight %}

I think it's obvious how HTML page will look like after
applying this XSL stylesheet to our XML document.

For me this XSL looks clean and easy to understand. However, I'm often hearing
people saying that XSLT is a hard-to-understand programming
language. I don't find it hard to understand at all. Of course, I'm not
using all of its features, but for simple page rendering all I need
to know is a few simple commands and the principle of XML transformation.

## Why Not Templating Engine?

Now, why this approach is better than all that widely used Java templating
engines, including
[JSP](http://en.wikipedia.org/wiki/JavaServer_Pages),
[JSF](http://en.wikipedia.org/wiki/JavaServer_Faces),
[Velocity](http://velocity.apache.org/engine/devel/),
[FreeMarker](http://freemarker.org/),
[Tiles](http://tiles.apache.org/), etc?
Well, I see a number of reasons, very important to me.

1. Web UI and API are same pages.
There is no need to develop separate pages for RESTful API &mdash;
web user interface, being accesses by a computer, is an API.
In my experience, this leads to massive avoidance of code duplication.

2. XSL is testable by itself, without a server.
In order to test how our web site will look with certain data,
we just create a new XML document with necessary test data, associate
it with an XSL and open it in a browser. We can also modify XML
and refresh the page in browser. This makes work of HTML/CSS designer
much easier and independent of programmers.

3. XSL is a powerful functional language.
Comparing with all other templating engines, which look mostly like
workarounds, XSL is a complete and well-designed environment.
Writing XSL, when you get used to its syntax and programming concepts,
is a pleasure by itself. You're not injecting instructions into
a HTML document (like in JSP and all others). Instead, you are programming
a transformation of data into presentation. A different midset and
much better feeling.

4. XML output is perfectly testable.
A controller in MVC that generates an XML document with all
data required for the XSL stylesheet can easily be tested in a
single unit test, using simple XPath expressions. Testing of a controller
that injects data into a templating engine is a much
more complex operation, even impossible sometimes.

I'm also writing in PHP and Ruby. They have exactly same problems,
even though their templating engines are much more powerful, due to
interpretation nature of languages.

## Is It Fully Supported?

Everything would be great, if all browsers would support XML+XSL rendering.
However, this is far from being true. Only latest versions of modern browsers
support XSL, check [this comparison](http://greenbytes.de/tech/tc/xslt/)
done by Julian Reschke. Besides that, XSLT 2.0 is
[not supported](http://stackoverflow.com/questions/6282340/which-browsers-support-xslt-2-0-already)
at all.

There is a workaround though. We can understand which browser is making
a request (via its [`User-Agent`](http://en.wikipedia.org/wiki/User_agent)
HTTP header) and transform XML into HTML
on the server side. Thus, for modern browsers that support XSL we will
deliver XML, for all others &mdash; HTML. This is exactly how
[ReXSL framework](http://www.rexsl.com)
works. Open [http://www.stateful.co](http://www.stateful.co) in
Internet Explorer and you will see an HTML document, not an XML as Chrome
is getting.

In the next post I'll explain [ReXSL framework](http://www.rexsl.com).
