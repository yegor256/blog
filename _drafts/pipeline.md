---
layout: post
title: "Declarative and Immutable Pipeline of Transformations"
date: 2022-06-14
place: Moscow, Russia
tags: oop
description: |
  Combining "strategy" objects into a pipeline is a trivial
  task if done in a mutable and imperative way; here I show
  a declarative and immutable approach
keywords:
  - oop pipeline
  - pipeline of transformations
  - pipeline of objects
  - object-oriented transformations
  - pipeline of object-oriented transformations
image: /images/2022/06/
jb_picture:
  caption: ...
---

A few months ago I made a [small Java library](https://github.com/yegor256/xsline),
which is worth explaining since
the design of its classes and interfaces is pretty unusual. It's very much
object-oriented for a pretty imperative task: building a pipeline of
document transformations. The goal was to do this in a declarative and
immutable way, and in Java. Well, as much as it's possible.

<!--more-->

{% jb_picture_body %}

Let's say you have a document, and you have a collection of transformations,
each of which will do something with the document. Each transformation, for example,
is a small piece of Java code. You want to build a list
of transformations and then pass a document through this list.

First, I made an interface [`Shift`](https://github.com/yegor256/xsline/blob/0.5.2/src/main/java/com/yegor256/xsline/Shift.java)
(instead of the frequently used and boring "transformation"):

{% highlight java %}
interface Shift {
  Document apply(Document doc);
}
{% endhighlight %}

Then I made an interface [`Train`](https://github.com/yegor256/xsline/blob/0.5.2/src/main/java/com/yegor256/xsline/Train.java)
(this is the name I made up for the collection
of transformations) and its default implementation:

{% highlight java %}
interface Train {
  Train with(Shift shift);
  Iterator<Shift> iterator();
}
class TrDefault implements Train {
  private final Iterable<Shift> list;
  @Override
  Train with(Shift shift) {
    final Collection<Shift> items = new LinkedList<>();
    for (final Shift item : this.list) {
        items.add(item);
    }
    items.add(shift);
    return new TrDefault(items);
  }
  @Override
  public Iterator<Shift> iterator() {
      return this.list.iterator();
  }
}
{% endhighlight %}

Ah, I forgot to tell you. I'm a big fan of [immutable]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %})
objects. That's why the
`Train` doesn't have a method `add`, but instead has `with`. The difference is that
`add` modifies the object, while `with` makes a new one.

Now, I can build a train of shifts with
[`TrDefault`](https://github.com/yegor256/xsline/blob/0.5.2/src/main/java/com/yegor256/xsline/TrDefault.java),
a simple default implementation of `Train`, assuming
`ShiftA` and `ShiftB` are already implemented:

{% highlight java %}
Train train = new TrDefault()
  .with(new ShiftA())
  .with(new ShiftB());
{% endhighlight %}

Then I created an [`Xsline`](https://github.com/yegor256/xsline/blob/0.5.2/src/main/java/com/yegor256/xsline/Xsline.java)
class (it's "XSL" + "pipeline", since in my case
I'm managing XML documents and transform them using XSL stylesheets). An instance
of this class encapsulates an instance of `Train` and then passes a document
through all its transformations:

{% highlight java %}
Document input = ...;
Document output = new Xsline(train).pass(input);
{% endhighlight %}

So far so good.

Now, I want all my transformations to log themselves. I created
[`StLogged`](https://github.com/yegor256/xsline/blob/0.5.2/src/main/java/com/yegor256/xsline/StLogged.java),
a decorator of `Shift`, which encapsulates the original `Shift`, decorates its method `apply`,
and prints a message to the console when the transformation is completed:

{% highlight java %}
class StLogged implements Shift {
  private final Shift origin;
  @Override
  Document apply(Document before) {
    Document after = origin.apply(before);
    System.out.println("Transformation completed!");
    return after;
  }
}
{% endhighlight %}

Now, I have to do this:

{% highlight java %}
Train train = new TrDefault()
  .with(new StLogged(new ShiftA()))
  .with(new StLogged(new ShiftB()));
{% endhighlight %}

Looks like a duplication of `new StLogged(`, especially with a collection of a few dozen
shifts. To get rid of this duplication I created a decorator for `Train`, which
on the fly decorates shifts that it encapsulates, using
[`StLogged`](https://github.com/yegor256/xsline/blob/0.5.2/src/main/java/com/yegor256/xsline/StLogged.java):

{% highlight java %}
Train train = new TrLogged(new TrDefault())
  .with(new ShiftA()))
  .with(new ShiftB());
{% endhighlight %}

In my case, all shifts are doing XSL transformations, taking XSL stylesheets from
files available in classpath. That's why the code looks like this:

{% highlight java %}
Train train = new TrLogged(new TrDefault())
  .with(new StXSL("stylesheet-a.xsl")))
  .with(new StXSL("stylesheet-b.xsl")));
{% endhighlight %}

There is an obvious duplication of `new StXSL(...)`, but I can't simply get rid of it,
since the method `with` expects an instance of `Shift`, not a `String`. To solve this,
I made the `Train` generic and created
[`TrClasspath`](https://github.com/yegor256/xsline/blob/0.5.2/src/main/java/com/yegor256/xsline/TrClasspath.java)
decorator:

{% highlight java %}
Train<String> train = new TrClasspath<>(new TrDefault<>())
  .with("stylesheet-a.xsl"))
  .with("stylesheet-b.xsl"));
{% endhighlight %}

`TrClasspath.with()` accepts `String`, turns it into
[`StXSL`](https://github.com/yegor256/xsline/blob/0.5.2/src/main/java/com/yegor256/xsline/StXSL.java)
and passes to `TrDefault.with()`.

Pay attention to the snippet above: the `train` is now of type `Train<String>`, not `Train<Shift>`,
as would be required by `Xsline`.
The question now is: how do we get back to `Train<Shift>`?

Ah, I forgot to mention. I wanted to design this library with one important principle
in mind, [suggested]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %})
in 2014: all objects may only implement methods from their interfaces. That's why,
I couldn't just add a method `getEncapsulatedTrain()` to `TrClasspath`.

I introduced a new interface
[`Train.Temporary<T>`](https://github.com/yegor256/xsline/blob/0.5.2/src/main/java/com/yegor256/xsline/Train.java)
with a single method `back()`
returning `Train<T>`. The class `TrClasspath` implements
it and I can do this:

{% highlight java %}
Train<Shift> train = new TrClasspath<>(new TrDefault<>())
  .with("stylesheet-a.xsl"))
  .with("stylesheet-b.xsl"))
  .back();
{% endhighlight %}

Next I decided to get rid of the duplication of `.with()` calls. Obviously, it would
be easier to have the ability to provide a list of file names as an array of `String`
and build the train from it. I created a new class
[`TrBulk`](https://github.com/yegor256/xsline/blob/0.5.2/src/main/java/com/yegor256/xsline/TrBulk.java),
which does exactly that:

{% highlight java %}
Iterable<String> names = Arrays.asList(
  "stylesheet-a.xsl",
  "stylesheet-b.xsl"
);
Train<Shift> train = new TrBulk<>(
  new TrClasspath<>(
    new TrDefault<>()
  )
).with(names).back();
{% endhighlight %}

With this design I can construct the train in almost any possible way.

See, for example, how we use it [here](https://github.com/objectionary/eo/blob/0.23.6/eo-parser/src/main/java/org/eolang/parser/ParsingTrain.java#L86-L103) and [here](https://github.com/objectionary/eo/blob/0.23.6/eo-maven-plugin/src/main/java/org/eolang/maven/SpyTrain.java#L49-L75).

