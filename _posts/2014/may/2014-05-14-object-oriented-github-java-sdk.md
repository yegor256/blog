---
layout: post
title: "Object-Oriented GitHub API"
date: 2014-05-14
tags: github jcabi
description: |
  Since none of the existing Java API-s are truly object-oriented
  or elegant enough for our quality standards, we
  decided to create a new one with the best principles of OOP in mind.
keywords:
  - github api
  - github java api
  - github object oriented java api
  - best github java api
  - java api github
  - java github api
  - object oriented github java api
  - java api design
---

{% badge /images/2014/05/github-logo.png 128 %}

[GitHub](http://www.github.com) is an awesome platform for maintaining Git sources and
tracking project issues. I moved all my projects (both private and public)
to GitHub about three years ago and have no regrets. Moreover,
GitHub gives access to almost all of its features through RESTful JSON API.

There are [a few](https://developer.github.com/libraries/)
Java SDK-s that wrap and expose the API. I tried to use them,
but faced a number of issues:

 * They are not really object-oriented (even though one of them has a description that says it is)
 * They are not based on JSR-353 (JSON Java API)
 * They provide no mocking instruments
 * They don't cover the entire API and can't be extended

{% badge https://www.jcabi.com/logo-square.svg 64 %}

Keeping in mind all those drawbacks, I created my
own library---[jcabi-github](http://github.jcabi.com).
Let's look at its most important advantages.

<!--more-->

## Object Oriented for Real

GitHub server is an object. A collection of issues is an object,
an individual issue is an object, its author is an author, etc.
For example, to retrieve the name of the author we use:

```java
GitHub github = new RtGitHub(/* credentials */);
Repos repos = github.repos();
Repo repo = repos.get(new Coordinates.Simple("jcabi/jcabi-github"));
Issues issues = github.issues();
Issue issue = issues.get(123);
User author = new Issue.Smart(issue).author();
System.out.println(author.name());
```

Needless to say, `GitHub`, `Repos`, `Repo`, `Issues`, `Issue`,
and `User` are interfaces. Classes that implement them are not visible in the library.

## Mock Engine

`MkGitHub` class is a mock version of a GitHub server. It behaves
almost exactly the same as a real server and is the perfect
instrument for unit testing. For example, say that you're
testing a method that is supposed to post a new issue to GitHub
and add a message into it. Here is how the unit test would look:

```java
public class FooTest {
  @Test
  public void createsIssueAndPostsMessage() {
    GitHub github = new MkGitHub("jeff");
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
```

This is much more convenient and compact than traditional
mocking via [Mockito](https://code.google.com/p/mockito/) or a similar framework.

## Extensible

It is based on JSR-353 and uses `jcabi-http` for HTTP request
processing. This combination makes it highly customizable and extensible,
when some GitHub feature is not covered by the library (and there are many of them).

For example, you want to get the value of `hireable` attribute of a `User`.
Class `User.Smart` doesn't have a method for it. So, here is how you would get it:

```java
User user = // get it somewhere
// name() method exists in User.Smart, let's use it
System.out.println(new User.Smart(user).name());
// there is no hireable() method there
System.out.println(user.json().getString("hireable"));
```

We're using method `json()` that returns an instance of
[`JsonObject`](http://docs.oracle.com/javaee/7/api/javax/json/JsonObject.html)
from JSR-353 (part of Java7).

No other library allows such direct access to JSON objects
returned by the GitHub server.

Let's see another example. Say, you want to use some feature
from GitHub that is not covered by the API. You get a `Request`
object from `GitHub` interface and directly access the HTTP entry point of the server:

```java
GitHub github = new RtGitHub(oauthKey);
int found = github.entry()
  .uri().path("/search/repositories").back()
  .method(Request.GET)
  .as(JsonResponse.class)
  .getJsonObject()
  .getNumber("total_count")
  .intValue();
```

[jcabi-http](http://http.jcabi.com) HTTP client is used by [jcabi-github](http://github.jcabi.com).

## Immutable

All classes are truly immutable and annotated with
[`@Immutable`](http://aspects.jcabi.com/annotation-immutable.html).
This may sound like a minor benefit, but it was very important for me.
I'm using this annotation in all my projects to ensure my classes are truly immutable.

## Version 0.8

A few days ago we released the latest [version 0.8](https://github.com/jcabi/jcabi-github/releases/tag/jcabi-0.8).
It is a major release, that included over 1200 commits. It covers the entire GitHub API and is
supposed to be very stable.
The library ships as a JAR dependency in [Maven Central](https://repo1.maven.org/maven2/com/jcabi/jcabi-github)
(get its latest versions in [Maven Central](http://search.maven.org/)):

```xml
<dependency>
  <groupId>com.jcabi</groupId>
  <artifactId>jcabi-github</artifactId>
</dependency>
```
