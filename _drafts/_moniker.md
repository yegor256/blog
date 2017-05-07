---
layout: post
title: "Monikers Instead of Variables"
date: 2017-05-13
place: Odessa, Ukraine
tags: oop
description: |
  To make code shorter and more cohesive
  we use unmodifiable values, still calling them
  variables; why so?
keywords:
  - variables
  - oop
  - variables in oop
  - no variables
  - algorithms in oop
image: /images/2015/05/oss-117.jpg
jb_picture:
  caption: "OSS 117: Cairo, Nest of Spies (2006) by Michel Hazanavicius"
---

If we agree that all local variables [must be](https://softwareengineering.stackexchange.com/questions/48413)
`final`, multiple `return`-s must be avoided, and
temporal coupling between statements is evil&mdash;we can get
rid of variables entirely and replace them with _inline values_
and their _monikers_.

<!--more-->

{% jb_picture_body %}

Here is the code from Section 5.10 _Algorithms_ of my book
[_Elegant Objects_](http://amzn.to/2pjciUY):

{% highlight java %}
public class Main {
  public static void main(String... args) {
    final Secret secret = new Secret();
    new Farewell(
      new Attempts(
        new VerboseDiff(
          new Diff(
            secret,
            new Guess()
          )
        ), 5
      ),
      secret
    ).say();
  }
}
{% endhighlight %}

Pay attention to the variable `secret`. It exists here because we
need its value twice: first, as a constructor argument for the `Diff`, second
as a constructor argument for the `Farewell`. We can't _inline_ the value by
creating two separate instances of class `Secret`, because it really has
to be the same object&mdash;it encapsulates the number we hide
from the user in a number-guessing game.

There could be many other situations where a _value_ need to used multiple
times, remaining unmodifiable. Why do we still call that values _variables_, if
technically they are constants?

I'm suggesting to introduce "monikers" for values and use them
through `as` keyword, for example:

{% highlight java %}
public class Main {
  public static void main(String... args) {
    new Farewell(
      new Attempts(
        new VerboseDiff(
          new Diff(
            secret,
            new Guess() as secret
          )
        ), 5
      ),
      secret
    ).say();
  }
}
{% endhighlight %}

Here `new Guess()` is the inlined value and `secret` is its _moniker_, which
we use a few lines later.

Would be great to have this feature in Java, right?
