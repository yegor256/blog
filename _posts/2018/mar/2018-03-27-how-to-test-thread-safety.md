---
layout: post
title: "How I Test My Java Classes for Thread-Safety"
date: 2018-03-27
place: Moscow, Russia
tags: java
description: |
  Thread-safety is a very important and critical
  quality of some Java objects; here is how it can
  be tested with the help of Cactoos RunInThreads class.
keywords:
  - thread safety
  - test thread safety
  - how to test thread safety
  - thread conflicts
  - thread safety bugs
image: /images/2018/03/scent-of-a-woman.jpg
jb_picture:
  caption: Scent of a Woman (1992) by Martin Brest
---

I touched on this problem in [one of my recent webinars](https://www.youtube.com/watch?v=rC17YwowURQ),
now it's time to explain it in writing. Thread-safety is an important
quality of classes in languages/platforms like Java, where we frequently share
objects between threads. The issues caused by lack of thread-safety
are very difficult to debug, since they are sporadic and almost impossible
to reproduce on purpose. How do you test your objects to make sure
they are thread-safe? Here is how I'm doing it.

<!--more-->

{% jb_picture_body %}

Let us say there is a simple in-memory bookshelf:

```java
class Books {
  final Map<Integer, String> map =
    new ConcurrentHashMap<>();
  int add(String title) {
    final Integer next = this.map.size() + 1;
    this.map.put(next, title);
    return next;
  }
  String title(int id) {
    return this.map.get(id);
  }
}
```

First, we put a book there and the bookshelf returns its ID. Then we can
read the title of the book by its ID:

```java
Books books = new Books();
String title = "Elegant Objects";
int id = books.add(title);
assert books.title(id).equals(title);
```

The class seems to be thread-safe, since we are using the thread-safe
[`ConcurrentHashMap`](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ConcurrentHashMap.html)
instead of a more primitive and non-thread-safe
[`HashMap`](https://docs.oracle.com/javase/8/docs/api/java/util/HashMap.html),
right? Let's try to test it:

```java
class BooksTest {
  @Test
  public void addsAndRetrieves() {
    Books books = new Books();
    String title = "Elegant Objects";
    int id = books.add(title);
    assert books.title(id).equals(title);
  }
}
```

The test passes, but it's just a one-thread test. Let's try to do the
same manipulation from a few parallel threads (I'm using
[Hamcrest](https://github.com/hamcrest/JavaHamcrest)):

```java
class BooksTest {
  @Test
  public void addsAndRetrieves() {
    Books books = new Books();
    int threads = 10;
    ExecutorService service =
      Executors.newFixedThreadPool(threads);
    Collection<Future<Integer>> futures =
      new ArrayList<>(threads);
    for (int t = 0; t < threads; ++t) {
      final String title = String.format("Book #%d", t);
      futures.add(service.submit(() -> books.add(title)));
    }
    Set<Integer> ids = new HashSet<>();
    for (Future<Integer> f : futures) {
      ids.add(f.get());
    }
    assertThat(ids.size(), equalTo(threads));
  }
}
```

First, I create a pool of threads via
[`Executors`](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/Executors.html).
Then I submit ten objects of type
[`Callable`](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/Callable.html) via
`submit()`. Each of them will add a new
unique book to the bookshelf. All of them will be executed, in some
unpredictable order, by some of those ten threads from the pool.

{% youtube rC17YwowURQ %}

Then I fetch the results of their executors through the list of objects
of type
[`Future`](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/Future.html).
Finally, I calculate the amount of unique book IDs
created. If the number is 10, there were no conflicts. I'm using the
[`Set`](https://docs.oracle.com/javase/7/docs/api/java/util/Set.html)
collection in order to make sure the list of IDs contains only
unique elements.

The test passes on my laptop. However, it's not strong enough. The problem
here is that it's not really testing the `Books` from multiple parallel threads.
The time that passes between our calls to `submit()` is large enough to finish
the execution of `books.add()`. That's why in reality only one thread
will run at the same time. We can check that by modifying the code a bit:

```java
AtomicBoolean running = new AtomicBoolean();
AtomicInteger overlaps = new AtomicInteger();
Collection<Future<Integer>> futures =
  new ArrayList<>(threads);
for (int t = 0; t < threads; ++t) {
  final String title = String.format("Book #%d", t);
  futures.add(
    service.submit(
      () -> {
        if (running.get()) {
          overlaps.incrementAndGet();
        }
        running.set(true);
        int id = books.add(title);
        running.set(false);
        return id;
      }
    )
  );
}
assertThat(overlaps.get(), greaterThan(0));
```

With this code I'm trying to see how often threads overlap each other and
do something in parallel. This never happens and `overlaps` is equal to zero.
Thus our test is not really testing anything yet. It just adds ten
books to the bookshelf one by one. If I increase the amount of threads to
1000, they start to overlap sometimes. But we want them to overlap even
when there's a small number of them.
To solve that we need to use
[`CountDownLatch`](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/CountDownLatch.html):

```java
CountDownLatch latch = new CountDownLatch(1);
AtomicBoolean running = new AtomicBoolean();
AtomicInteger overlaps = new AtomicInteger();
Collection<Future<Integer>> futures =
  new ArrayList<>(threads);
for (int t = 0; t < threads; ++t) {
  final String title = String.format("Book #%d", t);
  futures.add(
    service.submit(
      () -> {
        latch.await();
        if (running.get()) {
          overlaps.incrementAndGet();
        }
        running.set(true);
        int id = books.add(title);
        running.set(false);
        return id;
      }
    )
  );
}
latch.countDown();
Set<Integer> ids = new HashSet<>();
for (Future<Integer> f : futures) {
  ids.add(f.get());
}
assertThat(overlaps.get(), greaterThan(0));
```

Now each thread, before touching the books, waits for the permission
given by `latch`. When we submit them all via `submit()` they stay on hold
and wait. Then we release the latch with `countDown()` and they all start
to go, simultaneously. Now, on my laptop, `overlaps` is equal to 3-5 even when `threads`
is 10.

And that last `assertThat()` crashes now! I'm not getting 10 book IDs,
as I was before. It's 7-9, but never 10. The class, apparently, is not thread-safe!

But before we fix the class, let's make our test simpler. Let's use
[`RunInThreads`](http://static.javadoc.io/org.cactoos/cactoos/0.29/org/cactoos/matchers/RunsInThreads.html)
(renamed to just [`Threads`](https://www.javadoc.io/doc/org.cactoos/cactoos/latest/org/cactoos/experimental/Threads.html) in the recent version)
from [Cactoos](https://www.cactoos.org), which does exactly the same as we've done above,
but under the hood:

```java
class BooksTest {
  @Test
  public void addsAndRetrieves() {
    Books books = new Books();
    MatcherAssert.assertThat(
      t -> {
        String title = String.format(
          "Book #%d", t.getAndIncrement()
        );
        int id = books.add(title);
        return books.title(id).equals(title);
      },
      new RunsInThreads<>(new AtomicInteger(), 10)
    );
  }
}
```

{% badge /images/2014/12/java-concurrency-in-practice.png 100 https://amzn.to/2c7sVS1 %}

The first argument of `assertThat()` is an instance of
[`Func`](http://static.javadoc.io/org.cactoos/cactoos/0.29/org/cactoos/Func.html)
(a functional interface), accepting an
[`AtomicInteger`](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/atomic/AtomicInteger.html)
(the first argument of `RunsInThreads`) and returning `Boolean`. This function will
be executed on 10 parallel thread, using the same latch-based approach
as demonstrated above.

This `RunInThreads` seems to be compact and convenient, I'm using it
in a few projects already.

By the way, in order to make `Books` thread-safe we just need to add
`synchronized` to its method `add()`. Or maybe you can suggest a better
solution?

P.S. I learned all this from [Java Concurrency in Practice](https://amzn.to/2c7sVS1)
by Goetz et al.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Do you create unit tests to prove that your classes are thread-safe?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1028678871187640329?ref_src=twsrc%5Etfw">August 12, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
