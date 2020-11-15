---
layout: post
title: "In EO Objects Don't Have Methods"
date: 2020-11-17
place: Moscow, Russia
tags: oop
description: |
  ...
keywords:
  - methods in oop
  - object oriented programming
  - oop and eo
  - eolang
  - eo design
image: /images/2020/11/
jb_picture:
  caption: ...
---

What do you think an object is, in OOP? No matter what language you are
programming with, you will most probably agree with Bruce Eckel,
the author of [Effective Java](https://amzn.to/35xigKf), who said that "each object has a state
and operations that you can ask it to perform," or
Benjamin Evans, the author of [Java in a Nutshell](https://amzn.to/35uKVPU), who claimed that it is
"a collection of data fields that hold values and methods that operate on those values."
However, hold on... What if I tell you that an object may have no "operations"
and still be a perfect "equivalent of the quanta from which the universe
is constructed," as David West suggested in his great book
[Object Thinking](https://amzn.to/3kuXHlL)?

<!--more-->

{% jb_picture_body %}

In [EO](https://www.eolang.org),
our experimental programming language, we made an attempt to re-define
OOP and its objects. There are two types of _things_ in EO: atoms and objects.
Atom is a lowest level language primitive, which can't be expressed by
other atoms. For example, an object that represents an arithmetic
addition of other two objects, is an atom:

{% highlight text %}
add 5 y > x
{% endhighlight %}

This code makes a copy of an abstract object `add` with two
specific arguments: `5` and `y`. The name of a new object would
be `x`.

This is how a Fibonacci number would look in EO:

{% highlight text %}
[n] > fibo
  if > 𝜑
    less n 2
    n
    add
      fibo (sub n 1)
      fibo (sub n 2)
{% endhighlight %}

This code creates a new abstract object named `fibo` with the
only attribute named

What "operations" are for? We discussed
[earlier]({% pst 2018/aug/2018-08-22-builders-and-manipulators %})
that there are two types of
them: builders and manipulators. We may either ask a project to "build" something
for us (some other object) or "manipulate" existing objects and return
`void`. However, no matter whan an object does for us, it may either
do it all now in [imperative]({% pst 2015/mar/2015-03-09-objects-end-with-er %})
way, or prepare the execution and return
an object, which is ready to do the operation later. Functional programmers
know what I'm talking about, but here is an example for OOP people.

Say, it's a Java class, representing a text file:

{% highlight java %}
class Semaphore {
  private final Path path;
  Semaphore(Path p) {
    this.path = p;
  }
  /**
   * Check, whether the file exists and return
   * TRUE if it does. No matter what, the file
   * will also be removed in this method.
   */
  boolean checkAndRemove() {
    boolean exists = Files.exist(this.path);
    Files.deleteIfExists(this.path);
    return exists;
  }
}
{% endhighlight %}

This is imperative programming. Everything happens in the
method `checkAndRemove()` right when it's called. Even though
this may look intuitive---the computer does the work for us
when it's being instructed to---imperative style of programming
makes is hard to [compose]({% pst 2015/feb/2015-02-26-composable-decorators %})
objects. A better declarative alternative of the same functionality
would look like this
(I'm using [functional interface](https://docs.oracle.com/javase/8/docs/api/java/lang/FunctionalInterface.html)
`Scalar` from our awesome
[Cactoos](https://www.cactoos.org) library):

{% highlight java %}
import org.cactoos.Scalar;
class Semaphore {
  private final Path path;
  Semaphore(Path p) {
    this.path = p;
  }
  Scalar<Boolean> checkAndRemove() {
    return () -> { // A Scalar is created
      boolean exists = Files.exist(this.path);
      Files.deleteIfExists(this.path);
      return exists;
    };
  }
}
{% endhighlight %}

Now, when you call method `checkAndRemove()`, it doesn't really do anything aside
from creating a new object of class `Scalar` and defining its body.
No actual operations are performed with the file system;
they will be performed later, when you touch the "scalar" created:

{% highlight java %}
Semaphor sem = new Semaphore(Paths.get("/tmp/a.txt"));
Scalar<Boolean> exists = sem.checkAndRemove();
// Maybe some other code happens here...
if (exists.get()) { // File operations happen here!
  // Do something
}
{% endhighlight %}

Moreover, if the method `Scalar#get()` is never called, the file will never be checked
and deleted.

Now, the new idea.

What if we disallow objects to have imperative methods at all? What if we
allow them to only have "places" like `checkAndRemove()`, which construct
new `Scalar` objects. I'm talking about all objects! The code would look like this:

{% highlight java %}
Scalar<Boolean> checkAndRemove() {
  return () -> {
    Scalar<Boolean> exists = Files.exist(this.path);
    Scalar<Boolean> deleted = Files.deleteIfExists(this.path);
    return exists;
  };
}
{% endhighlight %}

However, this code won't work. The file will never be deleted. I'm sure you understand
why: the `deleted.get()` is never called and that's why the file deletion won't
ever happen. To solve this, we will need to "join" the objects in a logical
conjunction (I'm using [`And`](https://javadoc.io/doc/org.cactoos/cactoos/0.47/org/cactoos/scalar/And.html)
from [Cactoos](https://www.cactoos.org)):

{% highlight java %}
Scalar<Boolean> checkAndRemove() {
  return new And<>(
    Files.exist(this.path),
    Files.delete(this.path)
  );
}
{% endhighlight %}

Now everything is correct. The result of `checkAndRemove()` will return `TRUE` only
if the file exists. In this case, the file will be deleted. If the file is
absent, the result will be `FALSE` and the deletion won't be attempted.

Imagine how your Java code would look if _all_ methods are allowed to return only
instances of `Scalar`? The entire application will be busy contructing objects











