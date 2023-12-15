---
layout: post
title: "Test Methods Must Share Nothing"
date: 2016-05-03
place: Palo Alto, CA
tags: java oop
category: jcg
description: |
  When we use private static literals to get rid of value
  duplication, unnecessary coupling between test methods
  serously affects maintainability.
keywords:
  - private static final
  - java private static final
  - private static final java
  - code duplication
  - coupling and cohesion
image: /images/2016/05/old-boy.jpg
jb_picture:
  caption: Oldeuboi (2003) by Chan-wook Park
---

Constants... I wrote about them
[some time ago]({% pst 2015/jul/2015-07-06-public-static-literals %}), mostly
saying that they are a bad thing, if being public. They reduce duplication,
but introduce coupling. A much better way to get rid of duplication is
by creating new classes or methods---a traditional OOP method. This seems to make
sense and in our projects I see less and less public constants. In
some projects we don't have them at all. But one thing still bothers me:
unit tests. Most programmers seem to think that when static analysis says
that there are too many similar literals in the same file, the best way
to get rid of them is via a private static literal. This is just wrong.

<!--more-->

{% jb_picture_body %}

Unit tests, naturally, duplicate a lot of code. Test methods contain
similar or almost identical functionality and this is almost inevitable. Well,
we can use more of that [`@Before`](http://junit.sourceforge.net/javadoc/org/junit/Before.html)
and [`@BeforeClass`](http://junit.sourceforge.net/javadoc/org/junit/Before.html) features,
but sometimes it's just not possible. We may have, say, 20 test methods
in one `FooTest.java` file. Preparing all objects in one "before" is not
possible. So we have to do certain things again and again in our test
methods.

Let's take a look at one of the classes in our [Takes Framework](https://www.takes.org):
[`VerboseListTest`](https://github.com/yegor256/takes/blob/0.32.7/src/test/java/org/takes/misc/VerboseListTest.java).
It's a unit test and it has a problem, which I'm trying to tell you about.
Look at that [`MSG`](https://github.com/yegor256/takes/blob/0.32.7/src/test/java/org/takes/misc/VerboseListTest.java#L54)
private literal. It is used for the first time in
[`setUp()`](https://github.com/yegor256/takes/blob/0.32.7/src/test/java/org/takes/misc/VerboseListTest.java#L77-L80) method
as an argument of an object constructor and then in a few
test methods to check how that object behaves. Let me simplify that
code:

```java
class FooTest {
  private static final String MSG = "something";
  @Before
  public final void setUp() throws Exception {
    this.foo = new Foo(FooTest.MSG);
  }
  @Test
  public void simplyWorks() throws IOException {
    assertThat(
      foo.doSomething(),
      containsString(FooTest.MSG)
    );
  }
  @Test
  public void simplyWorksAgain() throws IOException {
    assertThat(
      foo.doSomethingElse(),
      containsString(FooTest.MSG)
    );
  }
}
```

This is basically what is happening in
[`VerboseListTest`](https://github.com/yegor256/takes/blob/0.32.7/src/test/java/org/takes/misc/VerboseListTest.java)
and it's very wrong. Why? Because this shared literal `MSG`
introduced an unnatural coupling between these two test methods.
They have nothing in common, because they test different behaviors
of class `Foo`. But this private constant ties them together. Now they are
somehow related.

If and when I want to modify one of the test methods, I may need
to modify the other one too. Say I want to see how `doSomethingElse()`
behaves if the encapsulated message is an empty string. What do I do?
I change the value of the constant `FooTest.MSG`, which is used by
another test method. This is called coupling. And it's a bad thing.

What do we do? Well, we can use that `"something"` string literal in
both test methods:

```java
class FooTest {
  @Test
  public void simplyWorks() throws IOException {
    assertThat(
      new Foo("something").doSomething(),
      containsString("something")
    );
  }
  @Test
  public void simplyWorksAgain() throws IOException {
    assertThat(
      new Foo("something").doSomethingElse(),
      containsString("something")
    );
  }
}
```

As you see, I got rid of that `setUp()` method and the private static
literal `MSG`. What do we have now? Code duplication. String `"something"`
shows up four times in the test class. No static analyzers will tolerate that.
Moreover, there are seven (!) test methods in
[`VerboseListTest`](https://github.com/yegor256/takes/blob/0.32.7/src/test/java/org/takes/misc/VerboseListTest.java),
which are using `MSG`. Thus, we will have 14 occurrences of `"something"`, right?
Yes, that's right and that's most likely why one of authors of this
test case introduced the constant---to get rid of duplication.
BTW, [@Happy-Neko](https://github.com/Happy-Neko) did that in pull request
[#513](https://github.com/yegor256/takes/pull/513),
[`@carlosmiranda`](https://github.com/carlosmiranda) reviewed the code and I
approved the changes. So, three people made/approved that mistake, including myself.

So what is the right approach that will avoid code duplication and
at the same time won't introduce coupling? Here it is:

```java
class FooTest {
  @Test
  public void simplyWorks() throws IOException {
    final String msg = "something";
    assertThat(
      new Foo(msg).doSomething(),
      containsString(msg)
    );
  }
  @Test
  public void simplyWorksAgain() throws IOException {
    final String msg = "something else";
    assertThat(
      new Foo(msg).doSomethingElse(),
      containsString(msg)
    );
  }
}
```

These literals must be different. This is what any static analyzer is
saying when it sees `"something"` in so many places. It questions us---why
are they the same? Is it really so important to use `"something"` everywhere?
Why can't you use different literals? Of course we can. And we should.

The bottom line is that each test method must have its own set of data and objects. They must
not be shared between test methods ever. Test methods must always be
independent, having nothing in common.

Having that in mind, we can easily conclude that methods like `setUp()` or
any shared variables in test classes are _evil_. They must not be used
and simply must not exist. I think that their invention in JUnit caused
a lot of harm to Java code.

