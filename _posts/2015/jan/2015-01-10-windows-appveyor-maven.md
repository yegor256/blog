---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Continuous Integration on Windows, with Appveyor and Maven"
date: 2015-01-10
tags: devops
description: |
  Appveyor is a Windows powered continuous integration
  hosted service; this article explains how Java Maven builds
  can be hosted there
keywords:
  - maven appveyor
  - maven windows
  - continuous integration windows
  - appveyor maven
  - continuous integration win7
---

{% badge /images/2014/10/appveyor.png 64 https://www.appveyor.com %}

The purpose of Continuous Integration is to tell us, the developers,
when the product we're working on is not "packagable" any more. The
sooner we get the signal, the better. Why? Because the damage will
be younger if we find it sooner. The younger the damage, the easier it is
to fix. There are many modern and high-quality
[hosted continuous integration services]({% pst 2014/oct/2014-10-05-ten-hosted-continuous-integration-services %}),
but only one of them (to my knowledge) supports Windows as a build
platform---[appveyor.com](https://www.appveyor.com). My experience
tells me that it's a good practice to continuously integrate on
different platforms at the same time, especially when developing an
open source library. That's why, in [Zerocracy](https://www.zerocracy.com)
we're using AppVeyor in combination with [Travis](https://www.travis-ci.org).

<!--more-->

This is how I managed to configure AppVeyor to build my Java Maven projects
(this is `appveyor.yml` configuration file you're supposed to place
in the root directory of your GitHub repository):

```text
version: '{build}'
os: Windows Server 2012
install:
  - ps: |
      Add-Type -AssemblyName System.IO.Compression.FileSystem
      if (!(Test-Path -Path "C:\maven" )) {
        (new-object System.Net.WebClient).DownloadFile(
          'https://www.us.apache.org/dist/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.zip',
          'C:\maven-bin.zip'
        )
        [System.IO.Compression.ZipFile]::ExtractToDirectory("C:\maven-bin.zip", "C:\maven")
      }
  - cmd: SET PATH=C:\maven\apache-maven-3.2.5\bin;%JAVA_HOME%\bin;%PATH%
  - cmd: SET MAVEN_OPTS=-XX:MaxPermSize=2g -Xmx4g
  - cmd: SET JAVA_OPTS=-XX:MaxPermSize=2g -Xmx4g
build_script:
  - mvn clean package --batch-mode -DskipTest
test_script:
  - mvn clean install --batch-mode
cache:
  - C:\maven\
  - C:\Users\appveyor\.m2
```

It was not that easy at all, so I decided to share. You can see
how this configuration works in these projects:
[jcabi-aspects](https://github.com/jcabi/jcabi-aspects),
[jcabi-email](https://github.com/jcabi/jcabi-email),
[jcabi-dynamo](https://github.com/jcabi/jcabi-dynamo), and
[rultor](https://github.com/yegor256/rultor).
