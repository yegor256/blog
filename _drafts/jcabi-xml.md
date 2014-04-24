---
layout: post
title: "Java XML Parsing Made Easy"
date: 2014-04-23
tags: xml java jcabi
description:
Parsing and traversing of XML documents as a very common and verbose operation is made easy with jcabi-xml
keywords:
  - xml parsing java
  - parse xml java
  - how to parse xml in java
  - java parsing of xml
  - DOM parsing java
  - simple parsing of xml in java
  - traversing xml using xpath
  - xml traversing using xpath
  - java xml traversing
---
Unlike with many other modern languages, parsing XML in Java requires more than one line of code. XML traversing using XPath takes even more code, and I find this is unfair and annoying.

I'm a big fan of XML and use it it in almost every Java application. Some time ago, I decided to put all of that XML-to-DOM parsing code into a small library &mdash;[jcabi-xml](http://xml.jcabi.com).

Put simply, the library is a convenient wrapper for JDK-native DOM manipulations. That's why it is small and dependency-free. With the following example, you can see just how simple XML parsing can be:

{% highlight java %}
import com.jcabi.xml.XML;
import com.jcabi.xml.XMLDocument;
XML xml = new XMLDocument(
"<root><a>hello</a><b>world!</b></root>"
);
{% endhighlight %}

Now, we have an object of interface [`XML`](http://xml.jcabi.com/apidocs-0.7.7/com/jcabi/xml/XML.html) that can traverse the XML tree and convert it back to text. 

For example:

{% highlight java %}
// outputs "hello"
System.out.println(xml.xpath("/root/a/text()").get(0));
// outputs the entire XML document
System.out.println(xml.toString());
{% endhighlight %}

Method `xpath()` allows you to find a collection of text nodes or attributes in the document, and then convert them to a collection of strings, using [XPath query](http://en.wikipedia.org/wiki/XPath):

{% highlight java %}
// outputs "hello" and "world"
for (String text : xml.xpath("/root/*/text()")) {
System.out.println(text);
}
{% endhighlight %}

Method `nodes()` enables the same XPath search operation, but instead returns a collection of instances of `XML` interface:

{% highlight java %}
// outputs "<a>hello</a>" and "<b>world</b>"
for (XML node : xml.xpath("/root/*")) 
System.out.println(node);
}
{% endhighlight %}

Besides XML parsing, printing and XPath traversing, [jcabi-xml](http://xml.jcabi.com) also provides XSD validation and XSL transformations. I'll write about those features in the next post :)
