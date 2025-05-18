---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Fast Tests Help Humans, Deep Tests Help Servers"
date: 2023-08-22
place: Kazan, Russia
tags: testing java
description: |
  Humans should run "fast" tests to catch obvious mistakes, while
  servers should execute "deep" tests to ensure the highest quality.
keywords:
  - fast tests
  - unit tests
  - thorough tests
  - slow tests
  - fast tests
image: /images/2023/08/inglourious-basterds.jpg
jb_picture:
  caption: Inglourious Basterds (2009) by Quentin Tarantino
---

In order to reveal errors of higher complexity, automated tests are
turned into integration tests that involve external resources in test
scenarios, instead of their mocks. While this approach improves test
coverage, it slows down the entire build pipeline. This compromises
the very idea of automated tests, which are meant to be a
[safety net]({% pst 2022/jul/2022-07-05-safety-net %})
and help programmers edit code safely. Splitting the tests into "fast"
and "deep," and then allowing humans to run the former while servers
run the latter, might be a good solution to the problem.

<!--more-->

{% jb_picture_body %}

Consider this Java code with a simple `toString()` static method:

```java
static String toString(InputStream stream) throws IOException {
  final StringBuilder buf = new StringBuilder();
  while (true) {
    int d = stream.read();
    if (d == -1) {
      break;
    }
    buf.append((char) d);
  }
  return buf.toString();
}
```

It reads the `stream` byte by byte, appends them to the buffer, and
returns the buffer to the client. Here is the JUnit5 test that validates
the functionality:

```java
@Test
void readsSomeData() throws IOException {
  Assertions.assertEquals(
    "ABC",
    toString(
      new ByteArrayInputStream(
        new byte[] {0x41, 0x42, 0x43}
      )
    )
  );
}
```

So far, so good. The test works, and the method seems to be correct. Moreover, the test
completes very quickly---just 5ms on my laptop. However, upon closer
inspection, we can identify a bug in the method: it doesn't close the
input stream. This issue doesn't impact the test because the input
stream is in memory and doesn't hold any valuable resources that might leak.
However, if we introduce a new test, it will expose this problem:

```java
@Test
void readsFromManyFiles(@TempDir Path tmp) throws IOException {
  Path f = tmp.resolve("test.txt");
  Files.write(f, "Hello, world!".getBytes());
  for (int i = 0; i < 20000; ++i) {
    Assertions.assertEquals(
      13,
      toString(new FileInputStream(f.toFile())).length()
    );
  }
}
```

When I run this test, I get a `FileNotFoundException` with a message saying
`Too many open files`. If I reduce the upper limit in the for loop to 10000,
the error disappears. This most definitely happens because the maximum number of open files
on Mac OS X [is 12,288](https://superuser.com/a/443168). However, on Ubuntu,
this limit is [set to 65536](https://askubuntu.com/questions/1049058). Thus, my test
won't spot an error if I run it on Ubuntu. I'm sure you know how to fix this error in the toString() method.

Obviously, the second test is much slower than the first one, taking
650ms on my laptop (130 times slower!). This is just an example of a test that
aids in bug detection but is time-consuming. Typically, integration tests
demonstrate such a negative impact on performance because they involve "external"
resources, which are slow. The file system, used by the second test, is one such external resource.

650ms might not be problematic when there are only a few test methods in
a young project. However, as the number of tests increases, slow tests
quickly become an issue since the overall build time lengthens, frustrating
programmers. Automated tests, meant to assist coders, turn into a hindrance.
If a coder has to wait several minutes after every code change to ensure nothing broke,
frustration ensues. Often, the frustrated coder might remove those slow tests.

{% quote It's impossible to make integration tests faster since they are inherently slow for a reason. %}

It goes without saying that deleting slow tests isn't the solution.
So, what is? Speeding them up? Not quite. It's almost always challenging,
if not impossible, to make integration tests faster since they are inherently
slow for a reason. The only way to speed them up is to mock those slow
external resources. But these resources are tested specifically to detect
bugs that unit tests might miss. For instance, in our case, if we mock
the input stream, the second test will miss the bug. Therefore, the
second (integration) test must be slow to be valuable.

> Once the commit build is good then other people can work on the code with confidence. However there are further, slower, tests that we can start to do. Additional machines can run further testing routines on the build that take longer to do.---[Martin Fowler](https://martinfowler.com/articles/continuousIntegration.html)

Classifying tests into _fast_ and _deep_ may be a solution. The first category comprises
tests that mock as much as possible and take no more than 20ms to run.
The second category consists of tests that probe deeper to uncover elusive bugs,
which might be overlooked by faster tests. More often than not, unit tests
fall into the first category, while integration tests fit into the second.
The distinction of "unit-vs-integration" is, in my view, misleading. "Fast-vs-deep"
is much clearer since it's evident to which category a test belongs.
If a test takes under 20ms, it's fast; if not, it's deep.

Once tests are designated as either fast or deep, they should be run in two
distinct scenarios: programmers run the fast tests during coding,
while servers execute the deep tests during software build and/or release phases.
In JUnit5, this categorization can be achieved using the @Tag annotation:

```java
@Test
@Tag("fast")
void readsSomeData() throws IOException {
  // ...
}
@Test
@Tag("deep")
void readsFromManyFiles(@TempDir Path tmp) throws IOException {
  // ...
}
```

In most cases, obvious bugs will be detected by fast tests, giving programmers
confidence when editing the code. On the rare occasions when fast tests
fail to identify certain bugs, the deep tests will catch them. Only then
will programmers run the slow tests on their laptops.

This is how `pom.xml` may be configured to turn "fast" tests ON, by default:

```xml
<plugin>
  <artifactId>maven-surefire-plugin</artifactId>
  <configuration>
    <groups>fast</groups>
  </configuration>
</plugin>
```

In the CI environment, Maven must be started with the following flag:

```
$ mvn test -Dgroups=slow
```

A programmer can also run the "slow" tests on their own laptop using
the same command line flag. However, this will typically only be done
when the server issues a red signal.

P.S. By the way, the `toString()` method has another bug that
isn't detected by either the first or second test. Can you identify it?
Could you devise a test that would expose this bug?
Would you categorize this test as "fast" or "deep"?
