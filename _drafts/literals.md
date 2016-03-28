---
layout: post
title: "..."
date: 2016-03-21
place: Palo Alto, CA
tags: java oop
description:
  When we use private static literals to get rid of values
  duplication, unnecessary coupling serously affects
  maintainability.
keywords:
  - private static final
  - java private static final
  - private static final java
  - code duplication
  - coupling and cohesion
---

Constants... I wrote about them
[some time ago]({% pst 2015/jul/2015-07-06-public-static-literals %}), mostly
saying that they are a bad thing, if being public. They reduce duplication,
but introduce coupling. A much better way to get rid of duplication is
by new classes and methods &mdash; a traditional OOP way. This seems to make
sense and in our projects I see less and less that public constants. In
some projects we don't have them at all. But one thing still bothers me:
unit tests. Most programmers seem to think that when static analysis says
that there are too many similar literals in the same file, the best way
to get rid of them is via a private static literal. It's wrong.

<!--more-->

Unit tests, naturally, duplicate a lot of code. Test methods contain
similar or almost identical functionality and this is almost inevitable. Well,
we can use more of that [`@Before`](http://junit.sourceforge.net/javadoc/org/junit/Before.html)
and [`@BeforeClass`](http://junit.sourceforge.net/javadoc/org/junit/Before.html) features,
but sometimes it's just not possible. We may have, say, 20 test methods
in one `FooTest.java` file and prepare all objects in one "before" is not
possible. So, we have to certain things again and again in our test
methods.

Let's take a look at one of the classes in our [Takes Framework](http://www.takes.org):
[`FkContentTypeTest`](https://github.com/yegor256/takes/blob/0.32.7/src/test/java/org/takes/facets/fork/FkContentTypeTest.java).
It's a unit test and it has a problem, which I'm trying to tell you about.
Look at that [`CONTENT_TYPE`](https://github.com/yegor256/takes/blob/0.32.7/src/test/java/org/takes/facets/fork/FkContentTypeTest.java#L51)
private literal. It is used in five out of six test methods. This is how,
[for example](https://github.com/yegor256/takes/blob/0.32.7/src/test/java/org/takes/facets/fork/FkContentTypeTest.java#L62-L74):

{% highlight java %}
@Test
public void matchesWithAnyTypes() throws IOException {
  MatcherAssert.assertThat(
    new FkContentType("text/xml", new RsEmpty()).route(
      new RqWithHeader(
        new RqFake(),
        FkContentTypeTest.CONTENT_TYPE, // here!
        "*/* "
      )
    ).has(),
    Matchers.is(true)
  );
}
{% endhighlight %}

What's wrong about it?
