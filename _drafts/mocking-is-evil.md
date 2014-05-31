---
layout: post
title: "Mocking Frameworks vs. Mock Classes"
date: 2014-04-18
tags: mocking design
description:
  Mocking frameworks is a bad practice and should be your last resort;
  instead, create and ship mock classes together with your code
keywords:
  - mocking is evil
  - mocks are evil
  - mocking frameworks
  - best practices of mocking
  - java mocking
  - java mock framework
  - why mocking is evil
  - mockito java
  - java mockito example
---

While mock objects is a perfect instrument for unit testing, mocking is a bad practice.

First, let's clarify the definitions. [Wikipedia](http://en.wikipedia.org/wiki/Mock_object)
says that **mock object** is &ldquo;a simulated object that mimics the behavior
of a real object in a controlled way&rdquo;.
There are also "test doubles", "fake objects", "test stubs", and maybe
some other names.

Let's start with a sample code. This is the interface of an employee:

{% highlight java %}
public interface Employee {
  int salary();
  void raise(double ratio);
}
{% endhighlight %}

This is the class of an annual review of an employee:

{% highlight java %}
public class Review {
  private final Employee employee;
  public Review(Employee emp) {
    this.employee = emp;
  }
  void apply() {
    boolean success = /* she was successful this year? */
    if (this.employee.salary() < 50000 && success) {
      this.employee.raise(0.05d);
    }
  }
}
{% endhighlight %}

This is how we're calling it, in production code:

{% highlight java %}
DataSource data = /* JDBC data source of MySQL database */
Employee employee = new MySQLEmployee(data, "Jeff Lebowski");
new Review(employee).apply();
{% endhighlight %}

Let's create a unit test for class `Review`, using [Mockito](http://www.mockito.org)
framework (very popular and well designed):

{% highlight java %}
import org.mockito.Mockito;
public class ReviewTest {
  @Test
  public raisesSalary() {
    Employee employee = Mockito.mock(Employee.class);
    Mockito.doReturn(45000).when(employee).salary();
    new Review(employee).apply();
    Mockito.verify(employee).raise(0.05d);
  }
}
{% endhighlight %}

## Better Readability of Tests

## Reusability Across Tests and Modules


