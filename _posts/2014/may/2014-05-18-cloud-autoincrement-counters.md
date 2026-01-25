---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Atomic Counters at Stateful.co"
date: 2014-05-18
tags: pets aws
place: Amsterdam, Holland
description: |
  The article explains how stateful.co atomic counters
  implement auto-increment functionality that
  is missing in, say, AWS DynamoDB
keywords:
  - stateful counters
  - auto increment dynamodb
  - dynamodb auto increment
  - nosql auto increment
  - auto increment online
  - cloud autoincrement counter
---

{% badge /images/2014/04/dynamodb-logo.png 150 %}

Amazon DynamoDB is a great NoSQL cloud database. It is cheap,
highly reliable and rather powerful. I'm using it in many web systems.

There is one feature that it lacks, though---auto-increment attributes.

Say that you have a table with a list of messages:

```text
+------+----------------------------+
| id   | Attributes                 |
+------+----------------------------+
| 205  | author="jeff", text="..."  |
| 206  | author="bob", text="..."   |
| 207  | author="alice", text="..." |
+------+----------------------------+
```

Every time you add a new item to the table, a new value
of `id` has to be set. And this has to be done with concurrency in mind.
SQL databases like PostgreSQL, Oracle, MySQL and others support
auto-increment features. When you add a new record to the table,
the value of the primary key is omitted and the server retrieves
the next one automatically. If a number of `INSERT` requests
arrive at the same time the server guarantees that the numbers won't be duplicated.

However, DynamoDB doesn't have this feature. Instead,
DynamoDB has [Atomic Counters](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithItems.html#WorkingWithItems.AtomicCounters)
and [Conditional Updates](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithItems.html#WorkingWithItems.ConditionalUpdate),
which are very similar features. Still, they're not exactly the same.

In case of an atomic counter, you should create a supplementary
table and keep the latest value of `id` in it.

In case of conditional updates, you should
[retry]({% pst 2014/aug/2014-08-15-retry-java-method-on-exception %})
a few times in case of collisions.

{% badge http://img.stateful.co/pomegranate.svg 128 %}

To make life easier in a few of my applications, I created a simple web
service---[stateful.co](https://www.stateful.co).
It provides a simple atomic counter feature through its RESTful API.

<!--more-->

First, you create a counter with a unique name. Then,
you set its initial value (it is zero by default). And, that's it.
Every time you need to obtain a new value for `id` column in
DynamoDB table, you make an HTTP request to [stateful.co](https://www.stateful.co)
asking to
increment your counter by one and return its next value.

[stateful.co](https://www.stateful.co) guarantees that values
returned will never duplicate each other---no matter how many
clients are using a counter or how fast they request increments simultaneously.

Moreover, I designed a small [Java SDK](https://github.com/sttc/java-sdk)
for [stateful.co](https://www.stateful.co). All you need to do is add
this [java-sdk.jar](https://repo1.maven.org/maven2/co/stateful/java-sdk/)
Maven dependency to your project:

```xml
<dependency>
  <groupId>co.stateful</groupId>
  <artifactId>java-sdk</artifactId>
  <version>0.6</version>
</dependency>
```

And, you can use [stateful.co](https://www.stateful.co) counters from Java code:

```java
Sttc sttc = new RtSttc(
  new URN("urn:github:526301"),
  "9FF3-41E0-73FB-F900"
);
Counters counters = sttc.counters();
Counter counter = counters.get("foo");
long value = counter.incrementAndGet(1L);
System.out.println("new value: " + value);
```

You can review authentication parameters for `RtSttc`
constructor at [stateful.co](https://www.stateful.co).

The service is absolutely free of charge.
