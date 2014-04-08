---
layout: post
title: "Xembly, an Assembly for XML"
date: 2014-04-07
tags: xembly xml xsl xsd
---

I'm using XML in almost every project. And, despite all this JSON/YAML
fuzz, honestly believe that XML is one of the
greatest languages invented so far. I also believe that its beauty
shows itself when XML is used in combination with related technologies.

For example, you expose your data in XML and render them to the end-user
by means of [XSL stylesheet](http://www.w3.org/Style/XSL/).
Another example, you validate the same data,
before rendering, for the correctness of their structure,
through [XSD](http://www.w3.org/TR/xmlschema11-1/) schema.
Or, you pick some data elements from the entire document with
[XPath](http://www.w3.org/TR/xpath/) queries.

Basically, these three technologies is what makes XML so powerful:
XSL, XSD schema and XPath.

However, there is one use case where XML falls short. Imagine you have
an existing document that needs to be modified a little bit. Take this one,
for example:

{% highlight xml linenos=table %}
<accounts>
  [...]
  <acc id='34'>
    <name>Jeffrey</name>
    <balance>305</balance>
  </acc>
  <acc id='35'>
    <name>Walter</name>
    <balance>50090</balance>
  </acc>
  [...]
</accounts>
{% endhighlight %}

It is a list of accounts. Each account has its own `id` an a few
child elements. Now we need to find the account that belongs to `Jeffrey`
and increment its balance by `500`. How would you do this?

Well, there are a few possible ways:

 * SAX-parse the document, change the balance, save the stream
 * DOM-parse it, find the element with XPath, change the value, print it
 * apply a parametrized XSL stylesheet
 * apply XQuery small script to make changes

Each of these mechanisms has its drawbacks. But all of them share one and the
same &mdash; they are very verbose. You need at least a page of code to do this
simple operation. And if the logic of the operation will become more complex,
the amount of code will grow faster than you may expect.

Simply put, XML lacks a tool for primitive data manipulations within
a document. Maybe this lackage is making XML unpopular sometimes.

Anyway, here is this tool, which I created a few month ago: [Xembly](http://www.xembly.org).
It is an imperative language with a few simple directives.
It resembles [Assembly](http://en.wikipedia.org/wiki/Assembly_language)
in style, that's why the name. There
are no loops, conditions or variables, just a sequence of directives with
arguments.

Let's start with a simple example. Say, we want to add a new account number `36`
to our document:

{% highlight asm linenos=table %}
XPATH '/accounts';
ADD 'account';
ATTR 'id', '36';
ADD 'name';
SET 'Donny';
UP;
ADD 'balance';
SET '3400';
{% endhighlight %}

Should be intuitively clear, but I'll explain. First `XPATH` directive points us
to the element found by "/accounts" XPath query. It will be our root element. We assume here that
it exists in the document. Yes, if it is absent, our Xembly script will
fail with a runtime exception.

Next, `ADD` directive at line 2 creates a new XML element, without any children
or attributes. Then, `ATTR` directive sets an attribute to this element. Then,
a new child element `name` is added. Then, its text value is set to `"Donny"`
by `SET` directive. Then, we're moving out pointer back to `account` element
using `UP`. Then, we add `balance` child element and set its value to `"3400"`.

Our balance changing task can be expressed in Xembly with the following code:

{% highlight asm linenos=table %}
XPATH '/accounts/account[name="Jeffrey"]/balance';
XSET '. + 500';
{% endhighlight %}

`XSET` directive is setting element text value, similar to `SET`, but
calculates it beforehand using the provided XPath expression `. + 500`.

Xembly does all its manipulations through DOM. That's why it can be
implemented inside any other language that has a built-in DOM implementation.

In the meantime, there is only one implementation of Xembly language
&mdash; in Java. Here is how it works:

{% highlight java linenos=table %}
Iterable<Directive> directives = new Directives()
  .xpath("/accounts")
  .add("account")
  .attr("id", "36")
  .add("name").set("Donny").up()
  .add("balance").set("3400");
new Xembler(directives).apply(document);
{% endhighlight %}

In this snippet I'm using a supplementary script builder `Directives`, which
enables generation of directives in a fluent way. Then, I'm using `Xembler` class,
which is similar to "assembler", that applies all specified directives
to the `document` object of class `org.w3c.dom.Document`.

More to this, Xembly can be used as a builder of XML documents from scratch,
as a replacement of a traditional DOM building. For example:

{% highlight java linenos=table %}
System.out.println(
  new Xembler(
    new Directives().add("html")
      .add("head")
      .add("title")
      .set("Hello, world!")
  ).xml()
);
{% endhighlight %}

The snippet produces this output:

{% highlight xml linenos=table %}
<html>
  <head>
    <title>Hello, world!</title>
  </head>
</html>
{% endhighlight %}

For me, this looks simple and compact.

As usual, bugs and suggestions are very welcome, as
[Github issues](https://github.com/yegor256/xembly/issues) :)

