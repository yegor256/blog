---
layout: post
title: "On the Layout of Tests"
date: 2022-10-24
place: Moscow, Russia
tags: tests
description: |
  What is the right way to keep test classes in a repository?
  There is no single canonical approach, but a few principles may help
  you keep test files in order.
keywords:
  - test methods
  - java test organization
  - how to structure test classes
  - test methods design
  - layout of tests classes
image: /images/2022/11/mimino.jpg
jb_picture:
  caption: Мимино (1977) by Георгий Данелия
---

I don't know what programming language you use, but my experience 
of recent coding in Java, Ruby, JavaScript, PHP, Python, C++, and Rust tells 
me that the principle, which I will try to convince you to adhere to --- 
is universal for all languages. It's about the naming of test files. 
It may look to you like a question of low importance, but let me try 
to demonstrate that it's not. How do you name your files with test classes? How many 
of them do you create in the src/test/java directory? Where do you place
a class that is used only in a test but is not a test by itself? To most of these
questions, the answer most of you would give is "Whatever!"
So let's try to find a better answer.

<!--more-->

{% jb_picture_body %}

The primary purpose of my unit tests is to help me code. They are the 
[safety net]({% pst 2022/jul/2022-07-05-safety-net %}) --- 
they catch me when I make a mistake. For example, let's say I go back and edit a few files that I 
edited a few years ago and, of course, I do it wrong this time. Then, I run all 500 unit tests
in the project, and ... ten of them turn red. Pay attention, I don't say "fail" because, 
just like a safety net around a building, failed tests are the tests 
that didn't catch a falling hammer and didn't spot a bug just introduced.
Thus, 490 of them _failed_, but ten of them _succeeded_.


## Assertions

Next, I scratch my head and think --- what exactly did I do wrong? Which 
file did I break? I just changed a few dozen code lines. Where exactly was the 
mistake? In order to find out, I read the output of the tests. I expect 
the messages they print to the console to be descriptive enough to 
help me understand the problem. I don't want to revert all my changes 
and start from scratch, right? I want to quickly jump to the line with 
the bug, fix it, rerun all 500 tests, see all of them green, 
commit my changes and call it a day.

Needless to say, descriptive messages of test assertions 
and proper naming of test methods are the recipe for success.
Let's consider simple object Phrases, where we add 
a few English phrases, and it magically understands which 
of them are greetings (obviously, using ML).
For such a class, this Java/JUnit5 test would be very bad:

```java
import org.junit.jupiter.api.Test;

@Test
void test1() {
  Phrases p = new Phrases();
  p.add("Hello, world!");
  p.add("London is a capital of Great Britain");
  assert(p.greetings().count() == 1);
}
```

While this test is much better, thanks to [Hamcrest](https://www.hamcrest.org)
assertions (how to name test methods --- is a separate
story explained in detail [here](https://stackoverflow.com/questions/155436/)):

```java
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

@Test
void countsSimpleGreetings() {
  Phrases p = new Phrases();
  p.add("Hello, world!");
  p.add("London is a capital of Great Britain");
  assertThat(
    "Total count of greetings",
    p.greetings().count(), equalTo(1)
  );
}
```

The first snippet will print a pretty obscure error message, while the
second one will help me a lot in my struggle with the bug I just made:
The message will be self-explanatory. I will quickly understand
what the problem is.

## Test Classes

Descriptive messages will help me understand what the problem is.
However, will I know _where_ the problem is? In which Java class? Not really.
Is it in `Phrases.java,` or maybe in `Greetings.java,` which is returned by `Phrases.greetings()`?
I can only get this information from the _name_ of the test class.
If it's called `PhrasesTest.java` --- all bugs that it catches _are most probably_
located in `Phrases.java.` If it's called `GreetingsTest.java` --- ... well, you get the idea.

My point is that the name of a test class is not just a name. It's an instruction
for a wondering programmer:
"Go look into the source file, the name of which you can derive from my name,
removing the `Test` suffix." If I try to follow this instruction and
it leads me nowhere, I get very frustrated, especially if the project
is not mine. I can't get the required information from anywhere else.
The name of the test class is my last hope.

## Very Long Test Classes

What if a test class gets too long? It may have a few dozen or more test methods. We don't
want a class to be too big, right? Wrong! A test class is not a class. It's not even 
a utility class. It's a container for test scripts. It's called a class because
Java (and many other languages) do not have alternative code 
organization instruments. So don't worry about your test classes getting excessively long. 5000 lines of code 
in a test class is _not a problem_ at all. Again, because it's not a class, it's only
a collection of test scripts.

## Test Prerequisites (Wrong Way)

Very often some classes or functions  are not tests,
but must be shared among tests. (I'm sure you know that sharing tests is an
[anti-pattern]({% pst 2018/dec/2018-12-11-unit-testing-anti-patterns %}). Do you?)
Look at how I refactored the unit test from above (it's not elegant
at all, but bear with me for a moment!):

```java
class PhrasesTest {
  @Test
  void countsSimpleGreetings() {
    Phrases p = new Phrases();
    prepare(p);
    assertThat(
      "Total count of greetings",
      p.greetings().count(), equalTo(1)
    );
  }
  private static void prepare(Phrases p) {
    p.add("Hello, world!");
    p.add("London is a capital of Great Britain");
  }
}
```

Here, in private method `prepare(),` I have a convenient builder
of the object of class `Phrases.` This builder may be beneficial
for other tests, such as `GreetingsTest.` I don't want
to copy it from `PhrasesTest` to `GreetingsTest.` Instead, I
want to put it somewhere where it can be reused. This would
be the right place for it (`foo` is the Java
package that all our classes belong to):

```text
src/
  main/
    java/
      foo/
        Phrases.java
        Greetings.java
  test/
    java/
      foo/
        support/
          FooUtils.java
        PhrasesTest.java
        GreetingsTest.java
```

Static method `FooUtils.prepare()` now sits in the `FooUtils` utility
class (a terrible [anti-pattern]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %})!),
which is in the package `foo.support`. But, pay attention, not in the `foo` package, but
in the sub-package that doesn't have a counterpart in the live code block:
there is no directory `src/main/java/foo/support.` This is a clear message
to a programmer who would meet this repository in a few years: all classes
that stay in `foo.support` belong to the test pipeline only and are not tests by
themselves.

## Test Prerequisites (Right Way)

As [you know]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}),
utility classes and [private static methods]({% pst 2017/feb/2017-02-07-private-method-is-new-class %})
are the rudiments of imperative programming. The object-oriented world has better alternatives.
JUnit5, in particular, offers pretty elegant mechanisms for
creating test prerequisites: [test extensions](https://junit.org/junit5/docs/current/user-guide/#extensions-registration).
Everything that a test method needs we supply through its parameters,
which are instantiated by extensions, for example:

```java
import org.junit.jupiter.api.extension.*;

class PhrasesExtension implements ParameterResolver {
  @Override
  public boolean supportsParameter(
    ParameterContext pctx, ExtensionContext ectx) {
    return pctx.getParameter().getType() == Phrases.class;
  }
  @Override
  public Object resolveParameter(
    ParameterContext pctx, ExtensionContext ectx) {
    Phrases p = new Phrases();
    p.add("Hello, world!");
    p.add("London is a capital of Great Britain");
    return p;
  }
}
```

Then, the test will look like this:

```java
import org.junit.jupiter.api.extension.ExtendWith;

@ExtendWith(PhrasesExtension.class)
class PhrasesTest {
  @Test
  void countsSimpleGreetings(Phrases p) {
    assertThat(
      "Total count of greetings",
      p.greetings().count(), equalTo(1)
    );
  }
}
```

Now, the test and its prerequisites stay in two different places and are not
as tightly coupled as they were before. Moreover, the prerequisites may be
easily reused. The magic `@ExtendWith` annotation may be attached to other
tests. The implementation of `PhrasesExtension` may become smarter: it
may start paying attention not only to the type of argument of a test method
but also to a custom annotation attached to it (this is how
[`@TempDir`](https://junit.org/junit5/docs/5.4.1/api/org/junit/jupiter/api/io/TempDir.html) works).

## Fake Objects (Best Way)

Despite the beauty of JUnit extensions, I don't think they are the best way
to decouple prerequisites from test methods. JUnit extensions are still pretty
coupled ... not to test methods, but to the entire test suite of a project. If you
decide to use them somewhere else, in another project, you won't be able to do so.

Also, if you decide to test your prerequisites, you won't be able to do
it elegantly. Of course, you could write tests for them in the same directory, but in this case,
you will brake the principle: one test per one live class.

The solution is: [fake objects]({% pst 2014/sep/2014-09-23-built-in-fake-objects %}).
They stay together with other live objects, but have special "fake" behavior,
for example (BTW, I [don't like factories]({% pst 2017/nov/2017-11-14-static-factory-methods %}),
but in this case, it's OK):

```java
class FactoryOfPhrases {
  public Phrases aboutLondong() {
    Phrases p = new Phrases();
    p.add("Hello, world!");
    p.add("London is a capital of Great Britain");
    return p;
  }
}
```

Then, the test will look like this:

```java
class PhrasesTest {
  @Test
  void countsSimpleGreetings() {
    assertThat(
      "Total count of greetings",
      new FactoryOfPhrases().aboutLondon()
        .greetings().count(),
      equalTo(1)
    );
  }
}
```

Repository layout would look like this:

```text
src/
  main/
    java/
      foo/
        FactoryOfPhrases.java
        Phrases.java
        Greetings.java
  test/
    java/
      foo/
        FactoryOfPhrasesTest.java
        PhrasesTest.java
        GreetingsTest.java
```

Pay attention to the test `FactoryOfPhrasesTest.` It tests the "fake" object `FactoryOfPhrases,`
which is part of the live classes collection. The factory of phases is shipped together
with all other classes. Therefore, it can be used by other projects and not only for test
purposes.

To summarize, as a rule, I suggest keeping test classes clean: only test methods
belong there. No attributes and, of course, no static private methods. Everything
that is a prerequisite must be a "fake" object.

## Integration Tests

In the Maven world, there are unit test classes (`Test` suffix),
and integration test classes (`ITCase` suffix).
The difference is huge. While both are compiled at the `test-compile` phase
by the same `maven-compiler-plugin,` they are not executed together.
Instead, unit tests are executed at the `test` phase. The build fails immediately if
any unit test is red. It's a pretty straightforward approach, which
is similar to other build automation engines.

Integration tests are executed in four steps (these are the names of Maven phases):

```text
pre-integration-test
integration-test
post-integration-test
verify
```

First, the resources needed for integration testing are acquired
at the `pre-integration-test` phase. For example, a test instance of MySQL 
database may be started. Then, the tests with `ITCase` are executed at the ‘integration-test' phase. The 
result of their execution is ignored for now but only recorded in a file. 
Then, the resources are released at the `post-integration-test` phase.
For example, the MySQL server is shut down. Finally, at the `verify` phase, 
the results of the tests are verified, and the build fails if 
some of them are not green.

I keep `ITCase` files together with `Test` files only when they are
integration tests for specific live classes. Very often, they are not --- that's why
they are integration tests. They may integrate and test a number of classes together.
In this case, I put them in a separate package and gave them arbitrary names
that don't match with the names of live classes:

```text
src/
  main/
    java/
      foo/
        Phrases.java
        Greetings.java
  test/
    java/
      foo/
        it/
          SimpleGuessingITCase.java
        PhrasesTest.java
        GreetingsTest.java
        GreetingsITCase.java
```

Here, `GreetingsITCase.java` is an integration test for `Greetings.java,`
while `SimpleGuessingITCase.java` is an integration test for no particular
class. Obviously, the package `foo.it` only exists in tests and is not
present in `src/main/java.`

<br/>

Thus, there is the first rule:
a test class may only have methods
annotated with `@Test` (in the case of Java).

Then, there is the second rule:
a package with tests may only have classes with `Test` or `ITCase` suffices
that map one-to-one to live classes and nothing else.

