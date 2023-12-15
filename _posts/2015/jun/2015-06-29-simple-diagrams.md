---
layout: post
title: "The Better Architect You Are, The Simpler Your Diagrams"
date: 2015-06-29
tags: architect
place: Palo Alto, CA
description: |
  Complex diagrams are the first and foremost
  sign of a bad architect who is not able to properly
  scope a problem.
keywords:
  - architectural diagrams
  - good architectural diagrams
  - make good diagrams
  - how to make good diagram
  - uml diagrams
social:
  - reddit: https://www.reddit.com/r/programming/comments/3bjrfy/the_better_architect_you_are_the_simpler_your/
image: /images/2015/06/a-beautiful-mind.jpg
jb_picture:
  caption: A Beautiful Mind (2001) by Ron Howard
---

I don't even know where to start. Let's begin with this:
_If I don't understand you, it's your fault_. This has to be
the most basic, fundamental principle of a good software architect (well,
of any engineer), but most of the architects I've met so far, in many
companies, don't seem to believe in it. They don't understand that
the job of a software architect is _to make complex things simple_,
not the other way around. They use diagrams, which are the most
popular instruments of an architect, to explain to us, programmers,
what he or she has in mind. But the diagrams are usually very cryptic
and hard to digest. What's worse is that the complexity goes up
in line with their salaries---it's disgusting.

<!--more-->

{% jb_picture_body %}

Why is this happening? Why are their diagrams complex and difficult to read?
I'm sure you know what I'm talking about; you probably have your own examples
of such diagrams from projects and architects you've worked with. So why do we have them?

Architects are _proud of complexity_, that's why. They think that
the more complex the problem they're working with, the better an engineer
they are. I've had this dialog many times:

```text
- You know, your diagram looks so complex ...
- Oh yeah, we're solving complex problems here!
```

Usually, after that, the architect smiles with an obvious feeling of satisfaction.
Indeed, someone actually noticed how difficult his job is and appreciated
his efforts. Someone is stupid, and he is smart. He can understand this
multi-tier architecture, and I can't. He definitely earns my respect, right?

Wrong! A good architect knows his main role is to decompose a complex problem
into less complex components and let programmers solve them one by one. Just as
a [good project manager]({% pst 2015/sep/2015-09-22-micromanagement %}) has to decompose a complex task into smaller ones.
When the problem is properly decomposed (broken down into smaller, isolated
and properly decoupled pieces), the complexity _decreases_, and it becomes
easier for everybody to understand and resolve.

{% quote If I don't understand you, it's your fault. %}

The main virtue of an architect is the ability to _reduce_ complexity. Thus,
a good architect would never be proud of a complex diagram. Instead, he would
be proud of a simple and easy-to-understand drawing with a few rectangles that
perfectly explain an entire multi-tier application. That is what
is really difficult to do. That's where a true architectural mind shines.

There are not many architects like that. I can't say I'm one of them yet,
but I have a few recommendations for your diagrams. Read on and remember
that the main goal of all this is to _reduce complexity_.

**No More Than Five Rectangles**.
If you have more, there is something wrong. Try to explain yourself
in less than five. Just group some of them together and give it a name.
You don't want me to spend more than a few seconds trying to understand who
is participating in the show you're presenting. I want to see them
all at one glance and immediately understand who is who. I just made up
the number five, but you get the idea---make sure all diagram participants
are easy to count. I've seen diagrams with 25 or more rectangles ... that's unacceptable.

{% badge /images/2015/06/uml-distilled-book.jpg 96 https://amzn.to/2bQVt00 %}

**Use UML**.
Well, use whatever notation you feel comfortable with, but many years ago
people agreed that instead of using different notations, it would be easier
to learn one for all; that's [UML](http://www.uml.org/).
It's a huge format/standard/language,
but you don't need to know all of it. Just learn the basics; that will be
enough to express almost any idea you have. I would recommend
[UML Distilled: A Brief Guide to the Standard Object Modeling Language (3rd Edition)](https://amzn.to/2bQVt00)
by Martin Fowler.

**Direct and Annotate Lines**.
There is nothing more annoying on a diagram than a line connecting two
rectangles without any text on it and without any direction. Is it a flow
of data? Is it a compile-time dependency? There are many possible meanings.
Always use arrows, and always annotate them---this will help me
understand you much faster.

{% quote A good architect would never be proud of a complex diagram. %}

**Don't Use Colors**.
Or let me put it this way: Don't abuse colors. And in order to avoid abusing
them, you are better off staying away from colors in the first place. If you need
to use colors, there must be something wrong with your diagram. It's probably
too complex; that's why you need to use colors. Simplify it by grouping elements.

**Don't Be Creative**.
It's not art; it's engineering. You don't need to impress me; you need
to deliver the message. Your goal is not to show how sophisticated your mind is.
Moreover, your diagram style should not be personal. A diagram from you and
a diagram from another architect should look almost exactly the same if they
deliver the same message. It's call uniformity. That's how you make them
easier for me to understand. I don't want to have to learn your personality
in order to understand your diagram. If it's a server, draw a
rectangle. There's no need to put a 3D picture of an HP server there.
A rectangle is enough. Also, please no shades, no fonts, and no styles.
Again, it's not an artistic contest. I will understand your rectangle
pretty well without that "nice" shadow you're tempted to drop. I will also
understand an arrow with a default width; no need to make it wider just
because your diagram editor allows you to. Don't waste your time and my
time on all this styling. Just focus on those simple lines, rectangles, text,
and arrows.

<hr/>

As I mentioned above, the goal of all this is to
[reduce complexity]({% pst 2015/apr/2015-04-13-tacit-css-framework-for-dummies %})
and help me, a programmer, understand you, an architect. Remember,
if I can't understand you, it's your fault. You're a bad architect
if you can't deliver your ideas in a plain, simple form.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Sometimes the documentation and diagrams I create are too complex and difficult to understand because...</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1086873609157705729?ref_src=twsrc%5Etfw">January 20, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
