---
layout: post
title: "How to Set Up a Private Maven Repository in Amazon S3"
date: 2015-09-07
place: Kyiv, Ukraine
tags: java maven
description: |
  Amazon S3 is a perfect place for keeping private Maven
  artifacts, automatically deploying them there, and making
  them available through s3auth.com.
keywords:
  - private maven repository
  - maven repository s3
  - maven repository s3auth
  - amazon s3 maven
  - amazon s3 maven repository
---

[Amazon S3](https://aws.amazon.com/s3/)
is a perfect place for keeping private [Maven](https://maven.apache.org/) artifacts.
I assume you keep public artifacts in
[Maven Central]({% pst 2014/aug/2014-08-19-how-to-release-to-maven-central %}) because
you want them to be available to everybody. Private artifacts
are those you don't want visible to anyone except members
of your team. Thus, you want to deploy your `.jar` files there
and make sure they are visible only by your team. Here is how we do
this in all [our](https://www.zerocracy.com) Java projects.

<!--more-->

## Create an S3 Bucket

First, you create a new S3 bucket. I would recommend you name it using
your project domain and a prefix. For example, with `repo.teamed.io`,
`repo` is a prefix and `teamed.io` is the domain.

There's no need to configure any permissions for this bucket. Just create it
through the [Amazon S3 console](https://console.aws.amazon.com/console/home).

## Create an IAM User

Create a new IAM user. I recommend you name it like `teamed-maven`
if your project name is `teamed`.

Add a new "inline policy" to the user:

```text
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::repo.teamed.io",
        "arn:aws:s3:::repo.teamed.io/*"
      ]
    }
  ]
}
```

Here, `repo.teamed.io` is the name of the S3 bucket you
created a minute ago.

Make sure you have an "access key" for this new user. It must look similar
to this:

```text
key: AKIAI9NNNJD5D7X4TUVA
secret: t5tZQCwuaRhmlOXfbGE5aTBMFw34iFyxfCEr32av
```

The key is 20 characters (all caps), and the secret is 40 characters.

## Extend `settings.xml`

Add this configuration to your `~/.m2/settings.xml` file:

```xml
<settings>
  <servers>
    <server>
      <id>repo.teamed.io</id>
      <username>AKIAI9NNNJD5D7X4TUVA</username>
      <password>t5tZQCwuaRhmlOXfbGE5aTBMFw34iFyxfCEr32av</password>
    </server>
    [...]
  </servers>
  [...]
</settings>
```

## Configure `pom.xml`

Add this configuration to `pom.xml`:

```xml
<project>
  <distributionManagement>
    <snapshotRepository>
      <id>repo.teamed.io</id>
      <url>s3://repo.teamed.io/snapshot</url>
    </snapshotRepository>
    <repository>
      <id>repo.teamed.io</id>
      <url>s3://repo.teamed.io/release</url>
    </repository>
  </distributionManagement>
  <repositories>
    <repository>
      <id>repo.teamed.io</id>
      <url>s3://repo.teamed.io/release</url>
    </repository>
  </repositories>
  [...]
</project>
```

Then, configure [S3 Wagon](https://github.com/jcaddel/maven-s3-wagon),
also in `pom.xml`:

```xml
<project>
  <build>
    <extensions>
      <extension>
        <groupId>org.kuali.maven.wagons</groupId>
        <artifactId>maven-s3-wagon</artifactId>
        <version>1.2.1</version>
      </extension>
    </extensions>
    [...]
  </build>
</project>
```

You're ready to go. You can deploy your artifacts just by running
Maven from the command line:

```text
$ mvn clean deploy
```

## Configure `s3auth.com`

Now you want to see these artifacts in your browser, in a secure mode, by
providing secure credentials. I recommend you use
[s3auth.com](http://www.s3auth.com), as explained in
[Basic HTTP Auth for S3 Buckets]({% pst 2014/apr/2014-04-21-s3-http-basic-auth %}).

## Configure Rultor

{% badge https://doc.rultor.com/images/logo.svg 100 https://www.rultor.com %}

Another recommendation is to configure rultor.com for deployment of your
artifacts to S3 automatically.

First, encrypt your `settings.xml` with this
[Rultor remote](https://github.com/yegor256/rultor-remote):

```xml
$ gem install rultor
$ rultor encrypt -p me/test settings.xml
```

Instead of `me/test`, you should use the name of your GitHub project.

As a result, you will get a new file named `settings.xml.asc`. Add it to the root directory
of your project, then commit and push. The file contains your secret information,
but only the Rultor server can decrypt it.

Create a `.rultor.yml` file in the root directory of your project
(The Rultor [reference page](https://doc.rultor.com/reference.html)
explains this format in greater detail):

```text
decrypt:
  settings.xml: "repo/settings.xml.asc"
deploy:
  script: |
    mvn clean deploy --settings ../settings.xml
```

Now it's time to see how it all works together. Create a new ticket in the
GitHub issue tracker and post something like this into it
(read more about [Rultor commands](https://doc.rultor.com/basics.html)):

```text
@rultor deploy
```

You will get a response in a few seconds. The rest will be done by Rultor.

That's it.
