---
layout: post
title: "DynamoDB Local Maven Plugin"
date: 2014-05-01
tags: maven aws java
description: |
  jcabi-dynamodb-maven-plugin is a Maven plugin for DynamoDB
  Local running locally and acting as a stub of DynamoDB server,
  which is very useful for integration testing
keywords:
  - dynamodb
  - maven plugin
  - dynamodb maven plugin
  - amazon dynamodb maven plugin
  - aws dynamodb maven
  - maven plugin for dynamodb local
  - dynamodblocal
---

{% badge /images/2014/04/dynamodb-logo.png 150 http://aws.amazon.com/dynamodb %}

[DynamoDB Local](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.html)
is a locally running copy of Amazon DynamoDB server. Amazon developed
the tool and based it on SQLite. It acts as a real DynamoDB
service through the RESTful API.

I guess, DynamoDB Local is meant to be used in
integration testing and this is how we're going to use it below.

I use Maven to run all of my Java integration
testing using [`maven-failsafe-plugin`](https://maven.apache.org/surefire/maven-failsafe-plugin/).
The philosophy of integration testing with Maven is
that you start all your supplementary test stubs during
the `pre-integration-test` phase, run your tests in the `integration-test`
phase and then shutdown all stubs during the `post-integration-test`.

{% badge https://www.jcabi.com/logo-square.svg 64 https://dynamodb.jcabi.com %}

It would be great if it were possible to use DynamoDB Local
that way. I didn't find any Maven plugins for that purpose,
so I decided to create my own---[jcabi-dynamodb-maven-plugin](https://github.com/jcabi/jcabi-dynamodb-maven-plugin).

<!--more-->

Full usage details for the plugin are explained
on [its website](https://dynamodb.jcabi.com). However, here is a simple example
(get its latest versions in [Maven Central](http://search.maven.org/)):

```xml
<plugin>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-dynamodb-maven-plugin</artifactId>
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
```

The above configuration will start DynamoDB Local
right before running integration tests, and then stop it
immediately afterwards. The server will listen at TCP port 10500.
While the number is used in the example, you're supposed
to use a randomly allocated port instead.

When the DynamoDB Local server is up and running,
we can create an integration test for it:

```java
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
```

Of course, there won't be any output because the server
starts without any tables. Since the server is empty,
you should create tables before every integration test, using
`createTable()` from [DynamoDB SDK](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/dynamodbv2/package-summary.html).

To avoid this type of extra hassle, in the latest version 0.6 of
[jcabi-dynamodb-maven-plugin](https://dynamodb.jcabi.com)
[we introduced](https://github.com/jcabi/jcabi-dynamodb-maven-plugin/issues/16)
a new goal [`create-tables`](https://dynamodb.jcabi.com/example-create-tables.html):

```xml
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
```

The `foo.json` file used above should contain a JSON request
that is sent to DynamoDB Local right after it is up and running.
The request should comply with the specification
of [`CreateTable`](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_CreateTable.html) request. For example:

```json
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
```

The table will be created during the
`pre-integration-test` phase and dropped at the
`post-integration-test` phase. Now, we can make our
integration test much more meaningful with the help of [jcabi-dynamo](https://dynamo.jcabi.com):

```java
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
```

The above test will put a new item into the table
and then assert that the item is there.

The plugin was tested with three operating systems, and proved
to work without problems: Mac OS X 10.8.5, Windows 7 SP1 and Ubuntu Linux 12.04 Desktop.
