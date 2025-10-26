---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Programmers, Don't Use Windows!"
date: 2025-10-05
place: Moscow, Russia
tags: mood
description: |
  Windows turns programmers into mouse operators.
  macOS, built on Unix, keeps the command line alive—where everything is a file,
  tools connect through pipelines, and real programmers stay in control.
keywords:
  - windows vs macOS
  - windows vs MacBook
  - macOS vs ubuntu
  - windows vs ubuntu
  - macOS vs windows
image: /images/2025/10/das-experiment.jpg
jb_picture:
  caption: Das Experiment (2001) by Oliver Hirschbiegel
---

In 2020, in the [Junior Objects](/books/junior-objects) book I wrote this:
  "_Windows is not suitable for programmers.
  If you meet anyone who will tell you otherwise, you must know that you deal with a bad programmer, or a poor one, which are the same things.
  Your computer has to be MacBook._"
Now, five years later, I still hold the same opinion.
This blog post is supposed to be less opinionated and, because of this, more convincing.
The point is still the same: you either use Windows or you are a professional programmer.

<!--more-->

{% jb_picture_body %}

First things first.
This is what ChatGPT [thinks][chat] about macOS vs. Windows (I toned it down a bit and sorted by importance, keeping what matters most at the top):

* It's [POSIX]-compliant
* Tools like `grep`, `awk`, `sed`, `ssh`, and `make` work natively
* Proper compiler toolchain: Clang, LLVM, make, [git][Git]
* Install everything with [HomeBrew], one command away
* Node, Python, Ruby, Go, Java---just work without PATH hell
* The [iTerm2] doesn't look like it was built in 1998
* [Docker] runs faster and cleaner than on Windows
* SSH keys integrate smoothly with the system keychain
* [Git] behaves predictably; no [CRLF vs LF nightmares]

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
Now, read on.

## What Is Unix?

Programmers are the masters of computers.
They tell machines what to do.
To simplify the task of managing a complex hardware, programmers invented a few layers of abstractions.
The first layer is an operating system.
Instead of dealing with the hard drive and the pixels on the screen directly, programmers invented files and stdout.

They did it in the [Bell Labs], during the late 1960s and early 1970s.
Earlier operating systems, like [CTSS] and [OS/360], gave them a good start.
Unix was the first OS to say that everything is a file, including devices, directories, sockets, and processes.
They also invented pipelines and the philosophy: "Write programs that do one thing well, and work together."
They also invented processes and their forking mechanism.

Their names were [Ken Thompson] and [Dennis Ritchie].

## What Is Windows?

Five years later, another operating system was created, with different abstractions.
Not everything was a file anymore, processes were not parallel, and there were no pipelines.
The name of the system was [CP/M] and the name of the inventor was [Gary Kildall].
Then, five years later, 24-year-old [Tim Paterson] has made a copy of CP/M and called it [86-DOS].
[Microsoft] purchased a non-exclusive license, rebranded it [MS-DOS], and sold it to IBM.
That's how Windows was born.

Why were there no proper files, no processes, and no pipelines?
Because they weren't trying to build a "real" operating system.
CP/M and MS-DOS were designed for tiny, single-user, single-task microcomputers, not multi-user minicomputers or mainframes.
Unix came out of Bell Labs---researchers, not hobbyists.
CP/M and MS-DOS were made for personal computers: offices and home users.
In other words, MS-DOS never meant to be a proper OS.
It was something that can boot up a small machine and run a single program.

Then, in 1985, [Windows 1.0] was built.
It was a fancy [GUI] on top of MS-DOS, not a new OS.
Later, in 1995, Microsoft introduced 32-bit APIs ([Win32]) and preemptive multitasking.
However, the DOS subsystem was still lurking underneath.
Windows 95 looked modern but was still a half-DOS zombie.

At the same time, in 1993, the team of [Dave Cutler] has built [Windows NT] that was not based on DOS at all.
Latest Windows versions are descendants of NT, not MS-DOS.
Under the hood it's conceptually closer to Unix than to CP/M.
There are features like protected memory, kernel/user separation, and file handles.
However, still it's not Unix.

## What Is macOS?

In 1984, [Apple] shipped their first [Macintosh] with the "System 1" operating system.
It was no better than MS-DOS: no multitasking, no memory protection, and primitive file system.
No surprise, it didn't fly.

In 1997, Apple bought [NeXT] and adopted [NeXTSTEP] operating system.
They made it the foundation for the new [Mac OS]---codenamed [Rhapsody], later "Mac OS X".

In 2001 they shipped Mac OS X 10.0 ("[Cheetah]").
Five years later I threw away my ThinkPad with Windows and bought my first MacBook with [Mac OS X Leopard].

Modern macOS (Catalina, Ventura, Sequoia, etc.) is still built on that NeXT foundation.
It is POSIX-compliant and, of course, it has processes and pipelines.
In other words, it is Unix with a pretty GUI.

## Abstractions

Both Windows and macOS, in their current versions, are solid operating systems.
The difference is in the abstractions inside them: files, sockets, processes, memory blocks, users, permissions, and so on.
In Unix (macOS), everything is a file, while in Windows, everything is an object.
Files in Unix are a uniform abstraction, that's why they can be chained via pipes.
In Windows objects are not unified in practice, they have different interfaces.

This is why [Unix shells][shell] and small composable tools became so powerful.
The uniformity of "everything is a file" made composition natural.
You can build complex workflows from simple programs.

Windows, on the other hand, evolved around GUI apps and message loops, not shell pipelines.

## Pipelines

[Unix] was built around pipelines.
In Unix, everything is a small tool reading stdin, writing stdout.
At the same time, everything is a file, including sockets, devices, and processes.
Programmers, in Unix, see every process as a composition of smaller processes, glued together via pipelines.
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
If it does, I bet you use [WSL].
Most serious Windows developers end up doing exactly that.

The command line is the bare metal interface to Unix.
The heart of the command line is pipelines.
Thanks to pipelines, command-line tools are inherently composable.
You can chain them and automate tasks in seconds that would take hours by hand.
No [IDE] plugin can replace this power.

## What Are You?

Now, you know what the difference is between Windows and macOS.
In both of them you can code, browse Internet, and watch movies.
However, in macOS you interact with the computer through Unix abstractions in a [shell].
You don't just use macOS---you inherit fifty years of disciplined abstraction.

In Windows you interact with the computer through draggable GUI elements.
A GUI makes you a consumer; a CLI makes you a creator.
A GUI hides the logic behind gestures and icons; a CLI exposes it as text you can reason about, automate, and combine.
You can't pipe a button click into another program, you can't grep a progress bar, and you can't version-control a mouse movement.
Every click you make dies the moment you make it; every command you write can live forever.

Oh, wait.
In macOS you can't really play games.
Bummer...
Maybe you shouldn't, since you are a programmer?

[chat]: https://chatgpt.com/share/68e2770a-79d8-8007-96d1-3722d4d3cfcd
[WSL]: https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux
[POSIX]: https://en.wikipedia.org/wiki/POSIX
[MS-DOS]: https://en.wikipedia.org/wiki/MS-DOS
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
[CTSS]: https://en.wikipedia.org/wiki/Compatible_Time-Sharing_System
[OS/360]: https://en.wikipedia.org/wiki/OS/360_and_successors
[Bell Labs]: https://en.wikipedia.org/wiki/Bell_Labs
[Dave Cutler]: https://en.wikipedia.org/wiki/Dave_Cutler
[Windows 1.0]: https://en.wikipedia.org/wiki/Windows_1.0
[Win32]: https://en.wikipedia.org/wiki/Windows_API
[Windows NT]: https://en.wikipedia.org/wiki/Windows_NT
[Mac OS X Leopard]: https://en.wikipedia.org/wiki/Mac_OS_X_Leopard
[Macintosh]: https://en.wikipedia.org/wiki/Macintosh_128K
[NeXTSTEP]: https://en.wikipedia.org/wiki/NeXTSTEP
[Windows 95]: https://en.wikipedia.org/wiki/Windows_95
[IDE]: https://en.wikipedia.org/wiki/Integrated_development_environment
[Apple]: https://www.apple.com/
[NeXT]: https://en.wikipedia.org/wiki/NeXT
[Mac OS]: https://en.wikipedia.org/wiki/MacOS
[Rhapsody]: https://en.wikipedia.org/wiki/Rhapsody_(operating_system)
[Cheetah]: https://en.wikipedia.org/wiki/Mac_OS_X_10.0
[GUI]: https://en.wikipedia.org/wiki/Graphical_user_interface
[ThinkPad]: https://en.wikipedia.org/wiki/ThinkPad
[shell]: https://en.wikipedia.org/wiki/Unix_shell
