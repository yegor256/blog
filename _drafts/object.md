---
layout: post
title: "Seven Virtues of a Good Object"
date: 2014-11-19
tags: oop
description:
  Who is that properly designed object in an object-oriented world? What
  name, behavior, habits, interfaces, and friends does he have? Let's
  look at it from a different perspective.
keywords:
  - object in java
  - object oriented programming
  - object oriented methodology
  - object oriented principles
  - object oriented programming concepts
---

Martin Fowler [says](http://martinfowler.com/bliki/InversionOfControl.html):

> A library is essentially a set of functions that you can call,
these days usually organized into classes

Functions organized into classes? What kind of programming is that?
Object-oriented? Martin, classes are **not** organizers of functions!
Unfortunately, you're not alone, since it is a very common
misconception of a class and an object in object-oriented programming.

So, what is a "proper" object? Which one is not a proper one?
What is the difference? Even though it is a very polemic subject, it is very important.
Unless we undertand what an object is, how can we write object-oriented software?
Well, thanks to Java, Ruby and others &mdash; we can, but how good will it be?
Unfortunately, this is not an exact science. There are many opinions.
Here is my list of qualities of a good object.

<!--more-->

## Class vs. Object

Before we start talking about objects, let's define what a *class* is. It
is a place where objects are being born (aka *instantiated*). The main responsibility
of a class is to *construct* new objects on demand and *destruct* them when
they are not used any more. A class knows how its children should look
and how they should behave. In other words, it knows what *contracts* they should obey.

Sometimes I hear classes being called "object templates"
(for example, [wikipedia says so](https://en.wikipedia.org/wiki/Class_%28computer_programming%29)).
This definition is not correct because it places classes into a passive position. This definition
assumes that someone will get a template and build an object using it.
This may be true, technically speaking, but conceptually it's wrong. There
is nobody else should be involved &mdash; there are only a class and its children. An
object asks a class to create another object and the class constructs it, that's it.
Ruby expresses this concept much better than Java or C++:

{% highlight java %}
photo = File.new('/tmp/photo.png')
{% endhighlight %}

The object `photo` is constructed by the class `File` (`new` is an entry point to the class).
Once constructed, the object is acting on its own. It shouldn't know who constructed it
and how many more brothers and sisters it has in the class. Yes, I mean
that [reflection](https://en.wikipedia.org/wiki/Reflection_%28computer_programming%29)
is a terrible idea, but about it in one of the next posts :)
Now, let's talk about objects and their best and worst sides.

## 1. He Exists In Real Life

First of all, an object is a **living organism**. Moreover, an object
should be [antropomorphized](https://en.wikipedia.org/wiki/Anthropomorphism), i.e.
treated like a human being (or a pet, if you like them more). By this
I basically mean that an object is not a *data structure* or a collection
of functions. Instead, it is an independent entity with its own life cycle,
its own behavior and its own habits.

An employee, a department, an HTTP request, a table in MySQL,
a line in a file, or a file itself are proper objects. Because they exist in
real-life, even when our software is turned off. To be more precise, an object is a
*representative* of a real-life creature. It is a *proxy* of that
real-life creature in front of all other objects. Without
such a creature &mdash; there is, obviously, no object.

{% highlight java %}
photo = File.new('/tmp/photo.png')
puts photo.width()
{% endhighlight %}

In this example I'm asking `File` to construct a new object `photo`, which will
be a representative of a real file on disc. You may say that a file
is also something virtual and exists only when the computer is turned on.
I would agree and refine the definition of "real life" &mdash; it is
everything that exists aside from the scope of the program the object
lives in. The disc file is outside of scope of our program, that's why
it perfectly correct to create its representative inside the program.

A controller, a parser, a filter, a validator, a service locator,
a singleton, or a factory are **not** good objects
(yes, most of GoF patterns are anti-patterns!).
They don't exist apart from your software, in real life. They
are invented just to tie other objects together. They are artificial
and fake creatures. They don't represent anyone. Seriously, an XML parser
&mdash; who does it represent? Noboby.

Some of them may become good if they change their names,
others can never excuse their existence. For example, that XML parser can be
renamed to "parseable XML" and start to represent an XML document,
that exists outside of our scope.

Always ask yourself, what is
the real-life entity behind your object. If you can't find an answer,
start thinking about refactoring.

## 2. He Works By Contracts

A good object always works by contracts. He expects to be hired not
because of his personal merits, but because he obeys the contracts. On the
other hand, when we hire an object, we shouldn't discriminate and expect some specific
object from a specific class to do the work for us. We should expect *any*
object to do what our contract says. As long as the object does what
we need, we should not be interested in his class of origin, his sex or religion.

For example, I need to show a photo on the screen.
I want that photo to be read from a file in PNG format. I'm
contracting an object from class `DataFile` and asking him to give me
a binary content of that image.

But wait, do I care where exactly the content will come from, the file on disc or
an HTTP request or maybe a document in Dropbox? Actually, I don't. All I care about
is that some object gives me a byte array with PNG content. So, my contract
would look like this:

{% highlight java %}
interface Binary {
  byte[] read();
}
{% endhighlight %}

Now, any object from any class (not just `DataFile`) can work for me.
All he has to do, in order to be eligible, is to obey the contract
&mdash; by implementing the interface `Binary`.

The rule here is simple &mdash; every public method in a good object should
implement its counter-part from an interface. If your object has
public methods that are not inherited from any interface, it is a bad design.

There are two practical reasons for this. First, an object working
without a contract is impossible to mock in a unit test. Second,
a contract-less object is impossible to extend via
[decoration](https://en.wikipedia.org/wiki/Decorator_pattern).

## 3. He Is Unique

A good object should always encapsulate something, in order
to be unique. If there is nothing to encapsulate, an object may
have identical clones, which, I believe, is bad. Here is an example
of a bad object, which may have clones:

{% highlight java %}
class HTTPStatus implements Status {
  private URL page = new URL("http://www.google.com");
  @Override
  public int read() throws IOException {
    return HttpURLConnection.class.cast(
      this.page.openConnection()
    ).getResponseCode();
  }
}
{% endhighlight %}

I can create a few instances of class `HTTPStatus` and all of them will be
equal to each other:

{% highlight java %}
first = new HTTPStatus();
second = new HTTPStatus();
assert first.equals(second);
{% endhighlight %}

Obviously, utility classes, which have only static methods,
can't instantiate good objects. More generally, utility classes
don't have any of the merits mentioned in this article and can't
even be called "classes". They are simply terrible abusers of an object paradigm
and exist in modern object-oriented languages only because their
inventors enabled static methods.

## 4. He Is Immutable

A good object should never change its encapsulated state.
Remember, an object is a representative of a real-life entity, and this
entity should stay the same through the entire life of the object. In other
words, an object should should never betray those who it represents. It should
never change owners :)

Be aware, immutability doesn't mean that all methods always return same values.
Instead, a good immutable object is very dynamic.
However, it never changes its internal state, for example:

{% highlight java %}
@Immutable
final class HTTPStatus implements Status {
  private URL page;
  public HTTPStatus(URL url) {
    this.page = url;
  }
  @Override
  public int read() throws IOException {
    return HttpURLConnection.class.cast(
      this.page.openConnection()
    ).getResponseCode();
  }
}
{% endhighlight %}

Even though method `read()` may return different values, the
object is immutable. It points to a certain web page and will
never point anywhere else, it will never change its encapsulated state, it will
never betray the URL it represents.

Why immutability is a virtue? This article explains in details:
[Objects Should Be Immutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}).
In a nutshell, immutable objects are better because:

 * immutable objects are simpler to construct, test, and use
 * truly immutable objects are always thread-safe
 * they help to avoid temporal coupling
 * their usage is side-effect free (no defensive copies)
 * they always have failure atomicity
 * they are much easier to cache
 * they prevent [NULL references]({% pst 2014/may/2014-05-13-why-null-is-bad %})

Of course, a good object doesn't have
[setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}), which
may change its state and force him to betray the URL. In other words,
introducing a `setURL()` method would be a terrible mistake in class `HTTPStatus`.

Besides all that, immutable objects will force you to make
more cohesive, solid, and understandable design, as this article
explains: [How Immutability Helps]({% pst 2014/nov/2014-11-07-how-immutability-helps %}).

## 5. His Class Doesn't Have Anything Static

A static method implements a behavior of a class, not an object. Let's say,
we have class `File` and its children have method `size()`:

{% highlight java %}
final class File implements Measurable {
  @Override
  public int size() {
    // calculate the size of the file and return
  }
}
{% endhighlight %}

So far so good, the method `size()` is there because of the contract `Measurable`
and every object of class `File` will be able to measure its size. A terrible
mistake would be to design this class with a static method instead
(this design is also known as
[a utility class]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %})
and is very popular in Java, Ruby and almost every OOP language):

{% highlight java %}
// TERRIBLE DESIGN, DON'T USE!
class File {
  public static int size(String file) {
    // calculate the size of the file and return
  }
}
{% endhighlight %}

This design is completely against the object-oriented paradigm. Why?
Because static methods turn object-oriented programming into a "class-oriented" one.
This method `size()` exponses the behavior of the class, not of its objects. What's
wrong with this, you may ask? Why can't we have both objects and classes
as first-class citizens in our code? Why can't both of them have methods and properties?

The problem is that with class-oriented programming
decomposition doesn't work any more. We can't break down a complex problem
into parts, because only a single instance of a class exists in the entire
program. The power of OOP is that it allows us to use objects as an instrument
for scope decomposition. When I instantiate an object inside a method, it
is dedicated to my specific task. It is perfectly isolated from
all other objects around the method. This object is a *local variable*
in the scope of the method. A class, with its static methods, is always
a *global variable*, no matter where I use it. Because of that, I can't
isolate my interaction with this variable from others.

Besides being conceptually against object-oriented principles, public static
methods have a few practical drawbacks:

First, it's **impossible to mock** them
(well, you can use [PowerMock](https://code.google.com/p/powermock/),
but this will be the most terrible decision
you can make in a Java project... I've made it once, a few years ago).

Second, they are **not thread-safe** by definition, since they always
work with static variables, which are accessible from all threads. You can
make them thread-safe, but this will always require explicit
synchronization.

Every time you see a public static method, start rewriting immediately. I don't
even want to mention how terrible are static (or global) variables. I think
it is just obvious.

## 6. His Name Is Not a Job Title

The name of an object should tell us what this object **is**, not what
it **does**. Just like we name objects in real life: book instead of
page aggregator, cup instead of water holder, t-shirt instead of body dresser.
There are exceptions, of course, like printer or computer, but
they were invented just recently and by those who didn't read this article :)

For example, these names tell us what their owners are:
an apple, a file, a series of HTTP requests, a socket, an XML document, a list of users, a regular
expression, an integer, a PostgreSQL table, or Jeffrey Lebowski. A properly named is always
possible to draw as a small picture. Even a regular expression can be drawn.

In the opposite, this is an example of names that tell us what their owners do:
a file reader, a text parser, an URL validator, a XML printer,
a service locator, a singleton, a script runner, or a Java programmer. Can you draw
any of them? No, you can't. These names are not suitable for good objects.
They are terrible names that lead to terrible design.

In general, avoid names that end with "-er" &mdash; most of them are bad.

"What is the alternative of a `FileReader`?" &mdash; I hear you asking. What would
be a better name? Let's see. We already have `File`, which is a representative
of a real-world file on disc. This representative is not powerful enough for us,
because it doesn't know how to read the content of the file. We want to create
a more powerful one, which will have that ability. How would we call him?
Remember, the name should say what it is, not what it does. What it is? It
is a file that has data. Not just a file, like `File`, but a more sophisticated
one, with data. So, how about `FileWithData` or simply `DataFile`?

The same logic should be applicable to all other names.
Always think about **what it is**, instead of what it does. Give your
objects real meaningful names instead of job titles.

## 7. His Class Is Either Final or Abstract

A good object comes from either final or abstract class. A `final` class is the one that
can't be extended via inheritance. An `abstract` class is the one that
can't have children. Simply put, a class should either say "you can never break
me, I'm a black box for you" or "I'm broken already, fix me first and then use".

There is nothing in between. A final class is a black box that you can't modify
anyhow. It works as it works and you either use it or throw away. You can't
create another class that will inherit its properties. This is not allowed
because of that `final` modifier. The only way to extend such a final class
is through decoration of its children. Let's say, I have class `HTTPStatus` (see
above) and I don't like it. Well, I like it, but it's not powerful enough
for me. I want it to throw an exception if HTTP status is over 400. I want
his method `read()` to do more that it does now. A traditional way would be
to extend the class and overwrite its method:

{% highlight java %}
class OnlyValidStatus extends HTTPStatus {
  @Override
  public int read() throws IOException {
    int code = super.read();
    if (code > 400) {
      throw new RuntimException("unsuccessful HTTP code");
    }
    return code;
  }
}
{% endhighlight %}

Why this is wrong? It is very wrong, because we're risking of breaking
the logic of the entire parent class, by overriding one of its methods. Remember,
once we override method `read()` in the child class, all methods from the
parent class start to use its new version. We're literally injecting
a new "piece of implementation" right into the class. Phylosophically
speaking, this is an offense.

On the other hand, to extend a final class you treat it like a black box
and decorate with your own implementation (aka
[Decorator Pattern](https://en.wikipedia.org/wiki/Decorator_pattern)):

{% highlight java %}
final class OnlyValidStatus implements Status {
  private final transient Status origin;
  public OnlyValidStatus(Status status) {
    this.origin = status;
  }
  @Override
  public int read() throws IOException {
    int code = this.origin.read();
    if (code > 400) {
      throw new RuntimException("unsuccessful HTTP code");
    }
    return code;
  }
}
{% endhighlight %}

Pay attention that this class is implementing the same interface
as the original one &mdash; `Status`. The instance of `HTTPStatus` will
be passed into it through the constructor and encapsulated. Then, every
call will be intercepted and implemented in a different way, if necessary.
In this design we treat the original object as a black box and never
touch its internal logic.

If you don't use that `final` keyword, anyone (including yourself) will
be able to extend the class and... offend it :( So, a class without `final`
is a bad design.

An abstract class is the exact oposite case &mdash; it tells us that
it is incomplete and we can't use it "as is". We have to inject
our custom implementation logic into it, but only into the places he allows
us to touch. These places are explicitly marked as `abstract` methods.
For example, our `HTTPStatus` may look like this:

{% highlight java %}
abstract class ValidatedHTTPStatus implements Status {
  @Override
  public final int read() throws IOException {
    int code = this.origin.read();
    if (!this.isValid()) {
      throw new RuntimException("unsuccessful HTTP code");
    }
    return code;
  }
  protected abstract boolean isValid();
}
{% endhighlight %}

As you see, the class doesn't know how exactly to validate the HTTP
code, and it expects us to inject that logic through inheritance and
overloading the method `isValid()`. We're not going to offend him with
this inheritance, since he defended all other methods with `final` (pay
attention to the modifiers of its methods). Thus, the class is ready
for our offense and is perfectly guarded against it.

To summarize, your class should either be `final` or `abstract` &mdash;
nothing in between.
