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
["Getters/Setters. Evil. Period."]({% pst 2014/sep/2014-09-16-getters-and-setters-are-evil %}),
["Objects Should Be Immutable"]({% pst 2014/jun/2014-06-09-objects-should-be-immutable %}), and
["Dependency Injection Containers are Code Polluters"]({% pst 2014/oct/2014-10-03-di-containers-are-evil %}),
I universally labelled all mutable objects with "setters" (object methods starting with `set`) evil.
My argumentation was based mostly on metaphors and abstract examples. Apparently,
this wasn't conviencing enough for many of you &mdash; I received a few requests
asking to provide more specific and practical examples.

Thus, in order to illustrate my strongly negative attitude to "mutability via setters", I took
an existing [commons-email](http://commons.apache.org/proper/commons-email/) Java library from Apache
and re-designed it my way, without setters and with an "object thinking" in mind.
I released my library as part of [jcabi](http://www.jcabi.com) family
&mdash; [jcabi-email](http://email.jcabi.com). Let's see what benefits
do we get from a "pure" object-oriented and immutable approach, without getters.

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
Envelope envelope = new Envelope.MIME()
  .with(new StSender("Yegor Bugayenko <yegor@teamed.io>"))
  .with(new StRecipient("dude@jcabi.com"))
  .with(new StSubject("how are you?"))
  .with(new EnPlain("Dude, how are you?"));
postman.send(envelope);
{% endhighlight %}

I think it's obvious what is the difference.

In the first example, you're
dealing with a monster class that can do everything for you, including
sending your MIME message via SMTP, creating the message, configuring
its parameters, adding MIME parts to it, etc. The
[`Email`](http://svn.apache.org/viewvc/commons/proper/email/tags/EMAIL_1_3_3/src/main/java/org/apache/commons/mail/Email.java?revision=1609295&view=co)
class from commons-email is really a huge class &mdash; 33 private properties, over
a hundred methods, about two thousands lines of code. First, you configure
the class through a bunch of setters and then you ask it to `send()`
an email for you.

In the second example, we have seven objects instantiated via seven `new` calls.
`Postman` is responsible for packaging a MIME message; `SMTP` is
responsible for sending it via SMTP; stamps (`StSender`, `StRecipient`,
and `StSubject`) are responsible for configuring the MIME message before
delivery; enclosure `EnPlain` is responsible for creating a MIME part
for the message we're going to send. We construct these seven objects,
encapsulating one into another, and then we ask the postman to `send()`
the envelope for us.



1. it is bad because it is big
2. it's possible to make it right
3. there is no motivation to make it right
4. immutability will force you to do it right

##


## Enclosure in LaTeX

## Filtering Postman (without recipients)
