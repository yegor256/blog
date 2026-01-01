---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "How We Write a Product Vision"
date: 2014-10-20
tags: specs
description: |
  Product Vision is a fundamental document in any software development project
  that explains what the product is about and defines its scope boundaries.
keywords:
  - vision
  - software project vision
  - vision document
  - vision statement examples
  - vision statement definition
  - vision statement software project
image: /images/2014/10/lifecycle-thinking.png
---

{% badge /images/2014/10/lifecycle-thinking.png 250 %}

Every software project we work with is started from a Product Vision document. We
create it during our
[Thinking]({% pst 2014/oct/2014-10-06-software-project-lifecycle %})
phase. Even though the document is as short as two pages of English text,
its development is the most painstaking task in the whole project.

There are a few tricks and recommendations which I'd like to share.

We usually design a Product Vision in four sections: product statement,
stakeholders and needs, features, and quality requirements.

<!--more-->

## Product Statement

Product Statement is a one-paragraph declaration of intent, explaining
to an absolute stranger what this product is about and what it is for.
It is very similar to an [elevator pitch](https://en.wikipedia.org/wiki/Elevator_pitch).
The Statement must answer these questions, preferably in this specific order:

 1. Who is the customer?
 2. What does she want?
 3. What is the market offering now?
 4. What is wrong with existing offers?
 5. How will our product fix this?

You should answer all these questions in less than 60 words altogether. If
you need more words, something is wrong with your understanding of the
product under development. If you can answer them in 20 words, your
product will conquer the world.

{% quote An eventual invention of a cancer vaccine will make millions of people healthier, but will also make thousands of oncologists jobless. %}

By the way, don't confuse a Product Statement with a [Mission](https://en.wikipedia.org/wiki/Mission_statement),
which is a much broader declaration of an overall goal of your business. You
may have a hundred products but only a single mission. For example,
Disney [says](https://www.lifehack.org/articles/work/20-sample-vision-statement-for-the-new-startup.html)
that its mission is: "to make people happy." They've got
hundreds of products that help them accomplish this mission. And each product
has its own Product Statement.

I find these articles helpful:
[The Product Vision](https://www.scrumalliance.org/community/articles/2009/january/the-product-vision),
[Agile Artifacts: The Product Vision Statement](https://platinumedge.com/blog/agile-artifacts-product-vision-statement),
[The Art of Agile Development: Vision](https://www.jamesshore.com/Agile-Book/vision.html).

## Stakeholders and Needs

This section must list everybody whose life
will be affected by the product (positively or negatively). Your list of stakeholders
may include: sponsors, developers, users, competitors, government,
banks, web hosting providers, Apple Store, hackers, etc.

It is very important to list both positive and negative stakeholders. If your
product is going to automate some routine manual operations,
don't forget that someone will be made redundant because of it. No matter
how "good" your product is, there is always an "evil" side. The
invention of the iPhone made millions of people happy, but also caused a lot
of trouble for Nokia and Blackberry. An eventual invention of a cancer
vaccine will make millions of people healthier, but will also make thousands
of oncologists jobless. My point is that any project has both positive and negative
stakeholders.

Each stakeholder must have a list of needs. They have to be simple
and straight forward, like "earn money," "increase profit," "share photos,"
or "host a website."

I would recommend defining one or two needs for each stakeholder. If there
are more than three, think again---do you really understand what your
stakeholders need?

Your project will be considered successful if you **satisfy** all the needs
of all your positive stakeholders and **neutralize** negative ones.

This [Stakeholder Needs and Requirements](https://www.sebokwiki.org/wiki/Stakeholder_Needs_and_Requirements)
article from SEBOK will be helpful.

## Actors and Features

In this section we list [actors](https://en.wikipedia.org/wiki/Actor_%28UML%29)
(entities communicating with the product) and the key functionalities
they use. This is the most abstract definition of
[functional requirements](https://en.wikipedia.org/wiki/Functional_requirement)
of the product. It doesn't need to be detailed. Instead, it has to
be very high-level and abstract. For example, this is how our
interaction with a well-known product may be described in two lines:

```text
User can post tweets, read tweets of his friends,
  follow new friends and re-tweet their tweets.
```

Is it clear for a stranger what we're talking about here? Absolutely not---what
is a "tweet," what does it mean to "follow" and what is a "re-tweet?"
These questions have no answers in the Product Vision document,
but it's clear that a user will have four main features available. All other
features will be similar to those.

{% quote If you can't fit all features into 2-3 lines, reconsider your understanding of the product. %}

Twitter is a multi-billion dollar business with a multi-million dollar
product. However, we managed to explain its key features in just two
lines of text. You should do the same with your product. If you can't fit
all its features into just two-three lines, reconsider your understanding
of the product you're going to develop. Also, read about
["feature bloat dilemma."](http://hbswk.hbs.edu/archive/5325.html)

Each actor must have at least three and at most six features. If
there are more, you should group them somehow. If there are less, break
them into smaller and more detailed features.

## Quality Requirements

This section lists all important non-functional
requirements. Any product may have hundreds of
[quality requirements](https://en.wikipedia.org/wiki/Non-functional_requirement),
as well as hundreds of features. However, a Product Vision document
must be focused on the most important ones. Consider some examples:

```text
Any web page must open in less than 300ms.
Total cost of ownership must be less than $5000/mo.
Mobile app must be tailored for 10+ popular screen sizes.
Mean time to recover must be less than 2 hours.
DB must be scalable up to 5Tb without cost increases.
```

{% quote It's better to say nothing than set false or ambiguous goals. %}

It is also very important to keep requirements
[measurable]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %}) (like each of these examples).
Every line in this section
is a message to product developers. They will read this document in
order to understand what is most important to the sponsor of the
project. For example, these quality requirements are useless: "user interface
must be attractive," "web site must be fast" or "the system must be stable."
They are not measurable or
testable. All they do is
[distract]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %}) developers. If you can't make
a strict and measurable statement about your quality objectives, don't write
anything. It's better to say nothing than set false or ambiguous goals here.

Try to keep this section short. There should be six quality requirements, at most.

## Remove Noise

Every section must be no more than twenty lines in length. Even if you're
developing a Google killer with a $50 million dollar budget, your Vision
document must be as short as two pages.

For most of my
[clients]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %})
this is a very complex and brain damaging task. They
usually come to us with a 50-page document explaining their business
ideas with all the important details. From this document, we should only extract
information that really makes a difference.

The Product Vision document must keep its reader on the highest level
of abstraction. The document must take less than a minute to read,
from start to finish.

If you can't keep it
[short]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %})---you don't understand your product well enough.

## Example

Here is an example of a very simple Product Vision
for a Facebook killer:

```text
Statement
  Facebook doesn't allow users to purchase "likes",
  our social network will have this.

Stakeholders and Needs
  Sponsor: to raise investments.
  Developer: to earn money by programming.
  Users: to share photos and purchase popularity.
  Bank: to make commission on every purchase.
  Government: to protect society against abusive content.
  Competitors: to wipe us off the market.

Actors and Features
  User can create account, upload photos, share photos,
    send personal messages, like other photos, purchase likes.
  Admin can ban user accounts, view summary reports, authorize
    credit card transactions, configure system parameters,
    monitor server resource usage.
  Bank can process credit card transactions.

Quality Requirements
  Any page must open in less than 300ms.
  Availability must be over 99.999%.
  Test coverage must be over 80%.
  Development pipeline must be fully automated.
  Interfaces must include web site and iOS/Android app.
```

## Diplomacy

We follow all these recommendations in our projects,
in [Zerocracy](https://www.zerocracy.com). You can use
them in your projects as well, but keep in mind that the process
of defining a Product Vision could be very painful. You may sometimes
[offend]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %})
a client by over-simplifying their "great" business idea. "Really?
I am ready to pay $250,000 for something awesome and you're telling
me that you've only got ten lines for it? Huh?"

{% quote Don't allow your client to force you to bloat the Product Vision. %}

To work around this situation, split the client's documentation into two parts.
The first part will fit into the Product Vision document; the second one
will be called "supplementary documentation" and will contain all that
valuable information you've got from the client. You may use
that documentation later, during the course of product development.

But don't cut corners. Don't allow your
[client]({% pst 2015/jan/2015-01-26-happy-boss-false-objective %})
(or anyone else) to force
you to bloat the Product Vision.
The document has to be very short and explicit.

No lyrics, only
[statements]({% pst 2015/nov/2015-11-10-ten-mistakes-in-specs %}).

PS. On top of all this we usually place a
[Glossary]({% pst 2015/mar/2015-03-16-technical-glossaries %}).
