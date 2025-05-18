---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Liquibase with Maven"
date: 2014-07-20
tags: maven java
description: |
  Liquibase is a convenient tool for database migration
  management. Here, I explain how to use it with Maven projects.
keywords:
  - liquibase integration testing java
  - liquibase java mysql
  - liquibase java postgresql
  - liquibase java test
  - liquibase maven example
  - liquibase maven integration test
  - liquibase maven mysql
---

[Liquibase](https://www.liquibase.org) is a migration management tool
for relational databases. It versionalizes schema and data changes in
a database; similar to the way Git or SVN works for source code.
Thanks to their [Maven plugin](https://www.liquibase.org/documentation/maven/),
Liquibase can be used as a part
of a build automation scenario.

<!--more-->

## Maven Plugin

Let's assume you're using MySQL (PostgreSQL or any other
database configuration will be very similar.)

Add `liquibase-maven-plugin`
to your [`pom.xml`](https://maven.apache.org/pom.html) (get its latest
version in [Maven Central](http://search.maven.org/)):

```xml
<project>
  [...]
  <build>
    [...]
    <plugins>
      <plugin>
        <groupId>org.liquibase</groupId>
        <artifactId>liquibase-maven-plugin</artifactId>
        <configuration>
          <changeLogFile>
            ${basedir}/src/main/liquibase/master.xml
          </changeLogFile>
          <driver>com.mysql.jdbc.Driver</driver>
          <url>jdbc:mysql://${mysql.host}:${mysql.port}/${mysql.db}</url>
          <username>${mysql.login}</username>
          <password>${mysql.password}</password>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
```

To check that it works, run `mvn liquibase:help`.

I would recommend you keep database credentials
in [`settings.xml`](https://maven.apache.org/settings.html)
and  in their respective profiles. For example:

```xml
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
```

When you run Maven, don't forget to turn
on one of the profiles. For example: `mvn -Pproduction`.

## Initial Schema

I assume you already have a database with
a schema (tables, triggers, views, etc.) and some data.
You should "reverse engineer" it and create an initial schema
file for Liquibase. In other words, we should inform Liquibase
where we are at the moment, so that it starts to apply
changes from this point.

Maven plugin doesn't support it, so you will have to run
Liquibase directly. But, it's not that difficult. First,
run `mvn liquibase:help` in order to download all artifacts.
Then, replace placeholders with your actual credentials:

```bash
$ java -jar \
  ~/.m2/repository/org/liquibase/liquibase-core/3.1.1/liquibase-core-3.1.1.jar \
  --driver=com.mysql.jdbc.Driver \
  --url=jdbc:mysql://db.example.com:3306/example \
  --username=example --password=example \
  generateChangeLog > src/main/liquibase/2014/000-initial-schema.xml
```

Liquibase will analyze your current database schema
and copy its own schema into `src/main/liquibase/2014/000-initial-schema.xml`.

## Master Changeset

Now, create XML master changeset and save it to `src/main/liquibase/master.xml`:

```xml
<databaseChangeLog
  xmlns="https://www.liquibase.org/xml/ns/dbchangelog"
  xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="https://www.liquibase.org/xml/ns/dbchangelog
    https://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-2.0.xsd">
  <includeAll path="src/main/liquibase/2014" />
</databaseChangeLog>
```

It is an entry point for Liquibase. It starts from this file
and loads all other changesets available in `src/main/liquibase/2014`.
They should be either `.xml` or `.sql`. I recommend that you use
XML mostly because it is easier to maintain and works faster.

## Incremental Changesets

Let's create a simple changeset, which adds a new column to an existing table:

```xml
<databaseChangeLog xmlns='https://www.liquibase.org/xml/ns/dbchangelog'
  xmlns:xsi='https://www.w3.org/2001/XMLSchema-instance'
  xsi:schemaLocation='https://www.liquibase.org/xml/ns/dbchangelog
    https://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-2.0.xsd'>
  <changeSet id="002" author="Yegor">
    <sql>
      ALTER TABLE user ADD COLUMN address VARCHAR(1024);
    </sql>
  </changeSet>
</databaseChangeLog>
```

We save this file in `src/main/liquibase/2014/002-add-user-address.xml`.
In big projects, you can name your files by the names of the tickets
they are produced in. For example, `045-3432.xml`, which means changeset
number 45 coming from ticket #3432.

The important thing is to have this numeric prefix in front of file names,
in order to sort them correctly. We want changes to be applied in their
correct chronological order.

That's it. We're ready to run `mvn liquibase:update -Pproduction` and
our production database will be updated---a new column will be
added to the `user` table.

Also, see how [MySQL Maven Plugin]({% pst 2014/may/2014-05-21-mysql-maven-plugin %})
can help you to automate integration testing of database-connected classes.
