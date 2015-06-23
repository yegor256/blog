---
layout: post
title: "The Better Architect You Are The Simpler Your Diagrams"
date: 2015-06-24
tags: architect
description:
  Complex diagrams is the first and the most important
  sign of a bad architect, who is not able to properly
  scope the problem.
keywords:
  - architectural diagrams
  - good architectural diagrams
  - make good diagrams
  - how to make good diagram
  - uml diagrams
---

I don't even know where to start. Let's start with this &mdash;
**if I don't understand you, it's your fault**. This has to be
the basic fundamental principle of a good software architect (well,
of any engineer), but most of those architects I've met so far, in many
companies, seem not to believe in it. They don't understandt that
the job of a software architect is _to make complex things simple_,
not the other way around. They use diagrams, as it is the most
popular instrument of an architect, to explains us, programmers,
what he or she has in mind. But their diagrams are usually very cryptic
and hard to digest. The complexity goes up together with their salaries &mdash;
it's disgusting.

<!--more-->

{% picture /images/2015/06/a-beautiful-mind.jpg 0 A Beautiful Mind (2001) by Ron Howard %}

Why it's happening? Why their diagrams are complex and difficult to read?
I'm sure you know what I'm talking about and you have you own examples
of such diagrams in your project and such architects. So, why do we have them?

Architects are **proud of complexity**, that's why. They think that
the more complex is the problem they are working with the better engineers
they are. I've had this dialog many times:

{% highlight text %}
- You know, your diagram looks so complex...
- Oh yeah, we're solving complex problems here!
{% endhighlight %}

Usually, after that, the architect smiles with a feeling of satisfaction.
Indeed, someone actually noticed how difficult is the job and appreciated
the efforts. Someone is stupid and he is smart. He can understand this
multi-tier architecture and I can't. He definitely earns a respect, right?

Wrong! A good architect knows that his main role is to decompose a complex problem
into less complex components and let programmers solve them one by one. As well
as a good project manager has to decompose a complex task into smaller ones.
When the problem is properly decomposed (broken down into smaller isolated
and properly de-coupled pieces) the complexity _decreases_ and it becomes
easier for everybody to understand and resolve.

The main virtue of an architect is the ability to _reduce_ complexity. Thus,
a good architect will never be proud of a complex diagram. Instead, he will
be proud of a simple and easy to understand drawing with a few rectangles in it,
which perfectly explain an entire multi-tier application. That is what
is really difficult to do. That's where a true architectural mind shines.

There are not so many architects like that. I can't say I'm one of them yet,
but I have a few recommendations for your diagrams. Read on and remember
that the main goal of all this is to **reduce complexity**.

**No More Than Five Rectangles**.
If you have more, there is something wrong. Try to explain yourself
in less than five. Just group some of them together and give it a name.
You don't want me to spend more than a few seconds to understand who
is taking participation in the show you're presenting. I want to see them
all at one glance and immediately understand who is who. I just made up
this number five, but you get the idea &mdash; make sure all diagram participants
are easy to count. I've seen diagrams with 25+ rectangles... that's unacceptable.

{% badge /images/2015/06/uml-distilled-book.jpg 96 http://www.amazon.com/gp/product/0321193687/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0321193687&linkCode=as2&tag=yegor256com-20&linkId=OAN3SZQEKQYKPSZX %}

**Use UML**.
Well, use whatever notation you feel comfortable, but many years ago
people agreed that instead of using different notations it's easier
to learn one for all and it's [UML](http://www.uml.org/).
It's a huge format/standard/language,
but you don't need to know all of it. Just learn the basics, that will be
enough to express almost any idea you have. I would recommend
[UML Distilled: A Brief Guide to the Standard Object Modeling Language (3rd Edition)](http://www.amazon.com/gp/product/0321193687/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0321193687&linkCode=as2&tag=yegor256com-20&linkId=OAN3SZQEKQYKPSZX)
by Martin Fowler.

**Direct and Annotate Lines**.
There is nothing more annoying on a diagram than a line connecting two
rectangles without any text on it and without any direction. Is it a flow
of data? Is it a compile-time dependency? There are many possible meanings.
Always use arrows and always annotate them &mdash; this will help me
to understand you much faster.

**Don't Use Colors**.
Or let me put it this way &mdash; don't abuse colors. In order to not abuse
them you better stay away from colors at all. If you need to use colors, there
must be something wrong with your diagram. It's probably too complex, that's
why you need to use colors. Make it simpler by groupping elements.

**Don't Be Creative**.
It's not art, it's engineering. You don't need to impress me, you need
to deliver the message. Your goal is not to show how sophisticated your mind is.
Moreover, your diagram style should not be personal. A diagram from you and
a diagram from another architect should look almost exactly the same, if they
deliver the same message. It's call uniformity. That's how you make them
easier for me to understand. I don't want to learn your personality first,
in order to understand your diagram. That's why, if it's a server, draw a
rectangle. No need to put a 3D picture of an HP server there.
A rectangle is enough. Also, please, no shades, no fonts, and no styles.
Again, it's not an artistic contest. I will understand your rectangle
pretty well without that "nice" shadow you're tempted to drop. I will also
understand an arrow with a default width, no need to make it wider just
because your diagram editor allows you to. Don't waste your time and my
time on all this styling. Just focus on that simple lines, rectangles, texts
and arrows.

<hr/>

As I mentioned above, the goal of all this is to reduce complexity
and help me, a programmer, to understand you, an architect. Remember,
if I can't understand you, it's your fault. You're a bad architect
if you can't deliver your ideas in a plain simple form.
