---
layout: post
title: "Stop Comparing JSON and XML"
date: 2015-11-20
place: Palo Alto, CA
tags: xml json
description:
  JSON vs XML? This comparison has no sense, since
  the former is a simple data format, while the later is
  a language, a very powerful one.
keywords:
  - xml vs json
  - json or xml which is better
  - json or xml for android
  - json or xml for iOS
  - json or xml for java
---

JSON or XML? Which one is better? Which one is faster? Which
one should I use in my next project? Stop it. These things are not comparable.
It's similar to comparing a bicycle and
[AMG S65](http://www.mbusa.com/mercedes/vehicles/model/class-S/model-S65V)? Seriously,
which one is better? They both can take you from home to the office, right?
In some cases a bicycle will do it even better. But does it mean
they can be compared directly? The same here, with JSON and XML.
They are very different things, with their own areas of applicability.

<!--more-->

{% quote JSON is a good data format and it is just a data format %}

Here is how a simple JSON piece of data may look
(140 characters):

{% highlight json %}
{
  "id": 123,
  "title": "Object Thinking",
  "author": "David West",
  "published": {
    "by": "Microsoft Press",
    "year": 2004
  }
}
{% endhighlight %}

A similar document would look like this, in XML
(167 characters):

{% highlight json %}
<?xml version="1.0"?>
<book id="123">
  <title>Object Thinking</title>
  <author>David West</author>
  <published>
    <by>Microsoft Press</by>
    <year>2004</year>
  </published>
</book>
{% endhighlight %}

Looks easy to compare, right? The first example is a bit shorter,
is easier to understand, since it's less "cryptic", and is also
perfectly parseable in JavaScript. That's it, let's use JSON
and manifest the death of XML! Who needs this heavy-weight 15-years old
XML in the first place?

Well, I need it and I love it. Let me explain why.

And, don't get me wrong, I'm not against JSON. Not at all.
It's a good **data format**. But it's just a data format.
We're using it **temporarily**, to transfer a piece
of data from point A to point B. Indeed, it is shorter than XML and
and more readable. That's it.

{% badge /images/2015/04/book-xml-nutshell.jpg 96 http://www.amazon.com/gp/product/0596007647/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0596007647&linkCode=as2&tag=yegor256com-20&linkId=MWLP356M3CQZSBS7 %}

XML is not data format, it is a **language**. A very powerful one. Let me
show what it has. Let me basically explain why I love it. And I would
strongly recommend to read
[**XML in a Nutshell, Third Edition**](http://www.amazon.com/gp/product/0596007647/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0596007647&linkCode=as2&tag=yegor256com-20&linkId=MWLP356M3CQZSBS7)
by Elliotte Rusty Harold and W. Scott Means.

I believe, there are four features XML has, which so seriously differ it from
JSON or any other simple data format, like
[YAML](https://en.wikipedia.org/wiki/YAML), for example.

**XPath**.
To get a year of publishing, from the document above, I just
send an [XPath](http://www.w3.org/TR/xpath20/)
query: `/book/published/year/text()`. There has to be
an XPath processor, which will understand my request and return `2004`.
The beauty of this is that XPath [2.0](http://www.xml.com/pub/a/2002/03/20/xpath2.html)
is a very powerful query engine,
with its own functions, predicates, axeses, etc. You can put literally
any logic into your XPath request, without writing any traversing logic
in Java, for example. You may ask "how many books were published by David in 2004"
and get an answer, just via XPath. JSON is not even close to this.

**Attributes and Namespaces**.
You can attach add meta-data to your data, just like it's done above,
with the `id` attribute. The data stay inside elements, just like the
name of the book author, for example, while meta-data (data about data)
may/should be placed into attributes. This seriously helps in organizing
and structuring information. On top of that, both elements and attributes
may be marked as belonging to certain [namespace](http://www.w3.org/TR/REC-xml-names/).
A very useful technique,
when a few applications are working with the same XML document.

**XML Schema**.
When you create an XML document in one place, modify it a few times somewhere
else and then transfer it to yet another place, you want to make sure its
structure is not broken by any of these participants. One of them may
use `<year>` to store publication date, while another one will use
`<date>` with ISO-8601. To avoid that mess in structure, you create a supplementary
document, which is called [XML Schema](http://www.w3.org/XML/Schema)
and ship it together with the main document.
Everyone who wants to work with the main document, will first **validate**
its correctness, using the schema supplied. This is sort of integration testing,
in production. [RelaxNG](http://relaxng.org/)
is a simpler and simimilar mechanism, give it a try if you find XML Schema too complex.

**XSL**.
You can make modifications to your XML document without any Java/Ruby/etc. code
at all. Just create an
[XSL transformation](http://www.w3.org/TR/xslt20/) document and "apply" it to your
original XML. As an output, you will get a new XML. The
[XSL](http://www.w3.org/Style/XSL/) language
(it is pure functional, by the way) is designed for hierachical data
manipulations. It is much more suitable for this task than Java or any other
OOP/procedural approach. You can transform XML document to anything, including
plain text and
[HTML]({% pst 2014/jun/2014-06-25-xml-and-xslt-in-browser %}).
Some complain about XSL complexity, but, please,
give it a try. You won't need all of it, while its core functionality is
pretty straight-forward.

This is not a full list, but these four features really mean a lot to me.
They give my document an ability to be "self-sufficient". It can validate
itself (XML Schema), it knows how to modify itself (XSL),
it gives me a very elegant access to any piece inside it (XPath).

There are [many more](http://users.jyu.fi/~airi/xmlfamily.html)
languages, standards and applications around XML, including
[XForms](http://www.w3.org/MarkUp/Forms/),
[SVG](http://www.w3.org/Graphics/SVG/),
[MathML](http://www.w3.org/Math/),
[RDF](http://www.w3.org/RDF/),
[OWL](http://www.w3.org/2001/sw/wiki/OWL),
[WSDL](http://www.w3.org/TR/wsdl), etc.
But you will less likely use them
in a mainstream project, they are rather "niche".

JSON was not designed to have that features, even though some of them
are now trying to find their places in JSON world. For example,
[JSONPath](http://goessner.net/articles/JsonPath/) for quering,
[some tools](http://stackoverflow.com/questions/1618038) for transformations, and
[json-schema](http://json-schema.org/) for validation. But they are just
weak parodies to what XML offers and I don't think they have any future. Or,
let's put it this, I wish them to disappear, sooner or later. They are just
turning a good simple format into something **clumsy**.

Thus, to conclude, JSON is a simple data format, with no additional
functionality. Its best use case is [AJAX](https://en.wikipedia.org/wiki/Ajax_%28programming%29).
In all other cases I would strongly recommend to use XML.
