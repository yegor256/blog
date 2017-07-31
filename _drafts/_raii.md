---
layout: post
title: "RAII"
date: 2017-05-02
place: Riga, Latvia
tags: oop
description: |
  ...
keywords:
  - RAII
  - resource acquisition is initialization
  - RAII in OOP
  - RAII in Java
  - RAII in C++
book: elegant-objects-1 4.4
image: /images/2015/03/at-sachem-farm.jpg
jb_picture:
  caption: At Sachem Farm (1998) by John Huddles
---

Resource Acquisition Is Initialization
([RAII](https://en.wikipedia.org/wiki/Resource_acquisition_is_initialization))
is a design idea introduced in C++ by
[Bjarne Stroustrup](http://amzn.to/2uMlANB)
for exception-safe resource management.
Thanks to garbage collection Java
[doesn't have](https://stackoverflow.com/questions/477399) this feature,
but we can implement something similar, using
[try/finally](https://docs.oracle.com/javase/tutorial/essential/exceptions/finally.html).

<!--more-->

{% jb_picture_body %}

The problem RAII is solving is obvious; have a look at this code
(I'm sure you know what
[`Semaphore`](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/Semaphore.html)
is and how it works in Java):

{% highlight java %}
class Foo {
  private Semaphore sem = new Semaphore(5);
  void print(int x) throws Exception {
    this.sem.acquire();
    if (x > 1000) {
      throw new Exception("Too large!");
    }
    System.out.printf("x = %d", x);
    this.sem.release();
  }
}
{% endhighlight %}

The code is rather primitive and doesn't do anything useful, but you
most probably get the idea: the method `print()`, if being called from
multiple parallel threads, will allow only five of them to print
in parallel. Sometimes it will not allow some of them to print and will
throw an exception if `x` is bigger than `1000`.

The problem with this code is&mdash;[resource leakage](https://en.wikipedia.org/wiki/Resource_leak).
Each `print()` call
with `x` larger than `1000` will take one permit from the semaphore and
won't return it. In five calls with exceptions
the semaphore will be empty and all other threads won't print anything.

What is the solution? Here it is:

{% highlight java %}
class Foo {
  private Semaphore sem = new Semaphore(5);
  void print(int x) throws Exception {
    this.sem.acquire();
    if (x > 1000) {
      this.sem.release();
      throw new Exception("Too large!");
    }
    System.out.printf("x = %d", x);
    this.sem.release();
  }
}
{% endhighlight %}

We must release the permit before we throw the exception.

However, there is another problem that shows up: code duplication. We release
the permit in two places. If we add more `throw` instructions we will
also have to add more `sem.release()` calls.

A very elegant solution was introduced in C++ and is called RAII. This
is how it would look in Java:

{% highlight java %}
class Permit {
  private Semaphore sem;
  Permit(Semaphore s) {
    this.sem = s;
    this.sem.acquire();
  }
  @Override
  public void finalize() {
    this.sem.release();
  }
}
class Foo {
  private Semaphore sem = new Semaphore(5);
  void print(int x) throws Exception {
    new Permit(this.sem);
    if (x > 1000) {
      throw new Exception("Too large!");
    }
    System.out.printf("x = %d", x);
  }
}
{% endhighlight %}

See how beautiful the code is inside method `Foo.print()`. We just create
an instance of class `Permit` and it immediately acquires a new permit
at the semaphore. Then we exit the method `print()`, either by exception
or in the normal way, and the method `Permit.finalize()` releases the permit.

Elegant, isn't it? Yes, it is, but it won't work in Java.

It won't work because, unlike C++, Java doesn't destroy objects when
their scope of visibility is closed. The object of class `Permit` won't
be destroyed when we exit the method `print()`. It will be destroyed
_eventually_ but we don't know when exactly. Most likely it will be
destroyed way after all permits in the semaphore got acquired and we
get blocked.

There is a solution in Java too. It is not as elegant as the one from
C++, but it does work. Here it is:

{% highlight java %}
class Permit implements Closeable {
  private Semaphore sem;
  Permit(Semaphore s) {
    this.sem = s;
  }
  @Override
  public void close() {
    this.sem.release();
  }
  public Permit acquire() {
    this.sem.acquire();
    return this;
  }
}
class Foo {
  private Semaphore sem = new Semaphore(5);
  void print(int x) throws Exception {
    try (Permit p = new Permit(this.sem).acquire()) {
      if (x > 1000) {
        throw new Exception("Too large!");
      }
      System.out.printf("x = %d", x);
    }
  }
}
{% endhighlight %}

Pay attention to the `try/finally` block and to the [`Closeable`](https://docs.oracle.com/javase/7/docs/api/java/io/Closeable.html) interface
that the class `Permit` now implements. The object `p` will be "closed"
when the `try/finally` block exits. It may exit either at the end, or
by the `return` or `throw` statements. In either case `Permit.close()`
will be called: this is how
[try/finally](https://docs.oracle.com/javase/tutorial/essential/exceptions/finally.html)
works in Java.

I introduced method `acquire()` and moved `sem.acquire()` out of the `Permit` constructor because I
[believe]({% pst 2015/may/2015-05-07-ctors-must-be-code-free %})
that constructors must be code-free.

To summarize, RAII is a perfect design <del>pattern</del> approach when you
deal with resources that may [leak](https://en.wikipedia.org/wiki/Resource_leak).
Even though Java doesn't have it out of the box we can implement it
via [try/finally](https://docs.oracle.com/javase/tutorial/essential/exceptions/finally.html) and
[`Closeable`](https://docs.oracle.com/javase/7/docs/api/java/io/Closeable.html).

