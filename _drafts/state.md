---
layout: post
title: "How An Immutable Object Can Have State and Behavior?"
date: 2014-12-08
tags: oop
description:
  Object state and behavior are two different things
  that are usually confused that leads to incorrect design
keywords:
  - object state
  - object state behaviour
  - object state behaviour identity
  - object state behaviour and methods
  - object behaviour model
  - object attributes
  - immutable object state
---

I often hear this argument against
[immutable objects]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}):
"Yes, they are useful when the state doesn't change. However, in
our case, we deal with frequently changing objects. We simply
can't afford to create a new `document` every time we just
need to change its `title`." Here is where I disagree &mdash; object
title is **not a state** of a document, if you need to change it frequently.
Instead, it is document's **behavior**. A `document` can/must be immutable,
if he is a [good object]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}),
even when its title is changing frequently. Let me explain how.

<!--more-->

## Identity, State, and Behavior

Basically, there are three elements in every object &mdash;
identity, state and behavior. *Identity* is what distinguishes our `document`
from other objects, *state* is what a document
knows about himself (a.k.a. "encapsulated knowledge"), and
*behavior* is what a document can do for us on request.
For example, this is a mutable document:

{% highlight java %}
class Document {
  private int id;
  private String title;
  Document(int id) {
    this.id = id;
  }
  public String getTitle() {
    return this.title;
  }
  public String setTitle(String text) {
    this.title = text;
  }
  @Override
  public String toString() {
    return String.format("doc #%d about '%s'", this.id, this.text);
  }
}
{% endhighlight %}

Let's try to use this mutable object:

{% highlight java %}
Document first = new Document(50);
first.setTitle("How to cook a sandwich");
Document second = new Document(50);
second.setTitle("How to cook a sandwich");
if (first.equals(second)) { // FALSE
  System.out.println(
    String.format("%s is equal to %s", first, second)
  );
}
{% endhighlight %}

Here, we're creating two objects and then modifying their encapsulated
states. Obviously, `first.equals(second)` will return `false` because
two objects have different identity, even though they encapsulate the
same state.

Method `toString()` exposes document's behavior &mdash; the document can
convert himself to a string.

In order to modify document's title we just call his `setTitle()`
once again:

{% highlight java %}
first.setTitle("How to cook a pasta");
{% endhighlight %}

Simply put, we can re-use the object many times, modifying his
internal state. It is fast and convenient, isn't it? Fast, yes.
Convenient, not really. Read on.

## Immutable Objects Have No Identity

As I've [mentioned before]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}),
immutability is one of the virtues of a good
object, and a very important one. A good object is immutable and a good
software contains only immutable objects. And the main difference between
immutable and mutable objects is that
an immutable one doesn't have an identity and his state never changes.
Here is an immutable variant of the same document:

{% highlight java %}
@Immutable
class Document {
  private final int id;
  private final String title;
  Document(int id, String text) {
    this.id = id;
    this.title = text;
  }
  public String title() {
    return this.title;
  }
  public Document title(String text) {
    return new Document(this.id, text);
  }
  @Override
  public boolean equals(Object doc) {
    return doc instanceof Document
      && Document.class.cast(doc).id == this.id
      && Document.class.cast(doc).title.equals(this.title);
  }
  @Override
  public String toString() {
    return String.format("doc #%d about '%s'", this.id, this.text);
  }
}
{% endhighlight %}

This document is immutable and his state (`id` ad `title`) is his identity. Let's
see how we can use this immutable class
(btw, I'm using [`@Immutable`]({% pst http://aspects.jcabi.com/annotation-immutable.html %}) annotation
from [jcabi-aspects]({% pst http://aspects.jcabi.com %})):

{% highlight java %}
Document first = new Document(50, "How to cook a sandwich");
Document second = new Document(50, "How to cook a sandwich");
if (first.equals(second)) { // TRUE
  System.out.println(
    String.format("%s is equal to %s", first, second)
  );
}
{% endhighlight %}

We can't modify a document any more. When we need to change the title
we have to create a new document:

{% highlight java %}
Document first = new Document(50, "How to cook a sandwich");
first = first.title("How to cook a pasta");
{% endhighlight %}

Every time we want to modify his encapsulated state, we have to modify
his identity too. Because there is no identity. State is the identity.
Look at the code of `equals()` method above &mdash; it compares documents
by their IDs and titles. Now ID+title of a document is his identity!

## What About Frequent Changes?

Now I'm getting to the question we started with &mdash; what about performance
and convenience? We don't want to change the entire document every time we
have to modify its title. If the document is big enough, that will be
a huge overhead. Moreover, if an immutable object encapsulates other immutable
objects, we have to change the entire hierarchy when modifying even a single
string in one of them.

The answer is simple. Document title should not be part of his **state**.
Instead, the title should be his **behavior**. For example, like this:

{% highlight java %}
@Immutable
class Document {
  private final int id;
  Document(int id) {
    this.id = id;
  }
  public String title() {
    // read title from storage
  }
  public void title(String text) {
    // save text into storage
  }
  @Override
  public boolean equals(Object doc) {
    return doc instanceof Document
      && Document.class.cast(doc).id == this.id;
  }
  @Override
  public String toString() {
    return String.format("doc #%d about '%s'", this.id, this.title());
  }
}
{% endhighlight %}

Conceptually speaking, this document is acting as a proxy or a real-life
document that has a title stored somewhere, for example, in a file. This is
what a good object should do &mdash; be a proxy of a real-life entity.
The document exponses two features: reading title and saving title. Here is
how his interface would look like:

{% highlight java %}
@Immutable
interface Document {
  String title();
  void title(String text);
}
{% endhighlight %}

`title()` reads the title of the document and returns it as a `String`,
and `title(String)` saves it back into the document. Imagine a real
paper document with a title. You ask an object to read that title from
the paper or to wipe an existing one and write a new text over it. This
paper is a "storage" used in the methods.

Now we can make frequent changes to the immutable document and the
document stays the same. It doesn't stop to immutable, since it's
state (`id`) is not changed. It is the same document, even though we
change its title. Becuase the title is not a state of the document. It
is something in the real world, outside of the document. The document
is just a proxy between us and that "something". Reading and writing
of the title is a behavior of the document, not his state.

## Mutable Memory

The only question we still have unanswered is what is that "storage"
and what happens if we need to keep the title of the document in memory?

Let's look at it from an "object thinking" point of view. We have a `document`
object, which [is supposed to represent]({%pst%}) a real-life entity in an
object-oriented world. If such an entity is a file &mdash; we can easily
implement `title()` methods. If such an entity is an Amazon S3 object &mdash;
we also implement title reading and writing methods easily, keeping the
object immutable. If such an entity is an HTTP page &mdash; we
have no issues in title reading/writing implementation, keeping the object immutable.
We have no issues as long as a real-world document exists and has its
own identity. Our title reading/writing methods will communicate with that
real-world document and extract/update its title.

Problems start when such an entity doesn't exist in a real world. In that
case we need to create a mutable object property `title`, read it via
`title()` and modify it via `title(String)`. But an object is immutable,
we can't have a mutable property in it, by definition! What do we do?

Think.

How could it be that our object doesn't represent a real-world entity?
Remember, *real world* is everything around the living environment of an object.
Is it possible that an object doesn't represent anyone and acts
on its own? No, it's not possible. Every object is a representantive of
a real-world entity. So, who does it represent if we want to keep `title` inside
it and we don't have any file or HTTP page behind the object?

{% badge /images/2014/12/memory-stick.png 200 %}

It represents *computer memory*.

The title of an immutable document #50 "How to cook a sandwich"
is stored in the memory, taking 23 byte of it. The document
should know where that bytes are stored, should be able to read them
and replace them with something else. These 23 bytes is that real-world
entity that the object represents. These bytes have nothing to do with
the state of the object. They are a *mutable* real-world entity, similar
to a file, HTTP page or an Amazon S3 object.

Unfortunately, Java (and many other modern languages) do not allow direct
access to computer memory. This is how we would design our class if such
a direct access would be possible:

{% highlight java %}
@Immutable
class Document {
  private final int id;
  private final Memory memory;
  Document(int id) {
    this.id = id;
    this.memory = new Memory();
  }
  public String title() {
    return new String(this.memory.read());
  }
  public void title(String text) {
    this.memory.write(text.getBytes());
  }
}
{% endhighlight %}

That `Memory` class would be implemented by JDK natively and all other
classes would be immutable. The class `Memory` would have direct access
to the memory heap and would be responsible for
[malloc and free](https://en.wikipedia.org/wiki/C_dynamic_memory_allocation)
operations on the operating system level.
Having such a class would allow us to make all Java classes immutable,
including `StringBuffer`, `ByteArrayOutputStream`, etc.

`Memory` class would explicitly emphasize the mission of an object
in a software program, which is a *data animator*. An object is not
holding data, he is animating it. The data exists somewhere and it is
anemic, static, motionless, stationary, etc. The data is **dead**
while the object is **alive**. The role of an object is to make a piece of data
alive, *animate* it, but not to become a data. An object needs some
knowledge in order to get access to that dead piece of data. An object
may need a database unique key, an HTTP address, a file name, or
a memory address in order to find the data and animate it. But an
object should never think of himself as data.

## What Is the Practical Solution?

Unfortunately, we don't have such a memory-representing class
in Java, Ruby, JavaScript, Python, PHP and many other high-level languages.
Looks like that language designers didn't get the idea of
alive object vs. dead data, which is sad. We're forced to mix
data with object state using the same language constructs &mdash;
object variables/properties.
Maybe some day we'll have that `Memory` class in Java and other languages,
but until then we have a few options.

**Use C++**.
In C++ and similar low-level languages it is possible to access memory
directly and deal with in-memory data the same way we deal with
in-file or in-HTTP data. In C++ we can create that `Memory` class
and use it exactly the way explained above.

**Use Arrays**.
In Java an array is a data structure with a unique property &mdash;
it can be modified while being declared as `final`. You can use
an array of bytes as a mutable data structure inside an immutable object.
It's a surrogate solution that conceptually resembles `Memory` class,
but is much more primitive.

**Avoid In-Memory Data**.
Try to avoid in-memory data as much as possible. In some domains it is
easy to do, for example in web apps, file processing, I/O adapters, etc.
However, in some domains it is much easier said than done. For example,
in games, data manipulation algorithms and GUI most of the objects animate
in-memory data mostly because memory is the only resource they have.
In that case, without `Memory` class, you end up with mutable objects :(
There is no workaround.

To summarize, don't forget that an object is an animator of data. He is using
his encapsulated knowledge in order to reach the data. No matter where
the data is stored, in file, in HTTP or in memory &mdash; it is
conceptually very different from object state, even though they may
look very similar.

A good object is an immutable animator of a mutable data. Even though he
is immutable and data is mutable, he is alive and data is dead.
In the scope of object's living environment.
