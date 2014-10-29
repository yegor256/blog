---
layout: post
title: "Synchronization Between Nodes"
date: 2014-10-26
tags: stateful
description:
  Free cloud stateful.co service helps you synchronize
  across multiple servers or paralell processes on the same machine
keywords:
  - Java synchronization between different JVMs
  - synchronization between different servers
  - synchronization between servers
  - synchronization between computers
  - synchronization between processes
  - synchronization between two computers
---

{% badge http://img.stateful.co/pomegranate.svg 128 %}



<!--more-->


{% highlight xml %}
<dependency>
  <groupId>co.stateful</groupId>
  <artifactId>java-sdk</artifactId>
  <version>0.6</version>
</dependency>
{% endhighlight %}

{% highlight java %}
Sttc sttc = new RtSttc(
  new URN("urn:github:526301"),
  "9FF3-41E0-73FB-F900"
);
Counters counters = sttc.counters();
Counter counter = counters.get("foo");
long value = counter.incrementAndGet(1L);
System.out.println("new value: " + value);
{% endhighlight %}

