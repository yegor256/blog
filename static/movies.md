---
layout: static
title: "Recommended Movies"
date: 2017-01-10
permalink: movies.html
description: |
  Here is a full list of movies I would recommend to
  watch; all of them were mentioned in my blog posts,
  this is just a full summary.
image: https://cf.jare.io/?u=http://www.yegor256.com/images/2014/12/99-francs.png
keywords:
  - best movies
  - movies to watch
  - best yegor movies
  - yegor bugayenko movies
  - movies
exclude_from_search: true
---

These movies were mentioned in all posts at this blog, I would
recommend to watch them all:

<div class="nospell">
{{ site.posts | movies | join:'' }}
</div>

If you know some other good movies, please
[recommend](mailto:movie@yegor256.com).
