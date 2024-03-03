---
layout: post
title: "Strict Control of Java Code Quality"
date: 2014-08-13
tags: java pets quality
description: |
  Qulice.com is a Java Maven plugin that aggregates
  Checkstyle, PMD, FindBugs, Cobertura and a few other
  plugins to strictly check the quality of your code
keywords:
  - java static analysis
  - java checkstyle config
  - java pmd config
  - java findbugs config
  - java strict quality
  - quality of java code
image: /images/2014/09/ratatouille.png
jb_picture:
  caption: Ratatouille (2007) by Brad Bird and Jan Pinkava
---

There are many tools that control the quality of
Java code, including
[Checkstyle](http://checkstyle.sourceforge.net/),
[PMD](http://pmd.sourceforge.net/),
[FindBugs](http://findbugs.sourceforge.net/),
[Cobertura](http://cobertura.github.io/cobertura/), etc.
All of them are usually used to analyze quality and build
some fancy reports. Very often, those reports are published
by [continuous integration]({% pst 2014/oct/2014-10-08-continuous-integration-is-dead %})
servers, like Jenkins.

<!--more-->

{% jb_picture_body %}

[Qulice](https://www.qulice.com) takes things one step further. It
aggregates a few quality checkers, configures them to a maximum
strict mode, and breaks your build if any of them fail.

{% badge https://www.qulice.com/logo.svg 128 https://www.qulice.com %}

Seriously. There are
[over 130 checks](http://checkstyle.sourceforge.net/checks.html) in Checkstyle,
[over 400 rules](http://pmd.sourceforge.net/pmd-5.1.2/rules/index.html) in PMD, and
[over 400 bugs](http://findbugs.sourceforge.net/bugDescriptions.html) in FindBugs.
All of them should say: "Yes, we like your code."
Otherwise, your build shouldn't pass.

What do you think? Would it be convenient for you---to have your
code rejected every time it breaks just one of 900 checks? Would it
be productive for the team---to force developers to focus
so much on code quality?

## First Reaction

If you join one of our teams as a Java developer, you will
develop your code [in branches]({% pst 2014/jul/2014-07-21-read-only-master-branch %})
and, then, [Rultor will merge]({% pst 2014/jul/2014-07-24-rultor-automated-merging %})
your changes into `master`. Before actually merging, though, [Rultor](https://www.rultor.com) will run an
automated build script to make sure that your branch doesn't break it.

{% quote If your changes break any of Qulice's rules, your entire branch gets rejected %}

As a static analysis tool, Qulice is just one of the steps in the automated
build script. It is actually a Maven plugin and we automate Java builds
with Maven 3x. Thus, if your changes break any of Qulice's rules,
your entire branch gets rejected.

Your first reaction---I've seen it hundreds of times---will be negative.
You may actually become frustrated enough to leave the project immediately.
You may say something like this (I'm quoting real life stories):

 * "These quality rules entirely ruin my creativity!"

 * "Instead of wasting time on these misplaced commas and braces, we'd be better
   off developing new features!"

 * "I've done many successful projects in my life, never heard about this
   ridiculous quality checking..."

This first reaction is only logical. I've seen many people say things like this,
in both
[open source]({% pst 2015/dec/2015-12-22-why-dont-you-contribute-to-open-source %})
and commercial projects. Not only in Java, but also
in PHP (with [phpcs](http://pear.php.net/package/PHP_CodeSniffer/)
and [phpmd](http://phpmd.org/)) and
Ruby (with [rubocop](https://github.com/bbatsov/rubocop)
and [simplecov](https://github.com/colszowka/simplecov)).

How do I answer? Read on.

## On Second Thought

My experience tells me that the sooner someone can get used to the
strict quality control of Qulice, the faster he/she can learn and grow;
the better programmer he/she is; and the further he/she can go with
us and our projects.

Having this experience in mind, I recommend that all new project members
be patient and try to get used to this new approach to
[quality]({% pst 2017/apr/2017-04-11-flexibility-equates-lower-quality %}).
In a few weeks, those who stick with it start to understand why
this approach is good for the project and for them, as Java engineers.

Why is it good? Read on.

## What Do Projects Get From Qulice?

Let's take one simple rule as an example. Here is a piece of Java
code that Qulice would complain about
(due to the [`DesignForExtension`](http://checkstyle.sourceforge.net/config_design.html#DesignForExtension) rule from Checkstyle):

```java
public class Employee {
  public String name() {
    return "Jeff";
  }
}
```

What is wrong with this code? Method `name()` is not final and can be overridden
by a class that extends `Employee`. Design-wise this is wrong, since a child
class is allowed to break a super class, overriding its method.

What is the right design? This one:

```java
public class Employee {
  public final String name() {
    return "Jeff";
  }
}
```

Now, the method is final and can't be overridden by child classes. It is
a much safer design (according to Checkstyle, and I agree).

So, let's say we make this rule mandatory for all classes in the project.
What does the project gain from this?
It can promise its members (programmers) a **higher quality** of work,
compared to other projects that don't have this restriction, mostly
because of:

 * **Predictability of Design**---I don't have to scroll through
   the entire class to make sure it doesn't have methods that can
   be accidentally overridden. I know for sure that this can't happen
   in this project. In other words, I know what to expect.

 * **Less Hidden Tricks**---Higher predictability of design leads
   to better visibility of mistakes and tricks. Standardization of source
   code makes it uniform. This means that it's easier to read and
   spot problems.

 * **Industry Standards**---The decision to use this design is
   made by Checkstyle, not by a project architect. For me, as a project
   developer, this means that I'm following industry standards. That makes
   the project (and its leaders) more respectable.

 * **Learning**---I'll bet that most of you who read this post didn't know about the
   design rule explained above. Just by reading this article, you learned
   something new. Imagine how much you could learn after making your
   code compliant to all 900 rules of Qulice (Checkstyle + PMD + FindBugs).

The point about learning brings us to the last, and the most important, thought
to discuss.

## What Do I Get from Qulice?

As a programmer, I hope you already realize what you get from working
in a project that raises its quality bar as high as Qulice asks. Yes,
you'll learn [a lot]({% pst 2015/jan/2015-01-21-if-then-throw-else %}) of
[new things]({% pst 2014/nov/2014-11-03-empty-line-code-smell %})
about writing quality Java code.

{% quote You are getting free lessons with every new line of code you write %}

On top of that though, I would actually say that you are getting free lessons with every
new line of code you write. And the teacher is a software, written
by hundreds of Java developers, for the last ten years. Qulice just
integrates those software tools together. Truthfully, it is the developers who are the
real authors of quality checks and rules.

So, what do I tell those who complain about quality rules being too strict?
I say this: "Do you want to learn and improve, or do you just want to get paid
and get away with it?"

ps. You can use my [settings.jar](http://img.teamed.io/settings.jar)
for IntelliJ, they are rather strict and will help you clean your
code even before Qulice starts to complain.
