---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: static
title: "Recommended Movies"
date: 2017-01-10
permalink: movies.html
description: |
  Here is a full list of movies I would recommend to
  watch; all of them were mentioned in my blog posts,
  this is just a full summary.
image: /images/2014/12/99-francs.png
keywords:
  - best movies
  - movies to watch
  - best yegor movies
  - yegor bugayenko movies
  - movies
---

These {{ site.posts | yb_movies_count }}
movies were mentioned in this blog, I would
recommend to watch them all:

<div class="nospell">
{{ site.posts | yb_movies | join:'' }}
</div>

If you know some other good movies, please
[recommend](mailto:movie@yegor256.com).
