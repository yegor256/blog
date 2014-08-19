---
layout: post
title: "How to Release to Maven Central, in One Click"
date: 2014-08-19
tags: java rultor devops
description:
  This tutorial explains how a Java project can be
  released to Maven Central in just one click and
  zero maintenance efforts, using Rultor.com, DevOps assistant
keywords:
  - release to maven central
  - how to release to maven central
  - maven central release
  - fast release to maven central
  - publish from github to maven central
  - upload to maven central
  - publishing to maven central with sonatype
---

When I release a new version of [jcabi-aspects](http://aspects.jcabi.com),
a Java open source library, to Maven Central, it takes 30 seconds of my time.
Maybe even less. Recently, I released version 0.17.2. You can see
how it all happened, in [Github issue #80](https://github.com/jcabi/jcabi-aspects/issues/80):

{% figure http://img.yegor256.com/2014/08/github-ticket-80.png 600 %}

As you see, I gave a command to [Rultor](http://www.rultor.com),
and it released a new version to Maven central. I didn't do anything else.

Now let's see how you can do the same. How you can configure your project
so that the release of its new version to Maven Central
takes just a few seconds of your time.

<!--more-->

By the way, I assume that you're hosting your project in Github. If not,
this entire tutorial won't work. If you are still not in Github, I would
strongly recommend moving there.

## Prepare Your POM

Make sure your `pom.xml` contains all elements required by Sonatype,
explained in [Central Sync Requirements](https://docs.sonatype.org/display/Repository/Central+Sync+Requirements).
We will release to Sonatype, and they will syncronize all JAR (and not only)
artifacts to Maven Central.

## Register a Project With Sonatype

Create an account in [Sonatype JIRA](https://issues.sonatype.org/)
and raise a ticket, asking to approve your groupId. This
[OSSRH Guide](http://central.sonatype.org/pages/ossrh-guide.html)
explains this step in more detail.

## Create and Distribute a GPG Key

Create a GPG key and distribute it, as explained in this
[Working with PGP Signatures](http://central.sonatype.org/pages/working-with-pgp-signatures.html)
article.

When this step is done, you should have two files:
`pubring.gpg` and `secring.gpg`.

## Create settings.xml

Create `settings.xml`, next to the two `.gpg` files created in the previous step:

{% highlight xml %}
<settings>
  <profiles>
    <profile>
      <id>foo</id> <!-- give it the name of your project -->
      <properties>
        <gpg.homedir>/home/r</gpg.homedir>
        <gpg.keyname>9A105525</gpg.keyname>
        <gpg.passphrase>my-secret</gpg.passphrase>
      </properties>
    </profile>
  </profiles>
  <servers>
    <server>
      <id>sonatype</id>
      <username><!-- Sonatype JIRA user name --></username>
      <password><!-- Sonatype JIRA pwd --></password>
    </server>
  </servers>
</settings>
{% endhighlight %}

In this example, `9A105525` is the ID of your public key, and `my-secret`
is the pass phrase you have used while generating the keys.

## Encrypt Security Assets

Now, encrypt these three files with a Rultor public key (`9AF0FA4C`):

{% highlight xml %}
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 9AF0FA4C
gpg --trust-model always -a -e -r 9AF0FA4C pubring.gpg
gpg --trust-model always -a -e -r 9AF0FA4C secring.gpg
gpg --trust-model always -a -e -r 9AF0FA4C settings.xml
{% endhighlight %}

You will get three new files: `pubring.gpg.asc`, `secring.gpg.asc`
and `settings.xml.asc`. Add them to the root directory of your project,
commit and push. The files contain your secret information,
but only the Rultor server can decrypt them.

## Add Sonatype Repositories

I would recommend using [jcabi-parent](http://parent.jcabi.com), as
a parent pom for your project. This will make many further steps
unnecessary. If you're using jcabi-parent, skip this step.

However, if you don't use jcabi-parent, you should add these two repositories
to your `pom.xml`:

{% highlight xml %}
<project>
  [...]
  <distributionManagement>
    <repository>
      <id>oss.sonatype.org</id>
      <url>https://oss.sonatype.org/service/local/staging/deploy/maven2/</url>
    </repository>
    <snapshotRepository>
      <id>oss.sonatype.org</id>
      <url>https://oss.sonatype.org/content/repositories/snapshots</url>
    </snapshotRepository>
  </distributionManagement>
</project>
{% endhighlight %}

## Configure GPG Plugin

Again, I'd recommend using [http://parent.jcabi.com](jcabi-parent),
which configures this plugin automatically. If you're using it, skip this step.

Otherwise, add this plugin to your `pom.xml`:

{% highlight xml %}
<project>
  [..]
  <build>
    [..]
    <plugins>
      [..]
      <plugin>
        <artifactId>maven-gpg-plugin</artifactId>
        <version>1.5</version>
        <executions>
          <execution>
            <id>sign-artifacts</id>
            <phase>verify</phase>
            <goals>
              <goal>sign</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
</project>
{% endhighlight %}

## Configure Versions Plugin

Once again, I recommend using [http://parent.jcabi.com](jcabi-parent). It
configures all required plugins out-of-the-box. If you're using it, skip this step.

Otherwise, add this plugin to your `pom.xml`:

{% highlight xml %}
<project>
  [..]
  <build>
    [..]
    <plugins>
      [..]
      <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>versions-maven-plugin</artifactId>
        <version>2.1</version>
        <configuration>
          <generateBackupPoms>false</generateBackupPoms>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
{% endhighlight %}

## Configure Sonatype Plugin

Yes, you're right, [http://parent.jcabi.com](jcabi-parent) will help
you here as well. If you're using it, skip this step too.

Otherwise, add these four plugins to your `pom.xml`:

{% highlight xml %}
<project>
  [..]
  <build>
    [..]
    <plugins>
      [..]
      <plugin>
        <artifactId>maven-deploy-plugin</artifactId>
        <configuration>
          <skip>true</skip>
        </configuration>
      </plugin>
      <plugin>
        <artifactId>maven-source-plugin</artifactId>
        <executions>
          <execution>
            <id>package-sources</id>
            <goals>
              <goal>jar</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
      <plugin>
        <artifactId>maven-javadoc-plugin</artifactId>
        <executions>
          <execution>
            <id>package-javadoc</id>
            <phase>package</phase>
            <goals>
              <goal>jar</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
      <plugin>
        <groupId>org.sonatype.plugins</groupId>
        <artifactId>nexus-staging-maven-plugin</artifactId>
        <version>1.6</version>
        <extensions>true</extensions>
        <configuration>
          <serverId>oss.sonatype.org</serverId>
          <nexusUrl>https://oss.sonatype.org/</nexusUrl>
          <description>${project.version}</description>
        </configuration>
        <executions>
          <execution>
            <id>deploy-to-sonatype</id>
            <phase>deploy</phase>
            <goals>
              <goal>deploy</goal>
              <goal>release</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
</project>
{% endhighlight %}

## Create Rultor Config

Create a `.rultor.yml` file in the root directory of your project
([reference page](http://doc.rultor.com/reference.html)
explains this format in details):

{% highlight yaml %}
decrypt:
  settings.xml: "repo/settings.xml.asc"
  pubring.gpg: "repo/pubring.gpg.asc"
  secring.gpg: "repo/secring.gpg.asc"
release:
  script:
    - "mvn versions:set \"-DnewVersion=${tag}\""
    - "git commit -am \"${tag}\""
    - "mvn clean deploy --settings /home/r/settings.xml"
{% endhighlight %}

You can compare your file with live Rultor
[configuration of jcabi-aspects](https://github.com/jcabi/jcabi-aspects/blob/master/.rultor.yml).

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
