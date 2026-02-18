---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Yet Another Evil Suffix For Object Names: Client"
date: 2017-09-12
place: Odessa, Ukraine
tags: oop
description: |
  It is a very popular design idea to create a client for
  a server and expose the entire functionality; this
  leads to procedural code and must be avoided.
keywords:
  - object naming
  - naming of classes
  - oop object names
  - object-oriented programming naming
  - how to name a class
image: /images/2017/09/dont-tempt-me.jpg
jb_picture:
  caption: Sin noticias de Dios (2001) by Agustín Díaz Yanes
buffer:
  - "There are over 160 (!) methods in AmazonS3Client at the time of writing, while it started with only a few dozen just a few hundred versions ago"
  - "The right design would be to replace clients with client-side objects that represent entities of the server side"
---

Some time ago we [were talking]({% pst 2015/mar/2015-03-09-objects-end-with-er %})
about "-ER" suffixes in object and class
names. We agreed that they were evil and must be avoided if we want
our code to be truly object-oriented and our objects to be objects instead
of collections of procedures. Now I'm ready to introduce a new evil suffix:
`Client`.

<!--more-->

{% jb_picture_body %}

Let me give an example first. This is what an object with such a suffix may look like
(it's a pseudo-code version of the
[`AmazonS3Client`](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/s3/AmazonS3Client.html)
from [AWS Java SDK](https://aws.amazon.com/sdk-for-java/)):

```java
class AmazonS3Client {
  createBucket(String name);
  deleteBucket(String name);
  doesBucketExist(String name);
  getBucketAcl(String name)
  getBucketPolicy(String name);
  listBuckets();
  // 160+ more methods here
}
```

All "clients" look similar: they encapsulate the destination URL
with some access credentials and expose a number of methods, which
transport the data to/from the "server." Even though this design
looks like a [proper object]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}),
it doesn't really follow the true spirit of object-orientation.
That's why it's not as maintainable as it should be, for two reasons:

  * **Its scope is too broad**.
  Since the client is an abstraction of a server, it inevitably has to
  represent the server's _entire_ functionality. When the functionality
  is rather limited there is no issue. Take
  [`HttpClient`](https://javadoc.io/doc/org.apache.httpcomponents/httpclient/latest/org/apache/http/client/HttpClient.html)
  from [Apache HttpComponents](https://hc.apache.org/) as an example.
  However, when the server is more complex, the size of the client also
  grows. There are over 160 (!) methods in `AmazonS3Client` at the time of writing, while
  it started with only a few dozen just a few ~~years~~ hundred versions ago.

  * **It is data focused**.
  The very idea of a client-server relationship is about transferring
  data. Take the HTTP RESTful API of the AWS S3 service as
  an example. There are entities on the AWS side: buckets, objects, versions,
  access control policies, etc., and the server turns them into JSON/XML
  data. Then the [data]({% pst 2016/nov/2016-11-21-naked-data %})
  comes to us and the client on our side deals
  with JSON or XML. It inevitably remains _data_ for us and never really becomes
  buckets, objects, or versions.

The consequences depend on the situation, but these are the most probable:

  * **Procedural code**.
  Since the client returns the data, the code that works with that
  data will [most likely]({% pst 2016/nov/2016-11-21-naked-data %})
  be procedural. Look at the results AWS SDK methods
  return, they all look like
  [objects]({% pst 2016/jul/2016-07-14-who-is-object %}), but in reality they are just
  data structures:
  [`S3Object`](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/s3/model/S3Object.html),
  [`ObjectMetadata`](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/s3/model/ObjectMetadata.html),
  [`BucketPolicy`](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/s3/model/BucketPolicy.html),
  [`PutObjectResult`](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/s3/model/PutObjectResult.html), etc.
  They are all [Data Transfer Objects]({% pst 2016/jul/2016-07-06-data-transfer-object %})
  with only
  [getters and setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})
  inside.

  * **Duplicated code**.
  If we actually decide to stay object-oriented we will have to
  turn the data the client returns to us into
  [objects]({% pst 2016/jul/2016-07-14-who-is-object %}). Most likely this
  will lead to code duplication in multiple projects. I had that too,
  when I started to work with S3 SDK. Very soon I realized that in order
  to avoid duplication I'd better create a library that does the job
  of converting S3 SDK data into objects: [jcabi-s3](https://github.com/jcabi/jcabi-s3).

  * **Difficulties with testing**.
  Since the client is in most cases a rather big class/interface, mocking
  it in unit tests or creating its [test doubles/fakes]({% pst 2014/sep/2014-09-23-built-in-fake-objects %})
  is a rather complex task.

  * **Static problems**.
  Client classes, even though their methods are not static, look very similar to
  [utility classes]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}),
  which are well known for being
  [anti-OOP]({% pst 2014/sep/2014-09-10-anti-patterns-in-oop %}). The issues we have
  with utility classes are almost the same as those we have with "client" classes.

  * **Extendability issues**.
  Needless to say, it's almost impossible to
  [decorate]({% pst 2015/feb/2015-02-26-composable-decorators %}) a client
  object when it has 160+ methods and [keeps on growing]({% pst 2014/nov/2014-11-07-how-immutability-helps %}).
  The only possible
  way to add new functionality to it is by creating new methods. Eventually
  we get a [monster class](https://en.wikipedia.org/wiki/God_object)
  that can't be re-used anyhow without modification.

What is the alternative?

The right design would be to replace "clients" with client-side objects
that represent _entities_ of the server side, not the entire server. For example, with the S3 SDK,
that could be `Bucket`, `Object`, `Version`, `Policy`, etc. Each of them
exposes the functionality of real
[buckets](http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html),
[objects](http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingObjects.html) and
[versions](http://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectVersioning.html),
which the AWS S3 can expose.

{% quote The right design would be to replace clients with client-side objects that represent entities of the server side. %}

Of course, we will need a high-level object that somehow represents the
entire API/server, but it should be small. For example, in the S3 SDK example
it could be called `Region`, which means the entire
[AWS region](http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region) with buckets.
Then we could retrieve a bucket from it and won't need a region anymore. Then,
to list objects in the bucket we ask the bucket to do it for us. No need to communicate
with the entire "server object" every time, even though technically such a communication
happens, of course.

To summarize, the trouble is not exactly in the name suffix, but in the very idea
of representing the entire server on the client side rather than its _entities_. Such
an abstraction is 1) too big and 2) very data driven.

BTW, check out some of the [JCabi libraries](https://www.jcabi.com) (Java) for examples
of object-oriented clients without "client" objects:
[jcabi-github](https://github.jcabi.com),
[jcabi-dynamo](https://dynamo.jcabi.com),
[jcabi-s3](http://s3.jcabi.com),
or [jcabi-simpledb](https://simpledb.jcabi.com).
