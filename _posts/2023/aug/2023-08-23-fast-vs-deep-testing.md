---
layout: post
title: "Fast vs. Deep Testing"
date: 2023-08-23
place: Moscow, Russia
tags: testing
description: |
  ...
keywords:
  - fast tests
  - unit tests
  - thorough tests
  - slow tests
  - fast tests
image: /images/2023/08/...
jb_picture:
  caption: ...
---


<!--more-->

{% jb_picture_body %}


```java
String read(InputStream file) throws IOException {
    final StringBuilder buf = new StringBuilder();
    while (true) {
        int d = stream.read();
        if (d == -1) {
            break;
        }
        buf.append((char) d);
    }
    return buf.toString();
}

@Test
void testIt() throws IOException {
    Assertions.assertEquals(
        "ABC",
        toString(new ByteArrayInputStream(new byte[] {0x41, 0x42, 0x43}))
    );
}

@Test
void testItMore() throws IOException {
    for (int i = 0; i < 150000; ++i) {
        Assertions.assertTrue(
            toString(new FileInputStream("a.tex")).length() > 0
        );
    }
}
```
