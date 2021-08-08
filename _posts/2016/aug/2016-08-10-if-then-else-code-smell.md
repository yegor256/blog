---
layout: post
title: "If-Then-Else Is a Code Smell"
date: 2016-08-10
place: Tallinn, Estonia
tags: oop
description: |
  Forking is a perfect mechanism to control execution
  flow in a procedure, which has almost
  no right to exist in OOP.
keywords:
  - if then else
  - if forking
  - if then else oop
  - oop forking
  - if forking
image: /images/2016/08/fargo.jpg
jb_picture:
  caption: Fargo (1996) by Coen Brothers
---

In most cases (maybe even in all of them), if-then-else can and must
be replaced by a decorator or simply another object.
I've been planning to write about this for almost a year but only today found
a real case in my own code that perfectly
illustrates the problem. So it's time to demonstrate it and explain.

<!--more-->

{% jb_picture_body %}

Take a look at the class
[`DyTalk`](https://github.com/yegor256/rultor/blob/1.61.9/src/main/java/com/rultor/dynamo/DyTalk.java)
from
[yegor256/rultor](https://github.com/yegor256/rultor)
and its method
[`modify()`](https://github.com/yegor256/rultor/blob/1.61.9/src/main/java/com/rultor/dynamo/DyTalk.java#L127-L169).
In a nutshell, it prevents you from saving any data to the DynamoDB if there were no
modifications of the XML document. It's a valid case, and it has to be
validated, but the way it's implemented is simply wrong. This is
how it works (an oversimplified example):

{% highlight java %}
class DyTalk implements Talk {
  void modify(Collection<Directive> dirs) {
    if (!dirs.isEmpty()) {
      // Apply the modification
      // and save the new XML document
      // to the DynamoDB table.
    }
  }
}
{% endhighlight %}

What's wrong, you wonder? This if-then-else forking functionality doesn't really belong
to this object---that's what's wrong. Modifying the XML document
and saving it to the database is _its functionality_, while
not saving anything if the modification instructions set is empty is not
(it's very similar to [defensive programming]({% pst 2016/jan/2016-01-26-defensive-programming %})).
Instead, there should be a decorator, which would look like this:

{% highlight java %}
class QuickTalk implements Talk {
  private final Talk origin;
  void modify(Collection<Directive> dirs) {
    if (!dirs.isEmpty()) {
      this.origin.modify(dirs);
    }
  }
}
{% endhighlight %}

Now, if and when we need our talk to be more clever in situations where
the list of directives is empty, we decorate it with `QuickTalk`.
The benefits are obvious: the `DyTalk` class is smaller and therefore
more cohesive.

{% quote If it's possible to convert if-then-else forking to a decorator, it has to be done. %}

But the question is bigger than just that. Can we make a rule out of it? Can we say that
_each and every forking_ is bad and should be moved out of a class? What about
forking that happens inside a method and can't be converted to a decorator?

I'm suggesting this simple rule: If it's possible to convert if-then-else forking
to a decorator, it has to be done. If it's not done, it's a code smell.
Make sense?
