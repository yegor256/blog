---
layout: post
title: "Strict Control of Java Code Quality"
date: 2014-04-19
tags: java qulice
description:
  Qulice.com is a Java Maven plugin that aggregates
  Checkstyle, PMD, FindBugs, Cobertura and a few other
  plugins to strictly check quality of your code
keywords:
  - java static analysis
  - java checkstyle config
  - java pmd config
  - java findbugs config
  - java strict quality
  - quality of java code
---

There are many tools that control quality of
Java code, including [Checkstyle](http://checkstyle.sourceforge.net/),
[PMD](http://pmd.sourceforge.net/),
[FindBugs](http://findbugs.sourceforge.net/),
[Cobertura](http://cobertura.github.io/cobertura/), etc.
All of them are usually used to analyze quality and build
some fancy reports. Very often that reports are published
by continuous integration servers, like Jenkins.

{% badge http://img.qulice.com/logo.svg 128 http://www.qulice.com %}

[Qulice](http://www.qulice.com) makes one step further. It
aggregates a few quality checkers, configures them to a maximum
strict mode, and breaks your build if any of them fail.

Seriously, there are
[over 130 checks](http://checkstyle.sourceforge.net/availablechecks.html) in Checkstyle,
[over 400 rules](http://pmd.sourceforge.net/pmd-5.1.2/rules/index.html) in PMD, and
[over 400](http://findbugs.sourceforge.net/bugDescriptions.html) in FindBugs.
All of them should say "yes, we like your code".
Otherwise, your build won't pass.

How do you think, would it be convenient for you &mdash; to have your
code rejected every time it breaks one of 900 checks? Would it
be productive for the team &mdash; to force developers to focus
so much on code quality?

<!--more-->

## First Reaction

If you join one of our teams as a Java developer, you will
develop your code [in branches]({% post_url 2014/jul/2014-07-21-read-only-master-branch %})
and, then, [Rultor will merge]({% post_url 2014/jul/2014-07-24-rultor-automated-merging %})
your changes into `master`. Before actually merging, [Rultor](http://www.rultor.com) will run
automated build script to make sure that your branch doesn't break it.

Qulice, as a static analysis tool, is one of the steps in the automated
build script. It is actually a Maven plugin and we automate Java builds
with Maven 3x. Thus, if your changes break any of Qulice rules,
your entire branch gets rejected.

Your first reaction, I've seen it hundreds of times, will be negative.
You may actualy become frustrated enough to leave the project immediately.
You may say something like this (I'm quoting real life stories):

 * "These quality rules entirely ruin my creativity!"

 * "Instead of wasting time on these misplaced commas and braces we better
   develop new features!"

 * "I've done many successful projects in my life, never heard about this
   ridiculous quality checking"

This first reaction is only logical. I've seen many people saying that,
in both open source and commercial projects. Not only in Java, but also
in PHP (with [phpcs](http://pear.php.net/package/PHP_CodeSniffer/)
and [phpmd](http://phpmd.org/)) and
Ruby (with [rubocop](https://github.com/bbatsov/rubocop)
and [simplecov](https://github.com/colszowka/simplecov)).

What do I answer? Read on.

## Second Thought

My experience tells me that the sooner someone can get used to
strict quality control of Qulice, the faster he/she can learn and grow;
the better programmer he/she is; and the further he/she can go with
us and our projects.

Having this experience in mind I recommend all new project members
to be patient and try to get used to this new approach to quality.
In a few weeks, those who stay, start to understand why
this approach is good for the project and for them, as Java engineers.

Why it is good? Read on.

## What Do The Project Get?

Let's take one simple rule as an example. Here is a piece of Java
code that Qulice would complain about
(due to [`DesignForExtension`](http://checkstyle.sourceforge.net/config_design.html#DesignForExtension) rule from Checkstyle):

{% highlight java %}
public class Employee {
  public String name() {
    return "Jeff";
  }
}
{% endhighlight %}

What is wrong with this code? Method `name()` is not final and can be overridden
by a class that extends `Employee`. Design-wise this is wrong, since child
class is allowed to break a super class, overriding its method.
What is the right design? Here it is:

{% highlight java %}
public class Employee {
  public final String name() {
    return "Jeff";
  }
}
{% endhighlight %}

Now, the method is final and can't be overriden by child classes. It is
a much safer design (according to Checkstyle, and I agree).

Let's say we make this rule mandatory for all classes in the project.
What does the project gain in this case?
It can promise its members (programmers) a **higher quality** of work,
comparing to other projects that don't have this restriction, mostly
because of:

 * **Predictability of Design** &mdash;
   I don't have to scroll through
   the entire class to make sure it doesn't have methods that can
   be overriden accidentally. I know for sure that this can't happen
   in this project. In other words, I know what to expect.

 * **Less Hidden Tricks** &mdash;
   higher predictability of design leads
   to better visibility of mistakes and tricks. Standardization of source
   code makes it uniform. This means that it's easier to read and
   spot problems.

 * **Industry Standards** &mdash;
   the decision to use this design is
   made by Checkstyle, not by project architect. For me, as a project
   developer, this means that I'm following industry standards. It produces
   much more respect to the project (and its leaders).

 * **Source for Learnings** &mdash;
   I bet most of you who read this post didn't know about that
   design rule explained above. Just by reading this article you learned
   something new. Imagine how much you learn after making your
   code compliant to all 900 rules from Qulice (Checkstyle + PMD + FindBugs).

The point about learning brings us to the last, and the most important thought
to discuss.

## What Do I Get?

I hope you already realize what do you get as a programmer, working
in a project that raises its quality bar as high as Qulice asks. Yes,
you learn a lot of new things about writing quality Java code.

I would actually say that you are getting free lessons with every
new line of code you write. And the teacher is a software, written
by hundreds of Java developers for the last ten years. Qulice just
integrates that software tools together, but their developers are the
real authors of quality checks and rules.

So, what do I tell those who complain about quality rules being too strict?
I say, "do you want to learn and improve or you just want to get paid
and get away with it?"
