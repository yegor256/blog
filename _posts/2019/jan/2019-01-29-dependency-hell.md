---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "My Recipe Against Dependency Hell"
date: 2019-01-29
place: Moscow, Russia
tags: devops
description: |
  Do you use fixed or dynamic versions for your
  dependencies? I wasn't sure which approach is the
  right one until I found a formula for myself.
keywords:
  - dependency hell
  - dependency fixed version
  - fixed version dependency
  - software dependencies
  - dependency packages
image: /images/2019/01/sin-noticias-de-dios.jpg
jb_picture:
  caption: Sin noticias de Dios (2001) by Agustín Díaz Yanes
---

Do you specify exact versions of your dependencies? I mean, when your
software package depends on another one, do you write down, in your `pom.xml`,
`Gruntfile`, `Gemfile`, or what have you, its version as `1.13.5` or just
`1.+`? I always [thought](https://twitter.com/yegor256/status/1059856548112068608)
that it was better to use exact version numbers,
to avoid the so called [dependency hell](https://en.wikipedia.org/wiki/Dependency_hell),
and [I was not alone](https://blog.danlew.net/2015/09/09/dont-use-dynamic-versions-for-your-dependencies/).
However, very soon I [realized](https://twitter.com/yegor256/status/1060538705260265474)
that dynamic versions, like `1.+`, give more flexibility.
Just a few weeks ago I realized that neither approach
is right and found myself a hybrid formula.

<!--more-->

{% jb_picture_body %}

First, let me explain what's wrong with fixed dependencies.

Say I create a library X, which depends on, for example, a logging
facility, which is a third-party library, not mine. Thus my library X has
a _dependency_. The logging library has a version number, such as
`1.13.5`. I put this text into the `pom.xml` file of X:

```xml
<dependency>
  <groupId>com.example</groupId>
  <artifactId>log-me</artifactId>
  <version>1.13.5</version>
</dependency>
```

Many advocates of fixed dependencies argue that it's very important
to stick to the version `1.13.5`, instead of using a more flexible dynamic
one: `1.13)` (i.e. any version, provided it is `1.13` or newer).
Why? Because future versions may introduce something that
will break the build of X. They may change interfaces, rename classes or methods,
or delete something that I'm using. You never know what the authors of this
`log-me` library might do. That's why it's better to hard-wire ourselves to `1.13.5` and
call it a day.

This is true.

But.

What if the library X is used by another library Y, which also depends on
`log-me` but needs version `1.14.1`. Boom! There will be a conflict
in library Y: Maven, the package manager, won't be able to decide
which version to use. It will be necessary to resolve the conflict somehow.
In the case of Maven it's resolvable, in the case of, for example,
[Rake](https://github.com/ruby/rake), it's not (to my knowledge).

{% quote If you trust the authors of the library, use dynamic versioning; if you don't, use a fixed version. %}

To resolve this problem, library Y will have to explicitly say which version
has to be used. But it can't be sure that `1.14.1` will work correctly with
library X. To confirm that it does, it would have to be tested by the authors of library
X. So the best the creators of library Y can do is to try it and hope
for the best. With other build tools, like Rake, the authors will have no choice,
but to ask the authors of library X to upgrade to `1.14.1` and release
a new version. Then, library Y will be able to use library X.

This problem would not exist if library X depended on `1.13` instead.
But, as I mentioned above, in that case its authors would be planting a time bomb---eventually
one of the future versions will definitely break the build.

So what is the solution?

Here is my formula: If you trust the authors of the library, use dynamic versioning;
if you don't, use a fixed version.

What I mean is, do you trust that they are professional enough to think about
backward compatibility and to follow the principles of [semantic versioning](https://semver.org/)?
If they are careful enough to not delete or modify something
that may affect future versions without also changing the major number of the version,
then you can trust them. How do you know who to trust? I don't trust anyone, except
my own libraries and a very small number of other libraries which I have reviewed in GitHub and checked
the quality of their repositories.

Of course, you can't fully trust anyone, but this is the formula I
have for myself now. You can see how it works in this
[Gemfile](https://github.com/zold-io/zold/blob/master/zold.gemspec), for example.
Pay attention to the version numbers. Those that start with `~>` or `>=` are dynamic,
while others are fixed. It's a hybrid approach, but it works for me.

Maybe it will help you too.
