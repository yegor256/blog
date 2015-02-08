---
layout: post
title: "Write For the User not for Yourself"
date: 2015-02-20
tags: mgmt agile
description:
  ...
keywords:
  - breaking down tasks
  - tasks breaking down
  - object relational mapping tutorials
  - orm is an anti-pattern
  - orm is antipattern
---

First, no matter what is the methodology, we all write software for our
users (a.k.a. customers, project sponsors, end-users, or clients). Second,
no matter what is the methodology, we write incrementally, releasing
new features one by one. Maybe I'll say something absolutely obvious here,
but it's important to remember that each new version should first of all satisfy
the needs of the user, not of us, programmers. In other words, the way
we decompose a big task into smaller pieces should be user targeted and that's
why top down. Let's what I mean, by a practical example.

<!--more-->

I'm contracted by a friend of mine to create a word counting command line
tool, very similar to [wc](http://en.wikipedia.org/wiki/Wc_%28Unix%29). He
promised to pay me $200 for this work and I promised him to deliver the
product in two increments &mdash; alpha and beta versions. I promised him
to release alpha version on Saturday and beta version on Sunday. He is
going to pay me $100 after the first release and the rest after the second release.

I'll write it in C.

## Bottom Up, Bad Practice

First, I'll do it in a wrong way, to demonstrate the problem. This wrong way
is a bottom up approach. I'll think like a programmer that is writing
for himself, not for the paying customer. Let's start. Here is how this
tool should work

{% highlight java %}
Session session = factory.openSession();
try {
  session.beginTransaction();
  Post post = new Post();
  post.setTitle("How to cook an omelette");
  session.save(post);
  session.getTransaction().commit();
} finally {
  session.close();
}
{% endhighlight %}

Let's see what's happening behind the scene.
