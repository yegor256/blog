---
layout: post
title: "How to Deploy Maven Artifacts to CloudRepo via Rultor"
date: 2019-02-03
place: Moscow, Russia
tags: devops maven java
description: |
  Are you trying to deploy your maven dependencies to a private
  repository manager?  Here's a detailed on how to read and write
  artifacts to CloudRepo.
keywords:
  - maven repository
  - private maven repository
  - maven repository manager
  - repository manager
  - artifact repository
  - apache maven
---

{% badge https://doc.rultor.com/images/logo.svg 100 https://www.rultor.com %}

In my [previous article]({% pst 2015/sep/2015-09-07-maven-repository-amazon-s3 %}),
I described how to
set up a private Maven repository in Amazon S3 and deploy there via [Rultor](https://www.rultor.com).
This is a great solution if you're familiar with managing Amazon Web Services (AWS),
[S3](https://aws.amazon.com/s3/), and [AWS Identity and Access Management (IAM)](https://aws.amazon.com/iam/).
However, if you're not comfortable administering an AWS account and
all the related permissions, you may want to store your Apache Maven Artifacts
in some cloud based repository manager instead.
Here is how you make Rultor deploy your Maven dependencies to [CloudRepo](https://www.cloudrepo.io/).
I wrote this blog post together with [Chris Shellenbarger](https://www.linkedin.com/in/chrisshellenbarger),
their founder.

<!--more-->

Both repository managers and S3 will allow your build tools
to store and retrieve your software libraries in a remote
repository or bucket.
However, repository managers take care of a lot of the work
that you'd have to manage yourself with the S3 solution.

While AWS is quite robust and can be configured to do everything
a repository manager can, there are use cases that work directly
out of the box when you choose a fully managed solution, like:
User/Group Administration, Maven Specific Views, Webhooks, Notifications,
Access and Audit Logs, Fully Managed Security, etc.
Simply put, they are not just storages of JAR files, but Maven repositories
in cloud.

A fully managed, cloud hosted solution will cost you a monthly subscription
fee of some sort. At the moment of writing they charge $9 per month
[and up](https://www.cloudrepo.io/pricing.html). They are free for open source,
but I don't see why you would need them if you can use
[Maven Central]({% pst 2014/aug/2014-08-19-how-to-release-to-maven-central %}).
The good news is that they are offering a special discount for my readers:
the first 90 days are free, versus the standard 14. This is effectively
a 25% discount off of your first year.
Simply [shoot them an email](mailto:support@cloudrepo.io) when your account is created
and they'll take care of you (don't forget to mention me, to get the discount).

{% badge /images/2019/02/cloudrepo.png 100 http://www.cloudrepo.io %}

Assuming you have created an account with
CloudRepo and [setup both a user and maven repository](https://www.cloudrepo.io/docs/maven.html#pre-requisites),
deploying to CloudRepo requires two steps on the client side:
1) Configure a `settings.xml` file with credentials, and
2) Add your repository to your `pom.xml` file's `<distributionManagement>` section.

The default location for the `settings.xml` file is in your
`~/.m2` directory.  Edit this file and ensure that you have
a `<server>` entry as seen below:

```xml
<settings>
  <servers>
    <server>
      <id>io.cloudrepo</id>
      <username>yegor256@gmail.com</username>
      <password>my-secret</password>
    </server>
  </servers>
</settings>
```

By declaring a `server` and specifying an `id`, you can reference the `id`
from within your Maven POM files.  When Maven attempts to
authenticate against a server it will look for a corresponding
key in the `settings.xml` file.

If you're worried about storing your password in plaintext
on your filesystem, check how Maven [recommends](https://maven.apache.org/guides/mini/guide-encryption.html)
fixing that.

Now that your credentials have been set, you must
point your [`pom.xml`](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html)
at your CloudRepo repository.
Add a new `<repository>` element to the `<distributionManagement>` (to upload them) section of your `pom.xml`
and to the `<repositories>` (to download them):

```xml
<project>
  [...]
  <repositories>
    <repository>
      <id>io.cloudrepo</id>
      <url>https://[your-org-name].mycloudrepo.io/repositories/[your-repository-name]</url>
    </repository>
  </repositories>
  [...]
  <distributionManagement>
    <repository>
      <id>io.cloudrepo</id>
      <name>CloudRepo Maven Repository</name>
      <url>https://[your-org-name].mycloudrepo.io/repositories/[your-repository-name]</url>
    </repository>
  </distributionManagement>
</project>
```

Once you have a build working in your local environment, you need to
deploy it to production with Rultor.
First, you'll need to store your credentials in Git so that Rultor
can access them at build and deploy time.   However, it
is very important to _never_ store your credentials in plaintext in version control
(substitute the name of your GitHub project with `my/project`):

```text
$ gem install rultor
$ rultor encrypt -p my/project settings.xml
```

This creates an encrypted version of your settings file with
the name `settings.xml.asc`.  Add this file to the root directory
of your project, then commit and push. It is safe.
Only Rultor has the keys to decrypt this file so even if your source
code is exposed to others, your credentials will be kept safe.

To enable Rultor, add a `.rultor.yml` file to the root directory
of your project with the following contents:

```yaml
decrypt:
  settings.xml: "repo/settings.xml.asc"
deploy:
  script: |
    mvn clean deploy --settings ../settings.xml
```

For more information on the `.rultor.yml` file,
check the [Rultor Reference Page](https://doc.rultor.com/reference.html).

Now that everything is configured you should be able to deploy to
CloudRepo with Rultor by executing the `@rultor deploy` command.
Wait for the response and Rultor will [take care]({% pst 2014/jul/2014-07-24-rultor-automated-merging %})
of all the rest.

That's it!
