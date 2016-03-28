---
layout: post
title: "Printers Instead of Getters"
date: 2016-01-31
place: Palo Alto, CA
tags: java oop
description:
  Since getters are an anti-pattern, how are we supposed
  to convert an object to, say, JSON or plain text?
keywords:
  - getters and setters
  - how to avoid getters
  - alternative to getters
  - getters java
  - getters and setters java
---

Getters and setters [are evil]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}).
No need to argue about this, it's settled. You disagree?
It's not important now. Let's say we want to get rid of getters.

<!--more-->

I'm suggesting to use "printers" instead. Instead of exposing
data via getters, an object will have a functionality of printing
itself to some media.

Let's say this is our class:

{% highlight java %}
public class Book {
  private final String isbn =
    "0735619654";
  private final String title =
    "Object Thinking";
}
{% endhighlight %}

We need it to be transferred into XML format. A more
or less traditional way to do it is via getters and JAXB:

{% highlight java %}
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
@XmlRootElement
public class Book {
  private final String isbn =
    "0735619654";
  private final String title =
    "Object Thinking";
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

This is a very offensive way of treating the object. We're basically
exposing everything that's inside to the public. It was a nice
little self-suffient solid object and we turned it into a bag of data,
which anyone can access in many possible ways. We can access it for reading, of course.

It is convenient to have these getters, you may say. We are all used to them.
If we want to convert it into JSON, they will be very helpful. If we want
to use this poor object as a data object in JSP, getters will help us. There
are many examples in Java, where getters are being actively used.

This is not because they are so effective. This is because we're so
procedural in our way of thinking. We don't trust our objects. We only trust
the data they store. We don't want this `Book` object to generate the XML. We
want it to give us the data. We will build the XML. The `Book` is too stupid
to do that job.

I'm suggesting to stop thinking this way. Instead, let's try to give
this poor `Book` a chance, and equip it with a printer:

{% highlight java %}
public class Book {
  private final String isbn =
    "0735619654";
  private final String title =
    "Object Thinking";
  public String toXML() {
    return String.format(
      "<book><isbn>%s</isbn><title>%s</title></book>",
      this.isbn, this.title
    );
  }
}
{% endhighlight %}

This isn't the best implementation, but you got the idea. The object is not
exposing its internals any more. We can't get its ISBN and its title. We
can only ask it to print itself in XML format.

We can add an additional printer, if another format is required:

{% highlight java %}
public class Book {
  private final String isbn =
    "0735619654";
  private final String title =
    "Object Thinking";
  public String toJSON() {
    return String.format(
      "{\"isbn\":\"%s\", \"title\":\"%s\"}",
      this.isbn, this.title
    );
  }
}
{% endhighlight %}

Again, not the best implementation, but you see what I'm trying to show.
Each time we need a new format, we create a new printer.

You may say that the object will be rather big if there will be many formats.
That's true, but a big object is a bad design in the first place. I would
say that if there is more than one printer &mdash; it's a problem.

to be continued...
