---
layout: post
title: "Maven, PhantomJS, CasperJS, Tomcat"
date: 2014-06-18
tags: maven casperjs phantomjs tests
description:
  Practical example of running automated integration tests
  in Maven build, using Tomcat, PhantomJS and CasperJS
keywords:
  - maven casperjs
  - maven phantomjs
  - maven tomcat casperjs
  - maven phantomjs tomcat
  - integration tests with casperjs
  - maven tests with casperjs
---

I'm a big fan of automated testing in general and integration
testing in particular. I strongly believe that efforts spent on
writing tests are direct investments into quality and stability
of the product under development.

This is an example CasperJS test, which makes an HTTP request
to the home page of a running WAR application and asserts that
the response has `200` HTTP status code:

{% highlight javascript %}
casper.test.begin(
  'home page can be rendered',
  function (test) {
    casper.start(
      casper.cli.get('home'),
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
{% endhighlight %}

I keep this test in `src/test/casperjs/home-page.js`.

Let's see how this CasperJS can be executed automatically on every Maven build.
Here is the test scenario, implemented by
a combination of Maven plugins:

 1. Install PhantomJS

 2. Install CasperJS

 3. Reserve a random TCP port

 4. Start Tomcat at that TCP port, with WAR inside

 5. Run CasperJS tests, pointing them to the Tomcat running

 6. Shutdown Tomcat

I'm using a combination of plugins. Let's go through these steps,
one by one.

BTW, I'm not showing plugin versions in the examples below, mostly
because most of them are in active development. Check their versions
at [Maven Central](http://search.maven.org/)
(yes, all of them are available there).

## 1. Install PhantomJS

{% highlight xml %}
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
{% endhighlight %}

## 2. Install CasperJS

Unfortunately, there is no plugin for CasperJS installation (at least
I haven't found any). That's why, I'm using plain old `git`. You should
have it installed on your build machine.

{% highlight xml %}
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
{% endhighlight %}

## 3. Reserve TCP Port

I need to get a random TCP port, where Tomcat will be started. The
port has to be available on the build machine. I want to be able
to run multiple Maven builds in parallel, that's why I'm getting a
random port on every build.

In other examples you may see people using fixed port number, like `5555` or
similar. This is a very bad practice. Always reserve a new random port
when you need it.

{% highlight xml %}
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
{% endhighlight %}

This plugin reserves a port and sets it value to `${tomcat.port}` Maven
property.

## 4. Start Tomcat

{% highlight xml %}
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
    <execution>
      <id>stop-tomcat</id>
      <phase>post-integration-test</phase>
      <goals>
        <goal>shutdown</goal>
      </goals>
    </execution>
  </executions>
</plugin>
{% endhighlight %}

## 5. Run CasperJS

{% highlight xml %}
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
        <executable>${project.build.directory}/casperjs-install/bin/casperjs</executable>
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
{% endhighlight %}

Environment variable `PHANTOMJS_EXECUTABLE` is the undocumented feature
that makes the whole scenario possible. It configures the location of
PhantomJS executable, which was downloaded a few steps above.

## 6. Shutdown Tomcat

{% highlight xml %}
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
{% endhighlight %}
