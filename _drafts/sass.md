---
layout: post
title: "SASS in Java Webapp"
date: 2014-06-25
tags: java sass webapp
description:
  SASS, as a CSS programming language, can be effectively
  used in a Java web application, read how
keywords:
  - sass java
  - sass java web app
  - sass maven java
  - sass maven
  - sass java tomcat
---

[SASS](http://sass-lang.com/)
is a powerful and very popular language for writing
[CSS](http://www.w3.org/Style/CSS/Overview.en.html) stylesheets.
This is how I'm using SASS in my Maven projects.

First, I change the extensions of `.css` files to `.scss` and move
them from `src/main/webapp/css` to `src/main/scss`.

Then, I configure [sass-maven-plugin](https://github.com/Jasig/sass-maven-plugin):

{% highlight xml %}
<plugin>
  <groupId>org.jasig.maven</groupId>
  <artifactId>sass-maven-plugin</artifactId>
  <version>1.1.1</version>
  <executions>
    <execution>
      <id>generate-css</id>
      <phase>generate-resources</phase>
      <goals>
        <goal>update-stylesheets</goal>
      </goals>
      <configuration>
        <sassSourceDirectory>${basedir}/src/main/scss</sassSourceDirectory>
        <destination>${project.build.directory}/css</destination>
      </configuration>
    </execution>
  </executions>
</plugin>
{% endhighlight %}

SASS compiler will compile `.scss` files from `src/main/scss` and
place `.css` files into `target/css`.

Then, I configure [minify-maven-plugin](https://github.com/samaxes/minify-maven-plugin),
in order to compress/minify the stylesheets produced by SASS compiler:

{% highlight xml %}
<plugin>
  <groupId>com.samaxes.maven</groupId>
  <artifactId>minify-maven-plugin</artifactId>
  <version>1.7.2</version>
  <configuration>
    <charset>UTF-8</charset>
    <nosuffix>true</nosuffix>
    <webappTargetDir>${project.build.directory}/css-min</webappTargetDir>
  </configuration>
  <executions>
    <execution>
      <id>minify-css</id>
      <goals>
        <goal>minify</goal>
      </goals>
      <configuration>
        <webappSourceDir>${project.build.directory}</webappSourceDir>
        <cssSourceDir>css</cssSourceDir>
        <cssSourceIncludes>
          <include>*.css</include>
        </cssSourceIncludes>
        <skipMerge>true</skipMerge>
      </configuration>
    </execution>
  </executions>
</plugin>
{% endhighlight %}

Minified `.css` files will be placed into `target/css-min`.

And the final step is to configure [maven-war-plugin](http://maven.apache.org/plugins/maven-war-plugin/)
to pick up `.css` files and package them into the final WAR archive:

{% highlight xml %}
<plugin>
  <artifactId>maven-war-plugin</artifactId>
  <configuration>
    [..other configuration options..]
    <webResources combine.children="append">
      <resource>
        <directory>${project.build.directory}/css-min</directory>
      </resource>
    </webResources>
  </configuration>
</plugin>
{% endhighlight %}

That's it.
