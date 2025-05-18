---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "A Compound Name Is a Code Smell"
date: 2015-01-12
tags: oop
categories: jcg
description: |
  A variable name that consists of several words is a code
  smell because it indicates a variable scope that's too big.
keywords:
  - variable naming convention
  - variable name
  - naming convention
  - composite variable name
  - long variable name
translated:
  - Chinese: http://blog.csdn.net/LvShuiLanTian/article/details/52349054
book: elegant-objects-2 5.1
image: /images/2015/01/meaning-of-life-every-sperm.png
jb_picture:
  caption: The Meaning of Life (1983) by Terry Jones and Terry Gilliam
---

Do you name variables like `textLength`, `table_name`, or `current-user-email`?
All three are compound names that consist of more than one word. Even though
they look more descriptive than `name`, `length`, or `email`, I would strongly
recommend avoiding them. I believe a variable name that is more complex than a noun
is a code smell. Why? Because we usually give a variable a compound name when its scope
is so big and complex that a simple noun would sound ambiguous.
And a big, complex scope is an obvious code smell.

<!--more-->

{% jb_picture_body %}

The scope of a variable is the place where it is visible, like a method, for example. Look
at this Ruby class:

```ruby
class CSV
  def initialize(csvFileName)
    @fileName = csvFileName
  end
  def readRecords()
    File.readLines(@fileName).map |csvLine|
      csvLine.split(',')
    end
  end
end
```

The visible scope of variable `csvFileName` is method `initialize()`, which
is a constructor of the class `CSV`. Why does it need a compound name
that consists of three words? Isn't it already clear that a single-argument
constructor of class `CSV` expects the name of a file with
comma-separated values? I would rename it to `file`.

Next, the scope of `@fileName` is the entire `CSV` class. Renaming a single
variable in the class to just `@file` won't introduce
any confusion. It's still clear what file we're dealing with.
The same situation exists with the `csvLine` variable. It is clear that we're
dealing with CSV lines here. The `csv` prefix is just a redundancy.
Here is how I would refactor the class:

```ruby
class CSV
  def initialize(file)
    @file = file
  end
  def records()
    File.readLines(@file).map |line|
      line.split(',')
    end
  end
end
```

Now it looks clear and concise.

If you can't perform such a refactoring, it means your scope is too
big and/or too complex. An ideal method should deal with up to five variables,
and an ideal class should encapsulate up to five properties.

If we have five variables, can't we find five nouns to name them?

Adam and Eve didn't have second names. They were unique in Eden,
as were many other characters in the Old Testament. Second and middle
names were invented later in order to resolve ambiguity. To keep
your methods and classes clean and solid, and to prevent ambiguity, try to give your variables
and methods unique single-word names, just like Adam and Eve were named
by you know who.

PS. Also, [redundant variables]({% pst 2015/sep/2015-09-01-redundant-variables-are-evil %})
are evil as well.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">What do you think about function and variable naming in this Ruby code?<br><br>def total_words_in_file(file_name) {<br>  text_file_content = <a href="https://t.co/u2RHVnNqB3">https://t.co/u2RHVnNqB3</a>(file_name)<br>  return text_file_content.split(&#39; &#39;).count<br>}</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1117419548582531074?ref_src=twsrc%5Etfw">April 14, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
