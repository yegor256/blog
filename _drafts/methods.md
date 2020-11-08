---
layout: post
title: "Objects without Methods"
date: 2020-11-00
place: Moscow, Russia
tags: oop
description: |
  ...
keywords:
  - methods in oop
  - object oriented programming
  - oop
  - eolang
  - oop design
image: /images/2020/11/
jb_picture:
  caption: ...
---

What do you think an object is, in OOP? No matter what language you are
programming with, you will most probably agree with Bruce Eckel,
the author of [Effective Java], who said that "each object has a state
and operations that you can ask it to perform," or
Benjamin Evans, the author of [Java in a Nutshell], who claimed that it is
"a collection of data fields that hold values and methods that operate on those values."
What if I tell you that an object may have no "operations"
and still be a perfect "equivalent of the quanta from which the universe
is constructed," as David West suggested in his great book
[Object Thinking]?

<!--more-->

{% jb_picture_body %}

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











