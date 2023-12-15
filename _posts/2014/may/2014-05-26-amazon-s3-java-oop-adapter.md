---
layout: post
title: "Object-Oriented Java Adapter of Amazon S3 SDK"
date: 2014-05-26
tags: aws java
description: |
  jcabi-s3 is an object-oriented Java adapter for Amazon S3
  that simplifies basic read and write operations and
  makes them truly object-oriented
keywords:
  - amazon s3 java
  - s3 java
  - s3 java api
  - s3 java client
  - s3 java example
  - s3 java api example
  - s3 java adapter
  - s3 java object-oriented
---

{% badge /images/2014/05/s3-logo.png 150 %}

I'm a big fan of Amazon Web Services (AWS). I'm using them
in almost all of my projects. One of their most popular
services is [Simple Storage Service (S3)](http://aws.amazon.com/s3/).
It is a storage for binary objects (files) with unique names,
accessible through HTTP or RESTful API.

Using S3 is very simple. You create a "bucket" with a unique name,
upload your "object" into the bucket through their web interface or
through RESTful API, and then download it again (either through HTTP or the API.)

Amazon ships the [Java SDK](https://aws.amazon.com/sdkforjava/)
that wraps their RESTful API. However, this SDK is not object-oriented
at all. It is purely imperative and procedural---it just mirrors the API.

For example, in order to download an existing object `doc.txt`
from bucket `test-1`, you have to do something like this:

```java
AWSCredentials creds = new BasicAWSCredentials(key, secret);
AmazonS3 aws = new AmazonS3Client(creds);
S3Object obj = aws.getObject(
  new GetObjectRequest("test-1", "doc.txt")
);
InputStream input = obj.getObjectContent();
String content = IOUtils.toString(input, "UTF-8");
input.close();
```

{% badge https://www.jcabi.com/logo-square.svg 64 %}

As always, procedural programming has its inevitable
disadvantages. To overcome them all, I designed
[jcabi-s3](http://s3.jcabi.com), which is a small
object-oriented adapter for Amazon SDK. This is how the same
object-reading task can be accomplished with [jcabi-s3](http://s3.jcabi.com):

```java
Region region = new Region.Simple(key, secret);
Bucket bucket = region.bucket("test-1");
Ocket ocket = bucket.ocket("doc.txt");
String content = new Ocket.Text(ocket).read();
```

Why is this approach better? Well, there are a number of obvious advantages.

<!--more-->

## S3 Object is an Object in Java

S3 object get its representative in Java. It is not
a collection of procedures to be called in order to
get its properties (as with AWS SDK). Rather, it is a Java object
with certain behaviors. I called them "ockets" (similar to "buckets"),
in order to avoid clashes with `java.lang.Object`.

[`Ocket`](http://s3.jcabi.com/apidocs-0.5/com/jcabi/s3/Ocket.html) is
an interface, that exposes the behavior of a real AWS S3 object:
read, write, check existence. There is also a convenient decorator
`Ocket.Text` that simplifies working with binary objects:

```java
Ocket.Text ocket = new Ocket.Text(ocket_from_s3);
if (ocket.exists()) {
  System.out.print(ocket.read());
} else {
  ocket.write("Hello, world!");
}
```

Now, you can pass an object to another class, instead of giving it
your AWS credentials, bucket name, and object name. You simply pass
a Java object, which encapsulates all AWS interaction details.

## Extendability Through Decoration

Since [jcabi-s3](http://s3.jcabi.com) exposes all entities
as interfaces, they can easily be extended through encapsulation
([Decorator Pattern](https://en.wikipedia.org/wiki/Decorator_pattern)).

For example, you want your code to retry S3 object read operations
a few times before giving up and
[throwing]({% pst 2015/dec/2015-12-01-rethrow-exceptions %}) an `IOException`
(by the way, this is a very good practice when working with web services).
So, you want all your S3 reading operations to be redone a few times
if first attempts fail.

You define a new decorator class, say, `RetryingOcket`,
which encapsulates an original `Ocket`:

```java
public RetryingOcket implements Ocket {
  private final Ocket origin;
  public RetryingOcket(Ocket ocket) {
    this.origin = ocket;
  }
  @Override
  public void read(OutputStream stream) throws IOException {
    int attempt = 0;
    while (true) {
      try {
        this.origin.read(stream);
      } catch (IOException ex) {
        if (attempt++ > 3) {
          throw ex;
        }
      }
    }
  }
  // same for other methods
}
```

Now, everywhere where `Ocket` is expected you send
an instance of `RetryingOcket` that wraps your original object:

```java
foo.process(new RetryingOcket(ocket));
```

Method `foo.process()` won't see a difference, since
it is the same `Ocket` interface it is expecting.

By the way, this retry functionality is implemented
out-of-the-box in [jcabi-s3](http://s3.jcabi.com),
in [`com.jcabi.s3.retry`](http://s3.jcabi.com/apidocs-0.5/com/jcabi/s3/retry/package-summary.html) package.

## Easy Mocking

Again, due to the fact that all entities in
[jcabi-s3](http://s3.jcabi.com) are interfaces, they are
very easy to mock. For example, your class expects an
S3 object, reads its data and calculates the MD5
hash (I'm using [`DigestUtils`](http://commons.apache.org/proper/commons-codec/apidocs/org/apache/commons/codec/digest/DigestUtils.html)
from [commons-codec](http://commons.apache.org/proper/commons-codec/)):

```java
import com.jcabi.s3.Ocket;
import org.apache.commons.codec.digest.DigestUtils;
public class S3Md5Hash {
  private final Ocket ocket;
  public S3Md5Hash(Ocket okt) {
    this.ocket = okt;
  }
  public hash() throws IOException {
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    this.ocket.read(baos);
    return DigestUtils.md5hex(baos.toByteArray());
  }
}
```

Here is how simple a unit test will look (try to create
a unit test for a class using AWS SDK and you will see the difference):

```java
import com.jcabi.s3.Ocket;
import org.junit.Test;
public class S3Md5HashTest {
  @Test
  public void generatesHash() {
    Ocket ocket = Mockito.mock(Ocket.class);
    Mockito.doAnswer(
      new Answer<Void>() {
        public Void answer(final InvocationOnMock inv) throws IOException {
          OutputStream.class.cast(inv.getArguments()[0]).write(' ');
        }
      }
    ).when(ocket).read(Mockito.any(OutputStream.class));
    String hash = new S5Md5Hash(ocket);
    Assert.assertEquals(hash, "7215ee9c7d9dc229d2921a40e899ec5f");
  }
}
```

I'm using [JUnit](http://junit.org/) and [Mockito](https://code.google.com/p/mockito/) in this test.

## Immutability

All classes in [jcabi-s3](http://s3.jcabi.com) are
annotated with [`@Immutable`](https://aspects.jcabi.com/annotation-immutable.html)
and are truly immutable.

The library ships as a JAR dependency in
[Maven Central](https://repo1.maven.org/maven2/com/jcabi/jcabi-s3)
(get its latest versions in [Maven Central](http://search.maven.org/)):

```xml
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-s3</artifactId>
</dependency>
```

As always, your comments and criticism are welcome as
[GitHub issues](https://github.com/jcabi/jcabi-s3/issues).
