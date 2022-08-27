---
layout: post
title: "DynamoDB + Rake + Maven + Rack::Test"
date: 2017-06-13
place: Odessa, Ukraine
tags: testing ruby aws
description: |
  The article explains how DynamoDB Local can be
  used in Rake integration testing; a practical
  example of SixNines.io testing is provided.
keywords:
  - dynamodb local
  - dynamodb
  - rake dynamodb
  - rack::test dynamodb
  - testing dynamodb ruby
---

In
[SixNines.io]({% pst 2017/apr/2017-04-25-sixnines %}),
one of my Ruby pet web apps, I'm using
[DynamoDB](https://aws.amazon.com/dynamodb/), a NoSQL cloud database
by [AWS](https://aws.amazon.com/). It works like a charm, but the problem
is that it's not so easy to create an integration test, to make sure
my code works together with the "real" DynamoDB server and tables. Let me
show you how it was solved. The code is open source and you can see it
in the [yegor256/sixnines](https://github.com/yegor256/sixnines) GitHub repo.

<!--more-->

{% jb_picture_body %}

## How to bootstrap DynamoDB Local

First, you need to use
[DynamoDB Local](https://aws.amazon.com/blogs/aws/dynamodb-local-for-desktop-development/),
a command line tool created by AWS exactly for the
purposes of testing. You need to start it before your integration
tests and stop it afterwards.

To make things simpler
I suggest you use [`jcabi-dynamodb-maven-plugin`](http://dynamodb.jcabi.com/),
a [Maven](https://maven.apache.org/) plugin that I
[made]({% pst 2014/may/2014-05-01-dynamodb-local-maven-plugin %}) a few years ago.
You will need to add
[`pom.xml`](https://github.com/yegor256/sixnines/blob/0.17/dynamodb-local/pom.xml) to your
repository and start/stop Maven from a
[`Rakefile`](https://github.com/yegor256/sixnines/blob/0.17/Rakefile),
just like I'm doing [here](https://github.com/yegor256/sixnines/blob/0.17/Rakefile#L50-L67):

```ruby
task :dynamo do
  FileUtils.rm_rf('dynamodb-local/target')
  pid = Process.spawn('mvn', 'install', chdir: 'dynamodb-local')
  at_exit do
    `kill -TERM #{pid}`
  end
  begin
    Dynamo.new.aws.describe_table(table_name: 'sn-endpoints')
  rescue Exception => e
    sleep(5)
    retry
  end
end
```

First, I'm removing `dynamodb-local/target`, the directory where Maven keeps
its temporary files, to make sure we always start from scratch.

Then, I'm starting `mvn install`, using `Process.spawn`, as a background
process with `pid` as its process ID (this won't work in Windows, only Linux/Mac).
Then I immediately register an
[`at_exit`](https://ruby-doc.org/core-2.2.3/Kernel.html#method-i-at_exit)
Ruby hook, which will be executed if Ruby dies for any reason. I'm sure
it's obvious why I have to do that---in order to avoid garbage running
in the background after Rake is finished or terminated.

Pay attention, I'm using `kill -TERM` instead of `kill -KILL`, in order to
give Maven a chance to wrap everything up, terminate DynamoDB Local correctly,
close its TCP port and exit.

## How to check that it's running

Next I'm checking the status of `sn-endpoints`, one of the tables in the
DynamoDB Local. It has to be there if the server is up and running. It will
be created by `jcabi-dynamodb-maven-plugin` according to
[`sn-endpoints.json`](https://github.com/yegor256/sixnines/blob/0.17/dynamodb-local/tables/sn-endpoints.json),
its JSON configuration.

Most probably the table won't be ready immediately though, since it takes time to
bootstrap Maven, start the server, and create tables there. That's why, if the
exception is thrown, I catch it, wait for 5 seconds and try again.
I keep trying many times, until the server is ready. Eventually it will be.
It takes about 12-15 seconds on my MacBook, which means 2-3 attempts/exceptions.

## How to connect to DynamoDB Local

My classes need to know how to connect to the server during integration tests.
In production they need to connect to AWS, in testing they have to
know about the DynamoDB Local instance I just started. This is what I have in my class
[`Dynamo`](https://github.com/yegor256/sixnines/blob/0.17/objects/dynamo.rb),
which is responsible for the very connection with DynamoDB. Its decision
on where to connect is based on the environment variable `RACK_ENV`, which
is set to `"test"` in
[`test__helper.rb`](https://github.com/yegor256/sixnines/blob/0.17/test/test__helper.rb#L25),
which is included by
[`rake/testtask`](https://github.com/yegor256/sixnines/blob/0.17/Rakefile#L39)
in front of all other tests, thanks to the double underscore in its name.

If the environment variable is set to `"test"`,
`Dynamo` takes the connectivity parameters from the YAML file
[`dynamodb-local/target/dynamo.yml`](https://github.com/yegor256/sixnines/blob/0.17/objects/dynamo.rb#L37)
created by
[`maven-resources-plugin:copy-resources`](https://github.com/yegor256/sixnines/blob/0.17/dynamodb-local/pom.xml#L79-L100).
The TCP port of the DynamoDB Local database will be
[there](https://github.com/yegor256/sixnines/blob/0.17/dynamodb-local/config/dynamo.yml),
as well as the DynamoDB authentication key and secret.

## How to run the integration tests

This is the easiest part. I just use my objects the way they are supposed
to be used in production and they connect to DynamoDB Local instead of AWS.

I'm using Rack::Test in order to test the entire application, via a set
of HTTP calls. For example,
[here](https://github.com/yegor256/sixnines/blob/0.17/test/test_sixnines.rb#L143-L147)
I'm trying to render Jeff's user account page.
Its HTTP response code is supposed to be 200:

```java
require 'test/unit'
require 'rack/test'
class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
  def test_user_account
    header('Cookie', 'sixnines=jeff')
    get('/a')
    assert_equal(200, last_response.status)
  end
```

##

Now you can run the entire test from the command line. You can see how
[Rultor]({% pst 2014/sep/2014-09-11-deployment-script-vs-rultor %})
runs it while releasing a new version: [full log](https://www.rultor.com/t/11705-302080694).
Also, see how it works [in Travis](https://travis-ci.org/yegor256/sixnines).
In a nutshell:

  * You call `rake` in the command line and Rake starts;
  * Rake attempts to run the [`default`](https://github.com/yegor256/sixnines/blob/0.17/Rakefile#L32) task,
    which depends on [`test`](https://github.com/yegor256/sixnines/blob/0.17/Rakefile#L36);
  * Rake attempts to run `test`, which depends on
    [`dynamo`](https://github.com/yegor256/sixnines/blob/0.17/Rakefile#L50);
  * Rake, inside `test` task, runs `mvn install` in the background
    with this [`pom.xml`](https://github.com/yegor256/sixnines/blob/0.17/dynamodb-local/pom.xml);
  * Maven [unpacks](https://github.com/yegor256/sixnines/blob/0.17/dynamodb-local/pom.xml#L38-L60)
    DynamoDB Local installation package;
  * Maven [reserves](https://github.com/yegor256/sixnines/blob/0.17/dynamodb-local/pom.xml#L61-L78)
    a random TCP port and stores its value into `${dynamo.port}`;
  * Maven [saves](https://github.com/yegor256/sixnines/blob/0.17/dynamodb-local/pom.xml#L79-L100)
    `${dynamo.port}` and key/secret pair info;
  * Maven [starts](https://github.com/yegor256/sixnines/blob/0.17/dynamodb-local/pom.xml#L101-L128)
    DynamoDB Local, binding it to the reserved TCP port;
  * Rake [waits](https://github.com/yegor256/sixnines/blob/0.17/Rakefile#L57-L65)
    for DynamoDB Local availability on the reserved port;
  * Rake [imports](https://github.com/yegor256/sixnines/blob/0.17/Rakefile#L38-L39)
    all [test classes](https://github.com/yegor256/sixnines/tree/0.17/test) starting from
    [test__helper.rb](https://github.com/yegor256/sixnines/blob/0.17/test/test__helper.rb);
  * Environment variable `RACK_ENV` is [set](https://github.com/yegor256/sixnines/blob/0.17/test/test__helper.rb#L25)
    to `"test"`;
  * Rack::Test [attempts](https://github.com/yegor256/sixnines/blob/0.17/test/test_sixnines.rb#L145)
    to dispatch a web page;
  * [`Dynamo`](https://github.com/yegor256/sixnines/blob/0.17/objects/dynamo.rb)
    [loads](https://github.com/yegor256/sixnines/blob/0.17/objects/dynamo.rb#L37-L39) YAML config from
    [`dynamo.yml`](https://github.com/yegor256/sixnines/blob/0.17/dynamodb-local/config/dynamo.yml)
    and connects to DynamoDB Local;
  * Rake stops;
  * Ruby [terminates](https://github.com/yegor256/sixnines/blob/0.17/Rakefile#L53-L56)
    Maven and it stops DynamoDB Local.

That's it.

