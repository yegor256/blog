---
layout: post
title: "Defensive Programming via Validating Decorators"
date: 2016-01-26
place: Palo Alto, CA
tags: oop
description: |
  Defensive programming is a good idea, but the way
  it gets implemented is, in most cases, very wrong;
  here is what I'm suggesting instead.
category: jcg
keywords:
  - defensive programming
  - validators in oop
  - check for null
  - validate method arguments
  - startup failure stories
jb_picture:
  src: /images/2016/01/shi-mian-mai-fu.jpg
  caption: Shi mian mai fu (2004) by Yimou Zhang
---

Do you check the input parameters of your methods for validity?
I don't. I used to, but not anymore.
I just let my methods crash with a null pointer and other exceptions
when parameters are not valid.
This may sound illogical, but only in the beginning.
I'm suggesting you use **validating decorators** instead.

<!--more-->

{% jb_picture_body %}

Let's take a look at this rather typical Java example:

{% highlight java %}
class Report {
  void export(File file) {
    if (file == null) {
      throw new IllegalArgumentException(
        "File is NULL; can't export."
      );
    }
    if (file.exists()) {
      throw new IllegalArgumentException(
        "File already exists."
      );
    }
    // Export the report to the file
  }
}
{% endhighlight %}

Pretty [defensive](https://en.wikipedia.org/wiki/Defensive_programming), right?
If we remove these validations, the code
will be much shorter, but it will crash with rather confusing messages
if `NULL` is provided by the client. Moreover, if the file already exists,
our `Report` will silently overwrite it. Pretty dangerous, right?

Yes, we must protect ourselves, and we must be defensive.

But not this way, not by bloating the class with validations that
have nothing to do with its core functionality. Instead, we should
use decorators to do the validation. Here is how. First,
there must be an interface `Report`:

{% highlight java %}
interface Report {
  void export(File file);
}
{% endhighlight %}

Then, a class that implements the core functionality:

{% highlight java %}
class DefaultReport implements Report {
  @Override
  void export(File file) {
    // Export the report to the file
  }
}
{% endhighlight %}

And, finally, a number of decorators that will protect us:

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
        "File already exists."
      );
    }
    this.origin.export(file);
  }
}
{% endhighlight %}

Now, the client has the flexibility of composing a complex object
from decorators that perform their specific tasks. The core object
will do the reporting, while the decorators will validate parameters:

{% highlight java %}
Report report = new NoNullReport(
  new NoWriteOverReport(
    new DefaultReport()
  )
);
report.export(file);
{% endhighlight %}

What do we achieve with this approach?
First and foremost: smaller objects.
And smaller objects always mean higher **maintainability**.
Our `DefaultReport` class will always remain small, no matter
how many validations we may invent in the future. The
more things we need to validate, the more validating decorators
we will create. All of them will be small and cohesive. And we'll
be able to put them together in different variations.

Besides that, this approach makes our code much more
**reusable**, as classes perform very few operations
and don't defend themselves by default. While being defensive
is an important feature, we'll use validating decorators. But
this will not always be the case. Sometimes validation is just
too expensive in terms of time and memory, and we may want to work
directly with objects that don't defend themselves.

I also decided not to use the Java Validation API anymore for the
same reason. Its annotations make classes much more verbose
and less cohesive. I'm using validating decorators instead.

