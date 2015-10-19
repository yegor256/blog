---
layout: post
title: "Chatbot is a Perfect UI for a Microservice"
date: 2015-10-27
place: Palo Alto, CA
tags: java architecture
description:
  Chatbot is a perfect alternative to a traditional
  user interface, when dealing with a microservice
  and professional users
keywords:
  - chatbot
  - chatbot in Github
  - chatbot java
  - chatbot architecture
  - chatbot user interface
---

Chatbot (or [chatterbot](https://en.wikipedia.org/wiki/Chatterbot), as Wikipedia says)
is a piece of software that talks to you, in some chat.
We're using chatbots in a few microservices and they
fully replace user interfaces. I don't think there is any innovation
in this approach, but it proved to be very effective, over the last year or so.
That's why this post.
Here is how [Rultor](http://www.rultor.com) chatbot works for us and what are the benefits.

<!--more-->

Let me give an example first. Look at
[jcabi/jcabi-http#115](https://github.com/jcabi/jcabi-http/issues/115)
GitHub ticket:

{% figure /images/2015/10/chatbot-1.jpg 600 %}

<style>
.bullet {
  display: inline-block;
  border-radius: 50%;
  color: #c22e12;
  font-size: 0.8em;
  background-color: #ffb800;
  padding: .2em;
  font-weight: bold;
  width: 1em;
  height: 1em;
  line-height: 1em;
  text-align: center;
  vertical-align: middle;
}
</style>

Let me explain what's going on here and then we'll discuss
how it's designed inside. Essentially, I'm talking to a chatbot here.
The name of the chatbot is `rultor` (I wrote about it
[last year]({% pst 2014/jul/2014-07-24-rultor-automated-merging %})).
At <span class="bullet">1</span> I'm asking chatbot to release
a new version of [jcabi-http](https://github.com/jcabi/jcabi-http) library.
At <span class="bullet">2</span> the chatbot responds, just confirming
that the task is clear and it is on it.
At <span class="bullet">3</span> the bot says that the job is
completed and its completion took nine minutes. Our conversation is over.
That's it.

Now, what is so special about it? A lot.

## No Web UI

First of all, Rultor doesn't have a traditional user interface, where
you can login, create a profile, click some buttons, and perform
some operations. Rultor.com is a web service that runs 24x7 on Heroku,
but it doesn't have a UI.

Here is
