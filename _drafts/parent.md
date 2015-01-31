---
layout: post
title: "Don't Repeat Yourself in Maven POMs, Use jcabi-parent"
date: 2015-02-10
tags: java maven jcabi
description:
  Maven pom.xml files may be very verbose repeatedly from project
  to project; jcabi-parent offers a pre-configured solution
keywords:
  - maven parent pom
  - maven pom settings
  - pom reference
  - maven pom
  - parent pom maven
---

{% badge http://img.jcabi.com/logo-square.svg 64 http://http.jcabi.com %}

Maven is a build automation tool, mostly for Java projects. It's a great
tool but it has one important drawback, which motivated the creation
of similar tools, like Gradle or SBT. It is its verbosity of configuration.
Maven gets all project build parameters from `pom.xml`, an XML
file that may be very long. I've seen POM files of 3000+ lines length.
Taking into account 1) recent DSL buzz and 2) fear of XML, it's
only logical that many people don't like Maven because of `pom.xml` verbosity.

But even if you're an XML fan enjoying its strictness and elegance
(like myself), you won't like the necessity to repeat yourself in `pom.xml`,
in every project. If you're working on multiple projects, code duplication
will be enormous. An average Java web app is using a few dozens of standard Maven plugins
and almost the same amount of pretty common dependencies, like
JUnit, Apache Commons, Log4J, Mockito, etc. All of them have their versions
and configurations, which have to be specified in you want to keep
the project stable and avoid Maven warnings. Thus, once a new version
of a plugin is released, you have to go through all `pom.xml` files in
the projects you're working on and update it there. You obviously understand
what code duplication means. It's a disaster. However, there is a solution.

<!--more-->

[jcabi-parent](http://parent.jcabi.com) is a very simple Maven dependency
with nothing inside except a large `pom.xml` with multiple pre-configured
dependencies, profiles and plugins. All you need to do in order to reuse thema
all in your project, define `com.jcabi:parent` as your parent POM:

{% highlight xml %}
<project xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <parent>
    <groupId>com.jcabi</groupId>
    <artifactId>parent</artifactId>
    <!-- check the latest version at http://parent.jcabi.com -->
    <version>0.32.1</version>
  </parent>
  [...]
</project>
{% endhighlight %}

That's all you need. Now you can remove most of your custom configurations
from `pom.xml` and rely on defaults provided by jcabi-parent. It's
[`pom.xml`](https://github.com/jcabi/jcabi-parent/blob/master/pom.xml)
is rather big and properly configured. Multiple projects depend on it, so you
can be confident that you're using the best possible configuration of
all standard plugins.

There are a few examples of `pom.xml` from projects that are using
jcabi-parent (you can see how compact they are):
[Xembly](https://github.com/yegor256/xembly/blob/master/pom.xml),
[ReXSL](https://github.com/yegor256/rexsl/blob/master/pom.xml),
[jcabi-http](https://github.com/jcabi/jcabi-http/blob/master/pom.xml), and
[Qulice](https://github.com/teamed/qulice/blob/master/pom.xml).
