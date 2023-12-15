---
layout: post
title: "Object-Oriented DynamoDB API"
date: 2014-04-14
tags: aws java jcabi
description: |
  I created jcabi-dynamo a few months ago to make AWS SDK more object oriented;
  the article explains why jcabi-dynamo is better than bare Amazon SDK
keywords:
  - dynamodb
  - dynamodb java
  - java dynamodb example
  - java dynamodb query
  - java dynamodb client
  - java dynamodb query example
---

{% badge https://www.jcabi.com/logo-square.svg 64 https://dynamo.jcabi.com %}

I'm a big fan of cloud computing in general and of
[Amazon Web Services](http://aws.amazon.com/) in particular. I honestly believe that in a
few years big providers will host all, or almost all, computing and storage
resources. When this is the case, we won't have to worry too much anymore about
downtime, backups and system administrators.
[DynamoDB](http://aws.amazon.com/dynamodb/) is one of the steps towards this
future.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">This looks cool - jcabi-dynamo - a <a href="https://twitter.com/hashtag/Java?src=hash&amp;ref_src=twsrc%5Etfw">#Java</a> Object layer atop the <a href="https://twitter.com/hashtag/DynamoDB?src=hash&amp;ref_src=twsrc%5Etfw">#DynamoDB</a> SDK - <a href="http://t.co/khRFR2joKX">http://t.co/khRFR2joKX</a> <a href="https://twitter.com/hashtag/aws?src=hash&amp;ref_src=twsrc%5Etfw">#aws</a></p>&mdash; Jeff Barr ☁️ (@jeffbarr) <a href="https://twitter.com/jeffbarr/status/380813867971915777?ref_src=twsrc%5Etfw">September 19, 2013</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<!--more-->

DynamoDB is a [NoSQL](https://en.wikipedia.org/wiki/NoSQL) database accessible
through [RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer)
JSON API. Its design is relatively simple. There are tables, which basically
are collections of data structures, or in AWS terminology, "items."

Every item has a mandatory "hash," an optional "range" and a number of other
optional attributes. For instance, take the example table `depts`:

```text
+------+--------+---------------------------+
| dept | worker | Attributes                |
+------+--------+---------------------------+
| 205  | Jeff   | job="manager", sex="male" |
| 205  | Bob    | age=43, city="Chicago"    |
| 398  | Alice  | age=27, job="architect"   |
+------+--------+---------------------------+
```

For Java, Amazon provides an
[SDK](https://aws.amazon.com/documentation/sdkforjava/), which mirrors all
RESTful calls to Java methods. The SDK works fine, but is designed in a pure
[procedural](https://en.wikipedia.org/wiki/Procedural_programming) style.

Let's say we want to add a new item to the table above. RESTful call
[`putItem`](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_PutItem.html)
looks like (in essence):

```text
putItem:
  tableName: depts
  item:
    dept: 435
    worker: "William"
    job: "programmer"
```

This is what the Amazon server needs to know in order to create a new item in
the table. This is how you're supposed to make this call through the AWS Java
SDK:

```java
PutItemRequest request = new PutItemRequest();
request.setTableName("depts");
Map<String, AttributeValue> attributes = new HashMap<>();
attributes.put("dept", new AttributeValue(435));
attributes.put("worker", new AttributeValue("William"));
attributes.put("job", new AttributeValue("programmer));
request.setItem(attributes);
AmazonDynamoDB aws = // instantiate it with credentials
try {
  aws.putItem(request);
} finally {
  aws.shutdown();
}
```

The above script works fine, but there is one major drawback---it is not
object oriented. It is a perfect example of an imperative [procedural
programming](https://en.wikipedia.org/wiki/Procedural_programming).

To allow you to compare, let me show what I've done with
[jcabi-dynamo](https://dynamo.jcabi.com). Here is my code, which does exactly the
same thing, but in an
[object-oriented](https://en.wikipedia.org/wiki/Object-oriented_programming) way:

```java
Region region = // instantiate it with credentials
Table table = region.table("depts");
Item item = table.put(
  new Attributes()
    .with("dept", 435)
    .with("worker", "William")
    .with("job", "programmer")
);
```

My code is not only shorter, but it also employs
[encapsulation]({% pst 2016/nov/2016-11-21-naked-data %}) and separates
responsibilities of classes.
[`Table`](https://dynamo.jcabi.com/apidocs-0.10/com/jcabi/dynamo/Table.html)
class (actually it is an interface internally implemented by a class)
encapsulates information about the table, while
[`Item`](https://dynamo.jcabi.com/apidocs-0.10/com/jcabi/dynamo/Item.html)
encapsulates item details.

We can pass an `item` as an argument to another method and all DynamoDB related
implementation details will be hidden from it. For example, somewhere later in
the code:

```java
void sayHello(Item item) {
  System.out.println("Hello, " + item.get("worker"));
}
```

In this script, we don't know anything about DynamoDB or how to deal with its
RESTful API. We interact solely with an instance of
[`Item`](https://dynamo.jcabi.com/apidocs-0.10/com/jcabi/dynamo/Item.html) class.

By the way, all public entities in [jcabi-dynamo](https://dynamo.jcabi.com) are
Java interfaces. Thanks to that, you can test and mock the library completely
(but I would recommend to use
[DynamoDB Local]({% pst 2014/may/2014-05-01-dynamodb-local-maven-plugin %})
and create integration tests).

Let's consider a more complex example, which would take a page of code if we
were to use a bare AWS SDK. Let's say that we want to remove all workers from
our table who work as architects:

```java
Region region = // instantiate it with credentials
Iterator<Item> workers = region.table("depts").frame()
  .where("job", Condition.equalTo("architect"));
while (workers.hasNext()) {
  workers.remove();
}
```

[jcabi-dynamo](https://dynamo.jcabi.com) has saved a lot of code lines in a few
of my projects. You can see it in action at
[rultor-users](https://github.com/rultor/rultor/tree/rultor-0.2/rultor-users/src/main/java/com/rultor/users).

The library ships as a JAR dependency in [Maven
Central](https://repo1.maven.org/maven2/com/jcabi/jcabi-dynamo)
(get its latest versions from [Maven Central](http://search.maven.org/)):

```xml
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-dynamo</artifactId>
</dependency>
```
