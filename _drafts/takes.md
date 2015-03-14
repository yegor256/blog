---
layout: post
title: "Takes Framework, First Steps"
date: 2015-02-10
tags: java
description:
  ...
keywords:
  - java web framework
  - java web development framework
  - best java web framework
  - object-oriented java web framework
  - java web app framework
---

Let's go, step by step.

<!--more-->

First, you create a Maven `pom.xml` project model:

{% highlight java %}
<?xml version="1.0"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <parent>
    <groupId>com.jcabi</groupId>
    <artifactId>parent</artifactId>
    <version>0.32.1</version>
  </parent>
  <groupId>org.takes</groupId>
  <artifactId>foo</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>jar</packaging>
  <name>foo</name>
  <dependencies>
    <dependency>
      <groupId>org.takes</groupId>
      <artifactId>takes</artifactId>
      <version>0.8.5</version>
    </dependency>
    <dependency>
      <groupId>com.jcabi.incubator</groupId>
      <artifactId>xembly</artifactId>
      <version>0.20.1</version>
    </dependency>
  </dependencies>
</project>
{% endhighlight %}

I'm using `com.jcabi:parent` POM as a parent object model, because
this [helps to reduce verbosity]({% pst 2015/feb/2015-02-05-jcabi-parent-maven-pom %})
in this XML.

There are just too dependencies: `org.takes:takes` fo the framework itself
and `com.jcabi.incubator:xembly` for Xembly processing (see below).

Now, let's create all other supplementary files. This is the project layout
you should have:

{% highlight text %}
/src
  /main
    /java
      /foo
        Entrance.java
        App.java
    /scss
    /js
    /xsl
    /resources
      /META-INF
        MANIFEST.MF
      log4j.properties
  /test
    /java
      /foo
        AppTest.java
    /resources
      /META-INF
        MANIFEST.MF
      log4j.properties
pom.xml
LICENSE.txt
{% endhighlight %}

Let's create basic entrance

Now, let's deploy it to Heroku:

{% highlight java %}
<project>
  [...]
  <profiles>
    <profile>
      <id>heroku</id>
      <activation>
        <file><exists>pom.xml</exists></file>
      </activation>
      <build>
        <finalName>heroku</finalName>
        <plugins>
          <plugin>
            <artifactId>maven-assembly-plugin</artifactId>
            <executions>
              <execution>
                <id>make-assembly</id>
                <phase>package</phase>
                <goals>
                  <goal>single</goal>
                </goals>
                <configuration>
                  <archive>
                    <manifestFile>${project.build.outputDirectory}/META-INF/MANIFEST.MF</manifestFile>
                  </archive>
                  <descriptorRefs>
                    <descriptorRef>jar-with-dependencies</descriptorRef>
                  </descriptorRefs>
                </configuration>
              </execution>
            </executions>
          </plugin>
        </plugins>
      </build>
    </profile>
  </profiles>
</project>
{% endhighlight %}



Let's see what's happening behind the scene.
