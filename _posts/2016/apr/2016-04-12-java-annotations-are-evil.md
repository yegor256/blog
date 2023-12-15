---
layout: post
title: "Java Annotations Are a Big Mistake"
date: 2016-04-12
place: Seattle, WA
tags: java oop
description: |
  Even though Java annotations are very popular and
  convenient, they are making Java code less object-oriented
  and more messy.
categories: jcg
keywords:
  - java annotations
  - java annotations example
  - java annotations runtime
  - java annotations tutorial
  - java annotations list
book: elegant-objects-2 6.1
image: /images/2016/04/gomorrah.jpg
jb_picture:
  caption: Gomorra (2008) by Matteo Garrone
---

[Annotations](https://en.wikipedia.org/wiki/Java_annotation)
were introduced in Java 5, and we all got excited. Such a great
instrument to make code shorter! No more Hibernate/Spring XML configuration
files! Just annotations, right there in the code where we need them. No more
[marker interfaces](https://en.wikipedia.org/wiki/Marker_interface_pattern),
just a [runtime-retained](https://docs.oracle.com/javase/7/docs/api/java/lang/annotation/Retention.html)
[reflection-discoverable](http://stackoverflow.com/questions/4296910/) annotation!
I was excited too. Moreover, I've made a few open source libraries which
use annotations heavily. Take [jcabi-aspects](https://github.com/jcabi/jcabi-aspects),
for example. However, I'm not excited any more. Moreover, I believe that
annotations are a big mistake in Java design.

<!--more-->

{% jb_picture_body %}

{% youtube g1ctRcW214w %}

Long story short, there is one big problem with annotations---they encourage us to implement
[object]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %})
functionality _outside_ of an object,
which is against the very principle of
[encapsulation]({% pst 2016/nov/2016-11-21-naked-data %}).
The object is not solid any more, since its behavior is not defined entirely by its own
methods---some of its functionality stays elsewhere. Why is it bad? Let's
see in a few examples.

## `@Inject`

Say we annotate a property with `@Inject`:

```java
import javax.inject.Inject;
public class Books {
  @Inject
  private final DB db;
  // some methods here, which use this.db
}
```

Then we have an injector that knows what to inject:

```java
Injector injector = Guice.createInjector(
  new AbstractModule() {
    @Override
    public void configure() {
      this.bind(DB.class).toInstance(
        new Postgres("jdbc:postgresql:5740/main")
      );
    }
  }
);
```

Now we're making an instance of class `Books` via the container:

```java
Books books = injector.getInstance(Books.class);
```

The class `Books` has no idea how and who will inject an instance
of class `DB` into it. This will happen behind the scenes and outside
of its control. The injection will do it. It may look convenient,
but this attitude causes a lot of damage to the entire code base. The
control is lost (not inverted, but lost!). The object is not in charge
any more. It can't be responsible for what's happening to it.

Instead, here is how this should be done:

```java
class Books {
  private final DB db;
  Books(final DB base) {
    this.db = base;
  }
  // some methods here, which use this.db
}
```

{% youtube oV6Utb5Jows %}

This article explains why Dependency Injection containers are
a wrong idea in the first place:
[Dependency Injection Containers are Code Polluters]({% pst 2014/oct/2014-10-03-di-containers-are-evil %}).
Annotations basically provoke us to make the containers and use them.
We move functionality outside of our objects and put it into
containers, or somewhere else. That's because we don't want to duplicate the
same code over and over again, right? That's correct, duplication is
bad, but tearing an object apart is even worse. Way worse. The same is
true about ORM (JPA/Hibernate), where annotations are being actively used.
Check this post, it explains what is wrong about ORM:
[ORM Is an Offensive Anti-Pattern]({% pst 2014/dec/2014-12-01-orm-offensive-anti-pattern %}).
Annotations by themselves are not the key motivator, but they help us
and encourage us by tearing objects apart and keeping parts in different
places. They are containers, sessions, managers, controllers, etc.

## `@XmlElement`

This is how JAXB
[works]({% pst 2015/mar/2015-03-26-jaxb-vs-xembly %}), when you want to convert your
[POJO](https://en.wikipedia.org/wiki/Plain_Old_Java_Object) to XML. First,
you attach the `@XmlElement` annotation to the getter:

```java
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
@XmlRootElement
public class Book {
  private final String title;
  public Book(final String title) {
    this.title = title;
  }
  @XmlElement
  public String getTitle() {
    return this.title;
  }
}
```

Then, you create a marshaller and ask it to convert an instance of class
`Book` into XML:

```java
final Book book = new Book("0132350882", "Clean Code");
final JAXBContext ctx = JAXBContext.newInstance(Book.class);
final Marshaller marshaller = ctx.createMarshaller();
marshaller.marshal(book, System.out);
```

{% youtube cv23Z6xpwDw %}

Who is creating the XML? Not the `book`. Someone else, outside of the
class `Book`. This is very wrong. Instead, this is how this should have
been done. First, the class that has no idea about XML:

```java
class DefaultBook implements Book {
  private final String title;
  DefaultBook(final String title) {
    this.title = title;
  }
  @Override
  public String getTitle() {
    return this.title;
  }
}
```

Then, the
[decorator]({% pst 2015/feb/2015-02-26-composable-decorators %})
that prints it to the XML:

```java
class XmlBook implements Book{
  private final Book origin;
  XmlBook(final Book book) {
    this.origin = book;
  }
  @Override
  public String getTitle() {
    return this.origin.getTitle();
  }
  public String toXML() {
    return String.format(
      "<book><title>%s</title></book>",
      this.getTitle()
    );
  }
}
```

Now, in order to [print]({% pst 2016/apr/2016-04-05-printers-instead-of-getters %})
the book in XML we do the following:

```java
String xml = new XmlBook(
  new DefaultBook("Elegant Objects")
).toXML();
```

The XML printing functionality is inside `XmlBook`. If you don't like the
decorator idea, you can move the `toXML()` method to the `DefaultBook` class. It's
not important. What is important is that the functionality always stays
where it belongs---inside the object. Only the object knows how
to
[print itself]({% pst 2016/apr/2016-04-05-printers-instead-of-getters %})
to the XML. Nobody else!

## `@RetryOnFailure`

Here is an example
(from [my own library]({% pst 2014/aug/2014-08-15-retry-java-method-on-exception %})):

```java
import com.jcabi.aspects.RetryOnFailure;
class Foo {
  @RetryOnFailure
  public String load(URL url) {
    return url.openConnection().getContent();
  }
}
```

After compilation, we run a so called
[AOP weaver]({% pst 2014/jun/2014-06-01-aop-aspectj-java-method-logging %})
that technically turns our code into something like this:

```java
class Foo {
  public String load(URL url) {
    while (true) {
      try {
        return _Foo.load(url);
      } catch (Exception ex) {
        // ignore it
      }
    }
  }
  class _Foo {
    public String load(URL url) {
      return url.openConnection().getContent();
    }
  }
}
```

I simplified the actual algorithm of retrying a method call on failure, but I'm
sure you get the idea. [AspectJ](https://www.eclipse.org/aspectj/),
the [AOP](http://en.wikipedia.org/wiki/Aspect-oriented_programming)
engine, uses
[`@RetryOnFailure`](http://aspects.jcabi.com/annotation-retryonfailure.html)
annotation as a signal, informing us that the class
has to be wrapped into another one. This is happening behind the scenes. We don't
see that supplementary class, which implements the retrying algorithm.
But the bytecode produced by the AspectJ weaver contains a modified
version of class `Foo`.

{% youtube WSgP85kr6eU %}

That is exactly what is wrong with this approach---we don't see
and don't control the instantiation of that supplementary object. Object
composition, which is the most important process in object design, is
hidden somewhere behind the scenes. You may say that we don't need
to see it since it's supplementary. I disagree. We must see how
our objects are composed. We may not care about how they work, but we
must see the entire composition process.

A much better design would look like this (instead of annotations):

```java
Foo foo = new FooThatRetries(new Foo());
```

And then, the implementation of `FooThatRetries`:

```java
class FooThatRetries implements Foo {
  private final Foo origin;
  FooThatRetries(Foo foo) {
    this.origin = foo;
  }
  public String load(URL url) {
    return new Retry().eval(
      new Retry.Algorithm<String>() {
        @Override
        public String eval() {
          return FooThatRetries.this.load(url);
        }
      }
    );
  }
}
```

And now, the implementation of `Retry`:

```java
class Retry {
  public <T> T eval(Retry.Algorithm<T> algo) {
    while (true) {
      try {
        return algo.eval();
      } catch (Exception ex) {
        // ignore it
      }
    }
  }
  interface Algorithm<T> {
    T eval();
  }
}
```

Is the code longer? Yes. Is it cleaner? A lot more. I regret that I
didn't understand it two years ago, when I started to work with
[jcabi-aspects](https://github.com/jcabi/jcabi-aspects).

<hr/>

The bottom line is that annotations are bad. Don't use them. What should be used
instead? Object [composition]({% pst 2015/feb/2015-02-26-composable-decorators %}).

What could be worse than annotations? [Configurations]({% pst 2016/apr/2016-04-19-object-must-not-be-configurable %}).
For example, XML configurations. Spring XML configuration mechanisms is a perfect
example of terrible design. I've said it many times before. Let
me repeat it again---Spring Framework is one of the worst
software products in the Java world. If you can stay away from it, you will
do yourself a big favor.

There should not be any "configurations" in [OOP]({% pst 2016/aug/2016-08-15-what-is-wrong-object-oriented-programming %}).
We can't configure our
objects if they are real objects. We can only instantiate them. And the
best method of instantiation is operator `new`. This operator is the key
instrument for an OOP developer. Taking it away from us and giving us
"configuration mechanisms" is an unforgivable
[crime]({% pst 2015/nov/2015-11-24-imprisonment-for-irresponsible-coding %}).

