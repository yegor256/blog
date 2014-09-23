---
layout: post
title: "Publishing to Google Play"
date: 2014-09-25
tags: android rultor devops
description:
  Mocking frameworks is not a good practice and should be your last resort;
  instead, create and ship mock classes together with your code.
keywords:
  - release to google play
  - publish to google play
---

## Create Account and Pay

Create and account in [Google Play Developer Console](http://play.google.com/apps/publish)
and pay $25 for registration.

## Add Jar Signer Maven Plugin

...

## Create a Keystore

{% highlight bash %}
keytool -v -genkey -v -keystore a.keystore -alias a -keysize 2048 -keyalg RSA -validity 10000
{% endhighlight %}

