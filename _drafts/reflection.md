---
layout: post
title: "Reflection Means Hidden Coupling"
date: 2022-05-14
place: Moscow, Russia
tags: oop
description: |
  Reflection in object-oriented programming languages like Java is
  a powerful technique, but a very dangerous and harmful one.
keywords:
  - reflection
  - oop reflection
  - reflection is bad
  - what is reflection
  - why reflection
image: /images/2022/02/wheelman.jpg
jb_picture:
  caption: Wheelman (2017) by Jeremy Rush
---

[Reflective programming](https://en.wikipedia.org/wiki/Reflective_programming) (or reflection) is 
when your code changes itself on-fly. For example, a method of a class, when we call it,
among other things, adds a new method to the class 
(also known as [monkey patching](https://en.wikipedia.org/wiki/Monkey_patch)). 
Java, Python, PHP, JavaScript, you name it---they
all have this "powerful" feature. What's 
[wrong](https://softwareengineering.stackexchange.com/questions/193526) with it? 
Well, it's 
[slow](https://mattwarren.org/2016/12/14/Why-is-Reflection-slow/), 
[dangerous](https://owasp.org/www-community/vulnerabilities/Unsafe_use_of_Reflection),
hard to read and debug.
But all that is nothing comparing with the _coupling_ it introduces to the code.

<!--more-->

{% jb_picture_body %}

There are many situations when reflection can "help" you.
Let's go through all of them and see why the coupling they add to the code is
unnecessary and harmful.

## Type Checking and Casting

Here is the code:

{% highlight java %}
public int sizeOf(Iterable items) {
  return ((Collection) items).size();
}
{% endhighlight %}

I'm not sure everybody would agree that this is reflection, but I believe
it is: we check the structure of the class in runtime and then make
a call to the method `size()` which doesn't exist in the `Iterable`. This method only
"shows up" in runtime, when we make
a [dynamic shortcut](https://stackoverflow.com/questions/19017258)
to it in the bytecode.

Why this is bad, aside from the facts that
1) it's [slow](http://www.buzdin.lv/2011/01/is-java-reflection-really-slow.html),
2) more verbose and that's why [less readable](https://armedia.com/blog/instanceof-avoid-in-code/),
and
3) introduces a new point of failure since the object `items` may not be
an instance of class `Collection`
leading to [`MethodNotFoundException`](https://docs.oracle.com/javaee/5/api/javax/el/MethodNotFoundException.html))?

The biggest problem the code above causes to the entire program is the coupling
it introduces betwen itself and its clients, for example:

{% highlight java %}
public void calc(Iterable<?> list) {
  int s = sizeOf(list);
  System.out.println("The size is " + s);
}
{% endhighlight %}

This method may work or it may not. It will depend on the actual class of `list`. If it will be
`Collection`, the call to `sizeOf` will succeed. Otherwise, there will be a runtime failure.
By looking at the method `calc` we can't tell what is the right way to handle `list` in order
to avoid runtime failure. We need to read the body of `sizeOf` and only then may change `calc`
somehow like this:

{% highlight java %}
public void calc(Iterable<?> list) {
  if (list instanceof Collection) {
    int s = sizeOf(list);
    System.out.println("The size is " + s);
  } else {
    System.out.println("The size is unknown");
  }
}
{% endhighlight %}

This code seems to be OK so far. However, what will happen when `sizeOf` changes its implementation
to something like this (I took it from
[this article]({% pst 2015/apr/2015-04-02-class-casting-is-anti-pattern %})
about casting):

{% highlight java %}
public int sizeOf(Iterable items) {
  int size = 0;
  if (items instanceof Collection) {
    size = ((Collection) items).size();
  } else {
    for (Object item : items) {
      ++size;
    }
  }
  return size;
}
{% endhighlight %}

Now, `sizeOf` perfectly handles any type that's coming in, whether it's an instance
of `Collection` or not. However, the method `calc` doesn't know about the changes made in the method `sizeOf`.
Instead, it still believes that `sizeOf` would break if it gets anything aside from `Collection`.
To keep them in sync we have to remember that `calc` knows too much about `sizeOf`  and
have to modify it when `sizeOf` changes. Thus, it's valid to say that `calc` is
coupled with `sizeOf` and this _coupling_ is hidden:
most probably, we will forget to modify `calc` when `sizeOf` gets a better implementation.
Moreover, there could be many other places in the program similar to `calc`,
which we must remember to modify when the method `sizeOf` changes.
Obvsiously, we will forget about most of them.

This coupling, which is a big maintainability issue, was introduced thanks to the
very existence of reflection in Java. If we would not be able to use `instanceof` operator
and class casting (or would not have them), the coupling would not be possible in the first place.

## Forceful Testing

Consider this code:

{% highlight java %}
class Book {
  private String author;
  private String title;
  Book(String a, String t) {
    this.author = a;
    this.title = t;
  }
  public void print() {
    System.out.println(
      "The book is: " + this.name()
    );
  }
  private String name() {
    return this.title + " by " + this.author;
  }
}
{% endhighlight %}

How would you write a unit test for this class and for its method `print()`?
Obivously, it's almost impossible without a refactoring of the class.
The method `print` sends a text to the console, which we can't easily mock
since it's "static." The right way would be making `System.out` injectable
as a dependency, but some of us believe that reflection is a better option,
which would allow us to test the private method `name` directly, without
calling `print` first:

{% highlight java %}
class BookTest {
  @Test
  void testNamingWorks() {
    Book b = new Book(
      "David West", "Object Thinking"
    );
    Method m = book.getClass().getDeclaredMethod("name");
    m.setAccessible(true);
    assertThat(
      (String) m.invoke(book),
      equalTo("Object Thinking by David West")
    );
  }
}
{% endhighlight %}

You can also use [PowerMock](https://github.com/powermock/powermock) Java library
to do many "beautiful" things with private methods.

The problem with this test is that it is tightly coupled with the object it
tests: the test _knows_ too much about the class `Book`. The test knows that the
class contains a private method `name`. The test also knows that the method `name`
will at some moment be called by the method `print`. Instead of testing `print`
the test tests what it's not supposed to be aware of: the internals of the class `Book`.

The main purpose of a unit test is to be a "safety net" for us
programmers trying to modify the code that was written earlier or much much earlier:
if we break anything, the tests give us a timely signal, "highlighting" the place
where the code was broken. If nothing is highlighted and the tests are green
I can continue modifying the code. I rely on the information from my tests. I trust them.

I take the class `Book` and want to modify it, simply making the method `name`
return `StringBuilder` instead of `String`. It's a pretty
innocent modification, which may be necessary for performance consideration.
Before I start making any changes, I run all tests
(it's a [good practice](https://wiki.c2.com/?TestEveryRefactoring)) and they all pass.
Then, I make my changes expecting no tests to fail:

{% highlight java %}
class Book {
  // ...
  public void print() {
    System.out.println(
      "The book is: " + this.name().toString()
    );
  }
  private StringBuilder name() {
    return new StringBuilder()
      .append(this.title)
      .append(" by ")
      .append(this.author);
  }
}
{% endhighlight %}

However, the test `BookTest` will fail, because it _expects_ my class `Book` having
method `name` that returns `String`. If it's not my test or I wrote it long time ago,
I would be frustrated to learn this fact: the test expects me to write my _private_ methods
only one specific way. Why? What's wrong with returning `StringBuilder`? I would think
that there is some hidden reason for this. Otherwise, why would a test demand anything
from a private implementation of a class? Very soon, after some investigation I would
find out that there is no reason. It's just an assumption the test made about the
internals of `Book` and this assumption has no reasons aside from "We didn't have time
to refactor the class and make `System.out` injectable."

By the way, this testing approach is
[known]({% pst 2018/dec/2018-12-11-unit-testing-anti-patterns %})
as "Inspector" test anti-pattern.

What would I do next? I would have to roll back my changes and then start refactoring
the test _and_ the class, in order to get rid of this assumption. However, changing the
test and at the same time changing main code is,
[I believe](https://twitter.com/yegor256/status/1525758255225528320),
a [dangerous practice](https://stackoverflow.com/questions/1569168):
most probably I will introduce some new bugs.

The tests are not a "safety net" for me anymore. I can't trust them.
I modify the code and I know that I didn't break anything.
However, the test gives me a read signal.
How can I trust it if it lies in such a simple scenario?

This coupling between the unit test `BookTest` and the class `Book`
would not happen if it would not be possible to use reflection in the first place.
If nobody would have any ability to reach the private method anyhow,
the Inspector anti-pattern in unit tests would not be possible.

[Of course]({% pst 2017/feb/2017-02-07-private-method-is-new-class %}),
life would be even better if we would not have private methods.

## Factories

Here is how a typical [factory]({% pst 2017/nov/2017-11-14-static-factory-methods %})
may work:

{% highlight java %}
interface Operator {
  int calc(int a, int b);
}
// This if Factory Method:
Operator make(String name) {
  try {
    return Class.forName("Op" + name);
  } catch (ClassNotFoundException ex) {
    throw new IllegalStateException(ex);
  }
}
{% endhighlight %}

The [factory method]({% pst 2017/nov/2017-11-14-static-factory-methods %})
is `make`. It expects the name of the "operator" to be provided
and then,
using [`Class.forName()`](https://docs.oracle.com/javase/8/docs/api/java/lang/Class.html#forName-java.lang.String-)
from Java Reflection API, constructs the name of the class, finds it in the
[classpath](https://docs.oracle.com/javase/tutorial/essential/environment/paths.html),
and makes an instance of it. Say, there are two classes both implementing the
interface `Operator`:

{% highlight java %}
class OpPlus implements Operator {
  int calc(int a, int b) {
    return a + b;
  }
}
class OpMinus implements Operator {
  int calc(int a, int b) {
    return a + b;
  }
}
{% endhighlight %}

Then, we use them, first asking our factory method to make objects from
operator names:

{% highlight java %}
int result = make("Plus").calc(
  make("Minus").calc(15, 3),
  make("Minus").calc(8, 7)
);
{% endhighlight %}

The `result` will be 13.

We would not be able to do this without reflection. We would have to do this
instead:

{% highlight java %}
int result = new OpPlus().calc(
  new OpMinus().calc(15, 3),
  new OpMinus().calc(8, 7)
);
{% endhighlight %}

If you ask me, this code looks much more readable and maintainable.
First of all, because in any IDE that enables
[code navigation](https://www.jetbrains.com/help/idea/navigating-through-the-source-code.html#go_to_declaration)
it would be possible to click on `OpMinus` or `OpPlus` and immediately
jump to the body of the class. Second, the logic of class finding
is provided out-of-the-box by JVM: I don't need to guess what happens when
`make("Plus")` is called.

There are a few reasons why people love static factories. I don't agree with them.
This [blog post]({% pst 2017/nov/2017-11-14-static-factory-methods %})
explains why. Without reflection it wouldn't be possible to
have static factories at all and the code would be more maintainable and better.

## Annotations

In Java you can attach an annotation
(an instance of a [DTO]({% pst 2016/jul/2016-07-06-data-transfer-object %})-ish interface)
to a class (or an element of it like a method or an argument).
Then, the information from the annotation can be read in runtime or compile time.
In modern frameworks like [Spring](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/beans/factory/annotation/Autowired.html)
this feature is frequently used in order
to automate [objects wiring](https://stackoverflow.com/questions/19414734):
you just attach some annotations to your classes
and the framework will find them, instantiate, place into a
[DI container]({% pst 2014/oct/2014-10-03-di-containers-are-evil %}),
and assign to other objects' attributes.

I've [said it earlier]({% pst 2014/oct/2014-10-03-di-containers-are-evil %})
that this very mechanism of discovering objects and _automatically_
wiring them together is an anti-pattern. I've also [said earlier]({% pst 2016/apr/2016-04-12-java-annotations-are-evil %})
that annotations are also an anti-pattern.

Neither dependency injection containers, not auto-wiring, nor annotations
would not exist if there would be no reflection. Life would be much better
and Java/OOP much cleaner.


## Serialization

When programmers don't understand [object-oriented paradigm]({% pst 2016/jul/2016-07-14-who-is-object %}),
they make [DTOs]({% pst 2016/jul/2016-07-06-data-transfer-object %}) instead of proper objects.
In th
















What did I miss?

















