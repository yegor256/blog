---
layout: static
title: "12 Best Articles to Read"
description:
  I'm writing mostly about Java, OOP, DevOps, and
  open source projects I'm working with in Teamed.io,
  my software development company
keywords:
  - java blog
  - java
  - software development blog
  - programming blog
  - yegor bugayenko blog
  - quality of software
  - software blog
  - high quality programming
  - static analysis
  - software testing
  - ruby blog
  - javascript blog
exclude_from_search: true
---

These twelve articles are the most interesting to read.
Here is the blog [contents](/contents.html).
And don't forget to subscribe to my [monthly updates](/about-me.html) :)

{% for post in site.categories['best'] %}
  {{ post | tagged }}
{% endfor %}

Other tags: {{ site.tags | tag_cloud }}
