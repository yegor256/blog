---
layout: post
title: "How to Write a Vision"
date: 2000-01-01
tags: mgmt
description:
  Vision is a fundamental document in any software project
  that explains what is it about and defines scope boundaries
keywords:
  - vision
  - software project vision
  - vision document
  - vision statement examples
  - vision statement definion
  - vision statement software project
---

{% badge /images/2014/10/lifecycle-thinking.png 250 %}

Every software project we work with is started from a Product Vision document. We
create this document during our
[Thinking]({% pst 2014/oct/2014-10-06-software-project-lifecycle %})
phase. Even though the document is as short as two pages of English text,
its development is the most painful task in the whole project.

There are a few tricks which I'd like to share.

<!--more-->

## Structure

We usually design Product Vision in four sections.

**Statement**. It is a one-paragraph declaration of intent, explaining
to an absolute stranger what this product is about and what is it for.
The Statement must answer these questions:

 * What are the main competing solutions?
 * What is wrong with them?
 * How our product is fixing that problems?

**Stakeholders and Needs**. This section must list everybody whose life
will be affected by the product (positively or negatively). In most cases,
this list includes: sponsor, developer, users, competitors, government,
bank, etc.

Each stakeholder must have a list of needs. They have to be simple
and straight forward, like "earn money", "increase profit", "share photos",
or "host a website".

**Actors and Features**. In this section we list actors
(entities communicating with the product) and key functionality
they can use in the product. Each actor must have at most six features. If
there are more, you should group them somehow.

**Quality Requirements**. This section lists all important non-functional
requirements, like performance, cost of ownership, reliability, user
interface or user experience, etc. There should be six quality
requirements maximum.

## Remove Noise

Every section must be of ten lines length, not more. Even if you're
developing a Google killer with a $50 million dollar budget, your Vision
document must be as short as two pages.

For most of my clients it is a very complex and brain damaging task. They
usually come to us with a 50-pages document explaining their business
ideas with all important details. From this document we should extract
information that really makes a difference.

Product Vision document must keep its reader on the highest level
of abstraction. The document must take less than a minute to read,
from its start till the end.

If you can't keep it short &mdash; you don't understand your product well enough.

## Example

Here is an example of a very simple Product Vision
for a Facebook killer:

{% highlight text %}
Statement
  Existing social networks, including Facebook and Twitter,
  suck because their users can't officially purchase "likes".

Stakeholders and Needs
  Sponsor wants to create a product and sell it to Google.
  Developer wants to earn money from programming.
  Users want to share photos and purchase popularity.
  Bank wants to make commission on every purchase.
  Government wants to protect us against abusive content.
  Competitors want to retain their market shares.

Actors and Features
  User can create account, upload photos, share photos,
    send personal messages, like other photos, purchase likes.
  Admin can ban user accounts, view summary reports, authorize
    credit card transactions, configure system parameters,
    monitor server resource usage.
  Bank can process credit card transactions.

Quality Requirements
  Performance must be less than 300ms response time, any page.
  User interface must be attractive and simple.
  Availability must be over 99.999%.
  Test coverage must be over 80%.
  Development pipeline must be fully automated.
  Interfaces must include web site and iOS/Android app
{% endhighlight %}
