---
layout: post
title: "Why NULL is Bad?"
date: 2014-05-12
tags: quality mistakes
description:
  Why NULL is a terrible practice is object-oriented programming?
  Despite the fact that it is used a lot and everywhere, this
  article tries to encourage you to give up this bad habbit
keywords:
  - null
  - null java
  - null c++
  - object design
  - null pointer
  - why null is bad
  - why null is bad
  - null is a bad practice
  - null reference is bad
  - worst practices null referece
  - null is bad
  - best practices null
  - null worst practices
---

A simple example of `NULL` usage in Java:

{% highlight java linenos=table %}
public Employee getByName(String name) {
  int id = database.find(name);
  if (id == 0) {
    return null;
  }
  return new Employee(id);
}
{% endhighlight %}

What is wrong with this method?
It may return `NULL` instead of an object &mdash; that's what is wrong.
`NULL` is a terrible practice in object-oriented paradigm
and should be avoided at all cost.

There have been a number of opinions already said about it, including
[Null References, The Billion Dollar Mistake](http://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare)
presentation by Tony Hoare and the entire
[Object Thinking](http://www.amazon.com/Object-Thinking-DV-Microsoft-Professional-David/dp/0735619654)
book by David West. Here, I'll try to summarize all the arguments
and show by example how `NULL` usage can be avoided and replaced
with a proper object-oriented constructs.

Basically, there are two possible alternatives to `NULL`.
First, it is **[Null Object](http://en.wikipedia.org/wiki/Null_Object_pattern)**
design pattern (the best way is to make it a constant):

{% highlight java %}
public Employee getByName(String name) {
  int id = database.find(name);
  if (id == 0) {
    return Employee.NOBODY;
  }
  return Employee(id);
}
{% endhighlight %}

Second possible alternative is to
[fail fast](http://martinfowler.com/ieeeSoftware/failFast.pdf)
by throwing an **Exception** when you can't return an object:

{% highlight java %}
public Employee getByName(String name) {
  int id = database.find(name);
  if (id == 0) {
    throw new EmployeeNotFoundException(name);
  }
  return Employee(id);
}
{% endhighlight %}

Now, let's see what are the arguments against `NULL`. Besides Tony Hoare's
presentation and David West's book mentioned above, I've read these publications
before writing this post:
[Clean Code](http://www.amazon.com/dp/0132350882/) by Robert Martin,
[Code Complete](http://www.amazon.com/dp/0735619670/) by Steve McConnell,
[Say "No" to "Null"](http://elegantcode.com/2010/05/01/say-no-to-null/) by John Sonmez,
[Is returning null bad design?](http://stackoverflow.com/questions/1274792/is-returning-null-bad-design) discussion at StackOverflow.

## Ad-hoc Error Handling

Every time you get an object as an input you must
check whether it is `NULL` or a valid object reference. If you forget to check, a
[`NullPointerException`](http://docs.oracle.com/javase/7/docs/api/java/lang/NullPointerException.html)
(NPE) may break execution in runtime. Thus, your logic
becomes polluted with multiple checks and if/then/else forks:

{% highlight java %}
// this is a terrible design, don't reuse
Employee employee = dept.getByName("Jeffrey");
if (employee == null) {
  System.out.println("can't find an employee");
  System.exit(-1);
} else {
  employee.transferTo(dept2);
}
{% endhighlight %}

This is how exceptional situations are supposed to be handled in
[C](http://en.wikipedia.org/wiki/C_%28programming_language%29) and other
imperative procedural languages. OOP introduced
[exception handling](http://en.wikipedia.org/wiki/Exception_handling) mostly in order to
get rid of these ad-hoc error handling blocks. In OOP we let exceptions
bubble up until they reach an application-wide error handler and our
code becomes much cleaner and shorter:

{% highlight java %}
dept.getByName("Jeffrey").transferTo(dept2);
{% endhighlight %}

Consider `NULL` references an inheritance of procedural programming and
use 1) Null Objects or 2) Exceptions instead.

## Ambiguous Semantic

In order to explicitly convey its meaning, the function
`getByName()` has to be named `getByNameOrNullIfNotFound()`. The same should
happen with every function that returns an object or `NULL`. Otherwise,
ambiguity is inevitable for a code reader. Thus, to keep semantic non-ambiguous
you should give longer names to functions.

To get rid of this ambiguity, always return a real object, a null object
or throw an exception.

Some may argue, that sometimes we have to return `NULL`,
for the sake of perfomance. For example, method `get()` of interface
[`Map`](http://docs.oracle.com/javase/7/docs/api/java/util/Map.html)
in Java returns `NULL` when there is no such item in the map:

{% highlight java %}
Employee employee = employees.get("Jeffrey");
if (employee == null) {
  throw new EmployeeNotFoundException();
}
return employee;
{% endhighlight %}

This code searches the map only once, due to the usage of `NULL` in `Map`. If
we would refactor `Map` the way that its method `get()` will throw an exception
if nothing is found, our code will look like this:

{% highlight java %}
if (!employees.containsKey("Jeffrey")) { // first search
  throw new EmployeeNotFoundException();
}
return employees.get("Jeffrey"); // second search
{% endhighlight %}

Obviously, this is twice as slow as the first one. What to do?

`Map` interface (no offense to its authors) has a wrong design. Its method
`get()` should have been returning an `Iterator`, and our code would look like:

{% highlight java %}
Iterator found = Map.search("Jeffrey");
if (!found.hasNext()) {
  throw new EmployeeNotFoundException();
}
return found.next();
{% endhighlight %}

BTW, that is exactly how C++ STL
[map::find()](http://en.cppreference.com/w/cpp/container/map/find) method is designed.

## Computer Thinking vs. Object Thinking

Statement `if (employee == null)` is understood by someone who
knows that an object in Java is a pointer to a data
structure, and than `NULL` is a pointer to nothing (`0x00000000`, in Intel x86
processors).

However, if you start thinking as an object, this statement will have much less
sense. This is how our code sounds from an object point of view:

{% highlight text %}
- Hello, is it a software department?
- Yes.
- Let me talk to "Jeffrey", your employee
- Hold the line please...
- Hello.
- Are you NULL?
{% endhighlight %}

The last question in this conversation sounds weird, isn't it?

Instead, if they hang up the phone after our request to call Jeffrey,
that will mean a problem for us (Exception).
We will try to call again or inform
our superviser that we can't reach Jeffrey and complete a bigger
transaction.

Otherwise, they may give us some other person, who is not exactly Jeffrey,
but can help with most of our questions or refuse to help
if we need something Jeffrey specific (Null Object).

## Slow Failing

Instead of
[failing fast](http://martinfowler.com/ieeeSoftware/failFast.pdf)
the code above attempts to die slowly, killing others on its way. Instead
of letting everybody know that something went wrong and an exception
handling should start immediately, it is hiding this fact of failure
from its client.

This argument is close to the "ad-hoc error handling" discussed above.
It is a good practice to make your code as fragile as possible, letting
it break when necessary.

Make your methods extremely demanding to the data they manipulate. Let them
complain by throwing exceptions, if the data provided are not good enough or
simply don't fit with the main usage scenario of the method.

Otherwise, return a Null Object, that exposes some common behaviour
and throws exceptions on all other calls:

{% highlight java %}
public Employee getByName(String name) {
  int id = database.find(name);
  Employee employee;
  if (id == 0) {
    employee = new Employee() {
      @Override
      public String name() {
        return "anonymous";
      }
      @Override
      public void transferTo(Department dept) {
        throw new AnonymousEmployeeException(
          "I can't be transferred, I'm anonymous"
        );
      }
    };
  } else {
    employee = Employee(id);
  }
  return employee;
}
{% endhighlight %}

## Mutable and Incomplete Objects

In general, it is highly recommended to design objects with immutability
in mind. That means that an object gets all necessary knowledge during
its instantiating and never changes its state during the entire lifecycle.

Very often `NULL` values are used in
[lazy loading](http://en.wikipedia.org/wiki/Lazy_loading),
to make objects incomplete and mutable,
for example:

{% highlight java %}
public class Department {
  private Employee found = null;
  public synchronized Employee manager() {
    if (this.found == null) {
      this.found = new Employee("Jeffrey");
    }
    return this.found;
  }
}
{% endhighlight %}

This technology, although widely used, is an anti-pattern in OOP. Mostly
because it makes an object responsible for performance problems of the
computational platform, which is something and `Employee` object should
not be aware of.

Instead of managing a state and exposing its business-relevant behavior
an object has to take care of caching
of its own results &mdash; this is what lazy loading is about.
Caching is not something an employee does in the office, isn't he?

The solution? Don't use lazy loading in such a primitive way, as in the example
above. Instead, move this caching problem to another layer of your application.
For example, in Java, you can use aspect-oriented programming aspects.

For example,
[jcabi-aspects](http://aspects.jcabi.com) has
[`@Cacheable`](http://aspects.jcabi.com/annotation-cacheable.html)
annotation that caches the value returned by a method:

{% highlight java %}
import com.jcabi.aspects.Cacheable;
public class Department {
  @Cacheable(forever = true)
  public Employee manager() {
    return new Employee("Jacky Brown");
  }
}
{% endhighlight %}

Hope this analysis was conviencing enough and you
and stop `NULL`-ing your code :)
