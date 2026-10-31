---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "How to Use Nutch From Java, Not From the Command Line"
date: 2019-04-17
place: Moscow, Russia
tags: java
description: |
  Nutch is an open source framework for crawling
  web content, however it is designed primarily to
  be used from the command line; here I explain how
  to use it from inside Java.
keywords:
  - nutch
  - nutch in java
  - java nutch
  - nutch without command line
  - nutch apache
---

[Apache Nutch](https://nutch.apache.org/)
is an open source framework written in Java. Its purpose
is to help us crawl a set of websites (or the entire Internet), fetch
the content, and prepare it for indexing by, say, Solr. A pretty useful
framework if you ask me, however it is designed to be used ~~only~~
mostly from the command line. You download the archive, unzip it, and run
the binary file. It crawls and you get the data. However, I've got a project
where this crawling had to be embedded into my own Java app. I realized
that there is a complete absence of any documentation for that. Hence
this blog post. It explains how you can use Nutch from Java, not from
the command line.

<!--more-->

I'll be talking about Nutch 1.15. There is a later version 2+, but I didn't
manage to make it work. If you know how, leave your comment below.

I'd recommend you read [this tutorial](https://examples.javacodegeeks.com/enterprise-java/apache-hadoop/apache-hadoop-nutch-tutorial/)
first, to understand how Nutch works from the command line. Well,
it helped me anyway.

Now, let's see how we can use Nutch without the command line.
First, you need these dependencies in your `pom.xml`
(Nutch uses [Apache Hadoop](https://hadoop.apache.org/), that's why we need the
second dependency):

```xml
<project>
  <dependencies>
    <dependency>
      <groupId>org.apache.nutch</groupId>
      <artifactId>nutch</artifactId>
      <version>1.15</version>
    </dependency>
    <dependency>
      <groupId>org.apache.hadoop</groupId>
      <artifactId>hadoop-common</artifactId>
      <version>2.7.2</version>
    </dependency>
    [...]
  </dependencies>
  [...]
</project>
```

Next, this is your Java code, which does all the work:

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import org.apache.commons.io.FileUtils;
import org.apache.hadoop.conf.Configuration;
import org.apache.nutch.crawl.CrawlDb;
import org.apache.nutch.crawl.Generator;
import org.apache.nutch.crawl.Injector;
import org.apache.nutch.fetcher.Fetcher;
import org.apache.nutch.parse.ParseSegment;
import org.apache.nutch.tools.FileDumper;
public class Main {
  public static void main(String... args) throws Exception {
    // Create a default configuration object, which will read
    // the content of nutch-default.xml file from the classpath,
    // parse it and take its entire content as the default
    // configuration. Funny, but this interface is from Hadoop:
    Configuration conf = NutchConfiguration.create();
    // Now it's possible to reset some configuration parameters
    // by using this set() method. This one is mandatory, if you
    // don't set it the crawling won't work. The value is used
    // as User-Agent HTTP header.
    conf.set("http.agent.name", "me, myself, and I");
    // This one is also mandatory and we will discuss its
    // value below. You need to point Nutch to the directory
    // with compiled plugins and this collection is NOT in
    // its default JAR package, unfortunately.
    conf.set("plugin.folders", System.getProperty("nutch.plugins.dir"));
    // First, we need to have a directory where everything will
    // happen. I assume you are familiar with Maven, so let's use
    // its default temporary directory "target":
    Path home = new Path("target");
    // Next, we have to create a file with a list of URLs Nutch will
    // start crawling from:
    String[] urls = { "https://www.zerocracy.com" };
    final Path targets = new Path(home, "urls");
    Files.createDirectory(Paths.get(targets.toString()));
    Files.write(
      Paths.get(targets.toString(), "list-of-urls.txt"),
      String.join("\n", urls).getBytes()
    );
    // Next, we have to point Nutch to the directory with the
    // text file and let it "inject" our URLs into its database:
    new Injector(conf).inject(
      new Path(home, "crawldb"), // the directory with its database
      new Path(home, "urls"), // the directory with text files with URLs
      true, true // no idea what this is
    );
    // Now, it's time to do a few cycles of fetching, parsing, and
    // updating. This is how Nutch works, in increments. Each increment
    // will bring new web pages to the database. The more increments
    // you run, the deeper Nutch will go into the Internet. Five here
    // is a very small number. If you really want to crawl deeper,
    // you will need hundreds of increments. I guess, anyway. I haven't tried it.
    for (int idx = 0; idx < 5; ++idx) {
      this.cycle(home, conf);
    }
    // Now it's time to dump what is fetched to a new directory,
    // which will contain HTML pages and all other files when
    // finished.
    Files.createDirectory(Paths.get(new Path(home, "dump").toString()));
    new FileDumper().dump(
      new File(new Path(home, "dump").toString()), // where to dump
      new File(new Path(home, "segments").toString()),
      null, true, false, true
    );
  }
  private void cycle(Path home, Configuration conf) {
    // This is the directory with "segments". Each fetching cycle
    // will produce its own collection of files. Each collection
    // is called a segment.
    final Path segments = new Path(home, "segments");
    // First, we generate a list of target URLs to fetch from:
    new Generator(conf).generate(
      new Path(home, "crawldb"),
      new Path(home, "segments"),
      1, 1000L, System.currentTimeMillis()
    );
    // Then, we get the path of the current segment:
    final Path sgmt = Batch.segment(segments);
    // Then, we fetch, parse and update:
    new Fetcher(conf).fetch(sgmt, 10);
    new ParseSegment(conf).parse(sgmt);
    new CrawlDb(conf).update(
      new Path(home, "crawldb"),
      Files.list(Paths.get(segments.toString()))
          .map(p -> new Path(p.toString()))
          .toArray(Path[]::new),
      true, true
    );
  }
  private static Path segment(final Path dir) throws IOException {
    // Get the path of the most recent segment in the list,
    // sorted by the date/time of their creation.
    final List<Path> list = Files.list(Paths.get(dir.toString()))
      .map(p -> new Path(p.toString()))
      .sorted(Comparator.comparing(Path::toString))
      .collect(Collectors.toList());
    return list.get(list.size() - 1);
  }
}
```

Pay attention that `Path` here is not the
[`Path`](https://docs.oracle.com/javase/8/docs/api/java/nio/file/Path.html) from JDK.
It's the [`Path`](https://hadoop.apache.org/docs/r2.7.2/api/org/apache/hadoop/fs/Path.html) from Hadoop.
Don't ask me why.

This seems to be a pretty straight-forward algorithm, however
there is one tricky part. Nutch, in order to work, needs a number
of plugins, which are standalone JAR packages, which it doesn't include
in its default JAR. They exist in its
binary distribution and they
are pretty heavy (over 250MB in Nutch 1.15). Nutch expects you to download
the entire distribution, unpack, and run the binary `nutch` they provide,
which will work with the provided plugins.

What can we do, now that we are in Java, not in the command line? Here is what
I suggest:

```xml
<project>
  <build>
    <plugins>
      <plugin>
        <groupId>com.googlecode.maven-download-plugin</groupId>
        <artifactId>download-maven-plugin</artifactId>
        <version>1.4.1</version>
        <executions>
          <execution>
            <id>download-nutch</id>
            <phase>generate-resources</phase>
            <goals>
              <goal>wget</goal>
            </goals>
            <configuration>
              <url>http://artfiles.org/apache.org/nutch/1.15/apache-nutch-1.15-bin.zip</url>
              <unpack>true</unpack>
              <outputDirectory>${project.build.directory}</outputDirectory>
              <overwrite>false</overwrite>
            </configuration>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
  [...]
</project>
```

This Maven plugin will download the entire binary distribution of Nutch
and will unpack it to `target/apache-nutch-1.15`. The plugins will be
in `target/apache-nutch-1.15/plugins`. The only thing we still need
to do is to set the system property for the unit test:

```xml
<project>
  <build>
    <pluginManagement>
      <plugins>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-surefire-plugin</artifactId>
          <configuration>
            <systemPropertyVariables>
              <nutch.plugins.dir>${project.build.directory}/apache-nutch-1.15/plugins</nutch.plugins.dir>
            </systemPropertyVariables>
          </configuration>
        </plugin>
      </plugins>
    </pluginManagement>
    [...]
  </build>
  [...]
</project>
```

Actually, one more thing we have to do: copy the contents of the directory `conf`
from their binary distribution to our `src/main/resources` directory. There
are many files, including the most important `nutch-default.xml`. They all
have to be available on classpath, otherwise Nutch will complain in so
many places and won't be able to load the `Configuration`.

You can see how it all works together in this
GitHub repository I created to illustrate the example:
[yegor256/nutch-in-java](https://github.com/yegor256/nutch-in-java).

If you have any questions or suggestions, feel free to submit a pull request
or comment here.
