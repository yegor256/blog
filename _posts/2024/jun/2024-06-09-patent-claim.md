---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Patents and Their Claims"
date: 2024-06-09
place: Moscow, Russia
tags: business
description: |
  If you are a programer, then even if a lawyer may help you write
  a patent application, your job is to prepare a proper
  patent claim, making its breadth right on.
keywords:
  - patent claim
  - patent breadth
  - patent length
  - patent infrigement
  - patent litigation
image: /images/2024/06/and-justice-for-all.jpg
jb_picture:
  caption: And Justice for All (1979) by Norman Jewison
---

If you, like me, are not a patent attorney and don't understand patent law,
but your boss asks you to turn your recently written piece of code into
a patent, read on. The boss most probably won't ask you to write the entire
patent. Instead, he will ask you to prepare a quick summary of the invention
(usually, a few slides) and then a hired lawyer will turn it into
a full-scale patent application. If you understand the purpose of patents,
the mechanics of patent offices, and the format of a patent claim, you will
do just fine.

<!--more-->

{% jb_picture_body %}

**What are patents for?**
Initially invented as a tool to encourage innocent inventors,
they are currently used mostly as a [weapon](https://en.wikipedia.org/wiki/Patent_war)
either to bully larger organizations or
to defend them against bullying. It all started in Italy in 1474,
when a three-year "grant" [was given](https://guides.slv.vic.gov.au/patents/history)
to Filippo Brunelleschi for "some machine or kind of ship,"
for a period of three years. Since then, [over 3.5 million patents](https://www.wipo.int/en/ipfactsandfigures/patents)
have been issued by different _patent offices_ around the globe to respected
inventors.

**What is a [patent office](https://en.wikipedia.org/wiki/Patent_office)?**
It's a security organization funded by a government:
[USPTO](https://www.uspto.gov/) in the United States,
[EPO](https://www.epo.org/en) in the European Union,
[CNIPA](https://english.cnipa.gov.cn/) in China,
[Rospatent](https://rospatent.gov.ru/en) in Russia,
[IPOS](https://www.ipos.gov.sg/) in Singapore,
and a [few dozen](https://en.wikipedia.org/wiki/Patent_office) in other countries.
Also, there is
[WIPO](https://www.wipo.int/portal/en/index.html) in Geneva (Switzerland) that
coordinates the work of all other POs, so far.
They protect you if you pay them (no surprise it all started in Italy!)

Let's say you invent a new file compression algorithm and
you don't want anyone to use it without your permission. First, you pay
[$320](https://www.uspto.gov/learning-and-resources/fees-and-payment/uspto-fee-schedule)
to USPTO and submit an application. Then, in a few months, they assign your application
a number and call it "pending." Then, you wait for about [3.5 years](https://www.uspto.gov/dashboard/patents/pendency.html)
until they reply back with a decision: either you get a patent, you get nothing,
or they ask you to refine the application (most common case).
You make the changes, resubmit, they criticize, you resubmit, ... and eventually
they issue a patent.

**Now what?**
Your company publishes a press release, informs all investors, you
make a Facebook post so that your mom can be proud of you,
and in a few days everybody forgets about it. Because nobody cares. Until
the _litigation_ day comes: your company finds out that another company is
also compressing files using the same algorithm. Or, the other way around:
they find out that the algorithm you invented is actually the algorithm they
have been quietly using for years. You both meet in a
[patent court](https://en.wikipedia.org/wiki/Patent_court).
The USPTO will be there too, since you paid them earlier.

If your opponent _does not_ have a patent, the judge will ask them to prove
that their compression algorithm was publicly available prior to your
application. If they provide such proof, your patent will be
[_infringed_](https://en.wikipedia.org/wiki/Patent_infringement)---you will lose
it, your $320 won't be refunded, and you will pay everything you made over the last
few years to the opponent.

If your opponent _does_ have a patent, you will have to prove that your
patent is older and _broader_. USPTO attorneys most probably won't try to help you,
since they won't be on your side, but simply a mediator between both of you
([Apple vs. Samsung](https://en.wikipedia.org/wiki/Apple_Inc._v._Samsung_Electronics_Co.)
litigation is a good example of such a patent war). If you win,
their patent will be infringed and you will get all the profit they managed
to collect over the last years. Big win!

**What is patent breadth?**
First, let's discuss what is its _length_. You may be surprised,
but patents have pretty short lifetimes.
If you don't extend a patent, it will expire in just _three years_. If you do want to
extend it, you must pay USPTO [again](https://www.uspto.gov/patents/basics/manage)
and much more than you paid the first time:
[$2,000](https://www.uspto.gov/patents/basics/manage) in 3 years,
$3,760 in 7 years,
$7,700 in 11 years.
Not cheap, huh?

Now, the breadth. Consider three _patent claims_:

* "An apparatus consisting of a file reader; a file writer; and a compressor."
* "A file compressing method comprising
  a reader of JPEG files;
  a probability distribution calculator;
  a discrete transformer;
  a bla-bla-bla optimizer;
  an intermediate storage;
  a writer of JPEG files."
* "A Lempel–Ziv based data compression method comprising:
  converting input stream into ψ-tokens;
  reducing redundancy via Prishvin Ω(x) factorials;
  serializing through Turgenev 𝛾-extremums."

The first claim is much broader: it probably covers all possible file compressing
software tools ever created. Such a broad patent claim won't even be
[accepted](https://en.wikipedia.org/wiki/Patentability)
by USPTO if you file it. They will do a quick search of _prior art_ (other
patents previously issued) and reject you on the basis of a lack of
[_novelty_](https://en.wikipedia.org/wiki/Novelty_%28patent%29).
The second claim is narrower, but still pretty broad, since the architecture
of other existing compressors may be very similar to the described one.
The third claim is the most narrow and the most specific (although, have
absolutely no sense, it is made up).

**How to write a good patent claim?**
There is no such thing as an objectively [good claim](https://support.lens.org/knowledge-base/what-are-claims/),
since it depends on the
situation in the market. If the territory of innovation is not yet developed
and you are a pioneer, a broader and shorter (by the length in years, not the
number of words) patent is better. If you are making a small improvement
to a well-developed prior art, better make the patent narrower and longer.

A _patent claim_ is the key element of a patent application. While the rest
of the document may be written by a patent attorney, I strongly suggest
you write the claim. At least its first version.
There is a more or less strict structure of a claim:
preamble, transitional phrase, and body:

| Preamble | Transitional Phrase | Body |
| --- | --- | --- |
| An apparatus | consisting of | a file reader; a file writer; and a compressor. |
| A file compressing method | comprising | a reader of JPEG files; a probability distribution calculator; a discrete transformer; a bla-bla-bla optimizer; an intermediate storage; a writer of JPEG files. |
| A Lempel–Ziv based data compression method | comprising | converting input stream into ψ-tokens, reducing redundancy via Prishvin Ω(x) factorials, serializing through Turgenev 𝛾-extremums. |

The [preamble](https://www.wilmerhale.com/insights/publications/patent-claim-preambles-july-16-2003)
must position your invention among all other devices
and methods in the prior art. The "an apparatus" preamble is very broad:
it could mean any device in the world, even not only
from the computing domain. The "a file compressing method" preamble
is much narrower, while "a Lempel–Ziv based data compression method" is the
most narrow one, with almost no ambiguity for the interpretation.

The body of a [patent claim](https://ocpatentlawyer.com/basics-writing-claim-patent-application/)
must iterate the elements that constitute
the invention. The fewer elements you include in this list, the broader
the patent will be. The broader the patent, the easier to infringe. Well, unless
you invent something revolutionary new. On the other hand, the more elements,
the narrower the patent, the weaker it is as a weapon. It will be very hard
to use a narrow patent in a patent litigation.

The claim must also be [_non-obvious_](https://en.wikipedia.org/wiki/Inventive_step_and_non-obviousness),
meaning that your invention has to be
an adequate distance beyond or above the state of the art. Say, a new file
format is invented for graphic images and you submit a patent application
for a ZIP compressor that can also compress files in this new format.
If there is no novelty in the compression algorithm itself, such a patent
would be considered obvious since it's not far away from prior art: existing
ZIP compressors can deal with this file format, even though they don't know
about it yet.

**How do you decide?**
It is your responsibility as a patent author to decide how broad
and how long your patent must be. Then, a patent attorney will help you turn your
patent claim into a patent application (charging a
[few thousand dollars](https://patentattorneyworldwide.com/us/much-patent-attorney-us-charges-stage-getting-patent/)
along the way), and then, hopefully, the litigation day will come and you will win
a lot of money. Most probably this will never happen and the patent will
remain a nice badge on your CV and your company's website.

By the way, it is important to remember that if you want to get similar protection
in another country, you will have to pay their patent office separately.
Just like you pay every time a different mafia boss for protection when
you want to work in the territories they control.
