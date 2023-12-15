---
layout: post
title: "How to Read MANIFEST.MF Files"
date: 2014-07-03
tags: java jcabi
description: |
  When there are many of them, then reading of MANIFEST.MF
  files can be a complex task, and their attributes may overlap;
  jcabi-manifests  library makes this process easier.
keywords:
  - manifest.mf example
  - manifest.mf maven
  - manifest.mf classpath
  - java manifest.mf
  - java read manifest.mf
  - manifest files java
  - how to read manifest.mf
---

{% badge https://www.jcabi.com/logo-square.svg 64 http://manifests.jcabi.com %}

Every Java package (JAR, WAR, EAR, etc.) has
a [`MANIFEST.MF`](http://docs.oracle.com/javase/tutorial/deployment/jar/manifestindex.html)
file in the `META-INF` directory. The file contains a list of attributes,
which describe this particular package. For example:

```text
Manifest-Version: 1.0
Created-By: 1.7.0_06 (Oracle Corporation)
Main-Class: MyPackage.MyClass
```

When your application has multiple JAR dependencies, you have multiple
`MANIFEST.MF` files in your class path. All of them have the same location:
`META-INF/MANIFEST.MF`. Very often it is necessary to go through all of
them in runtime and find the attribute by its name.

[jcabi-manifests](http://manifests.jcabi.com) makes it possible with a one-liner:

```java
import com.jcabi.manifests.Manifests;
String created = Manifests.read("Created-By");
```

<!--more-->

Let's see why you would want to read attributes from manifest
files, and how it works on a low level.

## Package Versioning

When you package a library or even a web application,
it is a good practice to add an attribute to its `MANIFEST.MF`
with the package version name and build number. In Maven,
[`maven-jar-plugin`](https://maven.apache.org/plugins/maven-jar-plugin/)
can help you (almost the same configuration for
[`maven-war-plugin`](https://maven.apache.org/plugins/maven-war-plugin/)):

```xml
<plugin>
  <artifactId>maven-jar-plugin</artifactId>
  <configuration>
    <archive>
      <manifestEntries>
        <Foo-Version>${project.version}</Foo-Version>
        <Foo-Hash>${buildNumber}</Foo-Hash>
      </manifestEntries>
    </archive>
  </configuration>
</plugin>
```

`buildnumber-maven-plugin`
will help you to get `${buildNumber}` from Git, SVN or Mercurial:

```xml
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>buildnumber-maven-plugin</artifactId>
  <executions>
    <execution>
      <goals>
        <goal>create</goal>
      </goals>
    </execution>
  </executions>
</plugin>
```

After all these manipulations, `MANIFEST.MF`, in your JAR will
contain these two extra lines (on top of all others added there by Maven by default):

```text
Foo-Version: 1.0-SNAPSHOT
Foo-Hash: 7ef4ac3
```

In runtime, you can show these values to the user to help him
understand which version of the product he is working with at any given moment.

Look at [stateful.co](https://www.stateful.co), for example. At the bottom
of its front page, you see the version number and Git hash. They are
retrieved from `MANIFEST.MF` of the deployed WAR package, on every page click.

## Credentials

Although this may be considered as a bad practice
(see [Continuous Delivery: Reliable Software Releases through Build, Test, and Deployment Automation](https://amzn.to/2bQVmlb)
by Jez Humble and David Farley), sometimes it is convenient to package production
credentials right into the JAR/WAR archive during the
[continuous integration]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %})/delivery cycle.

For example, you can encode your PostgreSQL connection
details right into `MANIFEST.MF`:

```xml
<plugin>
  <artifactId>maven-war-plugin</artifactId>
  <configuration>
    <archive>
      <manifestEntries>
        <Pgsql>jdbc:postgresql://${pg.host}:${pg.port}/${pg.db}</Pgsql>
      </manifestEntries>
    </archive>
  </configuration>
</plugin>
```

Afterwards, you can retrieve them in
runtime using [`jcabi-manifests`](http://manifests.jcabi.com):

```java
String url = Manifests.read("Pgsql");
```

If you know of any other useful purposes for `MANIFEST.MF`, let me know.

