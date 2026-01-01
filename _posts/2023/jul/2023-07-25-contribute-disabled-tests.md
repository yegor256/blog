---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "A Disabled Test In Lieu of a Bug Report"
date: 2023-07-25
place: Kazan, Russia
tags: pdd testing
description: |
  Instead of merely submitting bug reports, it can often be more efficient
  to contribute a pull request, complete with a disabled unit test
  and a detailed description of the problem.
keywords:
  - pull request
  - unit test
  - bug report
  - bug tracking
  - puzzle driven development
image: /images/2023/07/dead-or-alive.jpg
jb_picture:
  caption: Dead or Alive (1999) by Takashi Miike
---

When you find a bug in an open-source library that you use,
[what do you do]({% pst 2018/jul/2018-07-24-bugs-or-pull-requests %})?
You submit a GitHub issue (or whatever ticket tracking system they use).
In the issue, you describe the problem in the best possible way, preferably
providing a working code example that the author of the library can run locally
to reproduce the bug. If you don't provide them with an executable snippet of code,
they will most likely ask you to do so, unless the bug is trivial.
I suggest simplifying the workflow and giving them what they want right
in a pull request: send them the bug in the form of a disabled unit test.

<!--more-->

{% jb_picture_body %}

Say, there is a Rust library that provides a `fibo()` function that
calculates a [Fibonacci number](https://en.wikipedia.org/wiki/Fibonacci_sequence),
which you can use this way:

```rust
let n = 23;
let x = fibo(n);
println!("The {n}th Fibonacci is {x}");
```

You run it and it prints `17711`, which is mistakenly the 22nd Fibonacci number,
not the 23rd. It is definitely a bug. You submit a ticket, saying something like this:

```
I'm trying to use your library to calculate
a Fibonacci  number, but for some reason, I'm
getting a wrong result:  the 23rd number your
library returns is 17711, while I'm expecting
the number 28657. Please check and fix.
```

They will reply "Can you prove it, please? Show us the code!" and
you will probably add this code to the ticket:

```rust
let x = fibo(23);
assert_eq!(28657, x);
```

Then, if they are [disciplined]({% pst 2017/mar/2017-03-24-tdd-that-works %})
programmers, a new unit test will be created and the
`fibo()` function will be fixed. Moreover, if they are
[very disciplined]({% pst 2022/aug/2022-08-04-code-and-tests-different-pull-requests %}) programmers,
they will submit the test in a separate pull request, disabling it. Then, in
the second pull request, they will make a fix.

Why can't you help them and skip the issue submission step? Just make the
first pull request yourself, with the disabled test inside and a
["puzzle"]({% pst 2010/mar/2010-03-04-pdd %}) added to it:

```rust
// @todo #42 This test is disabled because the
//  fibo() function doesn't work correctly
//  with this particular number, it returns
//  17711 instead of 28657. Let's fix it.
#[test]
#[ignore]
fn calculates_23rd_fibonacci_number() {
  let x = fibo(23);
  assert_eq!(28657, x);
}
```

Such a PR serves as both a bug report
(this is what the text of the puzzle will be turned into, once the PR is merged)
and a test that reproduces the problem. It will be more than welcome
by the repository maintenance team. This kind of PR saves the time
they would spend creating a unit test. Also, it saves your time for
creating a bug report, as it will be created automatically by
[the puzzles discovery tool]({% pst 2014/apr/2014-04-12-puzzle-driven-development-by-roles %}).

{% badge https://www.jcabi.com/logo-square.svg 48 https://http.jcabi.com %}

BTW, this blog post was motivated by [this pull request](https://github.com/jcabi/jcabi-xml/pull/212)
in the [jcabi/jcabi-xml](https://github.com/jcabi/jcabi-xml) library, where a disabled
unit test was added to the code base specifically to reproduce the bug. In addition to
the test, a puzzle was added, which led to a [new ticket](https://github.com/jcabi/jcabi-xml/issues/213),
a [new pull request](https://github.com/jcabi/jcabi-xml/pull/214),
and finally a [new release](https://github.com/jcabi/jcabi-xml/releases/tag/0.28.0) of the library.
