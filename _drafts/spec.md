---
layout: post
title: "Ten Typical Mistakes in Specs"
date: 2015-10-27
place: Palo Alto, CA
tags: requirements mgmt
description:
  ...
keywords:
  - software specification
  - software specification template
  - software specification review
  - software specification example
  - software specification in software engineering
---

There is a great book called
[Software Requirements](http://www.amazon.com/gp/product/B00JDMPMOA/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00JDMPMOA&linkCode=as2&tag=yegor256com-20&linkId=PRSWJK34HNP355LK)
written by Karl Wiegers, about, well, software requirements.
It's a must read for every software engineer, I believe. No
need to repeat what it says, but there are a few very
simple and very typical mistakes we keep making in our
specs. I keep seeing them in our documents again and again,
that's why decided to summaries. Twelve most critical and typical of them,
from a programmer point of view, reading a specification document.

<!--more-->

{% badge /images/2015/11/ieee-830.jpg 128 https://standards.ieee.org/findstds/standard/830-1998.html %}

Chapter 4.3 of a famous standard
[IEEE 830-1998](https://standards.ieee.org/findstds/standard/830-1998.html)
says that a good
[specification](https://en.wikipedia.org/wiki/Software_requirements_specification)
should be **correct**, **unambiguous**, **complete**, **consistent**,
**ranked**, **verifiable**, **modifiable**, and **traceable**.
Eight qualities in total. Then, the standard explains them one by one,
in a pretty simple English. But do we have time to read that boring standards?
They are for university professors and certification boards.
We are practitioners, for Christ sake!... Hold on, I'm joking.

No matter how small is the project and how practical we are, there
is always a document that explains what needs to be done, and it
may be called "software requirements specification", or "specification",
or just a "spec". Of course, there is a lot of space for creativity, but
we're **engineers**, not artists. We must follow rules and standards,
mostly because they are making our communication easier.

Now I'm getting to my point. The specs I usually see violate pretty much
all eight principles mentioned earlier. Below is a summary of how exactly
they do it. BTW, all examples are taken from real documents in
real commercial software projects.

## No Glossary or a Messy One

How about this:

{% highlight text %}
UUID is set incrementally, to make sure there
are no two users with the same account number.
{% endhighlight %}

What is the difference between UUID and account number? Is it the
same thing? It seems so, right? Or maybe they are different... Would
be great to know what UUID stands for. Is it "unique user ID" or maybe
"unified user identity descriptor"? I have no idea. I'm lost and I want
to find the author of this text and do something bad to him... or her.

I've written already that
[worst technical specifications have no glossaries]({% pst 2015/mar/2015-03-16-technical-glossaries %}).
In my experience, this is the biggest problem in all requirement
documents. It's not prose! It's not a love letter! It's technical
documentation. We can't juggle words for the sake of fun. We should
not use product specs to express ourselves. We're writing in order
to be understood, not to impress the reader. And the rule is the
same here as with
[diagrams]({% pst 2015/jun/2015-06-29-simple-diagrams %})
&mdash; if I don't understand you, it's your fault.

Here is how that text would look after a proper rewriting:

{% highlight text %}
UUID is user unique ID, positive 4-bytes integer.
UUID is set incrementally, to make sure there
are no two users with the same UUID.
{% endhighlight %}

Better now?

Thus, the first and the biggest problem is a frivolous
use of terms and just words, without having them pre-defined in a Glossary.

## Questions, Discussions, Suggestions, Opinions

I've seen this, very recently, in a product spec:

{% highlight text %}
I believe that multiple versions of the API
must be supported. What options do we have? I'd
suggest to go with versioned URLs. Feel free to
post your thoughts here.
{% endhighlight %}

Yes, this text literally, in a requirements document. First, the
author expresses his personal opinion about the subject. Then,
the author asks the reader, what possible options are out there. Then,
the author suggests us to consider something, and, after that,
the author invites us for a talk.

Impressive, right? Obviously, the author has a very creative personality.
But we should keep this person as far away from project documentation as possible.
This is not what a requirements document appreciates. Well, we appreciate
creativity, but these four things are strictly prohibited &mdash;
questions, discussions, suggestions, and opinions.

Specifications can't have any **questions** inside. Who these questions
are addressed to? Me, a programmer? I'm supposed to implement the
software or answer your questions? I'm not interested in thinking
together with you. I expect you, a requirements author, to tell me
what needs to be done. Find all answers before writing the document. That's
what you're paid for. If you don't have answers, put something like
TBD ("to be determined") there. But don't ask questions. It's annoying.

Requirements document is not a **discussion** board. As a reader of the
spec I'm expecting to see exactly what needs to be done, without any
"maybe" or "we can do it differently". Of course, you need to discuss
first, before documenting. Do it somewhere else, in Skype, Slack or by email.
If you really want to discuss in the document, use Google Docs or simply
Word with version tracking. But, when discussion is over, remove its history
from the document. Its presence only confuses me, a programmer.

No need to format requirements as **suggestions**. Just say what needs to
be done, how the software has to work, without a fear to be wrong. Usually,
people suggest when they are afraid to say it straight. Instead of saying
"the app must work on Android 3.x and higher" they say
"I would suggest to make the app compatible with Android 3.x and higher".
See the difference? In the first sentence the author is trying to avoid
personal responsibility. I'm not saying "exactly Android 3.x", I'm just
suggesting. Don't be a coward, just say it straight. If you make a mistake,
we'll correct you.

And, of course, **opinions** are not appreciated at all. It's not a letter
to a friend, it's a formal document that belongs to the project. In a few
months or weeks you may leave the project and somebody else will work with
your document. The spec is a contract between project sponsor and project
team. The opinion of a document author doesn't make any difference here.
Instead of "it seems Java would be faster, we should use it" say
"Java is faster, we must use it". Of course, you put it here because you
think so. But once it is here, we don't care who it came from and what
the author thought about this problem. This information would just
confuse us more, skip it. Just facts, no opinions.

## Mixing Functional and Quality Requirements

This is how it looks:

{% highlight text %}
User must be able to scroll down through
the list of images in the profile,
smoothly and fast.
{% endhighlight %}

It's a typical mistake in almost every spec I see. Here we mix
together a functional requirement ("to scroll images") and
and a non-functional one ("scrolling is smooth and fast"). Why is it
bad? Well, there is no specific reason, but it's just a lack
of discipline.

Such a requirement is difficult to verify/test, difficult to trace,
difficult to implement. As a programmer, I don't know what is more
important &mdash; to scroll or to make sure that the scrolling is fast.

Also, it is difficult to modify such a text. If tomorrow we will have
another functional requirement, for example, about scrolling a list
of friends, we will want to say that this scrolling is also smooth and fast.
Then, a few days later, we will want to say that "fast" means less than
10 milliseconds reaction time. We will have to duplicate this information
in two places. See how messy our document may become eventually?

Thus, I would strongly recommend to document functional and non-functional
requirements separately.

## Unmeasurable Quality Requirements

How about this:

{% highlight text %}

{% endhighlight %}



## layout/implementation details
## mixing funcs and supplementary docs
## lack of user stories

## Noise

How about this:

{% highlight text %}
Our primary concern is performance and attractive
user interface.
{% endhighlight %}



## will work, need to work, must work

## don't explain why

I'm not in
favor of big requirements documents. Well, mostly because the longer
the document, the easier it is to turn it into mess. That's why,
we're always trying to stay within a few pages, usualy in `README`
file in GitHub.

