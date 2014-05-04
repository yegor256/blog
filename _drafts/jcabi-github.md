---
layout: post
title: "Object-Oriented Github API"
date: 2014-04-19
tags: github jcabi
description:
  Since none of the existing Java APIs are truly
  object-oriented we decided to create a new one
  with the best principles of OOP in mind
keywords:
  - github api
  - github java api
  - github object oriented java api
  - best github java api
  - java api github
---

{% badge http://img.yegor256.com/2014/05/github-logo.png 128 %}

[Github](http://www.github.com)
is an awesome platform for maintaining Git sources and
to track project issues. I moved all my projects (both private and public)
there about three years ago, and have no regrets. Moreover, Github
gives access to almost all of its features through RESTful JSON API.

There are [a few](https://developer.github.com/libraries/)
Java SDKs that wrap and expose the API. I tried to use them, but
faced a number of issues:

 * They are not really object-oriented, even though one of them says so

 * They are not based on JSR-353 (JSON Java API)

 * They provide no mocking instruments

{% badge http://img.jcabi.com/logo-square.png 64 %}

Having in mind all that drawbacks, I created my own library &mdash;
[jcabi-github](http://github.jcabi.com). Look at its most important
advantages.

## Object Oriented for Real

True

## Mock Engine

MiGithub class is a mock version of a Github server. It behaves almost
exactly the same as a real server, and is a perfect instrument for unit
testing. For example, you're testing a method that is supposed to
post a new issue to Github and add a message into it. Here is how
a unit test will look like:

{% highlight java %}
public class FooTest {
  @Test
  public void createsIssueAndPostsMessage() {
    Github github = new MkGithub("jeff");
    github.repos().create(
      Json.createObjectBuilder().add("name", owner).build()
    );
    new Foo().doTheThing(github);
    MatcherAssert.assertThat(
      github.issues().get(1).comments().iterate(),
      Matchers.not(Matchers.emptyIterable())
    );
  }
}
{% endhighlight %}

This is much more convenient and compact than traditional mocking
via Mockito or something similar.

## Immutable

All classes are truly immutable and annotated with
[`@Immutable`](http://aspects.jcabi.com/annotation-immutable.html). This
may sound like a minor benefit, but it was very important for me. I'm using
this annotation in all projects, in order to make sure my classes are
truely immutable.

## Version 0.8

A few days ago we released the latest
[version 0.8](https://github.com/jcabi/jcabi-github/releases/tag/jcabi-0.8). It is
a major release, that included over 1200 commits. It covers the entire Github
API and is supposed to be very stable.

The library ships as a JAR dependency in [Maven
Central](http://repo1.maven.org/maven2/com/jcabi/jcabi-github):

{% highlight xml %}
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-github</artifactId>
  <version><!-- check http://github.jcabi.com --></version>
</dependency>
{% endhighlight %}
