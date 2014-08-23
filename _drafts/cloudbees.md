---
layout: post
title: "How to Deploy to CloudBees, in One Click"
date: 2014-08-24
tags: java rultor devops
description:
  This tutorial explains how a Java web application can be
  deployed to CloudBees in just one click and
  zero maintenance efforts, using Rultor.com, DevOps assistant
keywords:
  - deploy to cloudbees
  - how to host java web app
  - how to deploy a java app to cloudbees
  - deploying to cloudbees
  - deploy in cloudbees
  - publish java web app to cloudbees
  - continuous delivery cloudbees
---

When I deploy a new version of [stateful.co](http://www.stateful.co),
a Java web application, to CloudBees, it takes 30 seconds of my time.
Maybe even less. Recently, I deployed version 1.6.5. You can see
how it all happened, in [Github issue #6](https://github.com/sttc/stateful/issues/6):

{% figure http://img.yegor256.com/2014/08/github-sttc-issue-6.png 600 %}

As you see, I gave a command to [Rultor](http://www.rultor.com),
and it packaged, tested and deployed a new version to CloudBees.
I didn't do anything else.

Now let's see how you can do the same. How you can configure your project
so that the deployment of its new version to CloudBees
takes just a few seconds of your time.

<!--more-->

## Configure CloudBees Maven Plugin

Add this profile to your `pom.xml`:

{% highlight xml %}
<project>
  [..]
  <profiles>
    <profile>
      <id>cloudbees</id>
      <activation>
        <property><name>bees.appId</name></property>
      </activation>
      <pluginRepositories>
        <pluginRepository>
          <id>cloudbees-public-release</id>
          <url>http://repository-cloudbees.forge.cloudbees.com/public-release</url>
        </pluginRepository>
      </pluginRepositories>
      <build>
        <pluginManagement>
          <plugins>
            <plugin>
              <artifactId>maven-deploy-plugin</artifactId>
              <configuration>
                  <skip>true</skip>
              </configuration>
            </plugin>
          </plugins>
        </pluginManagement>
        <plugins>
          <plugin>
            <groupId>com.cloudbees</groupId>
            <artifactId>bees-maven-plugin</artifactId>
            <version>1.3.2</version>
            <configuration>
              <appid>${bees.id}</appid>
              <apikey>${bees.key}</apikey>
              <secret>${bees.secret}</secret>
            </configuration>
            <executions>
              <execution>
                <id>deploy-to-production</id>
                <phase>deploy</phase>
                <goals>
                  <goal>deploy</goal>
                </goals>
              </execution>
            </executions>
          </plugin>
        </plugins>
      </build>
    </profile>
  </profiles>
</project>
{% endhighlight %}

This plugin is not in Maven Central (unfortunately), that's why
we have to specify that `<pluginRepository>`.

Pay attention that we're also disabling `maven-deploy-plugin`, since
it would try to deploy your WAR package to the repository from
`<distributionManagement>` section. We want to avoid this.

The profile is getting activated only when property `bees.id`
is defined. This won't happen during your normal development and testing,
but will occur during deployment cycle initiated by Rultor, becase
we will define this property in `settings.xml` (discussed below).

## Secure Access to CloudBees

Create an account in CloudBees and register your web application there.
It is free, as long as you don't need too much of computing power. I believe
that web applications should light-weight by definition, so CloudBees free
layer is an ideal choice.

Create `settings.xml` file (but don't commit it to your repo!):

{% highlight xml %}
<settings>
  <profiles>
    <profile>
      <id>cloudbees</id>
      <properties>
        <bees.id>stateful/web</bees.id>
        <bees.key><!-- your key --></bees.key>
        <bees.secret><!-- your secret --></bees.secret>
      </properties>
    </profile>
  </profiles>
</settings>
{% endhighlight %}

Encrypt this file using GPG, with Rultor key:

{% highlight xml %}
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 9AF0FA4C
gpg --trust-model always -a -e -r 9AF0FA4C settings.xml
{% endhighlight %}

You should get `settings.xml.asc` file. Add it to the root directory
of your project, commit and push. This file contains your CloudBees
credentials, but in an encrypted format. Nobody can read it, except
Rultor server.

## Configure Rultor

Create a `.rultor.yml` file in the root directory of your project
([reference page](http://doc.rultor.com/reference.html)
explains this format in details):

{% highlight yaml %}
decrypt:
  settings.xml: "repo/settings.xml.asc"
release:
  script: |
    mvn versions:set "-DnewVersion=${tag}"
    git commit -am "${tag}"
    mvn clean deploy --settings /home/r/settings.xml
{% endhighlight %}

You can compare your file with live Rultor
[configuration of stateful.co](https://github.com/sttc/stateful/blob/master/.rultor.yml).

## Run It!

{% badge http://img.rultor.com/logo.svg 100 http://www.rultor.com %}

Now it's time to see how it all works. Create a new ticket in the
Github issue tracker, and post something like that into it
(read more about [Rultor commands](http://doc.rultor.com/basics.html)):

{% highlight text %}
@rultor release, tag is `0.1`
{% endhighlight %}

You will get a response in a few seconds. The rest will be done by Rultor.

Enjoy :)

BTW, if something doesn't work as I've explained, don't hesitate to
submit a ticket to
[Rultor issue tracker](https://github.com/yegor256/rultor/issues).
I will try to help you.

BTW, a similar configuration can be done
for Heroku (using [jcabi-heroku-maven-plugin](http://heroku.jcabi.com))
and for AWS Elastic Beanstalk (using [jcabi-beanstalk-maven-plugin](http://beanstalk.jcabi.com)).
I'll probably dedicate individual posts to them.
