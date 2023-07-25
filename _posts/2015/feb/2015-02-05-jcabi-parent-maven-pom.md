---
layout: post
title: "Don't Repeat Yourself in Maven POMs; Use Jcabi-Parent"
date: 2015-02-05
tags: java maven jcabi
categories: jcg
description: |
  Maven pom.xml files may be repeatedly verbose from project
  to project; jcabi-parent offers a pre-configured solution.
keywords:
  - maven parent pom
  - maven pom settings
  - pom reference
  - maven pom
  - parent pom maven
---

{% badge https://www.jcabi.com/logo-square.svg 64 http://http.jcabi.com %}

Maven is a build automation tool mostly for Java projects. It's a great
tool, but it has one important drawback that has motivated the creation
of similar tools, like Gradle and SBT. That weakness is its verbosity of configuration.
Maven gets all project build parameters from `pom.xml`, an XML
file that can get very long. I've seen POM files of 3,000-plus lines.
Taking into account 1) recent DSL buzz and 2) fear of XML, it's
only logical that many people don't like Maven because of its `pom.xml` verbosity.

But even if you're an XML fan who enjoys its strictness and elegance
(like myself), you won't like the necessity to repeat yourself in `pom.xml`
for every project. If you're working on multiple projects, code duplication
will be enormous. An average Java web app uses a few dozen standard Maven plugins
and almost the same number of pretty common dependencies, like
JUnit, Apache Commons, Log4J, Mockito, etc. All of them have their versions
and configurations, which have to be specified if you want to keep
the project stable and avoid Maven warnings. Thus, once a new version
of a plugin is released, you have to go through all `pom.xml` files in
the projects you're working on and update it there. You obviously understand
what code duplication means. It's a disaster. However, there is a solution.

<!--more-->

[jcabi-parent](http://parent.jcabi.com) is a very simple Maven dependency
with nothing inside it except a large `pom.xml` with multiple pre-configured
dependencies, profiles, and plugins. All you need to do in order to reuse them
all in your project is define `com.jcabi:parent` as your parent POM:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
    http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <parent>
    <groupId>com.jcabi</groupId>
    <artifactId>parent</artifactId>
    <!-- check the latest version at http://parent.jcabi.com -->
    <version>0.32.1</version>
  </parent>
  [...]
</project>
```

That's all you need. Now you can remove most of your custom configurations
from `pom.xml` and rely on defaults provided by jcabi-parent. Its
[`pom.xml`](https://github.com/jcabi/jcabi-parent/blob/master/pom.xml)
is rather large and properly configured. Multiple projects depend on it, so you
can be confident that you're using the best possible configuration of
all standard plugins.

Here are a few examples of `pom.xml` from projects that are using
jcabi-parent (you can see how compact they are):
[Xembly](https://github.com/yegor256/xembly/blob/master/pom.xml)
[ReXSL](https://github.com/yegor256/rexsl/blob/master/pom.xml)
[jcabi-http](https://github.com/jcabi/jcabi-http/blob/master/pom.xml)
[Qulice](https://github.com/teamed/qulice/blob/master/pom.xml)
