---
layout: post
title: "Elegant READMEs"
date: 2019-04-23
place: Samara, Russia
tags: specs oss
description: |
  The README document is the most important piece of
  documentation your project can have; how to design
  it right is a big question; here is my cheat-sheet.
keywords:
  - README
  - how to write README
  - documentation
  - open source README
  - how to design README
image: /images/2019/04/life-of-pi.jpg
jb_picture:
  caption: Life of Pi (2012) by Ang Lee
---

Some time ago I wrote a blog post
[_An Open Code Base Is Not Yet an Open Source Project_]({% pst 2018/may/2018-05-08-open-source-attributes %})
where I suggested a few important qualities of a good open
source repository/project. One of them was the well-written README
file. Here I will try to give a few hints on how to create
a good README file and what mistakes to avoid. I hope you find it
helpful.

<!--more-->

{% jb_picture_body %}

I will list everything you need to have in the README, in the order
those elements should show up:

## Title and Description

Why include these? The title is already in the URL of your repo and the description
of the project is in the GitHub subtitle. Why repeat yourself? Instead,
start with a logo and a list of badges right after it:

```text
<img src="https://www.takes.org/logo.png" height="64px"/>

[![Build Status](https://travis-ci.org/zold-io/zold.svg?branch=master)](https://travis-ci.org/zold-io/zold)
```

Pay attention to the empty line after the logo. Don't forget to specify
the size of the image in the `height` attribute. You can skip the `width`,
since just one dimension is enough for the HTML. Don't make it larger
than 100px in height.

## Badges

You need them, as I [said earlier]({% pst 2018/may/2018-05-08-open-source-attributes %}).
But the question is how to position them inside the README.
You should put no more than fives badges in a line. Then separate the
lines with an empty line. See how it's done in
our [zold-io/zold](https://github.com/zold-io/zold) repo.

{% youtube Qxvk9z0tEP8 %}

You should group them somehow in the lines, using some logic. I group them
by the level of technical details. The first line is about CI, code coverage,
code quality. The second line is more about management, etc. It's up to you,
but make sure all badges that stay in the same line are of the same height!
If some badge has a different height than everything else, give it its own
line, but never put two badges of a different height on the same line!

Also, remember that only in a few very specific cases (like badges, for example)
are you allowed to make lines longer than 80 characters. Treat your README
document as a piece of source code. Make it properly and elegantly formatted.
The width of the line is one of those formatting rules that will make
your document look better. Eighty characters. That's it.

## What is it?

Your first paragraph after the badges should explain what the product is
about. Pay attention: a _paragraph_, not a page of text. You should put
the description of the product in one single paragraph. No bullets here,
no new lines, no indentations. Just a plain simple piece of text:

```text
**Takes** is a
[true object-oriented](https://www.yegor256.com/2014/11/20/seven-virtues-of-good-object.html)
and [immutable](https://www.yegor256.com/2014/06/09/objects-should-be-immutable.html)
Java7 web development framework. Its key benefits,
comparing to all others, include four fundamental principles:
1) not a single `null`, 2) not a single `public` `static`
method, 3) not a single mutable class, and 4) not
a single `instanceof` keyword, type casting, or reflection.
```

Pay attention, there are no headings yet. Just a logo, a few lines with badges
and some plain text with the description of the product. You may, and should,
use [markdown](https://help.github.com/en/articles/basic-writing-and-formatting-syntax)
here and point the reader to any relevant blog posts or YouTube
videos or anything else, but make sure you fit your entire idea into
a single paragraph.

## How to use it?

Then, again without any headings, you just get right to the point of how I can
use your baby, as a complete newbie to this repo. I just opened this
page because a friend of mine told me that it's great and I want to understand
if it's worth it or whether I should close it right now. You have my attention for another
60 seconds. Tell me _how to try it_! Something like this:

```text
First, you install it:

```text
$ gem install zold
```

Then, you run it and follow the instructions:

```text
$ zold --help
```

It should be clear what to do. If not, ask us in
our [Telegram chat](https://t.me/zold_io).
```

Pay attention to the formatting. I don't indent anything and I use triple-apostrophe
for code-sample formatting. You should do the same. Separate text blocks with
a [_single_]({% pst 2014/nov/2014-11-03-empty-line-code-smell %}) empty line.

## Use cases

Here starts the body of your README. The exact content depends on your specific
business case and the nature of your product. However, no matter what the
product, there are a few recommendations.

First, don't replace automatically generated Javadocs
(or whatever you have in your language) with the README. The README is not
user documentation for everything you have in your repo. There are
other places for that. What you can do here is explain a few of the most
interesting use cases. See how we did it in the
[yegor256/takes](https://github.com/yegor256/takes) project.

Second, start each use case with a header of the second level (`##` in Markdown),
and try to avoid third-level headers (`###`). Do I need to say that
the fourth level is absolutely prohibited? And, of course, again, no indenting.
Always start your text lines from the far left position, no matter
whether it's a paragraph of text or a section header.

Third, keep in mind that you will change your
product very soon and you don't want to always remember where in the
README file you have to change what. You want your README to stay
as short as possible and as high-level as possible. That's why, if you can,
avoid specific details and instead redirect the reader to the relevant
parts of the _automatically_ generated documentation.

Fourth, use as few words as you can. Nobody is interested in reading
your prose for more than a few seconds and only in order to understand
how to use your product or how to make some changes. Don't focus on yourself,
we don't care about you. Focus on us and our needs. Tell us how it works
and call it a README. No philosophy, no prose. Use your blog and Twitter
for those.

## How to contribute

Start it with a section header "How to contribute" and explain briefly
what needs to be done in order to create a pull request to your repo. Imagine
that you are talking to a junior developer who doesn't even know what
Java and Maven are (if your project is using them). You should explain how
to install the right tools, how to build the project, how to make changes,
how to run it in a hot-reload mode (when I'm making changes and see them
on the screen immediately), how to create the fork, and what to expect
when the fork is submitted.

Don't be too verbose. Actually, be as compact as you can. Always, where possible,
redirect the reader to the documentation of those tools or some blog posts,
which explain better. See how it's done in the README of [zold-io/wts.zold.io](https://github.com/zold-io/wts.zold.io#how-to-contribute),
a web app written in Ruby. The short piece of text at the bottom of the page
explains what you have to install (providing links to the installation tutorials),
how to run the app locally, how to run the build, how to run a single
unit test and what to do if it doesn't work. It's pretty compact and, I believe,
easy to understand.

You don't want your potential contributor to walk away. That's why this
part of the entire README is the most important one. Make sure you address
your text to a junior programmer, not yourself. As they say, your grandma
should be able to understand you here.

And don't teach us. We are not interested in becoming experts in the
frameworks you are using or in Docker, which is required in order to
run your stuff. We just want to run your stuff, make some changes,
get a new release, and walk away. So, please, don't tell me "first, you
have to learn Docker." No, I don't. If I did, I'd have done it myself already.
Tell me how to use it in _this specific case_, and spare me all the rest.

## Downloads and Releases

GitHub has a special tab "releases" for that. No need to repeat it in the
README. Just make sure your "releases" tab contains enough information
and enough binary artifacts to download. Don't say a word about them
in the README.

## License

GitHub automatically finds your `LICENSE.txt` file in the root directory
of your repository and understands the license. Just create that file
and don't say anything in the README about the license, it's just pure noise.
If I want to know what the license is, I know where to click.

## Changelog

This is something from pre-GitHub time. I would recommend you rely
on the "releases" tab and keep everything you want to tell us there.
Some old projects maintain changelogs, like this one in
[rubocop-hq/rubocop](https://github.com/rubocop-hq/rubocop/blob/master/CHANGELOG.md),
for example. I don't think it's a good idea.

## Contributors vs. Acknowledgements

GitHub has a special tab in each repository, which is called "contributors."
There is absolutely no reason to reproduce the list in the README file.
However, there is one reason: to help the contributors promote themselves. In such a case,
I would recommend creating a section (with a heading) called "Acknowledgements,"
which should list the most active contributors, with their blog URLs,
Twitter accounts, and so on.

If you don't have anyone to acknowledge, don't make a noise by telling us
who the contributors are. We know them, GitHub tells us.

PS. Here is a short list of READMEs I like, which are not mine
(if you think that yours is good too, [email](maito:readme-review@yegor256.com)
it to me, I will review it and perhaps add it to this list):

  * [rugk/offline-qr-code](https://github.com/rugk/offline-qr-code)
  * [Vatavuk/verano-http](https://github.com/Vatavuk/verano-http)
