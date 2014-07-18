---
layout: post
title: "Liquibase with Maven"
date: 2014-07-10
tags: liquibase maven java
description:
  Liquibase is a convenient tool for database migrations
  management, here I explain how to use it with Maven projects
keywords:
  - mysql maven liquibase
  - postgresql maven
  - liquibase integration testing java
  - liquibase java test
  - maven liquibase java test
  - liquibase maven plugin
  - maven linux liquibase
---

[Liquibase](http://www.liquibase.org)
is a migration management tool for relational databases. It
versionalize schema and data changes in a database, similar to what
Git or SVN does for source code. Thanks to their
Maven plugin, Liquibase can be used as a part of a build automation scenario.

<!--more-->

## Maven Plugin

Let's assume you're using MySQL. For PostgreSQL or any other
database configuration will be very similar.

Add this plugin to your `pom.xml`
(get its latest version in [Maven Central](http://search.maven.org/)):

{% highlight xml %}
<project>
  [...]
  <build>
    [...]
    <plugins>
      <plugin>
        <groupId>org.liquibase</groupId>
        <artifactId>liquibase-maven-plugin</artifactId>
        <configuration>
          <changeLogFile>${basedir}/src/main/liquibase/master.xml</changeLogFile>
          <driver>com.mysql.jdbc.Driver</driver>
          <url>jdbc:mysql://${mysql.host}:${mysql.port}/${mysql.db}</url>
          <username>${mysql.login}</username>
          <password>${mysql.password}</password>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
{% endhighlight %}

To check that it works, run `mvn liquibase:help`.

Database credentials I would recomment to keep in `settings.xml`,
in their respective profiles, for example:

{% highlight xml %}
<settings>
  <profiles>
    <profile>
      <id>production</id>
      <properties>
        <mysql.host>db.example.com</mysql.host>
        <mysql.port>3306</mysql.port>
        <mysql.db>example</mysql.db>
      </properties>
    </profile>
    <profile>
      <id>test</id>
      <properties>
        <mysql.host>test-db.example.com</mysql.host>
        <mysql.port>3306</mysql.port>
        <mysql.db>example-db</mysql.db>
      </properties>
    </profile>
  </profiles>
</settings>
{% endhighlight %}

When you run Maven, don't forget to turn on one of the profiles, for example:
`mvn -Pproduction`.

## Initial Schema

I assume you already have a database with a schema (tables, triggers, views, etc.)
and some data. You should "reverse engineer" it and create an initial
schema file for Liquibase. In other words, we should inform Liquibase where
we are at the moment, so that it starts to apply changes from this
point.

Maven plugin doesn't support it, you will have to run Liquibase directly. It's
not that difficult. First, run `mvn liquibase:help` in order to download
all artifacts. Then (replace placeholders with your actual credentials):

{% highlight bash %}
$ java -jar ~/.m2/repository/org/liquibase/liquibase-core/3.1.1/liquibase-core-3.1.1.jar \
  --driver=com.mysql.jdbc.Driver \
  --url=jdbc:mysql://db.example.com:3306/example \
  --username=example --password=example \
  generateChangeLog > src/main/liquibase/000-initial-schema.xml
{% endhighlight %}

Liquibase will analyze your current database schema and will copy
its schema into `src/main/liquibase/000-initial-schema.xml`.

## Master Changeset

Now, create XML master changeset and save it to `src/main/liquibase/master.xml`:

{% highlight xml %}
<databaseChangeLog
  xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-2.0.xsd">
  <includeAll path="src/main/liquibase" />
</databaseChangeLog>
{% endhighlight %}

It is an entry point for Liquibase. It starts from this file and loads
all other changesets available in `src/main/liquibase`. They should
be either `.xml` or `.sql`. I recommend to use XML, mostly because it
is easier to maintain and they work faster.

## Incremental Changesets

Let's create a first simple changeset, which adds a new column to an
existing table:

{% highlight xml %}
<databaseChangeLog xmlns='http://www.liquibase.org/xml/ns/dbchangelog'
  xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'
  xsi:schemaLocation='http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-2.0.xsd'>
  <changeSet id="002" author="Yegor">
    <sql>
      ALTER TABLE user ADD COLUMN address VARCHAR(1024);
    </sql>
  </changeSet>
</databaseChangeLog>
{% endhighlight %}

This file we save into `src/main/liquibase/002-add-user-address.xml`. In big
projects you can name your files by the names of the tickets they are produced in.
For example, `045-3432.xml`, which means changeset number 45 coming from
ticket #3432.

What is important is to have this numeric prefix in front of file names, in
order to sort them correctly. We want changes to be applied in their correct
chronological order.

That's it. We're ready to run `mvn liquibase:update -Pproduction` and
our production database will be updated &mdash; a new column will be
added to the `user` table.

See also how [MySQL Maven Plugin]({% post_url 2014/may/2014-05-21-mysql-maven-plugin %})
can help you to automate integration
testing of database-connected classes.
