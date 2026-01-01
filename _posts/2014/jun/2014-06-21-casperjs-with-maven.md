---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "CasperJS Tests in Maven Build"
date: 2014-06-21
tags: maven testing
description: |
  Practical example of running automated integration tests
  in Maven build using Tomcat, PhantomJS and CasperJS
keywords:
  - maven casperjs
  - maven phantomjs
  - maven tomcat casperjs
  - maven phantomjs tomcat
  - integration tests with casperjs
  - maven tests with casperjs
  - phantomjs maven plugin
---

I'm a big fan of automated testing in general and integration
testing in particular. I strongly believe that effort spent on
writing tests are direct investments into
[quality]({% pst 2017/dec/2017-12-26-software-quality-formula %}) and stability
of the product under development.

[CasperJS](http://casperjs.org/) is a testing framework on top of
[PhantomJS](http://phantomjs.org/), which is a headless browser. Using
CasperJS, we can ensure that our application responds correctly
to requests sent by a regular web browser.

<!--more-->

This is a sample CasperJS test, which makes an HTTP request to a home page
of a running WAR application and asserts that the response has
`200` HTTP status code:

```javascript
casper.test.begin(
  'home page can be rendered',
  function (test) {
    casper.start(
      casper.cli.get('home'), // URL of home page
      function () {
        test.assertHttpStatus(200);
      }
    );
    casper.run(
      function () {
        test.done();
      }
    );
  }
);
```

I keep this test in the `src/test/casperjs/home-page.js` file.
Let's see how CasperJS can be executed automatically on every Maven build.

Here is the test scenario, implemented with a combination of Maven plugins:

 1. Install PhantomJS

 2. Install CasperJS

 3. Reserve a random TCP port

 4. Start Tomcat on that TCP port (with WAR inside)

 5. Run CasperJS tests and point them to the running Tomcat

 6. Shutdown Tomcat

I'm using a combination of plugins. Let's go through the steps one by one.

BTW, I'm not showing plugin versions in the examples below, primarily
because most of them are in active development. Check their versions
at [Maven Central](http://search.maven.org/) (yes, all of them are available there).

## 1. Install PhantomJS

First of all, we have to download the PhantomJS executable.
It is a platform-specific binary. Thanks to [Kyle Lieber](https://github.com/klieber),
we have an off-the-shelf Maven plugin:
[phantomjs-maven-plugin](https://github.com/klieber/phantomjs-maven-plugin)
that understands what the current platform is and downloads the appropriate
binary automatically, placing it into the `target` directory.

```xml
<plugin>
  <groupId>com.github.klieber</groupId>
  <artifactId>phantomjs-maven-plugin</artifactId>
  <executions>
    <execution>
      <goals>
        <goal>install</goal>
      </goals>
    </execution>
  </executions>
  <configuration>
    <version>1.9.2</version>
  </configuration>
</plugin>
```

The exact name of the downloaded binary is stored in the
`${phantomjs.binary}` Maven property.

## 2. Install CasperJS

Unfortunately, there is no similar plugin for the CasperJS installation
(at least I haven't found any as of yet). That's why I'm using plain
old `git` (you should have it installed on your build machine).

```xml
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>exec-maven-plugin</artifactId>
  <executions>
    <execution>
      <id>casperjs-install</id>
      <phase>pre-integration-test</phase>
      <goals>
        <goal>exec</goal>
      </goals>
      <configuration>
        <executable>git</executable>
        <arguments>
          <argument>clone</argument>
          <argument>--depth=1</argument>
          <argument>https://github.com/n1k0/casperjs.git</argument>
          <argument>${project.build.directory}/casperjs</argument>
        </arguments>
      </configuration>
    </execution>
  </executions>
</plugin>
```

## 3. Reserve TCP Port

I need to obtain a random TCP port where Tomcat will be started.
The port has to be available on the build machine. I want to be able
to run multiple Maven builds in parallel, so that's why I get a random port on every build.

In other examples, you may see people using fixed port numbers,
like `5555` or something similar. This is a very bad practice.
Always reserve a new random port when you need it.

```xml
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>build-helper-maven-plugin</artifactId>
  <executions>
    <execution>
      <id>tomcat-port</id>
      <goals>
        <goal>reserve-network-port</goal>
      </goals>
      <configuration>
        <portNames>
          <portName>tomcat.port</portName>
        </portNames>
      </configuration>
    </execution>
  </executions>
</plugin>
```

The plugin reserves a port and sets it value to the `${tomcat.port}` Maven property.

## 4. Start Tomcat

Now, it's time to start Tomcat with the WAR package inside.
I'm using [tomcat7-maven-plugin](http://tomcat.apache.org/maven-plugin-2.0/tomcat7-maven-plugin/)
that starts a real Tomcat7 server and configures it to serve on the port reserved above.

```xml
<plugin>
  <groupId>org.apache.tomcat.maven</groupId>
  <artifactId>tomcat7-maven-plugin</artifactId>
  <configuration>
    <path>/</path>
  </configuration>
  <executions>
    <execution>
      <id>start-tomcat</id>
      <phase>pre-integration-test</phase>
      <goals>
        <goal>run-war-only</goal>
      </goals>
      <configuration>
        <port>${tomcat.port}</port>
        <fork>true</fork>
      </configuration>
    </execution>
  </executions>
</plugin>
```

Due to the option `fork` being set to `true`, Tomcat7 continues
to run when the plugin execution finishes. That's exactly what I need.

## 5. Run CasperJS

Now, it's time to run CasperJS. Even though there are some
plugins exist for this, I'm using plain old
`exec-maven-plugin`,
mostly because it is more configurable.

```xml
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>exec-maven-plugin</artifactId>
  <executions>
    <execution>
      <id>casperjs-test</id>
      <phase>integration-test</phase>
      <goals>
        <goal>exec</goal>
      </goals>
      <configuration>
        <executable>
          ${project.build.directory}/casperjs/bin/casperjs
        </executable>
        <workingDirectory>${basedir}</workingDirectory>
        <arguments>
          <argument>test</argument>
          <argument>--verbose</argument>
          <argument>--no-colors</argument>
          <argument>--concise</argument>
          <argument>--home=http://localhost:${tomcat.port}</argument>
          <argument>${basedir}/src/test/casperjs</argument>
        </arguments>
        <environmentVariables>
          <PHANTOMJS_EXECUTABLE>${phantomjs.binary}</PHANTOMJS_EXECUTABLE>
        </environmentVariables>
      </configuration>
    </execution>
  </executions>
</plugin>
```

The environment variable `PHANTOMJS_EXECUTABLE` is the undocumented
feature that makes this whole scenario possible. It configures
the location of the PhantomJS executable, which was downloaded a few steps above.

## 6. Shutdown Tomcat

In the last step, I shut down the Tomcat server.

```xml
<plugin>
  <groupId>org.apache.tomcat.maven</groupId>
  <artifactId>tomcat7-maven-plugin</artifactId>
  <executions>
    <execution>
      <id>stop-tomcat</id>
      <phase>post-integration-test</phase>
      <goals>
        <goal>shutdown</goal>
      </goals>
    </execution>
  </executions>
</plugin>
```

## Real Example

If you want to see how this all works in action, take
a look at [stateful.co](https://www.stateful.co). It is a Java
Web application hosted at [CloudBees](https://www.cloudbees.com).
Its source code is open and available in [GitHub](https://github.com/sttc/stateful).

Its [`pom.xml`](https://github.com/sttc/stateful/blob/sttc-1.5/pom.xml)
contains exactly the same configurations explained above, but joined together.

If you have any questions, please don't hesitate to ask below.

PS. Also, check this:
[PhantomJS as an HTML Validator]({% pst 2014/apr/2014-04-06-phandom %})
