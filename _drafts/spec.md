---
layout: post
title: "Ten Typical Mistakes in Specs"
date: 2015-10-27
place: Palo Alto, CA
tags: requirements mgmt
description:
  Requirements specification is where we make
  the most expensive mistakes, which are very
  difficult to correct.
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
that's why decided to summarize. Here they are,
twelve most critical and typical of them,
from a programmer point of view, who is reading a specification document.

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

Now, I'm getting to my point. The specs I usually see violate pretty much
**all** eight principles mentioned earlier. Below is a summary of how exactly
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
not use product specs just to express ourselves. We're writing in order
to be understood, and not to impress the reader. And the rule is the
same here as with
[diagrams]({% pst 2015/jun/2015-06-29-simple-diagrams %})
&mdash; if I don't understand you, it's your fault.

Here is how that text would look after a proper re-writing:

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
the author asks me, what possible options are out there. Then,
the author suggests me to consider something, and, after that,
the author invites me for a talk.

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

Don't get me wrong, I'm not against creativity. Programmers are not robots,
quietly implementing what the document says. But a messy document has
nothing to do with creativity. If you want me to be creating, define
the borders of that creativity and let me experiment within them, for example:

{% highlight text %}
Multiple versions of the API must be supported. How exactly
it is done, doesn't really matter.
{% endhighlight %}

This is how you invite me to be creative. I realize that the user
of the product doesn't really have any restrictions or expectations
about the versioning mechanims in the API. I'm free to do whatever
I can. Great, I'll do it my way.

But, again, let me re-iterate, a specification is not a discussion board.

## Mixing Functional and Quality Requirements

This is how it looks:

{% highlight text %}
User must be able to scroll down through
the list of images in the profile, smoothly and fast.
{% endhighlight %}

It's a typical mistake in almost every spec I've seen. Here we mix
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
requirements always separately.

## Unmeasurable Quality Requirements

This is what I'm talking about:

{% highlight text %}
Credit card numbers must be encrypted.
The app should launch in less than 2 seconds.
Each web page must open in less than 500 msec.
User interface must be responsive.
{% endhighlight %}

I can find many more of them, just by opening requirement specs in
many projects I've seen over the last years. They all look the same.
And the problem is always the same &mdash; it is very difficult
to define a truly testable and measurable non-functional requirement.

Yes, it's difficult. Mostly because there are many factors. Take this
line, for example: "the app must launch in 2 seconds". On what equipment?
With what amount of data in user profile? What means "launch", does it include
profile loading time? What if there are launching problems, do they count?
There are a lot of questions like that.

If we answer **all** of them, the requirement text will be as long as
a full-text page. Nobody wants that, but having un-measurable requirements
is a bigger evil.

There is no single solution. My suggestion is to

## Implementation Instructions

This is what:

{% highlight text %}
Our primary concern is performance and attractive
user interface.
{% endhighlight %}


## Mixing Requirements and Supplementary Docs

## Lack of User Perspective

## Noise

How about this:

{% highlight text %}
Our primary concern is performance and attractive
user interface.
{% endhighlight %}

This is noise. I, the reader of this document, am neither an investor,
not a user. I'm a programmer. I don't care what is your "primary concern"
in this project. My job is to implement the product so that it matches
the specs. If performance is your primary concern, create a measuable
and testable requirement(s) for me. I will make sure the product satisfies them.
If you can't create a requirement, don't spam me with this irrelevant
information.

I don't want to share your concerns, your beliefs or intentions. It's your
business. And you're paid to properly and unambiguously translate all that
into testable and measureable requirements. If you can't do this, it's
your problem and **your fault**. Don't try to make it mine.

Very often... wait. Very very often. No. Almost always. Wrong again. Always!
That's right. Always and all spec documents are full of noise.
Some of them have a bit less, some have more. I believe, that this
is a symptom of a **lazy** and unprofessional document authors. In most cases,
just lazy.

They don't want to think and translate that concerns, ideas, thoughts,
intents, and objectives into functional and non-functional requirements.
They just put them into the document and hope that programmers will
somehow find the right solution. Good programmers should figure out
what means good performance, right? Let's just tell them that performance
is a concern for us and they will figure something out.

No! Don't do that. Do your job right and let programmers do theirs.

And we, programmers, should never accept such documents. We should just reject
them and ask requirements authors to re-work and remove noise. I would recommend not
even start working with a product, if there is a lot of noise in its spec.

## Will work, Need to work, Must work

This is yet another very typical mistake:

{% highlight text %}
The API will support JSON and XML. Both formats
must fully support all data items. XML need to
be validated by XSD schema.
{% endhighlight %}

See how messy it sounds? There are three different points of view and
all of them are not suitable for a specification document. A spec
must describe a product as if it already exists. A spec must
sound like a manual, a tutorial, a reference. This text must be
re-written like this:

{% highlight text %}
The API supports JSON and XML. Both formats
fully support all data items. XML si validated
by XSD schema.
{% endhighlight %}

See the difference? All that "must", "need", and "will" are just
adding some doubt to the document. For me, a reader of this spec,
"_the API will support_" sounds like "_some time in the future, maybe in
the next version, it will support_". This is not what the author
had in mind, right? There should no doubt, no double meaning, no
maybe. The API supports. That's it.

<hr/>

Maybe I forgot something important, but these issues are so obvious
and so annoying... I'm going to use this post as a simple guide for our
system analysts. Feel free to share your experience with requirements
documents, below in the comments.
