---
layout: post
title: "Java Annotations Are Against OOP"
date: 2016-03-21
place: Seattle, WA
tags: java oop
description:
  ....
keywords:
  - java annotations
  - java annotations example
  - java annotations runtime
  - java annotations tutorial
  - java annotations list
---

[Annotations](https://en.wikipedia.org/wiki/Java_annotation)
were introduced in Java 6 in 2006, and we all got excited. Such a great
instrument to make code shorter! No more Hibernate/Spring XML configuration
files! Just annotations, right there in the code, where we need them. No more
[marker interfaces](https://en.wikipedia.org/wiki/Marker_interface_pattern)!
Just a [runtime-retained](https://docs.oracle.com/javase/7/docs/api/java/lang/annotation/Retention.html)
[reflection-discoverable](http://stackoverflow.com/questions/4296910/) annotation.
I was excited too. Moreover, I've made a few open source libraries, which
use annotations heavily. Take [jcabi-aspects](https://github.com/jcabi/jcabi-aspects),
for example. However, I'm not excited any more. Moreover, I believe that
annotations in Java is a big mistake in language design.

<!--more-->

I'm talking about annotations that either stay with the bytecode after
compilation or are being used by [apt](http://docs.oracle.com/javase/7/docs/technotes/guides/apt/)
(or similar tools) to post-compile modify bytecode. There are a few
typical usage scenarios, where annotations seem to be very convenient. Let's
discuss them one by one and I'll show that in each case they are very much against
[the principles]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %})
of a proper object-oriented programming.

That is basically the main reason why I call annotations a mistake &mdash;
looking like a very convenient technique they make code
**less maintainable**. Let's discuss each situation separately.

## AOP Weaving and APT

Here is an example
(from [my own library]({% pst 2014/aug/2014-08-15-retry-java-method-on-exception %})):

{% highlight java %}
import com.jcabi.aspects.RetryOnFailure;
class Foo {
  @RetryOnFailure
  public String load(URL url) {
    return url.openConnection().getContent();
  }
}
{% endhighlight %}

After compilation, we run a so called
[AOP weaver]({% pst 2014/jun/2014-06-01-aop-aspectj-java-method-logging %})
that technically turns our code into something like this:

{% highlight java %}
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
{% endhighlight %}

I simplified the actual algorithm of retrying a method call on failure, but I'm
sure you got the idea. [AspectJ](http://www.aspectj.org),
the [AOP](http://en.wikipedia.org/wiki/Aspect-oriented_programming)
engine, uses
[`@RetryOnFailure`](http://aspects.jcabi.com/annotation-retryonfailure.html)
annotation as a signal, informing us that the class
has to be wrapped into another one. This is happening behind the scene. We don't
see that supplementary class, which implements the retrying algorithm.
But the bytecode produced by the AspectJ weaver contains a modified
version of class `Foo`.

That is exactly what is wrong with this approach &mdash; we don't see
and don't control the instantiation of that supplementary object. Object
composition, which is the most important process in object design, is
hidden somewhere behind the scene. You may say that we don't need
to see it, since it's supplementary. I disagree. We must see how
our objects are composed. We may not care about how they work, but we
must see the entire composition process.

A much better design would look like this (instead of annotations):

{% highlight java %}
Foo foo = new FooThatRetries(new Foo());
{% endhighlight %}

And then, the implemenation of `FooThatRetries`:

{% highlight java %}
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
{% endhighlight %}

And now, the implementation of `Retry`:

{% highlight java %}
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
{% endhighlight %}

The code is longer? Yes. Is it cleaner? A lot more. I regret that I
didn't understand it two years ago, when I started to work with
[jcabi-aspects](https://github.com/jcabi/jcabi-aspects). Most of AOP
aspects must be implemented by decorators, just like in this
example. Not all of them, but most.

But why exactly it's cleaner?

