---
layout: post
title: "MySQL Maven Plugin"
date: 2014-05-21
tags: maven java
description: |
  jcabi-mysql-maven-plugin starts a fresh instance of MySQL
  server before integration tests and shuts it down
  when tests are finished.
keywords:
  - mysql maven
  - mysql maven plugin
  - maven plugin for mysql
  - mysql integration testing java
  - mysql java test
  - maven mysql java test
  - mariadb maven plugin
  - maven linux mysql
---

I was using MySQL in a few Java web projects and
found out there was no Maven plugin that would help me to
test my [DAOs]({% pst 2017/dec/2017-12-05-data-access-object %})
against a real MySQL server. There are plenty
of mechanisms to mock a database persistence layer both in
memory and on disc. However, it is always good to make sure
that your classes are tested against a database identical
to the one you have in production environment.

{% badge https://www.jcabi.com/logo-square.svg 64 http://mysql.jcabi.com %}

I've created my own Maven plugin, [jcabi-mysql-maven-plugin](http://mysql.jcabi.com),
that does exactly two things: starts a MySQL server on
`pre-integration-test` phase and shuts it down on
`post-integration-test`.

<!--more-->

This is how you configure it in `pom.xml`
(see also its full [usage instructions](http://mysql.jcabi.com/usage.html)):

```xml
<project>
  <build>
    <plugins>
      <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>build-helper-maven-plugin</artifactId>
        <executions>
          <execution>
            <goals>
              <goal>reserve-network-port</goal>
            </goals>
            <configuration>
              <portNames>
                <portName>mysql.port</portName>
              </portNames>
            </configuration>
          </execution>
        </executions>
      </plugin>
      <plugin>
        <artifactId>maven-dependency-plugin</artifactId>
        <executions>
          <execution>
            <goals>
              <goal>unpack</goal>
            </goals>
            <configuration>
              <artifactItems>
                <artifactItem>
                  <groupId>com.jcabi</groupId>
                  <artifactId>mysql-dist</artifactId>
                  <version>5.6.14</version>
                  <classifier>${mysql.classifier}</classifier>
                  <type>zip</type>
                  <overWrite>false</overWrite>
                  <outputDirectory>
                    ${project.build.directory}/mysql-dist
                  </outputDirectory>
                </artifactItem>
              </artifactItems>
            </configuration>
          </execution>
        </executions>
      </plugin>
      <plugin>
        <groupId>com.jcabi</groupId>
        <artifactId>jcabi-mysql-maven-plugin</artifactId>
        <executions>
          <execution>
            <id>mysql-test</id>
            <goals>
              <goal>classify</goal>
              <goal>start</goal>
              <goal>stop</goal>
            </goals>
            <configuration>
              <port>${mysql.port}</port>
              <data>${project.build.directory}/mysql-data</data>
            </configuration>
          </execution>
        </executions>
      </plugin>
      <plugin>
        <artifactId>maven-failsafe-plugin</artifactId>
        <configuration>
          <systemPropertyVariables>
            <mysql.port>${mysql.port}</mysql.port>
          </systemPropertyVariables>
        </configuration>
        <executions>
          <execution>
            <goals>
              <goal>integration-test</goal>
              <goal>verify</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
  [...]
</project>
```

There are two plugins configured above. Let's take a look
at what each does.

1. **`build-helper-maven-plugin`**
is reserving a temporary random TCP port, which will be used by MySQL server.
We don't want to start a server on its default 3306 port,
because there could be another server already running there.
Besides that, if we use a hard-coded TCP port, we won't be able to
run multiple builds in parallel. Maybe not a big deal when
you're developing locally, but in
[continuous integration]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %})
environment this can be a problem. That's why we're reserving a TCP port first.

2. [**`maven-dependency-plugin`**](https://maven.apache.org/plugins/maven-dependency-plugin/unpack-mojo.html)
is downloading a MySQL distribution in a zip archive (rather big file, over 300Mb for Linux), and unpacks it.
This archive contains exactly the same files as you would use
for a traditional MySQL installation. When the archive is unpacked,
it is ready to start serving SQL requests as a normal MySQL server.

3. [**`jcabi-mysql-maven-plugin`**](http://mysql.jcabi.com)
starts a server, binding it to a TCP port reserved randomly.
The main responsibility of my Maven plugin is to make sure
that MySQL server starts correctly on every platform (Mac OS, Linux, Windows)
and stops when it's not needed any more. All the rest is done by
the MySQL distribution itself.

4. **`maven-failsafe-plugin`**
is running unit tests on `integration-test` phase. Its main difference from
maven-surefire-plugin is that it doesn't fail a build when some tests fail.
Instead, it saves all failures into supplementary files in `target`
directory and allows the build continue. Later, when we call its `verify`
goal, it will fail a build if there were any errors during its
`integration-test` goal execution.

To be precise, this is the order in which Maven will execute configured goals:

```text
jcabi-mysql-maven-plugin:classify
maven-dependency-plugin:unpack
build-helper-maven-plugin:reserve-network-port
jcabi-mysql-maven-plugin:start
maven-failsafe-plugin:integration-test
jcabi-mysql-maven-plugin:stop
maven-failsafe-plugin:verify
```

Run `mvn clean install` and see how it works. If it doesn't work
for some reason, don't hesitate
[to report an issue to GitHub](https://github.com/jcabi/jcabi-mysql-maven-plugin/issues).

Now it's time to create an integration test,
which will connect to the temporary MySQL server, create
a table there and insert some data into it. This is just
an example to show that MySQL server is running and
is capable of serving transactions (I'm using [jcabi-jdbc](http://jdbc.jcabi.com)):

```java
public class FooITCase {
  private static final String PORT = System.getProperty("mysql.port");
  @Test
  public void worksWithMysqlServer() {
    Connection conn = DriverManager.getConnection(
      String.format(
        "jdbc:mysql://localhost:%s/root?user=root&password=root",
        FooITCase.PORT
      )
    );
    new JdbcSession(conn)
      .sql("CREATE TABLE foo (id INT PRIMARY KEY)")
      .execute();
  }
}
```

If you're using Hibernate, just create a `db.properties`
file in `src/test/resources` directory.
In that file you would do something like:

```properties
hibernate.connection.url=jdbc:mysql://localhost:${mysql.port}/root
hibernate.connection.username=root
hibernate.connection.password=root
```

Maven will replace that `${mysql.port}` with the number of
reserved TCP port, during resources copying. This operation
is called "resources filtering," and you can read about it
[here](https://maven.apache.org/plugins/maven-resources-plugin/examples/filter.html).

That's pretty much it. I'm using [jcabi-mysql-maven-plugin](http://mysql.jcabi.com)
in a few projects, and it helps me to stay confident that my code works
with a real MySQL server. I'm also using the
[Liquibase](https://www.liquibase.org/)
Maven [plugin](https://www.liquibase.org/documentation/maven/) in
order to populate an empty server with tables required for the application.
Nevertheless, that is a story for the
[next post]({% pst 2014/jul/2014-07-20-liquibase-in-maven %}).
