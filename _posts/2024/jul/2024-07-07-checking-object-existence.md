---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Files.fileExists or file.exists?"
date: 2024-07-07
place: St. Petersburg, Russia
tags: oop
description: |
  You either instantiate an object first and then check
  its qualities, or you check the quality and only then
  make an object; which way is better?
keywords:
  - object consistency
  - existence of object
  - object qualities
  - constructor
  - object constructor
image: /images/2024/07/capote.jpg
jb_picture:
  caption: Capote (2005) by Bennett Miller
---

How would you design a class that abstracts, say, a file on a disk with certain
properties? Let's say you need to be able to check whether the file exists on
the disk or has already been deleted. Would you create an object first and then
call the `exists()` method on it, or would you call `Disk.fileExists()` first
and only then, if `TRUE` is returned, make an instance of the `File` class and
continue working with it? This may sound like a matter of taste, but it's not
that simple.

<!--more-->

{% jb_picture_body %}

Let's see how we can check whether a file exists on the disk or not
in different programming languages and their SDKs:

| Language | How to check if file exists? |
|---|---|
| [JDK 7](https://docs.oracle.com/javase%2F7%2Fdocs%2Fapi%2F%2F/java/io/File.html#exists%28%29) | `Files.get("a.txt").exists()` |
|---|---|
| [JDK 8](https://docs.oracle.com/javase/8/docs/api/java/nio/file/Files.html#exists-java.nio.file.Path-java.nio.file.LinkOption...-) | `Files.exists(Path.get("a.txt"))` |
|---|---|
| [.Net](https://learn.microsoft.com/en-us/dotnet/api/system.io.file.exists?view=net-8.0) | `File.Exists("a.txt")` |
|---|---|
| [Node](https://nodejs.org/api/fs.html#fsexistssyncpath) | `fs.existsSync('a.txt')` |
|---|---|
| [Python](https://docs.python.org/3/library/os.path.html#os.path.exists) | `os.path.exists("a.txt")` |
|---|---|
| [Python (3.4+)](https://docs.python.org/3/library/pathlib.html#pathlib.Path) | `pathlib.Path("a.txt").exists()` |
|---|---|
| [Ruby](https://ruby-doc.org/core-2.5.1/File.html#method-c-exist-3F) | `File.exist?("a.txt")` |
|---|---|
| [Perl](https://perldoc.perl.org/functions/-X) | `if -e "a.txt"` |
|---|---|
| [PHP](https://www.php.net/manual/en/function.file-exists.php) | `file_exists('a.txt')` |
|---|---|
| Smalltalk | `(File name: 'a.txt') exists ifTrue: ...` |

There are basically two different design decisions: either you make a `File`
object first, then ask it for its existence on the disk, or you ask the disk
whether the file is there and only after that you make an instance of the
`File` class. Which design is better? Let's forget for a moment that static
methods are evil and imagine that `Files` is not a
[utility class]({% pst 2014/may/2014-05-05-oop-alternative-to-utility-classes %}), but an
abstraction of a disk. How would you design the `exists()` method if you were
the designer of a new SDK for a new programming language?

To answer this question, we must answer a more fundamental one: what is the
message an SDK would be sending to a programmer by placing the `exists
()` method either on the `File` or on the `Disk`?

This may sound like a trivial and cosmetic issue to an experienced programmer,
but let me convince you that it's not. Consider the design of a list of payment
bills in a database. A bill may either be "paid" or "not yet paid," which a
programmer may check through the `paid()` method. The first design choice is
this (it's Java):

```java
Bill b = bills.get(42)
if (b.paid()) {
  // do something
}
```

The second choice would be the following:

```java
if (bills.paid(42)) {
  // do something
}
```

What is the message in the first snippet? I believe it's the following: "A bill
may either be paid or not." What is the message in the second design option?
It's this: "If a bill exists, it is paid." In other words, in the first
snippet, two qualities of a bill ("I exist" and "I'm paid") co-exist, while in
the second snippet they are merged into one ("I'm paid").

At the persistence layer, this dichotomy of qualities may mean either a nullable
column `paid` in an SQL-database table or one with the `NOT NULL` constraint.
The first snippet may return a `bill` object that exists in the database as a
row, but the `paid` column is set to `NULL`. A programmer who uses your design
can easily grasp the idea of the "being paid" status of a bill: it's not the
same as the status of its existence. A programmer must first get the bill and
only then check its payment status. A programmer would also expect two points
of possible failure---a bill may be absent, or a bill may not be
paid---throwing different exceptions or returning different types of results.

As you see, this issue is not cosmetic but very much existential: the design of
the methods of a `Bill` or `Bills` helps programmers understand on what terms
the bills exist.

Now, the answer to the original question about the `exists()` method of a file
is easy to find. Locating a file on a disk is the first task, which checks
whether the name of the file is correct and the file may potentially exist on
the disk:

```java
// Here, an exception may be raised if,
// for example, the name of the file is
// wrong or simply a NULL.
File f = new File("a.txt");
```

Then, the existence of the file,
at this particular moment, on the disk, is checked:

```java
// Here, an exception may be raised if,
// for example, the disk is not mount or
// the permissions are not sufficient for
// checking the existence of the file.
boolean e = f.exists();
```

We may now conclude that how Python, JS, Ruby, and many others let us check the
existence of a file on the disk is wrong. JDK 7 was right, but the inventors of
JDK 8 ruined it (most probably for the sake of performance).

By the way, there are many more
[examples](https://rosettacode.org/wiki/Check_that_file_exists) of
different "file checking" design decisions in many other programming
languages.
