---
layout: post
title: "..."
date: 2017-08-29
place: Odessa, Ukraine
tags: oop
description: |
  ...
keywords:
  - object naming
  - naming of classes
  - oop object names
  - object-oriented programming naming
  - how to name a class
---

Some time ago we [were talking]({% pst 2015/mar/2015-03-09-objects-end-with-er %})
about "-ER" suffices in objects/classes
names. We agreed that they are evil and must be avoided, if we want
our code to be truly object-oriented, and objects be objects instead
of collections of procedures. Now I'm ready to introduce a new evil suffix:
"client."

<!--more-->

First, let me give you a few examples of classes with this suffix, which
I'm using in my projects:

  * [`o.a.h.c.HttpClient`](https://hc.apache.org/httpcomponents-client-ga/httpclient/apidocs/org/apache/http/client/HttpClient.html) from [Apache HttpComponents](https://hc.apache.org/) (Java)
  * [`j.w.r.c.Client`](http://docs.oracle.com/javaee/7/api/javax/ws/rs/client/Client.html) from JDK (Java)
  * [`o.s.w.s.c.WebSocketClient`](https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/web/socket/client/WebSocketClient.html) from [Spring Framework](http://spring.io/) (Java)
  * [`Octokit::Client`](http://octokit.github.io/octokit.rb/Octokit/Client.html) from [Octokit](http://octokit.github.io/) (Ruby)
  * [`Aws::S3::Client`](http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Client.html) from [AWS SDK](http://docs.aws.amazon.com/sdkforruby/api/Aws.html) (Ruby)

The "client" suffix implies that there is a "server" somewhere and it's
our responsibility to connect them. We have to create a client, ask it
to do the work with the server and return us the result.

This is very similar to how MVC design pattern works, which is not very
object-oriented, as we
[discussed earlier]({% pst 2016/dec/2016-12-13-mvc-vs-oop %}).
Dealing with the client, which deals with the serverWe play the role of the controller, connecting the dots. This is not
how objects are supposed to be designed in OOP.

Instead, a proper object must _encapsulate_ the logic and become a
_representative_ of a server. Thus, the right suffix is "server."
Or better skip the suffix and name the object by what it actually represents,
like a web page (`Page`), a JAX-RS resource (`Resource`),
a WebSocket (`WebSocket`), a GitHub repository through the API (`Repository`),
or a bucket in AWS S3 (`Bucket`).

This is how most [JCabi libraries](http://www.jcabi.com) (Java) are designed, by the way.
Check
[jcabi-github](http://github.jcabi.com),
[jcabi-dynamo](http://dynamo.jcabi.com),
[jcabi-s3](http://s3.jcabi.com),
or [jcabi-simpledb](http://simpledb.jcabi.com), for example.

