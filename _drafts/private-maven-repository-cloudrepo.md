---
layout: post
title: "How to Set Up a Private Maven Repository In CloudRepo"
date: 2019-01-17
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
image: /images/2019/01/
jb_picture:
  caption:
---

# How to Set Up a Private Maven Repository In CloudRepo

In our previous article, we described how to [set up a private maven repository in Amazon S3](https://www.yegor256.com/2015/09/07/maven-repository-amazon-s3.html).  This is a great solution if you're familiar with managing Amazon Web Services (AWS), [S3](https://aws.amazon.com/s3/), and [AWS Identity and Access Management (IAM)](https://aws.amazon.com/iam/).

However, if you're not comfortable administering an AWS account and all the related permissions, you may want to store your Apache Maven Artifacts in a cloud based repository manager instead.

Here we describe how to deploy and retrieve your maven dependencies from a cloud based private maven repository hosted by [CloudRepo](https://www.cloudrepo.io/).

## Why use a repository manager over S3?

Both repository managers and S3 will allow your build tools to store and retrieve your software libraries in a remote repository or bucket.

However, repository managers take care of a lot of the work that you'd have to manage yourself with the S3 solution.

While AWS is quite robust and can be configured to do everything a repository manager can, there are use cases that work directly out of the box when you choose a fully managed solution:

* User/Group Administration
* Maven Specific Views
   * Web Browsing
   * Search
   * Dependency Analysis
* Webhooks
* Notifications
* Access and Audit Logs
* Fully Managed Security
* No Plugins/Build Extensions (s3-wagon) Required

***Note:** While this article uses CloudRepo as the repository manager, the instructions should work for any Maven compliant alternative.*

## Deploying to CloudRepo

Assuming you have created an account with CloudRepo and [setup both a user and maven repository](https://www.cloudrepo.io/docs/maven.html#pre-requisites), deploying to CloudRepo requires two steps on the client side:

1. Configure a `settings.xml` file with credentials
2. Add your repository to your `pom.xml` file's `<distributionManagement>` section.

### Configure settings.xml

The default location for the `settings.xml` file is in your `~/.m2` directory.  Edit this file and ensure that you have a `<server>` entry as seen below:

```xml
<settings>
  <servers>
    <server>
      <!-- id is a unique identifier for a single repository.-->
      <id>io.cloudrepo</id>
      <!-- Email Address of the Repository User -->
      <username>repository-user-email-address</username>
      <!-- Password of the Repository User -->
      <password>repository-user-password</password>
    </server>
  </servers>
</settings>
```

**Explanation:**  By declaring a server and specifying an id, you can reference the id from within your Maven POM files.  When Maven attempts to authenticate against a server it will look for a corresponding key in the `settings.xml` file.

#### Password Encryption

If you're worried about storing your password in plaintext on your filesystem, please refer to [Maven's Guide to Password Encryption](https://maven.apache.org/guides/mini/guide-encryption.html).

If you're deploying to CloudRepo with [Rultor](http://www.rultor.com/) then this [Rultor Remote](https://github.com/yegor256/rultor-remote) can be used to encrypt your `settings.xml` file (more on this at the end of the article).

### Configure pom.xml

Now that your credentials have been set, you must point your [POM file](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html) (`pom.xml`) at your CloudRepo repository.

Add a new `<repository>` element to the `<distributionManagement>` section of your POM:

```xml
<project>
  <!-- All your other configuration -->
  <distributionManagement>
    <repository>
      <id>io.cloudrepo</id> <!-- Must Match the Unique Identifier in settings.xml -->
      <name>CloudRepo Maven Repository</name>
      <url>https://[your-org-name].mycloudrepo.io/repositories/[your-repository-name]</url>
    </repository>
  </distributionManagement>
</project>
```

**Explanation:** Your POM is now configured to deploy your artifacts to your repository whenever you use the `mvn deploy` command.

## Retrieving Artifacts from CloudRepo

After you've deployed your artifacts to your repository, you'll want to configure Maven to retrieve and download dependencies.

### Configure pom.xml

Configure your POM to point at your repository by adding a `<repository>` entry to the list of `<repositories>`:

```xml
<project>
  <!-- ...  -->
  <!-- Other Project Configuration (dependencies, etc.)-->
  <!-- ...  -->
  <repositories>
    <repository>
      <!--
      The username and password are retrieved by looking for the Repository
      Id in the $HOME/.m2/settings.xml file.
      -->
      <!-- id Must Match the Unique Identifier in settings.xml -->
      <id>io.cloudrepo</id>
      <url>https://[your-org-name].mycloudrepo.io/repositories/[your-repository-name]</url>
      <releases/>
    </repository>
  </repositories>
</project>
```

**Explanation:** With the above configuration, Maven will now retrieve dependencies from your CloudRepo repository.  Setting the `<id>` to match the `<id>` configured in the `settings.xml` file provides the credentials needed for authentication.

**Bonus Tip:**  Maven will retrieve dependencies from the repositories configured in the `pom.xml` as well as the default public repository, the [Maven Central Repository](https://www.cloudrepo.io/articles/public-maven-repositories-maven-central-and-more.html), where most of the world's open source artifacts are stored.

## Configure Rultor

Once you have a build working in your local environment, you may wish to deploy it to production with Rultor.  You can do that with the following steps:

### Encrypt settings.xml

We'll need to store your credentials in Git so that Rultor can access them at build and deploy time.   However, it is very important to ***never store your credentials in plaintext in version control***.   

Again: ***It's not safe to store plaintext credentials in Git.  Encrypt your credentials if you need to store them in version control.***

Fortunately, Rultor makes this easy with the following commands:

```bash
$ gem install rultor
$ rultor encrypt -p my/project settings.xml
```

**Note:** Substitute the name of your GitHub project with `my/project` in the above example.

This creates an encrypted version of your settings file with the name `settings.xml.asc`.  Add this file to the root directory of your project, then commit and push.  

Only Rultor has the keys to decrypt this file so even if your source code is exposed to others, your credentials will be kept safe.

### Create .rultor.yml

To enable Rultor, add a `.rultor.yml` file to the root directory of your project with the following contents:

```yaml
decrypt:
  settings.xml: "repo/settings.xml.asc"
deploy:
  script: |
    mvn clean deploy --settings ../settings.xml
```

**Note:** For more information on the `.rultor.yml` file, please see the [Rultor Reference Page](http://doc.rultor.com/reference.html).

### Deploying with Rultor

Now that everything is configued you should be able to deploy to CloudRepo with Rultor by executing the `@rultor deploy` command.

Wait for the response and Rultor will take care of all the rest.

That's it!