---
layout: post
title: "Java Method Logging with AOP and Annotations"
date: 2014-06-01
tags: aop java jcabi
categories: jcg
description: |
  For traceability and debugging purposes, it can be very
  convenient to log execution details of every method.
  This article explains how this can be done with AspectJ
  and Java annotations.
keywords:
  - aop annotations
  - aop java logging
  - aop logging annotations
  - aop logging java
  - aspect oriented programming java
  - aspectj logging
  - aspectj weaving annotations
---

Sometimes, I want to log (through [slf4j](http://www.slf4j.org)
and [log4j](http://logging.apache.org/log4j/2.x/)) every execution
of a method, seeing what arguments it receives, what
it returns and how much time every execution takes.
This is how I'm doing it, with help of [AspectJ](http://eclipse.org/aspectj/),
[jcabi-aspects](http://aspects.jcabi.com) and Java 6
[annotations]({% pst 2016/apr/2016-04-12-java-annotations-are-evil %}):

```java
public class Foo {
  @Loggable
  public int power(int x, int p) {
    return Math.pow(x, p);
  }
}
```

This is what I see in log4j output:

```text
[INFO] com.example.Foo #power(2, 10): 1024 in 12μs
[INFO] com.example.Foo #power(3, 3): 27 in 4μs
```

Nice, isn't it? Now, let's see how it works.

<!--more-->

## Annotation with Runtime Retention

[Annotations](http://en.wikipedia.org/wiki/Java_annotation) is
a technique introduced in Java 6. It is a meta-programming
instrument that doesn't change the way code works, but gives
marks to certain elements (methods, classes or variables).
In other words, annotations are just markers attached to the code
that can be seen and read. Some annotations are designed to be
seen at compile time only---they don't exist in `.class` files after
compilation. Others remain visible after compilation and can
be accessed in runtime.

{% youtube 4SRoLYxvIQ8 %}

For example,
[`@Override`](http://docs.oracle.com/javase/7/docs/api/java/lang/Override.html) is of
the first type (its retention type is [`SOURCE`](http://docs.oracle.com/javase/7/docs/api/java/lang/annotation/RetentionPolicy.html#SOURCE)), while [`@Test`](http://junit.sourceforge.net/javadoc/org/junit/Test.html) from JUnit is of the second type (retention type is [`RUNTIME`](http://docs.oracle.com/javase/7/docs/api/java/lang/annotation/RetentionPolicy.html#RUNTIME)).
[`@Loggable`](http://aspects.jcabi.com/apidocs-0.15.1/com/jcabi/aspects/Loggable.html)---the one I'm using in the script above---is an annotation of the second type,
from [jcabi-aspects](http://aspects.jcabi.com).
It stays with the byte-code in the `.class` file after compilation.

Again, it is important to understand that even though
method `power()` is annotated and compiled, it doesn't
send anything to slf4j so far. It just contains
a marker saying "please, log my execution."

## Aspect Oriented Programming (AOP)

[AOP](http://en.wikipedia.org/wiki/Aspect-oriented_programming)
is a useful technique that enables adding executable blocks
to the source code without explicitly changing it. In our example,
we don't want to log method execution inside the class. Instead,
we want some other class to intercept every call to method `power()`,
measure its execution time and send this information to slf4j.

We want that interceptor to understand our `@Loggable` annotation
and log every call to that specific method `power()`. And, of course,
the same interceptor should be used for other methods where
we'll place the same annotation in the future.

This case perfectly fits the original intent of AOP---to avoid re-implementation of some common behavior in multiple classes.

Logging is a supplementary feature to our main functionality,
and we don't want to pollute our code with multiple logging
instructions. Instead, we want
[logging]({% pst 2014/may/2014-05-23-avoid-java-static-logger %})
to happen behind the scenes.

In terms of AOP, our solution can be explained as creating
an **aspect** that **cross-cuts** the code at certain
**join points** and applies an **around advice** that
implements the desired functionality.

## AspectJ

Let's see what these magic words mean. But, first,
let's see how [jcabi-aspects](http://aspects.jcabi.com)
implements them using [AspectJ](http://eclipse.org/aspectj/)
(it's a simplified example, full code you can find in
[`MethodLogger.java`](https://github.com/jcabi/jcabi-aspects/blob/jcabi-0.15.2/src/main/java/com/jcabi/aspects/aj/MethodLogger.java)):

```java
@Aspect
public class MethodLogger {
  @Around("execution(* *(..)) && @annotation(Loggable)")
  public Object around(ProceedingJoinPoint point) {
    long start = System.currentTimeMillis();
    Object result = point.proceed();
    Logger.info(
      "#%s(%s): %s in %[msec]s",
      MethodSignature.class.cast(point.getSignature()).getMethod().getName(),
      point.getArgs(),
      result,
      System.currentTimeMillis() - start
    );
    return result;
  }
}
```

This is an **aspect** with a single **around advice**
`around()` inside. The aspect is annotated with `@Aspect`
and advice is annotated with `@Around`. As discussed above,
these annotations are just markers in `.class` files. They don't do
anything except provide some meta-information to those who are interested in runtime.

Annotation `@Around` has one parameter, which---in this case---says that the advice should be applied to a method if:

 1. its visibility modifier is `*` (`public`, `protected` or `private`);

 2. its name is `*` (any name);

 3. its arguments are `..` (any arguments); and

 4. it is annotated with `@Loggable`

When a call to an annotated method is to be intercepted,
method `around()` executes before executing the actual method.
When a call to method `power()` is to be intercepted, method `around()`
receives an instance of class `ProceedingJoinPoint` and must return an
object, which will be used as a result of method `power()`.

In order to call the original method, `power()`, the advice has
to call `proceed()` of the **join point** object.

We compile this aspect and make it available in classpath
together with our main file `Foo.class`. So far so good,
but we need to take one last step in order to put
our aspect into action---we should **apply** our advice.

## Binary Aspect Weaving

Aspect weaving is the name of the advice applying process.
Aspect weaver modifies original code by injecting calls to aspects.
AspectJ does exactly that. We give it two binary Java classes `Foo.class`
and `MethodLogger.class`; it gives back three---modified
`Foo.class`, `Foo$AjcClosure1.class` and unmodified `MethodLogger.class`.

{% quote Without weaving, both classes and aspects are just compiled Java binaries with attached annotations %}

In order to understand which advice should be applied to which methods,
AspectJ weaver is using annotations from `.class` files.
Also, it uses [reflection](http://docs.oracle.com/javase/tutorial/reflect/)
to browse all classes on classpath. It analyzes which methods satisfy
the conditions from the `@Around` annotation.
Of course, it finds our method `power()`.

So, there are two steps. First, we compile our `.java` files using
`javac` and get two files. Then, AspectJ weaves/modifies them and
creates its own extra class. Our `Foo` class looks something
like this after weaving:

```java
public class Foo {
  private final MethodLogger logger;
  @Loggable
  public int power(int x, int p) {
    // Prepares the "point" object
    return this.logger.around(point);
  }
  private int power_aroundBody(int x, int p) {
    return Math.pow(x, p);
  }
}
```

AspectJ weaver moves our original functionality to a new method,
`power_aroundBody()`, and redirects all `power()` calls
to the aspect class `MethodLogger`.

Instead of one method `power()` in class `Foo` now we have
four classes working together. From now on,
this is what happens behind the scenes on every call to `power()`:

{% plantuml %}
hide footbox
skinparam sequence {
  ArrowFontName "Courier New"
  ArrowFontSize 17
  ParticipantFontName "Courier New"
  ParticipantFontSize 17
  ActorFontSize 17
}

actor "Client" as client
participant "Foo" as foo
participant "MethodLogger" as aspect
participant "JoinPoint" as point
participant "Foo$AjcClosure1" as closure

client -> foo : power()
activate foo
foo -> aspect : around()
activate aspect
aspect -> point : proceed()
activate point
point -> closure : run()
activate closure
closure -> foo : power_aroundBody()
activate foo #228b22
foo --> closure
deactivate foo
closure --> point
deactivate closure
point --> aspect
deactivate point
aspect --> foo
deactivate aspect
foo --> client
deactivate foo
{% endplantuml %}

Original functionality of method `power()` is indicated
by the small green lifeline on the diagram.

As you see, the aspect weaving process connects together classes
and aspects, transferring calls between them through join points.
Without weaving, both classes and aspects are just
compiled Java binaries with attached annotations.

# jcabi-aspects

[jcabi-aspects](http://aspects.jcabi.com) is a JAR library
that contains `Loggable` annotation and `MethodLogger`
aspect (btw, there are [many more](http://aspects.jcabi.com)
aspects and annotations). You don't need to write your own
aspect for method logging. Just add a few dependencies to
your classpath and configure [jcabi-maven-plugin](http://plugin.jcabi.com)
for aspect weaving
(get their latest versions in [Maven Central](http://search.maven.org/)):

```xml
<project>
  <dependencies>
    <dependency>
      <groupId>com.jcabi</groupId>
      <artifactId>jcabi-aspects</artifactId>
    </dependency>
    <dependency>
      <groupId>org.aspectj</groupId>
      <artifactId>aspectjrt</artifactId>
    </dependency>
  </dependencies>
  <build>
    <plugins>
      <plugin>
        <groupId>com.jcabi</groupId>
        <artifactId>jcabi-maven-plugin</artifactId>
        <executions>
          <execution>
            <goals>
              <goal>ajc</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
</project>
```

Since this weaving procedure takes a lot of configuration effort,
I created a convenient Maven plugin with an `ajc` goal, which does
the entire aspect weaving job. You can use AspectJ directly, but
I recommend that you use [jcabi-maven-plugin](http://plugin.jcabi.com).

That's it. Now you can use [`@com.jcabi.aspects.Loggable`](http://aspects.jcabi.com/apidocs-0.15.1/com/jcabi/aspects/Loggable.html)
annotation and your methods will be logged through slf4j.

If something doesn't work as explained, don't hesitate to
submit a [GitHub issue](https://github.com/jcabi/jcabi-aspects/issues).
