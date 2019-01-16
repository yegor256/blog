---
layout: post
title: "My Recipe Against Dependency Hell"
date: 2019-01-25
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
image: /images/2019/01/
jb_picture:
  caption:
---

Do you specify exact versions of your dependencies? I mean, when your
software package depends on another one, will you write down, in your `pom.xml`,
`Gruntfile`, `Gemfile`, or what have you, its version as `1.13.5` or just
`1.+`? I always [thought](https://twitter.com/yegor256/status/1059856548112068608)
that it's better to use exact version numbers,
to avoid the so called [dependency hell](https://en.wikipedia.org/wiki/Dependency_hell),
and [I was not alone](https://blog.danlew.net/2015/09/09/dont-use-dynamic-versions-for-your-dependencies/).
However, very soon I [realized](https://twitter.com/yegor256/status/1060538705260265474)
that dynamic versions, like `1.+`, give more flexibility.
Just a few weeks ago I realized the neither approach
is right and found myself a hybrid formula. No suprise, I realized that
[I wasn't alone](https://brock.io/post/repeatable_android_builds/).

<!--more-->

{% jb_picture_body %}

First, let me explain what's wrong with fixed dependencies.

Say, I create a library X, which depends on, say, a logging
facility, which is a third-party library, not mine. Thus, my library X has
a _dependency_. The logging library has a version number, which is, say,
`1.13.5`. I put this text into the `pom.xml` file of X:

{% highlight xml %}
<dependency>
  <groupId>com.example</groupId>
  <artifactId>log-me</artifactId>
  <version>1.13.5</version>
</dependency>
{% endhighlight %}

Multiple advocates of fixed dependencies argue that it's very important
to stick to the version `1.13.5`, instead of using a more flexible dynamic
one: `1.13)` (whatever it is, provided it is younger than `1.13`).
Why? Because future versions may introduce something that
may break the built of X. They may change interfaces, rename classe or methods,
and delete something that I'm using. You never know what the authors of this
`log-me` library can do. That's why it's better to hard-wire ourselves to `1.13.5` and
call it a day.

This is true.

But.

What if the library X is used by another libray Y, which also depends on
`log-me` but needs version `1.14.1`. Boom! There will be a conflict
in the library Y: Maven, the package manager, won't be able to decide
which version to use. It will be necessary to resolve that conflict somehow.
In case of Maven it's resolvable, in case of, for example,
[Rake](https://github.com/ruby/rake), it's not (to my knowledge).

To resolve that, the library Y will have to explicitly say which version
has to be used. But it can't be sure that `1.14.1` will work correctly with the
library X. It has to be tested to confirm that, by the authors of the library
X. So, the best the creators of the library Y can do is to try and hope
for the best. In other builders, like Rake, the authors will have no choice,
but to ask the authors of the library X to upgrade to `1.14.1` and release
a new version. Then, the library Y will be able to use the library X.

This problem would not exist if the library X would use `1.13)` instead.
But, as I mentioned above, in this case its authors will plant a time bomb---eventually
one of the future version will definitely break the build.

What is the solution?

Here is my formula: if you trust the authors of the library, use dynamic version,
if you don't, use fixed version.

I mean, if you trust that they are professional enough to think about
backward compatibility and follow the principles of [semantic versioning](https://semver.org/).
If they are careful enough to not delete or modify something
that may affect future versions, without changing the major number of the version,
you can trust them. How do you know who to trust? I don't trust anyone, except
my own libraries and very few libraries, which I reviewed in GitHub and checked
the quality of their repositories.

Of course, you can't fully trust anyone, but this is the formula I
have for myself now. You can see how it works in this
[Gemfile](https://github.com/zold-io/zold/blob/master/zold.gemspec), for example.
Pay attention to the version numbers. Those that start with `~>` or `>=` are dynamic,
others are fixed. It's a hybrid approach, but it works for me.

Maybe it will help you too.


