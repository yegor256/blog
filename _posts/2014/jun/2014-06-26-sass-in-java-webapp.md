---
layout: post
title: "SASS in Java Webapp"
date: 2014-06-26
tags: java
description: |
  SASS, as a CSS programming language, can be used effectively
  in a Java web application. Read how below.
keywords:
  - sass java
  - sass java web app
  - sass maven java
  - sass maven
  - sass java tomcat
  - scss in java webapp
  - scss java web app tomcat
---

[SASS](http://sass-lang.com/) is a powerful and very popular
language for writing [CSS](https://www.w3.org/Style/CSS/Overview.en.html)
style sheets. This is how I'm using SASS in my Maven projects.

First, I change the extensions of `.css` files to
`.scss` and move them from `src/main/webapp/css` to `src/main/scss`.

Then, I configure the [sass-maven-plugin](https://github.com/Jasig/sass-maven-plugin)
(get its latest versions in [Maven Central](http://search.maven.org/)):

```xml
<plugin>
  <groupId>nl.geodienstencentrum.maven</groupId>
  <artifactId>sass-maven-plugin</artifactId>
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
```

<!--more-->

The SASS compiler will compile `.scss` files from
`src/main/scss` and place `.css` files into `target/css`.

Then, I configure the [minify-maven-plugin](https://github.com/samaxes/minify-maven-plugin)
to compress/minify the style sheets produced by the SASS compiler:

```xml
<plugin>
  <groupId>com.samaxes.maven</groupId>
  <artifactId>minify-maven-plugin</artifactId>
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
```

Minified `.css` files will be placed into `target/css-min`.

The final step is to configure the
[maven-war-plugin](https://maven.apache.org/plugins/maven-war-plugin/)
to pick up `.css` files and package them into the final WAR archive:

```xml
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
```

That's it.
