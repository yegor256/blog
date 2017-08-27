---
layout: post
title: "Yet Another Evil Suffix For Object Names: Client"
date: 2017-08-29
place: Odessa, Ukraine
tags: oop
description: |
  It is a very popular design idea to create a client for
  a server and expose the entire functionality out; this
  leads to procedural code and must be avoided.
keywords:
  - object naming
  - naming of classes
  - oop object names
  - object-oriented programming naming
  - how to name a class
image: /images/2017/08/...
jb_picture:
  caption: ...
---

Some time ago we [were talking]({% pst 2015/mar/2015-03-09-objects-end-with-er %})
about "-ER" suffices in objects/classes
names. We agreed that they were evil and must be avoided, if we want
our code to be truly object-oriented and objects be objects instead
of collections of procedures. Now I'm ready to introduce a new evil suffix:
`Client`.

<!--more-->

Let me give an example first. This is what an object with such a suffix may look like
(it's a pseudo-coded version of the
[`AmazonS3Client`](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/s3/AmazonS3Client.html)
from [AWS Java SDK](https://aws.amazon.com/sdk-for-java/)):

{% highlight java %}
class AmazonS3Client {
  createBucket(String name);
  deleteBucket(String name);
  doesBucketExist(String name);
  getBucketAcl(String name)
  getBucketPolicy(String name);
  listBuckets();
  // 160+ more methods here
}
{% endhighlight %}

All "clients" look similar: they encapsulate the destination URL
with some access credentials and expose a number of methods, which
transport the data to/from the "server." Even though this design
looks like a [proper object]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}),
it doesn't really have a true spirit of object-orientation.
That's why it is not as maintainable as it should be, for two reasons:

  * **Its scope is too broad**.
  Since the client is an abstraction of a server, it inevitably has to
  represent the _entire_ functionality of it. When the functionality
  is rather limited, there is no issue, take
  [`HttpClient`](https://hc.apache.org/httpcomponents-client-ga/httpclient/apidocs/org/apache/http/client/HttpClient.html)
  from [Apache HttpComponents](https://hc.apache.org/) as an example.
  However, when the server is more complex, the size of the client also
  grows. There are over 160 (!) methods in `AmazonS3Client` now, while
  they started with only a few dozens just a few <del>years</del> hundred versions ago.

  * **It is data focused**.
  The very idea of a client-server relationship is about transferring
  data between them. Take HTTP RESTful API of the AWS S3 service as
  an example. There are entities on that side: buckets, objects, versions,
  access control policies, etc. The server on the AWS side turns them into JSON/XML
  data. Then, the data arrives to us and the client on our side deals
  with JSON or XML. They inevitably remain _data_ for us and never really become
  buckets, objects, or versions.

The consequences depend on the situation, but these are the most probable
of them:

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
  They all are [Data Transfer Objects]({% pst 2016/jul/2016-07-06-data-transfer-object %})
  with only
  [getters and setters]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %})
  inside.

  * **Duplicated code**.
  If we actually decide to stay object-oriented, we will have to
  turn the data the client returns us into
  [objects]({% pst 2016/jul/2016-07-14-who-is-object %}). Most likely this
  will lead to code duplication in multiple projects. I had that too,
  when started to work with S3 SDK. Very soon I realized that in order
  to avoid duplication I better create a library that does the job
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
  with utility classes are almost the same to what we have with "client" classes.

  * **Extendability issues**.
  Needless to say that it's almost impossible to
  [decorate]({% pst 2015/feb/2015-02-26-composable-decorators %}) a client
  object when it has 160+ methods, and it keeps growing. The only possible
  way to add new functionality to it is by creating new methods. Eventually
  we get a monster class that can't be re-used anyhow without modification.

What is the alternative?

The right design would be to replace "clients" with client-side objects
that represent _entities_ of the server side, not the entire server. For example, with the S3 SDK,
that could be `Bucket`, `Object`, `Version`, `Policy`, etc. Each of them
exposes the functionality of real buckets, objects and versions, which the AWS S3
can expose.

Of course, we will need a high-level object that somehow represents the
entire API/server, but it needs to be small. For example, in the S3 SDK example
it could be called `Region`, which means the entire S3 region with buckets.
Then, we retrieve a bucket from it and don't need a region anymore. Then,
to list objects in the bucket we ask the bucket to do that. No need to communicate
with the entire server object every time, even though technically such a communication
happens, of course.

To summarize, the trouble is not in the name suffix, but in the very idea
to represent the entire server on the client side, not its entities. Such
an abstraction is 1) too big and 2) very data driven.

BTW, check some of the [JCabi libraries](http://www.jcabi.com) (Java),
they are object-oriented clients without "client" objects:
[jcabi-github](http://github.jcabi.com),
[jcabi-dynamo](http://dynamo.jcabi.com),
[jcabi-s3](http://s3.jcabi.com),
or [jcabi-simpledb](http://simpledb.jcabi.com).

