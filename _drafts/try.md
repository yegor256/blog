---
layout: post
title: "Smaller Try-Blocks Are Better"
date: 2022-09-07
place: Moscow, Russia
tags: oop java
description: |
  ...
keywords:
  - try catch
  - oop try catch
  - exception handling oop
  - try block
  - try catch exceptions
image: /images/2022/09/
jb_picture:
  caption:
---


<!--more-->

{% jb_picture_body %}

What do you think is wrong with this Java method
(aside from using `System.out` instead of an injected dependency)?:

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.regex.Pattern;

void grep(Path file, Pattern regex) {
  try {
    for (String line : Files.readAllLines(file)) {
      if (regex.matcher(line).matches()) {
        System.out.println(line);
      }
    }
  } catch (IOException ex) {
    throw new IllegalStateException(ex);
  }
}
```

First, I would

