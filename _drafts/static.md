---
layout: post
title: "A Few Thoughts On Unit Test Scaffolding"
date: 2015-05-24
tags: oop java
description:
  Most unit tests require mocks, stubs and some other
  structures to be prepared before a test can start working,
  here is how I recommend to do that.
keywords:
  - unit test scaffolding
  - unit testing best practices
  - unit testing mocks
  - unit testing stubs
  - unit testing of static
---

When I start to repeat myself in unit test methods, creating
the same objects or basically preparing some data to run the test,
I feel sad about my design. Long test methods with a lot of code
duplication just don't look right. To simplify and shorten them
there are basically two options, well, in Java: 1) private properties
initialized through `@Before` and `@BeforeClass` and 2) private static
methods. They both look anti-OOP to me and I think there is an
alternative. Let me explain.

<!--more-->

Here is what JUnit officially suggests and calls it a
[test fixture](http://junit.org/faq.html#atests_2):

{% highlight java %}
public final class MetricsTest {
  private File temp;
  private Folder folder;
  @Before
  public void prepare() {
    this.temp = Files.createTempDirectory("test");
    this.folder = new DiscFolder(this.temp);
    this.folder.save("first.txt", "hello, world!");
    this.folder.save("second.txt", "good bye!");
  }
  @After
  public void clean() {
    FileUtils.deleteDirectory(this.temp);
  }
  @Test
  public void calculatesTotalSize() {
    assertEquals(22, new Metrics(this.folder).size());
  }
  @Test
  public void countsWordsInFiles() {
    assertEquals(4, new Metrics(this.folder).wc());
  }
}
{% endhighlight %}

I think it's obvious what this test is doing. First, in `prepare()`,
it creates a "test fixture", of type `Folder`. It is used in all three
tests as an argument for `Metrics` constructor. The real class under
test here is `Metrics`, while `this.folder` is something we need
in order to test it.

What's wrong with this test? There is one serious issue &mdash;
**coupling** between test methods. Test methods (and all tests in general)
must be perfectly isolated from each other. This means that changing
one test must not affect any others. In this example it is not the case.
When I want to change `countsWords()` test, I have to change the internals
of `before()`, which will affect the other method in the test "class".

With all due respect to JUnit, the idea of creating test fixtures in
`@Before` and `@After` is wrong, mostly because it encourages
developers to couple test methods.

Here is how we can improve our test and make test methods isolated:

{% highlight java %}
public final class MetricsTest {
  @Test
  public void calculatesTotalSize() {
    final File dir = Files.createTempDirectory("test-1");
    final Folder folder = MetricsTest.folder(
      dir,
      "first.txt:hello, world!",
      "second.txt:good bye!"
    );
    try {
      assertEquals(22, new Metrics(folder).size());
    } finally {
      FileUtils.deleteDirectory(dir);
    }
  }
  @Test
  public void countsWordsInFiles() {
    final File dir = Files.createTempDirectory("test-2");
    final Folder folder = MetricsTest.folder(
      dir,
      "alpha.txt:three words here",
      "beta.txt:two words"
      "gamma.txt:one!"
    );
    try {
      assertEquals(6, new Metrics(folder).wc());
    } finally {
      FileUtils.deleteDirectory(dir);
    }
  }
  private static Folder folder(File dir, String... parts) {
    Folder folder = new DiscFolder(dir);
    for (final String part : parts) {
      final String[] pair = part.split(":", 2);
      this.folder.save(pair[0], pair[1]);
    }
    return folder;
  }
}
{% endhighlight %}

Does it look better now? We're not there yet, but now our test
methods are perfectly isolated. If I want to change one of them,
I'm not going to affect others, because I pass all configuration
parameters to a private static utility (!) method `folder()`.

A utility method, huh? Yes,
[it smells]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}).

The main issue with this design, even though it is way better than
the previous one, is that it doesn't prevent code duplication between
test "classes". If I need a similar test fixture of type `Folder` in
another test case, I will have to move this static method there. Or,
what is even worse, I will have to create a utility class.
Yes, there is [nothing worse]({% pst 2015/feb/2015-02-20-utility-classes-vs-functional-programming %})
in object-oriented programming than utility classes.

A much better design would be to use
["fake" objects]({% pst 2014/sep/2014-09-23-built-in-fake-objects %})
instead of private static. Here is how. First, we create a fake class
and place is into `src/main/java`. This class can be used in tests
and also in production code, if necessary (`Fk` for "fake"):

{% highlight java %}
public final class FkFolder implements Folder, Closeable {
  private final File dir;
  private final String[] parts;
  public FkFolder(String... prts) {
    this(Files.createTempDirectory("test-1"), parts);
  }
  public FkFolder(File file, String... prts) {
    this.dir = file;
    this.parts = parts;
  }
  @Override
  public Iterable<File> files() {
    final Folder folder = new DiscFolder(this.dir);
    for (final String part : this.parts) {
      final String[] pair = part.split(":", 2);
      folder.save(pair[0], pair[1]);
    }
    return folder.files();
  }
  @Override
  public void close() {
    FileUtils.deleteDirectory(this.dir);
  }
}
{% endhighlight %}

Here is how our test will look like now:

{% highlight java %}
public final class MetricsTest {
  @Test
  public void calculatesTotalSize() {
    final String[] parts = {
      "first.txt:hello, world!",
      "second.txt:good bye!"
    };
    try (final Folder folder = new FkFolder(parts)) {
      assertEquals(22, new Metrics(folder).size());
    }
  }
  @Test
  public void countsWordsInFiles() {
    final String[] parts = {
      "alpha.txt:three words here",
      "beta.txt:two words"
      "gamma.txt:one!"
    };
    try (final Folder folder = new FkFolder(parts)) {
      assertEquals(6, new Metrics(folder).wc());
    }
  }
}
{% endhighlight %}

What do you think? Isn't it better than what JUnit is offering?
Isn't it more reusable and extendable than utility methods?

To summarize, I believe that scaffolding in unit testing must be
done through fake objects that are shipped together with production
code.
