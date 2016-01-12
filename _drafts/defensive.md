---
layout: post
title: "Defensive Programming?"
date: 2015-10-20
place: Palo Alto, CA
tags: oop
description:
  ...
keywords:
  - why startups fail
  - failure of startup
  - startup failure reasons
  - startup failure rate
  - startup failure stories
---

Do you check input parameters of your methods for validity?
I don't. But I did. Not any more.
I just let my methods crash with null pointer and other exceptions,
when parameters are not valid.
This may sound illogical, but I have some reasons.
I'll try to convience you now.

<!--more-->

Let's take a look at this rather typical example:

{% highlight java %}
class Report {
  void export(File file) {
    if (file == null) {
      throw new IllegalArgumentException(
        "file is NULL, can't export"
      );
    }
    if (file.exists()) {
      throw new IllegalArgumentException(
        "file already exists"
      );
    }
    // export the report to the file
  }
}
{% endhighlight %}

Pretty defensive, right? If we remove these validations, the code
will be way shorter, but it will crash with rather confusing messages,
if `NULL` is provided by the client. Moreover, if the file already exists,
our `Report` will silently overwrite it.

We must protect ourselves. We must be defensive.

But not this way. Not by bloating the class with validations,
which have nothing to do with its core functionality. Instead, we should
use decorators, which will do the validation. Here is how. First,
there must be an interface `Report`:

{% highlight java %}
interface Report {
  void export(File file);
}
{% endhighlight %}

Then, the class that implement the core functionality:

{% highlight java %}
class DefaultReport implements Report {
  @Override
  void export(File file) {
    // export the report to the file
  }
}
{% endhighlight %}

And finally, a number of decorators that will protect us:

{% highlight java %}
class NoWriteOverReport implements Report {
  private final Report origin;
  NoWriteOverReport(Report rep) {
    this.origin = rep;
  }
  @Override
  void export(File file) {
    if (file.exists()) {
      throw new IllegalArgumentException(
        "file already exists"
      );
    }
    this.origin.export(file);
  }
}
{% endhighlight %}

Now, the client has flexibility of composing a complex object
from decorators, which perform their specific tasks. The core object
will do the reporting, while decorators will validate parameters:

{% highlight java %}
Report report = new NoNullReport(
  new NoWriteOverReport(
    new DefaultReport()
  )
);
report.export(file);
{% endhighlight %}

What do we achieve with this approach?
First and foremost &mdash; smaller objects.
And smaller objects always mean higher maintainability.
Our `DefaultReport` class will always stay small, no matter
how many validations we may invent in the future. The
more things we need to validate, the more validating decorators
we'll create. All of them will be small and cohesive. And we'll
be able to put them together in different variations.

Besides that, this approach makes our code much more
reusable, since classes are performing very few operations
and don't defend themselves by default. When being defensive
is an important feature, we'll use validating decorators. But
this will not always be the case. Sometimes validation is just
too expensive in terms of time and memory and we want to work
directly with objects that don't defend themselves anyhow.

I also decided not to use Java Validation API any more. For the
same reason. Its annotations make my classes much more verbose
and less cohesive. I'm using validating decorators instead.

