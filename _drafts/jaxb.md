---
layout: post
title: "JAXB is Doing It Wrong, Try Xembly"
date: 2015-03-20
tags: oop java xml
description:
  JAXB is a 10-years old anti-pattern that encourages Java
  developers to turn their objects into dumb and passive
  data structures.
keywords:
  - jaxb anti-pattern
  - jaxb is bad
  - jaxb marshalling
  - jaxb marshalling example
  - jaxb alternative
---

[JAXB](http://en.wikipedia.org/wiki/Java_Architecture_for_XML_Binding)
is a 10-years old Java technology that allows us to
convert a Java object into an XML document (marshalling) and
back (unmarshalling). This technology is based on
[setters and getters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})
and, in my opinion, violates key principles of object-oriented
programming, turning objects into **passive data structures**. I would
recommend to use [Xembly](http://www.xembly.org)
instead, for marshalling Java objects into XML documents.

<!--more-->

This is how JAXB marshalling works. Say, you have a `Book` class that need to be
marshalled into an XML document. You have to create getters and annotate them:

{% highlight java %}
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
@XmlRootElement
public class Book {
  private final String isbn;
  private final String title;
  public Book(final String isbn, final String title) {
    this.isbn = isbn;
    this.title = title;
  }
  @XmlElement
  public String getIsbn() {
    return this.isbn;
  }
  @XmlElement
  public String getTitle() {
    return this.title;
  }
}
{% endhighlight %}

Then, you create a marshaller and ask it to convert an instance of class
`Book` into XML:

{% highlight java %}
final Book book = new Book("0132350882", "Clean Code");
final JAXBContext context = JAXBContext.newInstance(Book.class);
final Marshaller marshaller = jaxbContext.createMarshaller();
marshaller.marshal(book, System.out);
{% endhighlight %}

You should be expecting something like this in the output:

{% highlight xml %}
<?xml version="1.0"?>
<book>
  <isbn>0132350882</isbn>
  <title>Clean Code</title>
</book>
{% endhighlight %}

What's wrong about it? Pretty much the same as what is wrong with
object-relational mapping, explained in
[ORM Is an Offensive Anti-Pattern]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %}).
JAXB is treating an object as a bag of data, extracting the data
and converting it into XML the way JAXB wants. The object has no control
over this process. An object is not
[an object]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %})
any more but a passive bag of data.

An ideal approach would be to re-design our class `Book` this way:

{% highlight java %}
public class Book {
  private final String isbn;
  private final String title;
  public Book(final String isbn, final String title) {
    this.isbn = isbn;
    this.title = title;
  }
  public String toXML() {
    // create XML document and return
  }
}
{% endhighlight %}

However, there are a few problems with this approach. First of all,
a massive code duplication. Building an XML document is a rather verbose
process in Java. If every class would have to re-implement it in its
`toXML()` method, we would have a big problem with duplicated code.

The second problem is that we don't know exactly in what type of wrapping
our XML document should be delivered. It may be a `String` or an `InputStream`
or maybe an instance of `org.w3c.dom.Document`. Making many `toXML()` methods
in each object would definitely be a disaster.

[Xembly](http://www.xembly.org) provides a solution. As I've
[mentioned before]({% pst 2014/apr/2014-04-09-xembly-intro %}), it is
an imperative language for XML constructions and manipulations. Here is
how we can implement our `Book` object with the help of Xembly:

{% highlight java %}
import org.xembly.Directive;
public class Book {
  private final String isbn;
  private final String title;
  public Book(final String isbn, final String title) {
    this.isbn = isbn;
    this.title = title;
  }
  public Iterable<Directive> toXembly() {
    return new Directives()
      .add("book")
      .add("isbn").set(this.isbn).up()
      .add("title").set(this.title).up()
      .up();
  }
}
{% endhighlight %}

Now, in order to build an XML document we should use this code
outside of the object:

{% highlight java %}
final Book book = new Book("0132350882", "Clean Code");
final String xml = new Xembler(book.toXembly()).xml();
{% endhighlight %}

This `Xembler` class will convert Xembly directives into XML document.

The beauty of this solution is that the internals of the object are
not exposed via getters and the object is fully in charge of XML
marshalling process. More to this, the compexity of these directives
may be very high. Much higher than rather cumbersome annotations of JAXB.

Xembly is an open source project, feel free to submit your questions
or corrections to [Github](https://github.com/yegor256/xembly).
