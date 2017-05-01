---
layout: post
title: "Any Program has an Unlimited Number of Bugs"
date: 2017-05-02
place: Odessa, Ukraine
tags: testing
description: |
  Since requirements and user expectations are vague
  any piece of software may be improved a literally
  unlimited amount of times.
keywords:
  - testing
  - bugs
  - number of bugs
  - bugs count
  - philosophy of testing
image: /images/2015/03/?
jb_picture:
  caption: xxx
---

This may sound strange, but I will prove it: no matter how big
or stable a piece of software is, it has an _unlimited_ number
of bugs not yet found. No matter how many of them we have already managed
to find and fix, there are still too many left to count.

<!--more-->

{% jb_picture_body %}

Let's take this simple Java method that calculates a sum of two integers
as an example:

{% highlight java %}
int sum(int a, int b) {
  return a + b;
}
{% endhighlight %}

This simple program has an _unlimited_ number of bugs.

To prove this claim we just need to put two thoughts together:

  * First, a bug is something that compromises the quality of software,
    which, according to IEEE&nbsp;610.12-1990, is "the degree to which
    a system meets specified requirements or _user expectations_."

  * Second, requirements and expectations may be functional and non-functional.
    The latter include performance, resilience, robustness, _maintainability_,
    and a few dozen other NFRs.

It is obvious that there are at least two variables in this equation that
are not discrete: user expectations and maintainability. We can't be precise
about them and that's why the number of bugs they will produce has no limit.

Of course, only a very limited subset of the entire set of bugs has any
real business impact. Most of the bugs that exist in a program may
stay there even after it is shipped to its users&mdash;nobody will ever
find them or else the damage they cause to the user experience will be
insignificant.

Finally, take a look at the method `sum()` one more time. How about these bugs:

  * It doesn't handle overflows
  * It doesn't have any user documentation
  * Its design is not object-oriented
  * It doesn't sum three or more numbers
  * It doesn't sum `double` numbers
  * It doesn't cast `long` to `int` automatically
  * It doesn't skip execution if one argument is zero
  * It doesn't cache results of previous calculations
  * There is no logging
  * Checkstyle would complain since arguments are not `final`

I'm sure you can find many more.
