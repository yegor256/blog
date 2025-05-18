---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Please, Don't Improvise"
date: 2019-05-21
place: Moscow, Russia
tags: mood
description: |
  Getting a programmer to create a good looking user interface
  is an impossible mission; however there are a few simple
  rules that I, a programmer, follow to make my UIs look good enough.
keywords:
  - programmer designer paradox
  - ui design for programmer
  - ui programmer
  - simple ui
  - ui principles
image: /images/2019/05/big-eyes.jpg
jb_picture:
  caption: Big Eyes (2014) by Tim Burton
---

We all know what happens when a programmer decides how a web site
or a mobile app should look. It ends up looking ugly. And why is that? I don't know exactly,
but my best bet is on the [left-brained nature](https://www.linkedin.com/pulse/left-brain-vs-right-brain-developers-warren-gwartney/)
of programmers, who mostly are rigid and logical mathematicians. UI design, to the contrary,
requires creativity and intuition, which reside in the right side of our brain.
Some [recent studies](https://www.fastcompany.com/3029364/this-is-your-brain-on-code-according-to-functional-mri-imaging)
are skeptical about that, but my personal experience tells me that you should never expect
a programmer to make a user interface right.
Moreover, *I'm* one of those programmers: No matter what I draw, it's either
[black-and-white](/paintings.html), or ugly.
But I still have to design my [pet projects](/pets.html).
Here is a list of the top lessons I learned for myself, which help me survive
with my left-sided brain.

<!--more-->

{% jb_picture_body %}

**Leaders**.
I look at the things that big and famous companies are doing. I check the websites
I'm using every day to see what is "good" in modern web design:
[stackoverflow](https://stackoverflow.com),
[github](https://github.com),
[apple](https://www.apple.com),
[amazon](https://www.amazon.com),
[craigslist](https://www.craigslist.org/) (no kidding), etc.
I actually pay attention to fewer than ten websites.
They make buttons flat? I make them flat. They make fonts larger? I make
fonts larger. They make the background white, I make it white too.
I just copy them. They know better anyway.

**Frameworks**.
There are [many](https://github.com/troxler/awesome-css-frameworks) of them for
the web. I tend to pick the simplest one and use it. Well, I even created my own one
a few years ago: [_Tacit, a CSS Framework Without Classes_]({% pst 2015/apr/2015-04-13-tacit-css-framework-for-dummies %}).
I always try to "design" as little as possible and follow the
conventions forced by the framework's authors. If they want me to have my
buttons blue, they will be blue. I don't try to be creative but just follow
the rules of the frameworks I use.

**Defaults**.
There is always a big temptation to align the content "nicely,"
centering it or placing it in some multi-column grids. I try not to do
that, despite the temptation. I just don't know how to do it right,
which is why the content "flows" from the top to the bottom, element
by element, aligned _left_. Well, unless it's a set of tabular data.
Sometimes there is also a temptation to add or remove spacing between
elements, either via an extra `<br/>` or a `margin`. I don't do this.
The elements will be placed the way my framework places them by default.

**Colors**.
Choosing the right colors is a huge problem for me---I don't know how to do that right.
I don't know which red matches which green. That's why I use
[Coolors](https://coolors.co/app). I just click "space" multiple times and they
offer me a combination of five colors, which match each
other. I find the most attractive combination and call it a day. Five colors
are always enough for any web app.

**Bold, Italic, Underscore, and All Caps**.
It's simple---don't use them. Never. Well,
[as little as possible](https://practicaltypography.com/bold-or-italic.html).
You definitely shouldn't use them in order to make a visual element more visible. You've got
fonts for that. If you want your caption to catch the eye, make the
font larger. But don't use italic, bold, or, God forbid, all caps. I use
them sometimes, very rarely, but only in order to
[emphasize](https://en.wikipedia.org/wiki/Emphasis_%28typography%29)
a word in a sentence.

**Fonts**.
I try to stick to defaults, which are
[Serif](https://en.wikipedia.org/wiki/Serif),
[Sans-serif](https://en.wikipedia.org/wiki/Sans-serif),
and [Monospace](https://en.wikipedia.org/wiki/Monospaced_font).
If I can't, I use [Google Fonts](https://fonts.google.com/),
but very carefully. Of course, I use one font per system.
Do I know which two fonts are compatible? I don't. Do you?
Don't even try to make that decision right. Just one font and
[that's it](https://www.quora.com/How-many-different-fonts-should-you-use-in-your-website).
And I always try to make them as large as possible. This seems to be a
[trend](https://blog.marvelapp.com/body-text-small/)
now, most probably because screens are getting bigger.

**Images**.
I do everything I can to avoid them, to be honest. I always attempt to
replace them with text or [Unicode symbols](https://en.wikipedia.org/wiki/List_of_Unicode_characters),
if necessary. When it's absolutely necessary, I use
[SVG](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics) vector graphics.
PNG/JPEG raster-graphics is my last resort.

**Artists**.
I pay absolutely no attention to what modern web artists are doing.
They create beautiful things, but I don't even need to know about them.
They only annoy me, because I can't create anything similar. When someone
shows me a website with new CSS tricks, I close it immediately. This is not for
me. My CSS has to be as _short_ and _primitive_ as possible.

**Compliance**.
W3C has a number of validators for
[HTML](https://validator.w3.org/) and
[CSS](https://jigsaw.w3.org/css-validator/), which can tell what's
wrong with a website, statically analyzing it. This is similar to what
[Checkstyle](http://checkstyle.sourceforge.net/)
does for our Java code. I rely on their recommendations, always.
Sometimes they sound too strict, but they tell me what the expectations are
of those who know web design way better than I do.  In HTML5,
for example, we are supposed to have `<thead>` in our `<table>`, or the `alt` attribute
in all `<img>` elements. I always try to follow these and other rules.

**Responsive**.
The design has to be [mobile friendly](https://en.wikipedia.org/wiki/Responsive_web_design).
Always.

<hr/>

To summarize, I would suggest: don't improvise, don't try to be
creative, don't think that you understand what is beautiful and what's not.
You don't. Me neither. Just be as _minimalistic_ and _traditional_ as possible
and you will do yourself and your users a big favor.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">How to make a UI look yummy? <a href="https://twitter.com/hashtag/graphicdesigning?src=hash&amp;ref_src=twsrc%5Etfw">#graphicdesigning</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1132522579674173441?ref_src=twsrc%5Etfw">May 26, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
