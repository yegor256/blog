---
layout: post
title: "Strong Typing without Types"
date: 2020-11-00
place: Moscow, Russia
tags: oop
description: |
  Strong typing is a powerful instrument to prevent
  type errors in OOP, but do we really need explicitly
  defined types to enable it?
keywords:
  - types
  - typing
  - strong typing
  - strong vs weak typing
  - type system oop
image: /images/2020/11/
jb_picture:
  caption: ...
---

In 1974, Liskov and Zilles [defined](https://dl.acm.org/doi/abs/10.1145/942572.807045)
a [strongly-typed](https://en.wikipedia.org/wiki/Strong_and_weak_typing)
language as one in which "whenever an object is passed from
a calling function to a called function, its type must be
compatible with the type declared in the called function."
Strong [type checking](https://en.wikipedia.org/wiki/Type_system),
without doubts, decreases the amount of
[type errors](https://en.wikipedia.org/wiki/Type_system#Type_errors),
which leads to higher quality. However, the question is:
do we really need types in order to strongly enforce typing?

<!--more-->

{% jb_picture_body %}

Say, this is the place where we expect an object of
Java interface (another name for types) `Book` to arrive:

{% highlight java %}
void print(Book b) {
  System.out.printf(
    "The ISBN is: %s%n", b.isbn()
  );
}
{% endhighlight %}

The type `Book` would look like this:

{% highlight java %}
interface Book {
  String isbn();
}
{% endhighlight %}

If an object that doesn't `implement` the interface `Book` is passed
to the method `print()`, the compiler during compile-time will complain
with the "type mismatch" error. It will be hard for a programmer to make
a mistake and pass an object of type `Car` to the method `print()`. It will
still be possible, during dynamic type casting:

{% highlight java %}
Car car = new Car("Mercedes-Benz G63");
print(Book.class.cast(car)); // Here!
{% endhighlight %}

This code will compile without issues, but in runtime the
[`ClassCastException`](https://docs.oracle.com/javase/7/docs/api/java/lang/ClassCastException.html)
will be thrown, since it's impossible to cast `Car` to `Book`.

This is beauty of strong typing: it prevents errors. However, it increases
the complexity of code: you need to create types first, you need to declare them
in all your functions, you need type casting, which is hard to debug, and so on.
Weak typing adepts complain about this a lot and create languages like Ruby,
which don't have types at all, for example:

{% highlight ruby %}
def print(b)
  puts(format("This is ISBN: %s", b.isbn))
end
{% endhighlight %}

Here, the function `print()` doesn't expect `b` to be of any
particular type. Whatever comes in---is fine. Later, when it's
time to call `.isbn` the runtime checks whether the
incoming `b` has such a method. If it does, everything works just fine,
if it doesn't, a runtime error [`NoMethodError`](https://ruby-doc.org/core-2.5.0/NoMethodError.html)
is raised.

Now, there is an idea: what if we combine the simpicity and brevity
of dynamic typing with the safetiness of strong typing by getting
rid of types all together and letting the compiler infer type
information from the code that works with objects? Here is our
code again:

{% highlight java %}
void print(Book b) {
  System.out.printf(
    "The ISBN is: %s%n", b.isbn()
  );
}
{% endhighlight %}

During compile type it's already obvious that `b` must have
_at least_ one method `isbn()`. No need to ask the programmer to define
the type `Book` explicitly and say in the signature of the method `print()`
that only books are welcome: this knowledge can easily be infered from
the body of the method `print()`! The compiler may look at all statements
in the method `print()` and clearly understand what exactly will be done
with the object `b`. This information should be enough to visualize
the "type" of the incoming object. No need to ask the programmer to
do this explicitly and spend another five lines of code in a new file
to declare the type `Book`. The compiler can do this job for us.

Of course, to make this work we must prohibit
[type casting]({% pst 2015/apr/2015-04-02-class-casting-is-anti-pattern %})
of any kind, which is not possible in Java, C++, C# and other
pseudo-object-oriented languages. But it is possible in
[EO](https://www.eolang.org)!

WDYT?




