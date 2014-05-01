---
layout: post
title: "DynamoDB Local Maven Plugin"
date: 2014-04-29
tags: dynamodb maven
description:
  jcabi-dynamodb-maven-plugin is a Maven plugin for
  DynamoDB Local running locally and acting as a stub of DynamoDB server,
  very useful for integration testing
keywords:
  - dynamodb
  - maven plugin
  - dynamodb maven plugin
  - amazon dynamodb maven plugin
  - aws dynamodb maven
  - maven plugin for dynamodb local
  - dynamodblocal
  - dynamodb local maven plugin
  - dynamodb local integration testing
  - integration test dynamodb
---

{% badge http://img.yegor256.com/2014/04/dynamodb-logo.jpg 150 %}

[DynamoDB Local](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.html)
is a locally running copy of Amazon DynamoDB server. The tool
is being developed by Amazon team and is based on SQLite. It acts
as a real DynamoDB service, through RESTful API.

DynamoDB Local is ment to be used in integration testing, I guess.

I run all my Java integration tests with Maven, using
[maven-failsafe-plugin](http://maven.apache.org/surefire/maven-failsafe-plugin/).
The phylosofy of integration testing in Maven is that you start
all your supplementary test stubs during `pre-integration-test` phase,
run your tests at `integration-test` phase, and shutdown all stubs
at `post-integration-test`.

{% badge http://img.jcabi.com/logo-square.png 64 %}

Would be great to have a possibility to use DynamoDB Local that way. I didn't
find any Maven plugins for that purpose and decided to create my own &mdash;
[jcabi-dynamodb-maven-plugin](https://github.com/jcabi/jcabi-dynamodb-maven-plugin).

Its full usage details are explained on
[its website](http://dynamodb.jcabi.com). Here is just a simple example:

{% highlight xml %}
<plugin>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-dynamodb-maven-plugin</artifactId>
  <version>0.6</version>
  <executions>
    <execution>
      <goals>
        <goal>start</goal>
        <goal>stop</goal>
      </goals>
      <configuration>
        <port>10500</port>
        <dist>${project.build.directory}/dynamodb-dist</dist>
      </configuration>
    </execution>
  </executions>
</plugin>
{% endhighlight %}

This configuration will start DynamoDB Local right before running
integration tests, and stop it right after them. The server will
listed at TCP port 10500. This is just a number. You're supposed
to use a [randomly allocated port](http://mojo.codehaus.org/build-helper-maven-plugin/reserve-network-port-mojo.html)
instead.

When this DynamoDB Local server is up and running we can create
an integration test for it:

{% highlight java linesnos=table %}
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.model.ListTablesResult;
public class FooITCase {
  @Test
  public void worksWithAwsDynamoDb() {
    AmazonDynamoDB aws = new AmazonDynamoDBClient(
      new BasicAWSCredentials("", "")
    );
    aws.setEndpoint("http://localhost:10500");
    ListTablesResult list = aws.listTables();
    for (String name : list.getTableNames()) {
      System.out.println("table found: " + name);
    }
  }
}
{% endhighlight %}

Of course, there won't be any output because the server starts without
any tables inside. It is empty and you should create tables before
every integration test, using `createTable()` from
[DynamoDB SDK](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/dynamodbv2/package-summary.html).

To avoid this extra hassle, in the latest version 0.6 of
[jcabi-dynamodb-maven-plugin](http://dynamodb.jcabi.com),
[we introduced](https://github.com/jcabi/jcabi-dynamodb-maven-plugin/issues/16)
a new goal
[`create-tables`](http://dynamodb.jcabi.com/example-create-tables.html):

{% highlight xml %}
<plugin>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-dynamodb-maven-plugin</artifactId>
  <executions>
    <execution>
      <goals>
        <goal>create-tables</goal>
      </goals>
      <configuration>
        <tables>
          <table>${basedir}/src/test/dynamodb/foo.json</table>
        </tables>
      </configuration>
    </execution>
  </executions>
</plugin>
{% endhighlight %}

Then, this `foo.json` file should contain JSON request to be sent
to DynamoDB Local right after it is up and running. The request
should comply with the specification of
[CreateTable](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_CreateTable.html) request,
for example:

{% highlight json %}
{
  "AttributeDefinitions": [
    {
      "AttributeName": "id",
      "AttributeType": "N"
    }
  ],
  "KeySchema": [
    {
      "AttributeName": "id",
      "KeyType": "HASH"
    }
  ],
  "ProvisionedThroughput": {
    "ReadCapacityUnits": "1",
    "WriteCapacityUnits": "1"
  },
  "TableName": "foo"
}
{% endhighlight %}

The table will be created on `pre-integration-test` phase and dropped
on `post-integration-test` phase. Now we can make our integration test
much more meaningful, with a help of
[jcabi-dynamo](http://dynamo.jcabi.com):

{% highlight java linesnos=table %}
import com.jcabi.dynamo.Attributes;
import com.jcabi.dynamo.Conditions;
import com.jcabi.dynamo.Credentials;
import com.jcabi.dynamo.Region;
import com.jcabi.dynamo.Table;
import org.hamcrest.MatcherAssert;
import org.hamcrest.Matchers;
public class FooITCase {
  @Test
  public void worksWithAwsDynamoDb() {
    Region region = new Region.Simple(new Credentials.Simple("", ""));
    Table table = region.table("foo");
    table.put(
      new Attributes()
        .with("id", 123)
        .with("name", "Robert DeNiro")
    );
    MatcherAssert.assertThat(
      table.frame().where("id", Conditions.equalTo(123)),
      Matchers.notEmpty()
    );
  }
}
{% endhighlight %}

This test will put a new item into the table and then assert
that the item is there.

The plugin was tested with three operating systems, and
proved to be working without problems: Mac OS X 10.8.5, Windows 7 SP 1,
Ubuntu Linux 12.04 Desktop.

