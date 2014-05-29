---
layout: post
title: "Java Method Logging with AOP and Annotations"
date: 2014-05-25
tags: aop java logging
description:
  ...
keywords:
  - aop java logging
  - log every method java
  - method logging java
  - every method logging java
  - aspect oriented programming java
  - aop annotations
  - aop logging annotations
  - aspectj logging
  - aspectj weaving annotations
---

Sometimes I want to log (through [slf4j](http://www.slf4j.org)
and [log4j](http://logging.apache.org/log4j/2.x/))
every execution of a method, seeing
what arguments it was receiving, what was it returning and how much
time every execution was taking. This is how I'm doing it, with help of
[AspectJ](http://eclipse.org/aspectj/),
[jcabi-aspects](http://aspects.jcabi.com), and
Java 6 annotations:

{% highlight java %}
public class Foo {
  @Loggable
  public int power(int x, int p) {
    return Math.pow(x, p);
  }
}
{% endhighlight %}

This is what I see in log4j output:

{% highlight text %}
[INFO] 12:34:08 com.example.Foo #power(2, 5): 32 in 12μs
[INFO] 12:35:23 com.example.Foo #power(3, 3): 27 in 4μs
{% endhighlight %}

Nice, isn't it? Now, let's see how it works.

## Annotation with Runtime Retention

[Annotations](http://en.wikipedia.org/wiki/Java_annotation)
is a technique introduced in Java 6. It is a meta-programming
instrument that doesn't change the way code works, but gives marks to its certain
elements (methods, classes or variables). Yes, annotations are just markers
attached to our code that can be seen and read.

Some annotations are designed to be seen at compile time only &mdash;
they don't exist in `.class` files after compilation. Others remain
visible after compilation and can be accessed in runtime.

For example,
[`@Override`](http://docs.oracle.com/javase/7/docs/api/java/lang/Override.html)
is of the first type (its retention type is [`SOURCE`](http://docs.oracle.com/javase/7/docs/api/java/lang/annotation/RetentionPolicy.html#SOURCE)),
while
[`@Test`](http://junit.sourceforge.net/javadoc/org/junit/Test.html) from JUnit is
of the second type (retention type is [`RUNTIME`](http://docs.oracle.com/javase/7/docs/api/java/lang/annotation/RetentionPolicy.html#RUNTIME)).

[`@Loggable`](http://aspects.jcabi.com/apidocs-0.15.1/com/jcabi/aspects/Loggable.html)
&mdash; the one I'm using in the script above &mdash;
is an annotation of the second type
from [jcabi-aspects](http://aspects.jcabi.com).
It stays with the bytecode in `.class` file after compilation.

That's all we have at the first step,
after attaching [`@Loggable`](http://aspects.jcabi.com/apidocs-0.15.1/com/jcabi/aspects/Loggable.html) annotation
to method `power()` and compiling the class. The sources are compiled but they
don't send anything to slf4j so far. Method `power()` just contains a marker
saying "please, log my execution".

## Aspect Oriented Programming (AOP)

[AOP](http://en.wikipedia.org/wiki/Aspect-oriented_programming)
is useful technique that enables adding executable blocks to
the source code without explicitly changing it. In our example,
we don't want to log method execution inside the class. Instead,
we want some other class to intercept every call to method `power()`,
measure its execution time, and send this information to slf4j.

This case perfectly fits with the original intent of AOP &mdash;
to avoid re-implementation of some common behavior in multiple classes.
Logging is a supplementary feature to our main functionality and
we don't want to polute our code with multiple logging instructions.
Instead, we want logging to happen behind the scene.

In terms of AOP, our solution can be explained as creating an **aspect** that
**cuts across** the code at certain **join points** and
applies an **around advice** that implements the desired functionality.

## AspectJ

Before we discuss what these magic words mean, lets see how
[AspectJ]() implements them (it's a simplified example, full
code you can see in [MethodLogger.java]()):

{% highlight java %}
@Aspect
public class LogMethods {
  @Around("execution(* *(..)) && @annotation(Loggable)")
  public Object around(ProceedingJoinPoint point) {
    long start = System.currentTimeMillis();
    Object result = point.proceed();
    Logger.info(
      "#%s(): %s in %[msec]s",
      MethodSignature.class.cast(point.getSignature()).getMethod().getName(),
      point.getArgs(),
      System.currentTimeMillis() - start
    );
    return result;
  }
}
{% endhighlight %}

This is an aspect `LogMethods` with a single around advice `around()` inside.
The aspect is annotated with `@Aspect` and advice is annotated with `@Around`.
As discussed above, these annotations are just markers in `.class` files. They
don't do anything except providing some meta-information to
those who are interested.

Annotation `@Around` has one parameter, which in this case say, that
the advice should be applied to a method if:

 1. its visibility modifier is `*` (`public`, `protected` or `private`),

 2. its name is name `*` (any name),

 3. its arguments are `..` (any arguments), and

 4. it is annotated with `@Loggable` annotation

We compile this aspect and make it available in classpath, together
with our main file `Foo.class`. So far so good, but we need to
make one last step in order to put our aspect into action &mdash;
we should "apply" our advice.

## Binary Aspect Weaving

Aspect weaving is a mechanism of modifying original code by
injecting calls to aspects. AspectJ does exactly that. We give it
two binary Java classes `Foo.class` and `LogMethods.class`
and it gives back three &mdash; modified `Foo.class`,
`Foo$AjcClosure1.class` and unmodified `LogMethods.class`.

By the way, since this weaving procedure takes a lot of
configuration efforts, I created a convenient Maven plugin
[jcabi-maven-plugin](http://plugin.jcabi.com) with an `ajc` goal,
which does the entire aspect weaving job:

{% highlight xml %}
<plugin>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-maven-plugin</artifactId>
  <version>0.9.2</version>
  <executions>
    <execution>
      <goals>
        <goal>ajc</goal>
      </goals>
    </execution>
  </executions>
</plugin>
{% endhighlight %}

First, we compile our files using `javac` and get two files. Then,
AspectJ weaves/modifies them and creates its own
extra class.



