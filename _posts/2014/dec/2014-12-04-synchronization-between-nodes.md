---
layout: post
title: "Synchronization Between Nodes"
date: 2014-12-04
tags: pets
description: |
  Free cloud service stateful.co helps you synchronize
  across multiple servers or parallel processes on the same machine.
keywords:
  - Java synchronization between different JVMs
  - synchronization between different servers
  - synchronization between servers
  - synchronization between computers
  - synchronization between processes
  - synchronization between two computers
image: /images/2014/12/van-damme-split.png
jb_picture:
  caption: No Retreat, No Surrender (1986) by Corey Yuen
---

When two or more software modules are accessing the same
resource, they have to be synchronized. This means that only
one module at a time should be working with the resource. Without
such synchronization, there will be collisions and conflicts. This
is especially true when we're talking about "resources" that do
not support *atomic* transactions.

{% badge http://img.stateful.co/pomegranate.svg 64 https://www.stateful.co %}

To solve this issue and prevent conflicts, we have to introduce
one more element into the picture. All software modules, before
accessing the resource, should *capture* a lock from a centralized
server. Once the manipulations with the resource are complete, the module
should *release* the lock. While the lock is being captured by one
module, no other modules will be able to capture it. The approach
is very simple and well-known. However, I didn't find any cloud services
that would provide such a locking and unlocking service over a RESTful API.
So I decided to create one---[stateful.co](https://www.stateful.co).

<!--more-->

{% jb_picture_body %}

Here is a practical example. I have a Java web app that is hosted
at Heroku. There are three servers (a.k.a. "dynos") running the same `.war`
application. Why three? Because the web traffic is rather active, and one
server is not powerful enough. So I have to have three of them. They all
run exactly the same applications.

Each web app works with a table in Amazon DynamoDB. It updates the table,
puts new items into it, deletes some items sometimes, and selects them. So far,
so good, but conflicts are inevitable. Here is an example of a typical
interaction scenario between the web app and DynamoDB (I'm using jcabi-dynamo):

```java
Table table = region.table("posts");
Item item = table.frame()
  .where("name", "Jeff")
  .iterator().next();
String salary = item.get("salary");
item.put("salary", this.recalculate(salary));
```

The logic is obvious here. First, I retrieve an item from the table `posts`,
then read its `salary`, and then modify it according to my recalculation
algorithm. The problem is that another module may start to do the same while
I'm recalculating. It will read the same initial value from the table
and will start exactly the same recalculation. Then it will save a new
value, and I will save one too. We will end up having Jeff's salary modified
only once, while users will expect a double modification since two of them
initiated two transactions with two different web apps.

The right approach here is to "lock" the DynamoDB table first, even before
reading the salary. Then do the modifications and eventually unlock it. Here is
how [stateful.co](https://www.stateful.co) helps me. All I need to do is create a new named lock
in the [stateful.co](https://www.stateful.co) web panel,
get my authentication keys, and modify my Java code:

```java
Sttc sttc = new RtSttc(
  new URN("urn:github:526301"), // my GitHub ID
  "9FF3-4320-73FB-EEAC" // my secret key!
);
Locks locks = sttc.locks();
Lock lock = locks.get("posts-table-lock");
Table table = region.table("posts");
Item item = table.frame()
  .where("name", "Jeff")
  .iterator().next();
new Atomic(lock).call(
  new Callable<Void>() {
    @Override
    public void call() {
      String salary = item.get("salary");
      item.put("salary", this.recalculate(salary));
      return null;
    }
  }
);
```

As you see, I wrap that critical transaction into `Callable`, which will
be executed in isolation. This approach, obviously, doesn't
guarantee atomicity of transaction---if part of the transaction fails,
there won't be any automatic rollbacks and the DynamoDB table will be left
in a "broken" state.

Locks from [stateful.co](https://www.stateful.co) guarantee isolation in resource usage, and you can
use any type of resources, including NoSQL tables, files, S3 objects,
embedded software, etc.

I should not forget to add this dependency to my `pom.xml`:

```xml
<dependency>
  <groupId>co.stateful</groupId>
  <artifactId>java-sdk</artifactId>
</dependency>
```

Of course, you can do the same; the service is absolutely free of charge.
And you can use any other languages, not just Java. BTW, if interested,
contribute with your own SDK in your preferred language; I'll add it to
the [GitHub collection](https://github.com/sttc).
