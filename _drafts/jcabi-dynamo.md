---
layout: post
title: "Object-Oriented DynamoDB API"
date: 2014-04-12
tags: cloud
keywords:
  - amazon web services
  - dynamodb
  - java api dynamodb
  - dynamodb java
  - object oriented dynamodb java
---

I'm a big fan of cloud computing in general and of Amazon Web Services
in particular. I honestly believe that in a few years all our
computing and storage resources will be hosted by big providers. We
won't have to worry any more about downtime, backups, and system
administrators. DynamoDB is one of the steps towards this future.

<blockquote class="twitter-tweet" lang="en"><p>This looks cool - jcabi-dynamo - a <a href="https://twitter.com/search?q=%23Java&amp;src=hash">#Java</a> Object layer atop the <a href="https://twitter.com/search?q=%23DynamoDB&amp;src=hash">#DynamoDB</a> SDK - <a href="http://t.co/khRFR2joKX">http://t.co/khRFR2joKX</a> <a href="https://twitter.com/search?q=%23aws&amp;src=hash">#aws</a></p>&mdash; Jeff Barr (@jeffbarr) <a href="https://twitter.com/jeffbarr/statuses/380813867971915777">September 19, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

DynamoDB is a NoSQL database accessible through RESTful JSON API. Its
design is very simple. There are tables, which basically are
collections of data structs, called "items", according to AWS terminology.
Every item has a mandatory "hash", an optional "range",
and a number of optional attributes. For example, here is a table `depts`:

{% highlight text %}
+------+--------+---------------------------+
| dept | worker | Attributes                |
+------+--------+---------------------------+
| 205  | Jeff   | job="manager", sex="male" |
| 205  | Bob    | age=43, city="Chicago"    |
| 398  | Alice  | age=27, job="architect"   |
+------+--------+---------------------------+
{% endhighlight %}

For Java Amazon provides an SDK, which mirrors all RESTful calls to
Java methods. It works fine, but it is designed in a pure procedural
COBOL style. Say, we want to add a new item to the table above. RESTful
call `putItem` looks like:

{% highlight text linenos=table %}
putItem:
  tableName: depts
  item:
    dept: 435
    worker: "William"
    job: "programmer"
{% endhighlight %}

This is what Amazon server needs to know in order to create a new item
in the table. This is how you're supposed to make this call through
AWS Java SDK:

{% highlight java linenos=table %}
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
{% endhighlight %}

This script works fine, but there is one major drawback &mdash; it is not
object oriented. It is a perfect example of an imperative
procedural programming. Let me show what I've done with
[jcabi-dynamo](http://dynamo.jcabi.com), to let you compare. Here
is my code, which is doing exactly the same, but in an object-oriented way:

{% highlight java linenos=table %}
Region region = // instantiate it with credentials
Table table = region.table("depts");
Item item = table.put(
  new Attributes()
    .with("dept", 435)
    .with("worker", "William")
    .with("job", "programmer")
);
{% endhighlight %}

It is not just a shorter code. It employs encapsulation and separates
responsibilities of classes. `Table` class (actually it is an
interface internally implemented by a class) encapsulates information
about the table, while `Item` encapsulates item details. We
can pass an `item` as an argument to another method and all DynamoDB
related implementation details will be hidden from it. For example,
somewhere later in the code:

{% highlight java linenos=table %}
void sayHello(Item item) {
  System.out.println("Hello, " + item.get("worker"));
}
{% endhighlight %}

In this script we don't know anything about DynamoDB or
how to deal with its RESTful API. We interact solely with an
instance of `Item` class.

By the way, all public entities in
[jcabi-dynamo](http://dynamo.jcabi.com) are
Java interfaces. Thanks to that, the library is perfectly testable
and mockable.

Let's consider a more complex example, which would take a page of
code if we would use a bare AWS SDK. Say, we want to remove all
workers from our table who work as architects:

{% highlight java linenos=table %}
Region region = // instantiate it with credentials
Iterator<Item> workers = region.table("depts").frame()
  .where("job", Condition.equalTo("architect"));
while (workers.hasNext()) {
  workers.remove();
}
{% endhighlight %}

[jcabi-dynamo](http://dynamo.jcabi.com) saved a lot
of code lines in a few of my projects. You can see it in action
at [rultor-users](https://github.com/rultor/rultor).

The library is shipped as a JAR dependency in
[Maven Central](http://repo1.maven.org/maven2/com/jcabi/jcabi-dynamo):

{% highlight xml %}
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-dynamo</artifactId>
  <version><!-- check http://dynamo.jcabi.com --></version>
</dependency>
{% endhighlight %}
