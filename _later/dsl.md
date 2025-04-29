---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Maybe DSL Is Not Such a Good Idea?"
date: 2016-01-08
place: Kyiv, Ukraine
tags: architecture
description: |
  DSL is a hype for the last few years, but is it
  really such a good idea that may help us
  make code cleaner?
keywords:
  - domain specific language
  - DSL design pattern
  - DSL is anti-pattern
  - DSL is bad
  - DSL vs configuration
---

Using DSL (Domain Specific Language) instead of configuration
is a very popular concept. However, I don't really like it.
I'm not a big expert, since I know just a few DSLs,
but my experience is mostly negative. As I see, DSL

<!--more-->

Again, I'm not a big expert in DSLs. I will just speak about my
personal experience. Let me show you a few examples first, to
demonstrate what bothers me most. The first example is
from nokogiri, a Ruby library for building XML documents:

```ruby
```

This is another one:
