---
layout: post
title: "10 Typical Mistakes in Specs"
date: 2015-11-10
place: Palo Alto, CA
tags: requirements
description: |
  We make the most expensive mistakes in our specifications
  for requirements, because they are very difficult to correct.
keywords:
  - software specification
  - software specification template
  - software specification review
  - software specification example
  - software specification in software engineering
image: /images/2015/11/reservoir-dogs.jpg
jb_picture:
  caption: Reservoir Dogs (1992) by Quentin Tarantino
---

There is a great book called
[Software Requirements](http://amzn.to/2c5n12h)
written by Karl Wiegers about, well, software requirements.
It's a must read for every software engineer, in my opinion. There's
no need for me to repeat what it says, but there are a few very
simple and very typical mistakes we keep making in our
specs. I see them in our documents again and again,
which is why I've decided to summarize them. So here they are,
the ten most critical and typical of them,
from the point of view of a programmer reading a specification document.

<!--more-->

{% jb_picture_body %}

Chapter 4.3 of a famous standard
[IEEE 830-1998](https://standards.ieee.org/findstds/standard/830-1998.html)
says that a good
[specification](https://en.wikipedia.org/wiki/Software_requirements_specification)
should be _correct_, _unambiguous_, _complete_, _consistent_,
_ranked_, _verifiable_, _modifiable_, and _traceable_.
Eight qualities in total. Then, the standard explains them one by one
in pretty simple English. But do we have time to read those boring standards?
They are for university professors and certification boards.
We are practitioners, for goodness sake! ... Hold on, I'm joking.

{% badge /images/2015/11/ieee-830.jpg 128 https://standards.ieee.org/findstds/standard/830-1998.html %}

No matter how small the project is and how practical we are, there
is always a document that explains what needs to be done, and it
may be called the "software requirements specification," or "specification,"
or just "spec." Of course, there is a lot of space for creativity, but
we're _engineers_, not artists. We must follow rules and standards,
mostly because they make our communication easier.

Now, I'm getting to my point. The specs I usually see violate pretty much
_all_ eight principles mentioned earlier. Below is a summary of how exactly
they do it. By the way, all examples are taken from real documents in
real commercial software projects.

## No Glossary or a Messy One

How about this:

{% highlight text %}
UUID is set incrementally to make sure there
are no two users with the same account number.
{% endhighlight %}

What is the difference between UUID and account number? Is it the
same thing? It seems so, right? Or maybe they are different ... it would
be great to know what UUID stands for. Is it "unique user ID" or maybe
"unified user identity descriptor?" I have no idea. I'm lost, and I want
to find the author of this text and do something bad to him ... or her.

{% quote We're writing in order to be understood, not to impress the reader. %}

I've written already that the
[worst technical specifications have no glossaries]({% pst 2015/mar/2015-03-16-technical-glossaries %}).
In my experience, this is the biggest problem in all requirement
documents. It's not prose! It's not a love letter! It's technical
documentation. We can't juggle words for the sake of fun. We should
not use product specs just to express ourselves. We're writing in order
to be understood, not to impress the reader. And the rule is the
same here as with
[diagrams]({% pst 2015/jun/2015-06-29-simple-diagrams %}):
if I don't understand you, it's your fault.

Here is how that text would look after a proper re-writing:

{% highlight text %}
UUID is user unique ID, a positive 4-bytes integer.
UUID is set incrementally to make sure there
are no two users with the same UUID.
{% endhighlight %}

Better now?

Thus, the first and biggest problem is a frivolous
use of terms and just words, without having them pre-defined in a glossary.

## Questions, Discussions, Suggestions, Opinions

I've seen this very recently in a product spec:

{% highlight text %}
I believe that multiple versions of the API
must be supported. What options do we have? I'd
suggest we go with versioned URLs. Feel free to
post your thoughts here.
{% endhighlight %}

Yes, this text exists verbatim in a requirements document. First, the
author expresses his personal opinion about the subject. Then,
the author asks me what possible options are out there. Then,
he suggests I consider something, and after that,
he invites me for a talk.

{% quote Find all your answers before writing the document, that's what you're paid for. %}

Impressive, right? Obviously, the author has a very creative personality.
But we should keep this person as far away from project documentation as possible.
This is not what a requirements document appreciates. Well, we appreciate
creativity, but these four things are strictly prohibited:
questions, discussions, suggestions, and opinions.

Specifications can't have any _questions_ in them. Who are these questions
addressed to? Me, a programmer? Am I supposed to implement the
software or answer your questions? I'm not interested in brainstorming
with you. I expect you, a requirements author, to tell me
what needs to be done. Find all your answers before writing the document. That's
what you're paid for. If you don't have the answers, put something like
TBD ("to be determined") there. But don't ask questions. It's annoying.

A requirements document is not a _discussion_ board. As a reader of the
spec, I expect to see exactly what needs to be done without any "maybe" or
"we could do it differently." Of course you need to discuss these issues,
but do it before documenting it. Do it somewhere else, like in Skype, on Slack,
or by email. If you really want to discuss in the document, use Google Docs or
Word with version tracking. But when the discussion is over, remove its history
from the document. Its presence only confuses me, a programmer.

There's no need to format requirements as _suggestions_ either. Just say what
needs to be done and how the software has to work without fear of being wrong.
Usually, people resort to suggestion when they are afraid to say it straight. Instead
of saying "the app must work on Android 3.x and higher," they say
"I would suggest making the app compatible with Android 3.x and higher."
See the difference? In the second sentence, the author is trying to avoid
personal responsibility. He's not saying "exactly Android 3.x;" he's just
suggesting. Don't be a coward; say it straight. If you make a mistake,
we'll correct you.

And, of course, _opinions_ are not appreciated at all. It's not a letter
to a friend; it's a formal document that belongs to the project. In a few
months or weeks, you may leave the project, and somebody else will work with
your document. The spec is a contract between the project sponsor and project
team. The opinion of a document author doesn't make any difference here.
Instead of noting "it seems Java would be faster" and suggesting "we should use it,"
say "Java is faster, so we must use it." Obviously you put it there because you
thought so. But once it's there, we don't care who it came from and what
you thought about this problem. The information would just
confuse us more, so skip it. Just facts, no opinions.

Don't get me wrong, I'm not against creativity. Programmers are not robots,
quietly implementing what the document says. But a messy document has
nothing to do with creativity. If you want me to create, define
the limits of that creativity and let me experiment within them; for example:

{% highlight text %}
Multiple versions of the API must be supported. How exactly
that is done doesn't really matter.
{% endhighlight %}

This is how you invite me to be creative. I realize that the user
of the product doesn't really have any justifications or expectations
for the versioning mechanisms in the API. I'm free to do whatever
I can. Great, I'll do it my way.

But again, let me reiterate: A specification is not a discussion board.

## Mixing Functional and Quality Requirements

This is how it looks:

{% highlight text %}
User must be able to scroll down through
the list of images in the profile smoothly and fast.
{% endhighlight %}

It's a typical mistake in almost every spec I've seen. Here, we mix
together a functional requirement ("to scroll images") and
and a non-functional one ("scrolling is smooth and fast"). Why is it
bad? Well, there is no specific reason, but it exhibits a lack
of discipline.

Such a requirement is difficult to verify or test, difficult to trace,
and difficult to implement. As a programmer, I don't know what is more
important: to scroll or to make sure the scrolling is fast.

Also, it is difficult to modify such a statement. If tomorrow we add
another functional requirement---scrolling a list
of friends, for example---we'll want to require this scrolling to also be smooth and fast.
Then, a few days later, we'll want to say that "fast" means less than
10 milliseconds of reaction time. We'll then have to duplicate this information
in two places. See how messy our document may become eventually?

Thus, I would strongly recommend you always document functional and non-functional
requirements separately.

## Mixing Requirements and Supplementary Docs

This is similar to a previous problem and may look like this:

{% highlight text %}
User can download a PDF report that includes a full
list of transactions. Each transaction has ID,
date, description, account, and full amount. The report
also contains a summary and a link to the user account.
{% endhighlight %}

It's obvious there are two things described in this
paragraph. First is that a user can download a PDF report. Second is
how this report should look. The first thing is a functional
requirement, and the second one must be described in a supplementary
document (or appendix).

In general, functional requirements must be very short:
"user downloads," "user saves," "client requests and receives," etc.
If your text gets any longer, there is something wrong.
Try to move part of it to a supplementary document.

## Un-measurable Quality Requirements

This is what I'm talking about:

{% highlight text %}
Credit card numbers must be encrypted.
The app should launch in less than 2 seconds.
Each web page must open in less than 500 milliseconds.
User interface must be responsive.
{% endhighlight %}

I can find many more examples just by opening requirement specs in
many projects I've seen over the past few years. They all look the same.
And the problem is always the same: It is very difficult
to define a truly testable and measurable non-functional requirement.

Yes, it's difficult. Mostly because there are many factors. Take this
line, for example: "The app must launch in 2 seconds." On what equipment?
With what amount of data in the user profile? What does "launch" mean; does it include
profile loading time? What if there are launching problems? Do they count?
There are a lot of questions like that.

If we answer _all_ of them, the requirement text will fill an entire
page. Nobody wants that, but having un-measurable requirements
is a greater evil.

Again, it's not easy, but it's necessary. Try to make sure all
quality requirements are complete and without ambiguity.

## Implementation Instructions

This example illustrates a very common pitfall:

{% highlight text %}
User authenticates via Facebook login button
and we store username, avatar, and email in the
database.
{% endhighlight %}

This is
[micromanagement]({% pst 2015/sep/2015-09-22-micromanagement %}), and
it's something a requirements analyst should never do to a programmer.
You shouldn't tell me how to implement the functionality you desire.
You want to give a user the ability to login via Facebook?
Say so. Do you really care whether it's going to happen through a button
click or somehow else? Do you really care what I store in the database?
What if I use files instead of a database? Is that important to you?

I don't think so. Only in very rare cases will it matter. Most
of the time, it's just micromanagement.

The spec should only require what really matters for the business. Everything
else is up to us, the programmers. We decide what database to use, where the
button will be placed, and what information will be stored in the database.

{% quote You shouldn't tell me how to implement the functionality you desire. %}

If you really care about that because there are certain higher-level
limitations---say so. But again, not as implementation instructions
to us programmers, but rather as non-functional requirements like this:

{% highlight text %}
Login page must look like this (screenshot attached).
We must store user email locally for future needs.
{% endhighlight %}

The point is that I have nothing against requirements, but I'm
strongly against implementation instructions.

## Lack of Actor Perspective

The text may look like:

{% highlight text %}
PDF report is generated when required. It is
possible to download a report or save it
in the account.
{% endhighlight %}

The problem here is that there is no "actor" involved. This functionality
is more or less clear, but it's not clear who is doing all this. Where
is the user? It is just a story of something happening somewhere. That's not
really what programmers need in order to implement it.

{% quote A good user story always has, guess what ... a user. %}

The best way to explain functionality is through user stories. And a good
user story always has, guess what ... a user. It always starts with
"the user ...," followed by a verb. The user downloads, the user saves,
the user clicks, prints, deletes, formats, etc.

It's not necessary for the user to be a human. It may be a system, a RESTful API
client, a database, anything. But always someone. "It is possible to download ..."
is not a user story. It's possible for who?

## Noise

How about this:

{% highlight text %}
Our primary concern is performance and an attractive
user interface.
{% endhighlight %}

This is noise. As the reader of this document, I'm neither an investor
nor a user. I'm a programmer. I don't care what your "primary concern" is
in this project. My job is to implement the product so that it matches
the specs. If performance is your primary concern, create measurable
and testable requirements for me. I will make sure the product satisfies them.
If you can't create a requirement, don't spam me with this irrelevant
information.

{% quote Good programmers should figure out what good performance means, right? %}

I don't want to share your concerns, your beliefs, or your intentions. That's your
business. And you're paid to properly and unambiguously translate all that
into testable and measurable requirements. If you can't do this, it's
your problem and _your fault_. Don't try to make it mine.

Very often ... wait. Very, very often. No. Almost always. Wrong again. Always!
That's right, spec documents are always full of noise.
Some of them have a bit less; some have more. I believe this
is a symptom of _lazy_ and unprofessional document authors. In most cases,
just lazy.

They don't want to think and translate their concerns, ideas, thoughts,
intentions, and objectives into functional and non-functional requirements.
They just put them into the document and hope the programmers will
somehow find the right solution. Good programmers should figure out
what good performance means, right? Let's just tell them that performance
is a concern for us, and they will figure something out.

No! Don't do that. Do your job right and let programmers do theirs.

And we, programmers, should never accept such documents. We should just reject
them and ask requirements authors to re-work and remove noise. I would recommend not
even starting to work on a product if there is a lot of noise in its specs.

## Will Work, Needs to Work, Must Work

This is yet another very typical mistake:

{% highlight text %}
The API will support JSON and XML. Both formats
must fully support all data items. XML needs to
be validated by XSD schema.
{% endhighlight %}

See how messy it sounds? There are three different points of view, and
none of them are suitable for a specification document. A spec
must describe a product as if it already exists. A spec must
sound like a manual, a tutorial, or a reference. This text must be
re-written like this:

{% highlight text %}
The API supports JSON and XML. Both formats
fully support all data items. XML is validated
by XSD schema.
{% endhighlight %}

See the difference? All the "must," "need," and "will" words are just
adding doubt to the document. For a reader of this spec,
"_the API will support_" sounds like "_some time in the future, maybe in
the next version, it will support_." This is not what the author
had in mind, right? There should be no doubt, no double meaning, no
maybe. The API supports. That's it.

<hr/>

I may have forgotten something important, but these issues are so obvious
and so annoying ... I'm going to use this post as a simple guide for our
system analysts. Feel free to share your experience with requirements
documents below in the comments.
