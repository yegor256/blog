---
layout: post
title: "Three Things I Expect From a Software Architect"
date: 2015-05-15
tags: mgmt agile
description:
  A software architect is responsible for a technical
  success of a software project and must accurately report
  to the project manager.
keywords:
  - software architect
  - software architect job description
  - software architect responsibilities
  - software architect vs developer
  - software architect vs engineer
---

A software architect is a key person in a software project. I
explained this idea in [What Does a Software Architect Do?]({% pst 2014/oct/2014-10-14-who-is-software-architect %})
post, a few months ago. The architect is personally responsible for
the technical quality of the product we're developing. No matter how
good is the team, how complex is the technology, how messy are
the requirements or how chaotic is the project sponsor &mdash;
we blame the architect and nobody else. Of course, we also reward the architect,
if we succeed. Here is what I, a project manager, expect from a good architect.

<!--more-->

In all projects we run in [Teamed.io](http://www.teamed.io), I'm expecting
regular reports from software architects, a few times a week. Each report
includes three mandatory parts: 1) scope status, 2) issues and 3) risks.

## Scope Status

The first and the most important type of information I'm looking for
is scope status, which should be presented in
[Product Breakdown Structure](https://en.wikipedia.org/wiki/Product_breakdown_structure)
(PBS) format. No matter how complex or small is the product, a good architect
should be able to create a PBS of _4-8 items_. For example:

{% highlight text %}
1. MySQL persistence [done]
2. OAuth login [done]
3. Input parsing in XML [75%]
4. S3 data storage [none]
5. UI cross-platform testing [none]
{% endhighlight %}

That's the size of report I'm expecting to recieve from a good architect
every few days. The main goal for the architect here is to make sure
that nothing is missed. No matter how big is the project, all its
technical product components must fit into this PBS.

The architect is _personally_ responsible for not missing the information
in the PBS and making it as accurate as possible. If something is missed
or the report is delayed, it's a good reason for changing the architect.

The completeness percentages are also important here. Even though
individual tasks are managed with "0/100 completion principle" in mind,
the architect must compile that percentages and make sure that compilation
is accurate. Again, a mistake here is unforgivable.

## Issues

The second important part of a regular report from an architect is a list
of current issues the development team is facing. An issue is something
that has already happened and we're suffering already from it. Here are
a few practical examples:

{% highlight text %}
1. MySQL is too slow for our performance requirements
2. Java 1.6 doesn't allow us to use library X
3. We don't have a replacement for a Ruby guy who left us
4. Integration tests are not predictable
{% endhighlight %}

Again, the list must include 4-8 items (no more and not less) and the architect
shall mention the most critical issues there.

## Risks

Now, the risks. Risk is something that hasn't happened yet, but may happen
soon and if it happens, we'll be in trouble. The architect is responsible
for keeping an eye on all potential risks and report the most critical
of them to the project manager, regularly. Here is an example of
a brief risk report:

{% highlight text %}
1. Deployment platform may not support Java 8 [3/8]
2. Library X may take more than two weeks planned [7/3]
3. We may lose a good Ruby developer soon [5/6]
4. Integration tests may not be safe enough [7/2]
5. We may fail to find an open source library [3/8]
{% endhighlight %}

A project manager may require additional information about each risk, but
that's another story. What is the most important, is to keep the project manager
informed about the top of the list. Each risk has two numbers associated with
it &mdash; _probability_ and _impact_, from 0 to 9. In the list above, the first
risk has probability of 4 and impact of 8. This means that the architect
believes that most probably this won't happen, but if it happens, we'll be
in big trouble.

Pay attention, the key word in each risk description is _may_. A risk
is something that hasn't happened yet. That's the key difference between
a risk and an issue. An issue is a risk that has already occurred.
