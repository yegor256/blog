---
layout: post
title: "Object-Oriented Email Sending SDK"
date: 2014-10-28
tags: jcabi java
description:
  jcabi-email is a compact object-oriented email sending SDK
  for Java, which is highly flexible, testable and extendable
keywords:
  - email sending java
  - java email send
  - java send email html
  - java email api
  - java email send sdk
---

In a few recent posts, including
["Getters/Setters. Evil. Period."]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}) and
["Dependency Injection Containers are Code Polluters"]({% pst 2014/oct/2014-10-03-di-containers-are-evil %}),
I universally labelled all setters (object methods starting with `set`) evil.
My argumentation was based mostly on metaphors and abstract examples. Apparently,
this wasn't conviencing enough for many of you &mdash; I received a few requests
asking to provide more specific and practical examples.

Thus, in order to illustrate my negative opinion about "setters", I took
an existing [commons-email](http://commons.apache.org/proper/commons-email/) Java library from Apache
and re-designed it my way, without setters and with an "object thinking" in mind.
I released my library as part of [jcabi family](http://www.jcabi.com)
&mdash; [jcabi-email](http://email.jcabi.com). Let's see what benefits
do we get from a pure object-oriented approach, without getters and setters.

<!--more-->

Here is how your code will look, if you send an email using commons-email:

{% highlight java %}
Email email = new SimpleEmail();
email.setHostName("smtp.googlemail.com");
email.setSmtpPort(465);
email.setAuthenticator(new DefaultAuthenticator("user", "pwd"));
email.setFrom("yegor@teamed.io", "Yegor Bugayenko");
email.setSubject("how are you?");
email.setMsg("Dude, how are you?");
email.addTo("dude@jcabi.com");
email.send();
{% endhighlight %}

{% badge http://img.jcabi.com/logo-square.svg 64 http://http.jcabi.com %}

Here is how you do the same with [jcabi-email](http://email.jcabi.com):

{% highlight java %}
Postman postman = new Postman.Default(
  new SMTP("smtp.googlemail.com", 465, "user", "pwd")
);
postman.send(
  new Envelope.MIME()
    .with(new StSender("Yegor Bugayenko <yegor@teamed.io>"))
    .with(new StRecipient("dude@jcabi.com"))
    .with(new StSubject("how are you?"))
    .with(new EnPlain("Dude, how are you?"))
);
{% endhighlight %}

Let's discuss why my approach is better.

## Separation of Concerns

First, we create an instance of class `SimpleEmail`. It extends an abstract
class `Email`. Let's take a closer look at it. There are 33 private
properties, 120 methods and 2000 lines of code.

## Enclosure in LaTeX

## Filtering Postman (without recipients)
