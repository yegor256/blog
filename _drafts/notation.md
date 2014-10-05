---
layout: post
title: "Paired Brackets"
date: 2014-10-07
tags: java oop programming
description:
  Paired Brackets notation makes your object-oriented
  code look beautiful and disciplined, no matter
  how deep is the nesting level
keywords:
  - indentation notation
  - indentation in java
  - indentation in php
  - indentation in ruby
  - indentation in c++
---

Here is the rule: **a bracket should either start/end
a line or be paired on the same line**. The rule
universally applies to any programming language (incl.
Java, Ruby, Python, C++, PHP) where brackets are used
for method/function calls.

Here is how your code will look, if you follow
the principle:

{% highlight java linenos=table %}
new Foo( // ends the line
  Math.max(10, 40), // open/close at the same line
  String.format(
    "hello, %s",
    new Name(
      Arrays.asList(
        "Jeff",
        "Lebowski"
      )
    )
  ) // starts the line
);
{% endhighlight %}

Obviously, the line with a closing bracket should start at the same
indentation level as the line with it opening pair.

This is how your IDE will render your code if you
follow this notation (IntelliJ IDEA):

{% figure /images/2014/10/intellij-idea-indentation.png 500 %}

Sublime Text will also appreciate it:

{% figure /images/2014/10/sublime-text-indentation.png 500 %}

As you see, those light vertical lines at the left side
of the code help you to navigate, if you follow the notation.

Those multiple closing brackets may look strange to you
at the beginning &mdash; give yourself some time and you will
get used to them :)
