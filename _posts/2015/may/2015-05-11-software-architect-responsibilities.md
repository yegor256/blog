---
layout: post
title: "Three Things I Expect From a Software Architect"
date: 2015-05-11
tags: architect
description: |
  A software architect is responsible for the technical
  success of a software project and must accurately report
  to the project manager.
book: code-ahead-1 2
keywords:
  - software architect
  - software architect job description
  - software architect responsibilities
  - software architect vs developer
  - software architect vs engineer
image: /images/2015/05/dr-strangelove.jpg
jb_picture:
  caption: Dr. Strangelove (1964) by Stanley Kubrick
---

A software architect is a key person in a software project, which I
explained in my [What Does a Software Architect Do?]({% pst 2014/oct/2014-10-12-who-is-software-architect %})
post a few months ago. The architect is personally responsible for
the technical quality of the product we're developing. No matter how
good the team is, how complex the technology is, how messy the
requirements are, or how chaotic the project sponsor is,
we blame the architect and no one else. Of course, we also reward the architect
if we succeed. Here is what I, as
[project manager]({% pst 2015/sep/2015-09-22-micromanagement %}), expect from a good architect.

<!--more-->

{% jb_picture_body %}

In all projects we run at [Zerocracy](https://www.zerocracy.com), I expect
regular reports from software architects a few times a week. Each report
includes three mandatory parts: 1) scope status, 2) issues, and 3) risks.

## Scope Status

{% youtube 0fuEgmibJc4 %}

The first and most important type of information I'm looking for
is the scope status, which should be presented in
[Product Breakdown Structure](https://en.wikipedia.org/wiki/Product_breakdown_structure)
(PBS) format. No matter how complex or how small the product is, a good architect
should be able to create a PBS of _four to eight items_. For example:

{% highlight text %}
1. MySQL persistence [done]
2. OAuth login [done]
3. Input parsing in XML [75%]
4. S3 data storage [none]
5. UI cross-platform testing [none]
{% endhighlight %}

That's the size of the report I'm expecting to receive from a good architect
every few days. The main goal for the architect here is to make sure
that nothing is missed. No matter how big the project is, all its
technical components must fit into this PBS.

The architect is _personally_ responsible for not missing the information
in the PBS and making it as accurate as possible. If something is missed
or the report is delayed, that becomes a good reason to change the architect.

The percentages of progress are also important here. Even though
individual tasks are managed with the "0/100 completion principle" in mind,
the architect must compile those percentages and make sure that compilation
is accurate. Again, a mistake here is unforgivable.

## Issues

{% youtube PNSezrlemsY %}

The second important part of a regular report from an architect is a list
of current issues the development team is facing. An issue is something
that has already happened and we're suffering from it. Here are
a few practical examples:

{% highlight text %}
1. MySQL is too slow for our performance requirements
2. Java 1.6 doesn't allow us to use library X
3. We don't have a replacement for a Ruby guy who left us
4. Integration tests are not predictable
{% endhighlight %}

Again, the list must include four to eight items (no more and no less), and the architect
should mention the most critical issues there.

## Risks

{% youtube AvVQ5NjS_Nk %}

Now, the risks. A risk is something that hasn't happened yet but may happen
soon, and if it happens, we'll be in trouble. The architect is responsible
for keeping an eye on all potential risks and regularly reporting the most critical
ones to the
[project manager]({% pst 2016/may/2016-05-24-who-is-project-manager %}). Here is an example of
a brief risk report:

{% highlight text %}
1. Deployment platform may not support Java 8 [3/8]
2. Library X may take more than the two weeks planned [7/3]
3. We may lose a good Ruby developer soon [5/6]
4. Integration tests may not be safe enough [7/2]
5. We may fail to find an open source library [3/8]
{% endhighlight %}

A project manager may require additional information about each risk, but
that's another story. What is most important is to keep the project manager
informed about the top of the list. Each risk has two numbers associated with
it: _probability_ and _impact_, from 0 to 9. In the list above, the first
risk has a probability of 3 and impact of 8. This means the architect
believes that most likely this won't happen, but if it does happen, we'll be
in big trouble.

Pay attention, as the key word in each risk description is _may_. A risk
is something that hasn't happened yet. That's the biggest difference between
a risk and an issue. An issue is a risk that has already occurred.

PS. Here is how an architect can enforce the principles
of design and architecture:
[Two Instruments of a Software Architect]({% pst 2015/may/2015-05-13-two-instruments-of-software-architect %})
