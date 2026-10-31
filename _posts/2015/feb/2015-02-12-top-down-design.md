---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Code For the User, Not for Yourself"
date: 2015-02-12
tags: etiquette agile
categories: jcg
description: |
  Each change we make to our software has to provide some value
  to our users and customers; our technical objectives should
  take a back seat.
keywords:
  - breaking down tasks
  - tasks breaking down
  - incremental delivery
  - iterative and incremental
  - iterative programming
image: /images/2015/02/delicatessen.png
jb_picture:
  caption: Delicatessen (1991) by Jean-Pierre Jeunet
---

First, no matter what the methodology is, we all write software for our
users (a.k.a. customers, project sponsors, end users, or
[clients]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %})). Second,
no matter what the methodology is, we write incrementally, releasing
features and bug fixes one by one. Maybe I'm saying something absolutely obvious here,
but it's important to remember that each new version should first of all satisfy
the needs of the user, not of us programmers. In other words, the way
we decompose a big task into smaller pieces should be user-targeted, and that's
why you always work **top down**. Let's see what I mean through a practical example.

<!--more-->

{% jb_picture_body %}

Say I'm contracted by a friend of mine to create a word-counting command line
tool very similar to [wc](https://en.wikipedia.org/wiki/Wc_%28Unix%29). He
promised to pay me $200 for this work, and I promised him I'd deliver the
product in two increments---an alpha and beta version. I promised him
I'd release the alpha version on Saturday and the beta version on Sunday. He is
going to pay me $100 after the first release and the rest after the second release.

I'll write in C, and he will pay in cash.

The tool is very primitive, and it only took me a few minutes to write. Take a look at it:

```c
#include <stdio.h>
#include <unistd.h>
int main() {
  char ch;
  int count = 0;
  while (1) {
    if (read(STDIN_FILENO, &ch, 1) <= 0) {
      break;
    }
    if (ch == ' ') {
      ++count;
    }
  }
  if (count > 0) {
    ++count;
  }
  printf("%d\n", count);
  return 0;
}
```

But let's be professional and not forget about build automation and unit
testing. Here is a simple `Makefile` that does them both:

```makefile
all: wc test
wc: wc.c
  gcc -o wc wc.c
test: wc
  echo '' | ./wc | grep '0'
  echo 'Hello, world! How are you?' | ./wc | grep '5'
```

Now I run `make` from a command line and get this output:

```text
$ make
echo '' | ./wc | grep '0'
0
echo 'Hello, world! How are you?' | ./wc | grep '5'
5
```

All clean!

I'm ready to get my $200. Wait, the deal was to deliver two
versions and get cash in two installments. Let's back up a little and
think---how can we break this small tool into two parts?

On first thought, let's release the tool itself first and
build automation and testing next. Is that a good idea? Can we
deliver any software without running it first with a test? How can I be
sure that it works if I don't ship tests together with it? What will my friend
think about me releasing anything without tests? This would be
a total embarrassment.

Okay, let's release `Makefile` first and `wc.c` next. But what will my
friend do with a couple of tests and no product in hand? This first
release will be absolutely pointless, and I won't get my $100.

{% quote Every new increment must add some value to the product as it is perceived by the customer, not by us programmers %}

Now we're getting to the point of this article. What I'm trying to say
is that every new increment must add some value to the product as it
is perceived by the customer, not by us programmers. The `Makefile` is
definitely a valuable artifact, but it provides no value to my friend.
He doesn't need it, but I need it.

Here is what I'm going to do. I'll release a skeleton of the tool, backed
by the tests but with an absolutely dummy implementation. Look at it:

```c
#include <stdio.h>
int main() {
  printf("5\n");
  return 0;
}
```

And I will modify the `Makefile` accordingly. I will disable the first test
to make sure the build passes.

Does my tool work? Yes, it does. Does it count words? Yes, it does for
some inputs. Does it have value to my friend. Obviously! He
can run it from the command line, and he can pass a file as an input. He will
always get number "5" as a result of counting, though. That's a bummer, but it's
an alpha version. He doesn't expect it to work perfectly.

However, it works, it is backed by tests, and it is properly packaged.

What I just did is a top-down approach to design. First of all, I created
something that provides value to my customer. I made sure it also satisfies
my technical objectives, like proper unit test coverage and build automation.
But the most important goal for me was to make sure my friend received
something ... and paid me.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">What from would you start making a new webservice?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1264577360449409024?ref_src=twsrc%5Etfw">May 24, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
