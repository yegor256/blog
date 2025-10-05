---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Windows vs. macOS"
date: 2025-10-05
place: Moscow, Russia
tags: mood
description: |
  ...
keywords:
  - windows vs macOS
  - windows vs MacBook
  - macOS vs ubuntu
  - windows vs ubuntu
  - macOS vs windows
image: /images/2025/10/...
jb_picture:
  caption: ...
---

In 2020, in the [Junior Objects](/books/junior-objects) book I wrote this:
  "_Windows is not suitable for programmers.
  If you meet anyone who will tell you otherwise, you must know that you deal with a bad programmer, or a poor one, which are the same things.
  Your computer has to be MacBook._"
Now, five years later, I still stand at the same opinion.
This blog post is supposed to be less opinionated and, because of this, more convincing.
The point is still the same: you either use Windows or you are a professional programmer.

<!--more-->

{% jb_picture_body %}

First thing first.
This is what ChatGPT [thinks][chat] about macOS vs. Windows (I toned it down a bit and sorted by importance, keeping what matters most at the top):

* It's [POSIX]-compliant
* Tools like `grep`, `awk`, `sed`, `ssh`, and `make` work natively---no WSL hacks
* Proper compiler toolchain (Clang, LLVM, make, [git][Git]), not bloated Visual Studio nonsense
* You can install everything with [HomeBrew], one command away
* Node, Python, Ruby, Go, Java --- everything just works without endless PATH hell
* The [iTerm2] is stable, scriptable, and doesn't look like it was built in 1998
* [Docker] runs faster and cleaner than on Windows (even with [WSL2][WSL])
* SSH keys integrate smoothly with the system keychain
* [Git] behaves predictably; no [CRLF vs LF nightmares]
* Most open-source tools are made on macOS or Linux, not Windows

I can hear you saying:
What do I need it to be POSIX-compliant, and what is POSIX?
Why do I need `grep`, `sed`, and `awk`?
Am I a 60 years old Unix admin?
Why would I ever need `git` and `make` in the command line?
I don't use command line at all.
I stay in the [VS Code] that works like a charm and helps me make a living.

I hear you. I do.

Now, hear me out.
You are not a programmer.
You look like one.
You walk like one.
You click the same buttons programmers click.
You even make the same salary they make.
But you are not one of them.
Yet.

## What Is Unix?

Programmers are the masters of computers.
They tell machines what to do.
To simplify the task of managing a compex hardware, programmers invented a few layers of abstractions.
The first layer is an operating system.
Instead of dealing with the hard drive and the pixels on the screen directly, programmers invented files and stdout.

They did it in the [Bell Labs], during the late 1960s and early 1970s.
Earlier operating systems, like [CTSS] and [OS/360], gave them a good start.
Unix was the first OS to say that everything is a file, including devices, directories, sockets, and processes.
They also invented pipelines and the philosophy: "Write programs that do one thing well, and work together."
Also they invented processes and their forking mechanism.
Their names were [Ken Thompson] and [Dennis Ritchie].

## What Is Windows?

Five years later, another operating system was created, with different abstractions.
Not everything was a file anymore, processes were not parallel, and there were no pipelines.
The name of the system was [CP/M] and the name of the inventor was [Gary Kildall].
Then, five years later, 24-years-old [Tim Paterson] has made a copy of CP/M and called it [86-DOS].
[Microsoft] purchased a non-exclusive license for it, changed the label, and licensed it to IBM.
You know this story.

Why there were no proper files, no processes, and no pipelines?
Because they weren't trying to build a "real" operating system.
CP/M and MS-DOS were designed for tiny, single-user, single-task microcomputers, not multi-user minicomputers or mainframes.
Unix came out of Bell Labs --- researchers, not hobbyists.
CP/M and MS-DOS were made for personal computers: hobbyists, offices, home users.
In other words, MS-DOS never ment to be a proper OS.
It was something that can boot up a small machine and run a single program.

Then, in 1985, Windows 1.0 was built.
It was as a fancy GUI on top of MS-DOS, not a new OS.
Later, in 1995, Microsoft introduced 32-bit APIs (Win32) and preemptive multitasking.
However, the DOS subsystem was still lurking underneath.
Windows 95 looked modern but was still half-DOS zombie.

At the same time, in 1993, the team of [Dave Cutler] has built Windows NT that was not based on DOS at all.
Latest Windows versions are descends from NT, not MS-DOS.
Under the hood it's conceptually closer to Unix than to CP/M.
There are features like protected memory, kernel/user separation, and file handles.
However, still it's not Unix.
Because it doesn't have pipelines.

## Pipelines

[Unix] was built around pipelines.
In Unix, everything is a small tool reading stdin, writing stdout.
At the same time, everything is a file, including sockets, devices, and processes.
Programmers, in Unix, see every process a composition of smaller processes, glued together via pipelines.
This mindset, since 1970s, has proven to be effective, amongst a few generations of software engineering elite.

Say, you want to know which parts of your codebase change the most---maybe for refactoring, testing focus, or bug-hotspot analysis.
This is how you do it Unix-style:

```bash
git log --pretty=format: --name-only | \
  grep '\.java$' | \
  sort | \
  uniq -c | \
  sort -nr | \
  head -20
```

Does this syntax make sense to you?
Yes, it does and you are on Windows?
I bet you use [WSL].
Most serious Windows developers end up doing exactly that.

The command line is the bare metal interface to Unix.
It exposes what GUIs and IDEs hide---file structure, processes, I/O, permissions, and pipelines.
Command-line tools are inherently composable.
You can chain them in a pipeline and automate tasks in seconds that would take hours by hand.
No IDE plugin can replace this power.

...

[chat]: https://chatgpt.com/share/68e2770a-79d8-8007-96d1-3722d4d3cfcd
[WSL]: https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux
[POSIX]: https://en.wikipedia.org/wiki/POSIX
[iTerm2]: https://iterm2.com/
[CRLF vs LF nightmares]: https://stackoverflow.com/questions/1552749/difference-between-cr-lf-lf-and-cr-line-break-types
[Docker]: https://www.docker.com/
[Git]: https://git-scm.com/
[HomeBrew]: https://brew.sh/
[VS Code]: https://code.visualstudio.com/
[Unix]: https://en.wikipedia.org/wiki/Unix
[Ken Thompson]: https://en.wikipedia.org/wiki/Ken_Thompson
[Dennis Ritchie]: https://en.wikipedia.org/wiki/Dennis_Ritchie
[Tim Paterson]: https://en.wikipedia.org/wiki/Tim_Paterson
[Gary Kildall]: https://en.wikipedia.org/wiki/Gary_Kildall
[86-DOS]: https://en.wikipedia.org/wiki/86-DOS
[CP/M]: https://en.wikipedia.org/wiki/CP/M
[Microsoft]: https://www.microsoft.com/
[CTTS]: https://en.wikipedia.org/wiki/Compatible_Time-Sharing_System
[OS/360]: https://en.wikipedia.org/wiki/OS/360_and_successors
[Bell Labs]: https://en.wikipedia.org/wiki/Bell_Labs
[Dave Cutler]: https://en.wikipedia.org/wiki/Dave_Cutler
