---
layout: post
title: "Why NULL is Evil?"
date: 2014-04-29
tags: quality mistakes
description:
  Why NULL is a terrible practice is object-oriented programming?
  Despite the fact that it is used a lot and everywhere, this
  article encourages you to give up this bad habbit
keywords:
  - object design
  - null pointer
  - why null is bad
  - null is bad
  - best practices null
  - null worst practices
---

A simple example of `NULL` usage in Java:

{% highlight java linenos=table %}
public class Department {
  public Employee getByName(String name) {
    int id = database.find(name);
    if (id == 0) {
      return null;
    }
    return new Employee(id);
  }
}
{% endhighlight %}

What is wrong with this code? Both `name` and return value of `getByName()` may
be unset, or set to `NULL`, which is the same. Why it's bad? There are a few
reasons:

**Additional Code Paths**. Every time you get an object as an  input you must
check whether it is NULL or a valid object reference. If you forget to check, a
Null Pointer Exception (NPE) may break execution in runtime. Thus, your logic
becomes polluted with multiple checks and if/then/else forks.

**Ambiguous Semantic**. To explicitly convey its meaning the  function
`getByName()` has to be named `getByNameOrNullIfNotFound()`. The same should
happen with every function that returns an object or `NULL`. Otherwise,
ambiguity is inevitable for a code reader. Thus, to keep semantic non-ambiguous
you should give longer names to functions.

**Computer Thinking vs. Object Thinking**. Statement `if (employee == null)`  is
understood by someone who knows that an object in Java is a pointer to a data
structure, and than `NULL` is a pointer to nothing (`0x00000000`, in Intel x86
processors). If you start thinking as an object this statement will have less
sense:

{% highlight text %}
- Hello, is it a software department?
- Yes.
- I would like to talk to your employee by the name "Jacky Brown"
- Hold on, please.
- ...
- Are you NULL?
{% endhighlight %}

## Basic Alternatives

First of all, it's [NullObject](http://en.wikipedia.org/wiki/Null_Object_pattern)
design pattern (the best way to make it a constant):

{% highlight java %}
if (id == 0) {
  return Employee.NOBODY;
}
return Employee(id);
{% endhighlight %}

Second, [fail fast](http://martinfowler.com/ieeeSoftware/failFast.pdf) and throw an exception when you can't return anything:

{% highlight java %}
if (id == 0) {
  throw new EmployeeNotFoundException(name);
}
return Employee(id);
{% endhighlight %}

## Temporary NULL

Sometimes `NULL` is the only way, if you don't want to have
[multiple returns](http://www.javapractices.com/topic/TopicAction.do?Id=114):

{% highlight java linenos=table %}
Employee getByName(String name) {
  Employee employee = null;
  for (Employee candidate : this.everybody) {
    if (employee.name().equals(name)) {
      employee = candidate;
      break;
    }
  }
  if (employee == null) {
    throw new EmployeeNotFoundException(name);
  }
  return employee;
}
{% endhighlight  %}

How can we get rid of `NULL` in this example? Use lambda expressions
and streams (in Java8):

{% highlight java linenos=table %}
Employee getByName(String name) {
  Optional<Employee> employee = this.everybody.stream()
    .filter(emp -> emp.name().equals(name))
    .findFirst();
  if (!employee.isPresent()) {
    throw new EmployeeNotFoundException(name);
  }
  return employee.get();
}
{% endhighlight  %}

Other object-oriented languages have their own alternatives:
blocks in Ruby, anonymous functions in PHP, etc. The point here is
that the internals of a method should be done in a functional way, but
not a procedural, as an example above.

## Lazy Loading

`NULL` values are actively used in [lazy loading](http://en.wikipedia.org/wiki/Lazy_loading), for example:

{% highlight java linenos=table %}
public class Department {
  private Employee loaded = null;
  public Employee manager() {
    if (this.loaded == null) {
      this.loaded = new Employee("Jacky Brown");
    }
    return this.loaded;
  }
}
{% endhighlight %}

The solution? Use caching through aspect-oriented programming aspects. For
example,
[jcabi-aspects](http://aspects.jcabi.com) has
[`@Cacheable`](http://aspects.jcabi.com/annotation-cacheable.html)
annotation that caches the value returned by a method:

{% highlight java linenos=table %}
import com.jcabi.aspects.Cacheable;
public class Department {
  @Cacheable(forever = true)
  public Employee manager() {
    return new Employee("Jacky Brown");
  }
}
{% endhighlight %}

## References

I'll try to find more references on this subject. At the moment,
here is the list:

 1. [Tony Hoare, NullReferences, The Billion Dollar Mistake](http://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare)
 1. [Ward Cunningham, Null Considered Harmful](http://c2.com/cgi/wiki?NullConsideredHarmful)
 1. [David West, Object Thinking](http://www.amazon.com/Object-Thinking-DV-Microsoft-Professional-David/dp/0735619654)
