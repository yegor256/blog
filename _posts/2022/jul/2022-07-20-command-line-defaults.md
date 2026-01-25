---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Command Line Default Options in Linearized Plain Text"
date: 2022-07-20
place: Moscow, Russia
tags: tests
description: |
  Where to put default configuration parameters for
  a command line tool? It has to be a JSON or YAML
  config file? Neither. Just plain text.
keywords:
  - command line
  - configure command line
  - default options command line
  - cli defaults
  - command line tool defaults
image: /images/2022/07/the-trotsky.jpg
jb_picture:
  caption: The Trotsky (2009) by Jacob Tierney
---

{% badge https://raw.githubusercontent.com/yegor256/xcop/master/logo.svg 128 https://github.com/yegor256/xcop %}

[A few years ago]({% pst 2017/aug/2017-08-29-xcop %})
I created [xcop](https://github.com/yegor256/xcop),
a simple command line tool that
can check the style of an XML file. It's similar to
[Checkstyle](https://checkstyle.sourceforge.io) (for Java) and
[Pep8](https://pypi.org/project/pep8/) (for Python),
but for XML. It's pretty easy to use `xcop`: just run it with a few command
line arguments and it returns the list of errors found in your XML file, if there are any. However,
some of the arguments may be convenient to have as defaults and instead of
passing them through the command line on every execution, we could store them in some configuration file.
The question is: What is the best format for this file?
[YAML](https://en.wikipedia.org/wiki/YAML),
[JSON](https://en.wikipedia.org/wiki/JSON), or
[TOML](https://en.wikipedia.org/wiki/TOML)?
None of them! I suggest plain text.

<!--more-->

{% jb_picture_body %}

Let's say, you want `xcop` to check all `*.xml` files in your repository,
but ignore XML files in the `.idea/` directory. You also want to make sure
all XML files have a license in their preamble. This is how you would
call `xcop`:

```text
$ xcop --include '*.xml' --exclude '.idea/**' \
  --license LICENSE.txt
```

You have to use this set of arguments everywhere you call `xcop`:
in the build script, in the CI/CD pipeline, and on your laptop when you check
that everything is correct. What some of us sometimes do is create a new
Bash file called `run_xcop.sh` with exactly this single command.

I suggest a better solution. You can create a `.xcop`
plain text file in the root of the repository and put all
the required "default" command line options there, one per line:

```text
--include=*.xml
--exclude=.idea/**
--license=LICENSE.txt
```

Now, you can call the tool just like this:

```text
$ xcop
```

It will find the `.xcop` file and will read all lines from it, treating
each of them as command line arguments. It will basically _concatenate_
what is provided in the command line with what is found in the file
with defaults.

I believe this approach is much better than YAML, JSON, XML, TOML, INI,
and other configuration formats simply because it doesn't require us
users to learn two formats: one for command line options, another one
for the configuration file. We learn just one and use it interchangeably
either when we call the tool "manually" or when we configure its
behavior in the file with defaults.

By the way, it's possible to configure the behavior of `xcop` globally
creating the file `~/.xcop` (in the home directory of the user). The
defaults from this file will also be concatenated with the ones provided
in the command line and with the ones found in the local `.xcop` file.

I designed a few of my other command line tools using the same principle,
including
[pdd](https://github.com/yegor256/pdd),
[texqc](https://github.com/yegor256/texqc),
and
[texsc](https://github.com/yegor256/texsc).
