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

{% badge http://img.jcabi.com/logo-square.svg 64 http://http.jcabi.com %}

Email sending in Java is painful and Apache Commons Email
doesn't help at all since it is purely procedural:

{% highlight java %}
Email email = new SimpleEmail();
email.setHostName("smtp.googlemail.com");
email.setSmtpPort(465);
email.setAuthenticator(new DefaultAuthenticator("x", "y"));
email.setFrom("user@gmail.com");
email.setSubject("test email");
email.setMsg("This is a test mail ... :-)");
email.addTo("foo@bar.com");
email.send();
{% endhighlight %}

Here is how you do the same with [jcabi-email](http://email.jcabi.com):

{% highlight java %}
{% endhighlight %}

<!--more-->

## Enclosure in LaTeX

## Filtering Postman (without recipients)
