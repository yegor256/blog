---
layout: post
title: "Are You a Hacker or Designer?"
date: 2000-01-01
tags: mgmt programming
description:
  Twenty years ago we worried about performance. Now
  it is time to worry about maintainability, even though
  it often compromises the performance
keywords:
  - performance vs maintainability
  - software performance
  - scalability
  - maintainability
  - readability
---

Twenty years ago, the best programmer was the one
capable of fitting an entire application into a 64Kb
`.COM` file. Those who were able to get the maximum
from that poor Intel 80386 were icons of programming.

That's because twenty years ago computers were expensive and programmers
were cheap. That was the time of "hacker mentality".
This time is over. This mentality is not appreciated any more,
because the market situation is completely opposite.

Today, computers are cheap and programmers are expensive.
This is the era of "designer mentality", when readability
of our code is much more important than its performance.

<!--more-->

## Prices vs Salaries

Look at this graph. It is a comparison of two trends over the
last twenty years (1994-2014):

{% figure /images/2014/10/trends.png 720 %}

The first trend falls down and shows how much cheaper
[computer memory](http://www.jcmit.com/memoryprice.htm)
and [HDD storage](http://ns1758.ca/winch/winchest.html)
have become over the last twenty years.

The second trend demonstrates how much software developers salaries
escalated over the same period. Actually, they are trippled. There is
no official report about that, but I'm sure it's not a secret for anyone
that salaries of programmers keep growing &mdash; $200,000 per year for
a senior developer is not a dream any more. I found
[this article](http://markcunningham91.blogspot.com/2013/05/a-history-of-offers-to-software.html)
very interesting about this very subject.

Basically, this means that in order to create a PHP website
in 1994 we had to spend 1000 times more on hardware and three times
less on programmers than in 2014. And we're talking about the
same stack of technologies here. The same Linux box with Apache HTTP Server
inside.

The difference is that in 1994, if our application had performance problems because of
hardware limitations, we paid $35,000 per each additional gigabyte of RAM, while
in 2014 we pay $10.

In 1994 it was much more efficient to hire more programmers and ask
them to [optimize](https://en.wikipedia.org/wiki/Program_optimization)
the code or even rewrite it, instead of buying new hardware. In 2014 the
situation is exactly the opposite. It is much cheaper to double the
size of the server (especially if the server is a virtual cloud one)
instead of paying salaries for optimizing the software.

In 1994 the best engineers had "hacker mentality", while in 2014
"designer mentality" is much more appreciated.

## Hacker Mentality

Someone with a hacker mentality would call this an "elegant code"
(would you?):

{% highlight c %}
int fibo(int n) { return n>2?fibo(n-1)+fibo(n-2):1; }
{% endhighlight %}

I would highlight these seven qualities of a good
[hacker](https://en.wikipedia.org/wiki/Hacker_%28computer_security%29):

 * uses all known (and unknown) features of a programming language
 * discriminates others as hackers and newbies and writes for hackers
 * gets bored and frustrated by rules and standards
 * doesn't write unit tests &mdash; juniors will write them later
 * enjoys fire-fighting &mdash; that's how his talent manifests
 * prefers talks over docs, since they are much more fun
 * posts comments on Hacker News

A hacker is a talented individual. He wants to express his
talent in the software he writes. He enjoys coding and does
it mostly for fun. I would say, he is married to his code and can't imagine
its happy life after an eventual divorce.

When I ask one of my hacker friends &mdash; "How will someone understand
what this function does?" I almost always hear the same answer &mdash;
"They will ask me!" (usually said very proudly with a sincere smile).

## Designer Mentality

Someone with a designer mentality would refactor the code above
to make it easier to read. He would call this function an "elegant code"
(how about you?):

{% highlight c %}
int fibo(int n) {
  int f;
  if (n > 2) {
    f = fibo(n - 1) + fibo(n - 2);
  } else {
    f = 1;
  }
  return f;
}
{% endhighlight %}

I think, these seven qualities attributes a good designer:

 * assumes everybody is a newbie and writes accordingly
 *
 * prefers docs over talks and automation over docs
 * posts links on Hacker News

A good designer understands the most important concern of a modern business owner,
which is: "I want to be able to change and maintain my software"

## The Future

If you consider yourself a hacker, I believe it's time to change. Time of
hackers is fading out.

In the near future we will even stop thinking in terms of "hardware" and will
run our application in elastic computational platforms with unlimited
amount of memory, CPU power and storage space. We will simply pay
for resource utilization and almost any performance issue will just add a few extra
dollars to our monthly bills. We won't care about optimization any more.

At the same time, good software engineers will become more and more expensive
and will charge $500+ per hour just to check out software and give
a diagnosis. Just like good lawyers or dentists.

That's why, while developing a new software product, those who pay for it, will
care mostly about its maintainability. Project sponsors will
understand that the best solution they can get for their money is
the one that is readable and fully automated.

Not the fastest.
