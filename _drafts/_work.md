---
layout: post
title: "Flexibility Means Lower Quality"
date: 2016-06-20
place: Palo Alto, CA
tags: management
description: |
  The more options a programmers has to implement
  a feature in a programming language, the lower will
  be the overall quality of the product.
keywords:
  - quality
  - programming language quality
  - syntactic sugar
  - rubocop
  - checkstyle
---

There are two opposite mindsets: "If it works, it's good" vs.
"If it's good, it works"; or "Make it work" vs. "Make it right".
I'm talking about the software source code. I'm been hearing that
almost every day in blog comments: Why do we need all that _new_ OOP
principles, if our code works just fine without them? What is the
point of introducing a new way, which is supposed to be "better,"
if the existing traditional semi-object semi-procedural not-so-perfect
approach **just works**?

<!--more-->

Let's try to think bigger. Not just about object-oriented programming, but
in general about software development. There are many examples of
"just works" mentality.

Take Perl, a programming language famous
for its ability to do anything in three different ways. This means that
there is no one "right" way. I'm not a Perl expert, that's why
look at this Ruby code instead:

{% highlight ruby %}
if a > b
  m = 'hello!'
end
{% endhighlight %}

We can re-write it like this:

{% highlight ruby %}
m = if a > b
  'hello!'
end
{% endhighlight %}

And one more time:

{% highlight ruby %}
m = 'hello!' if a > b
{% endhighlight %}

And one more:

{% highlight ruby %}
m = a > b ? 'hello' : nil
{% endhighlight %}

Which one is "right"? Are there any Perl developers? Can you suggest
some other way to achieve the same result?

Not surprisingly, in Java (the language I find better designed than Ruby)
there is only one way to do it:

{% highlight ruby %}
if (a > b) {
  m = "hello!";
}
{% endhighlight %}

Well, I'm wrong, there are two actually, here is the second one:

{% highlight ruby %}
if (a > b) m = "hello!";
{% endhighlight %}

What does this variety of options give us, programmers? I guess, the answer
seriously depends on what we, programmers, are doing with the code:
writing or reading it. Also, it depends on our
[attitude]({% pst 2014/oct/2014-10-26-hacker-vs-programmer-mentality %}) to the
software we're making: we either
_own_ it (hacker mentality) or
_build_ it (designer mentality).

If we're writing it and we love to think about ourselves as code owners&mdash;we
definitely will need that arsenal of
[syntactic sugar](https://en.wikipedia.org/wiki/Syntactic_sugar) weapons. We need them to prove ourselves
that we're smart and, of course, to show off in front of our friends and
that soulless Ruby interpreter.

On the other hand, if we're designers and happen to read the code that is
full of sugar, which "just works"&mdash;we'll be very annoyed and
frustrated. Well, maybe I have to speak for myself, but I definitely will be.

This overly-sugared Ruby syntax is a perfect example of "works vs. good"
positioning. Ruby philosophy is this: No matter how you write it, as long
as it works. Java philosophy is different and much closer to:
Make it right and it will work.
[Weak](https://en.wikipedia.org/wiki/Strong_and_weak_typing)
and
[dynamic](https://en.wikipedia.org/wiki/Type_system#Dynamic_type_checking_and_runtime_type_information)
typing in Ruby vs. strong and
[static](https://en.wikipedia.org/wiki/Type_system#Static_type_checking)
one in Java also prove my point.

In general, I believe that the more flexible the programming language is, the
lower the _maintainability_ of the code&mdash;its key quality characteristic.
Simply put, higher quality comes from simpler languages.

The same is true for the entire software development: the more restrictions
we put on programmers and the fewer options they have for their
"syntax creativity," the higher the quality of the software they write.
Static analyzers like
[Checkstyle](http://checkstyle.sourceforge.net/) for Java or
[Rubocop](https://github.com/bbatsov/rubocop) for Ruby are trying
to solve that problem and prohibit us from using certain language features,
but they are far behind. We are very "creative."

Now, let's get back to the original OOP question:
Why do we need to improve anything, if it works the way it is?
Here is the answer: modern OOP (as in Java, Ruby, and C++)
doesn't produce quality code because it doesn't have a strong
and properly restricted paradigm. It just has too many "features,"
which were mostly introduced by C++ and remained there, for our
mutual "convenience."

They do work indeed, but the maintainability of the software we produce
is very low. Well, it's way lower than it could be, if our "creativity"
would be restricted.
