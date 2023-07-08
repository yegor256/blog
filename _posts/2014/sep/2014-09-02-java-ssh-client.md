---
layout: post
title: "Simple Java SSH Client"
date: 2014-09-02
tags: java jcabi
description: |
  jcabi-ssh is a simple Java SSH client that
  wraps jsch library and makes its usage more
  object-oriented and convenient
keywords:
  - java ssh
  - java ssh client
  - ssh library for java
  - openssh for java
  - ssh libraries for java
  - open source ssh for java
  - ssh tunneling for java
categories: jcg
---

An execution of a shell command via SSH can be done in
Java, in just a few lines, using [`jcabi-ssh`](http://ssh.jcabi.com):

```java
String hello = new Shell.Plain(
  new SSH(
    "ssh.example.com", 22,
    "yegor", "-----BEGIN RSA PRIVATE KEY-----..."
  )
).exec("echo 'Hello, world!'");
```

[`jcabi-ssh`](http://ssh.jcabi.com) is
a convenient wrapper of [`JSch`](http://www.jcraft.com/jsch/),
a well-known pure Java implementation of SSH2.

<!--more-->

Here is a more complex scenario, where I upload a file via SSH
and then read back its grepped content:

```xml
Shell shell = new SSH(
  "ssh.example.com", 22,
  "yegor", "-----BEGIN RSA PRIVATE KEY-----..."
);
File file = new File("/tmp/data.txt");
new Shell.Safe(shell).exec(
  "cat > d.txt && grep 'some text' d.txt",
  new FileInputStream(file),
  Logger.stream(Level.INFO, this),
  Logger.stream(Level.WARNING, this)
);
```

Class `SSH`, which implements interface `Shell`, has only one method, `exec`.
This method accepts four arguments:

```xml
interface Shell {
  int exec(
    String cmd, InputStream stdin,
    OutputStream stdout, OutputStream stderr
  );
}
```

I think it's obvious what these arguments are about.

There are also a few convenient decorators that make it easier to operate with
simple commands.

## Shell.Safe

`Shell.Safe`
[decorates]({% pst 2017/jan/2017-01-31-decorating-envelopes %}) an instance of `Shell` and
[throws]({% pst 2015/dec/2015-12-01-rethrow-exceptions %}) an exception
if the `exec` exit code is not equal to zero. This may be very useful when
you want to make sure that your command executed successfully, but don't
want to duplicate `if/throw` in many places of your code.

```xml
Shell ssh = new Shell.Safe(
  new SSH(
    "ssh.example.com", 22,
    "yegor", "-----BEGIN RSA PRIVATE KEY-----..."
  )
);
```

## Shell.Verbose

`Shell.Verbose` decorates an instance of `Shell` and copies
`stdout` and `stderr` to the slf4j logging facility (using
[`jcabi-log`](http://log.jcabi.com)). Of course, you can combine
decorators, for example:

```xml
Shell ssh = new Shell.Verbose(
  new Shell.Safe(
    new SSH(
      "ssh.example.com", 22,
      "yegor", "-----BEGIN RSA PRIVATE KEY-----..."
    )
  )
);
```

## Shell.Plain

`Shell.Plain` is a wrapper of `Shell` that introduces a new `exec` method
with only one argument, a command to execute. It also doesn't return an
exit code, but `stdout` instead. This should be very convenient when you want
to execute a simple command and just get its output
(I'm combining it with `Shell.Safe` for safety):

```xml
String login = new Shell.Plain(new Shell.Safe(ssh)).exec("whoami");
```

## Download

You need a single dependency
[`jcabi-ssh.jar`](https://repo1.maven.org/maven2/com/jcabi/jcabi-ssh)
in your Maven project
(get its latest version in [Maven Central](http://search.maven.org/)):

```xml
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-ssh</artifactId>
</dependency>
```

The project is in [GitHub](https://github.com/jcabi/jcabi-ssh).
If you have any problems, just submit an issue. I'll try to help.
