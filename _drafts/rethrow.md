---
layout: post
title: "Exception Without a Context is a Bad Practice"
date: 2015-10-26
place: San Jose, CA
tags: java
description:
  This must be a good practice to add a contextual
  message to an exception on each re-throw, and
  actually, in all other situations.
keywords:
  - rethrow exception
  - rethrow exception java
  - rethrow exception c++
  - rethrow exception scala
  - rethrow exception with new message
---

I keep repeating the same mistake again and again. It's time to
stop and make a rule, to prevent this from happening. The mistake
is not fatal, but very annoying. When I look at production logs I often see
something like `"file doesn't exist"` and I question myself:
What file? Where it is supposed to exit? What did the server try to do with it?
What was going on, a second before it crashed?
There is no answer in the log, and it's totally my fault.
I either 1) don't re-throw or 2) re-throw without adding context.
Both are wrong.

<!--more-->

This is how the code may look:

{% highlight java %}
if (!file.exists()) {
  throw new IllegalArgumentException(
    "file doesn't exist"
  );
}
{% endhighlight %}

Also, it may look like this:

{% highlight java %}
try {
  Files.delete(file);
} catch (IOException ex) {
  throw new IllegalArgumentException(ex);
}
{% endhighlight %}

Both examples demonstrate a bad style of handling exceptional
situations and reporting them. What's wrong here? Exception messages
are not rich enough. They simply don't contain any information
from the place where they originated from.

This is how they should look instead:

{% highlight java %}
if (!file.exists()) {
  throw new IllegalArgumentException(
    String.format(
      "user profile file %s doesn't exist",
      file.getAbsolutePath()
    )
  );
}
{% endhighlight %}

And the second example should look like this:

{% highlight java %}
try {
  Files.delete(file);
} catch (IOException ex) {
  throw new IllegalArgumentException(
    String.format(
      "can't delete user profile data file %s",
      file.getAbsolutePath()
    ),
    ex
  );
}
{% endhighlight %}

See the difference? This may look like redundant code, but it's not.
Of course, when I'm writing all this, I don't really care about
logs and exceptional situations. I'm not really expecting this file
to be absent.

But I should.

There should be a rule &mdash; every time we throw or re-throw,
exception message must describe the problem with as much
details as possible.

Of course, we must not forget about security and never put any
sensitive information into exception message, like passwords,
credit card numbers, etc. Besides that, as much as possible
must be exposes to the exception catcher on a higher level.

Throwing an exception literally is an escalation of a problem
to the higher level of management. Imagine, my boss is asking
me to install a new server. I come back to him in a few hours
and say &mdash; "I failed, sorry". This will sound strange. He
will ask for more details. Why failed? What exactly was wrong?
Is it possible to do it differently? Etc.

This code is literally a sign of disrespect to the client,
which is calling me, a piece of code:

{% highlight java %}
throw new IllegalArgumentException(
  "file doesn't exist"
);
{% endhighlight %}

I have to be more verbose and give more details.

And I'm not alone in this mistake. I see it everywhere and it really
makes debugging difficult, especially in production, where it's
almost impossible to reproduce the problem right away.

Thus, please, be more verbose in your exceptions. I will do the same
in my code :)

And, one more thing, before you go. In most OOP languages exceptions
are unchecked, which means that catching them is not a mandatory
operation, [unfortunately]({% pst 2015/jul/2015-07-28-checked-vs-unchecked-exceptions %}).
Nevertheless, I would recommend to catch, add context, and
re-throw them all, **always**. This may look like pure noise, but it's not!
Just make your methods smaller and make sure all exceptions
floating out of them have enough information about their origins.
You will do yourself and everybody else a big favor.
