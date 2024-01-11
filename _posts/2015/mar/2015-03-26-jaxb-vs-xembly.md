---
layout: post
title: "JAXB Is Doing It Wrong; Try Xembly"
date: 2015-03-26
tags: java xml
categories: jcg
description: |
  JAXB is a 10-year-old anti-pattern that encourages Java
  developers to turn their objects into dumb, passive
  data structures.
keywords:
  - jaxb anti-pattern
  - jaxb is bad
  - jaxb marshalling
  - jaxb marshalling example
  - jaxb alternatives
---

{% badge https://www.xembly.org/logo.png 64 https://www.xembly.org %}

[JAXB](https://en.wikipedia.org/wiki/Java_Architecture_for_XML_Binding)
is a 10-year-old Java technology that allows us to
convert a Java object into an XML document (marshalling) and
back (unmarshalling). This technology is based on
[setters and getters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})
and, in my opinion, violates key principles of object-oriented
programming by turning objects into **passive data structures**. I would
recommend you use [Xembly](https://www.xembly.org)
instead for marshalling Java objects into XML documents.

<!--more-->

This is how JAXB marshalling works. Say you have a `Book` class that needs to be
marshalled into an XML document. You have to create getters and annotate them:

```java
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
```

Then you create a marshaller and ask it to convert an instance of class
`Book` into XML:

```java
final Book book = new Book("0132350882", "Clean Code");
final JAXBContext context = JAXBContext.newInstance(Book.class);
final Marshaller marshaller = jaxbContext.createMarshaller();
marshaller.marshal(book, System.out);
```

You should be expecting something like this in the output:

```xml
<?xml version="1.0"?>
<book>
  <isbn>0132350882</isbn>
  <title>Clean Code</title>
</book>
```

So what's wrong with it? Pretty much the same thing that's wrong with
object-relational mapping, which is explained in
[ORM Is an Offensive Anti-Pattern]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %}).
JAXB is treating an object as a bag of data, extracting the data
and converting it into XML the way JAXB wants. The object has no control
over this process. Therefore an object is not
[an object]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %})
anymore but rather a passive bag of data.

An ideal approach would be to redesign our class `Book` this way:

```java
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
```

However, there are a few problems with this approach. First of all, there's
massive code duplication. Building an XML document is a rather verbose
process in Java. If every class had to re-implement it in its
`toXML()` method, we would have a big problem with duplicate code.

The second problem is that we don't know exactly what type of wrapping
our XML document should be delivered in. It may be a `String` or an `InputStream`
or maybe an instance of `org.w3c.dom.Document`. Making many `toXML()` methods
in each object would definitely be a disaster.

[Xembly](https://www.xembly.org) provides a solution. As I've
[mentioned before]({% pst 2014/apr/2014-04-09-xembly-intro %}), it is
an imperative language for XML constructions and manipulations. Here is
how we can implement our `Book` object with the help of Xembly:

```java
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
```

Now, in order to build an XML document, we should use this code
outside the object:

```java
final Book book = new Book("0132350882", "Clean Code");
final String xml = new Xembler(book.toXembly()).xml();
```

This [`Xembler`](https://www.xembly.org/apidocs-0.21/org/xembly/Xembler.html)
class will convert Xembly directives into an XML document.

The beauty of this solution is that the internals of the object are
not exposed via getters and the object is fully in charge of the XML
marshalling process. In addition, the complexity of these directives
may be very high---much higher than the rather cumbersome
[annotations]({% pst 2016/apr/2016-04-12-java-annotations-are-evil %}) of JAXB.

Xembly is an open source project, so feel free to submit your questions
or corrections to [GitHub](https://github.com/yegor256/xembly).
