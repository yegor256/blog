---
layout: post
title: "A Chatbot Is Better Than a UI for a Microservice"
date: 2015-11-03
place: Seattle, WA
tags: java architecture
description: |
  Chatbot is a perfect alternative to a traditional
  user interface when dealing with a microservice
  and professional users.
keywords:
  - chatbot
  - chatbot in GitHub
  - chatbot java
  - chatbot architecture
  - chatbot user interface
social:
  - reddit: https://www.reddit.com/r/programming/comments/3reqsj/a_chatbot_is_better_than_a_ui_for_a_microservice/
---

A chatbot (or [chatterbot](https://en.wikipedia.org/wiki/Chatterbot), as Wikipedia says)
is a piece of software that talks to you in chat format.
[We](https://www.zerocracy.com) use chatbots in a few (micro)services, and they
fully **replace** user interfaces. I don't think there is any innovation
in this approach, but it has proved to be very effective over the last year or so.
That's the impetus for this post.
Here is how the [Rultor](https://www.rultor.com) chatbot works for
us and what its benefits are.

<!--more-->

Let me give an example first. Look at the
[jcabi/jcabi-http#115](https://github.com/jcabi/jcabi-http/issues/115)
GitHub ticket:

{% figure /images/2015/10/chatbot-1.png 600 %}

Let's see what's going on here, and then we'll discuss
how it's designed inside. Essentially, I'm **talking** to a chatbot here.
The name of the chatbot is `@rultor` (I wrote about it
[last year]({% pst 2014/jul/2014-07-24-rultor-automated-merging %})).
At <span class="bullet">1</span>, I'm asking the chatbot to release
a new version of the [jcabi-http](https://github.com/jcabi/jcabi-http) library.
At <span class="bullet">2</span>, the chatbot responds, just confirming
that the task is clear and that it's on it.
At <span class="bullet">3</span>, the bot says the job is
completed and its completion took nine minutes. Our conversation is over.
That's it.

{% youtube mHCwlZSlZeU %}

Now, what is so special about this?

One thing: There is no user interface. Well, there is
no **traditional** web-based HTML/CSS user interface. There is no
login, logout, profile, menu, or anything like this. Rultor is
a web service that has **no web UI**. The only way to
communicate with it is by talking with its chatbot.

What's so good about it? A few things.

## Service Is Not a Server

This is how the traditional architecture of a web system would look:

{% plantuml style="width:75%" %}
skinparam componentStyle uml2
User -> [Service]
[Service] -> [Database]
{% endplantuml %}

A user gives instructions to a service and receives responses.
This communication happens through a **user interface** (UI)---a bunch
of HTTP entry points that receive requests from a browser and return
HTML+CSS responses. Or, if a user is on another service, requests may
contain some data, and responses will be in
[XML or JSON]({% pst 2015/nov/2015-11-16-json-vs-xml %}). You get the idea;
a user is a client, and the service is a server.

{% youtube jUil-aTImgU %}

Like in a restaurant---you say what you want, and a **server** goes
to the kitchen, waits there, and in a few minutes, comes back with
spaghetti carbonara. You're a client, and that cute lady is a server.

In the case of a chatbot, that's not the case anymore. Look at the
architecture:

{% plantuml style="width:75%" %}
skinparam componentStyle uml2
User -up-> [GitHub]
[Service] -up-> [GitHub]
[Database] -up-> [Service]
{% endplantuml %}

First, a user posts a request to GitHub through a web user interface
provided by GitHub. It is a communication **hub** for us. Then, the service
connects to GitHub through its RESTful API and checks whether there
are any new requests there. If something new is found, the service
does the job, prepares a response, and posts it there. The client receives
an email notification about a new response just posted to the ticket. The
client then checks GitHub and finds the response.

{% badge /images/2015/11/bot-3.jpg 250 %}

Here is how this would look in a restaurant: There would be a board with sticky notes.
First, you write the note, "I'd like spaghetti carbonara
with parmesan and fresh pepper on top" (Damn, I'm just too hungry now), and
pin it to the board at number 15. Then, you return to your table. A chef from
the kitchen checks that board and finds your sticky note. He makes that
spaghetti, tops it with parmesan, fresh pepper, some basil leaves, and
virgin olive oil ... yeah, he makes it right ... and puts it next to the board.
You hear an announcement that order number 15 is ready. You go there,
collect the food, return to your table, and enjoy.

{% youtube Xj226o2xI9Y %}

The point is that there is **no cute lady** involved anymore. There is no
server. There are two parties communicating with the board---you and
the kitchen. The kitchen is our microservice, but it's not a server anymore.

These two parties are perfectly **decoupled** now. They never talk to each other. And
they both are **clients** of the communication hub, which is GitHub or
a board in the restaurant.

Again, the microservice is **not a server** anymore.
Instead, it is a client of a communication hub. And the flip of its position
provides a lot of benefits to us, its developers.

## No Need to Be Fast

{% badge /images/2015/11/bot-5.jpg 250 %}

First of all, we don't need to care much about the performance of our
UI. Well, we don't care at all, since we don't have a UI. Do we care
about the **speed** of responses on GitHub? Not really. When a user posts
a message to GitHub, he or she doesn't expect our chatbot to give an
immediate answer in less than 100 milliseconds. (That's what any properly
designed web system must guarantee, I believe.)

We put a note on the board, and we assume that the kitchen is probably
doing something else at the moment. We'll wait for a few seconds or even minutes.
If, on the other hand, I give an order to the waitress and she waits five seconds
before replying back, I'll be very surprised. If she keeps doing
that with every question, I'll start to wonder to myself if everything is OK with her.

{% youtube vOMqDcSXnT0 %}

I expect a user interface to be instant, while in a chat I have no problem
allowing some time for the bot to answer. This happens **naturally**. We're
used to delays in chats, when we're talking with real people. They need some
time to process our information, to think, and to type something back.

But a user interface doesn't have that luxury. It has to be bullet-fast;
otherwise, I immediately get frustrated. The same thing happens to you, right?

## No Need to Look Cute

{% badge /images/2015/11/bot-4.jpg 250 %}

Another advantage of this no-server design is that there is no need
to look pretty. There is no web interface, no HTML, no CSS,
**no graphic design**. Perhaps not everybody really likes that.
Most non-professional users may still prefer to talk to a cute server
instead of sticking some paper notes to the board.
But if we're dealing with professional
computer engineers, they're not that demanding.

Rultor doesn't have any web UI, and its users simply don't know how
it "looks." It just **talks** to you. The only thing you see is its
avatar in GitHub.

This saves a lot of money and time on design efforts, which are usually
very expensive if you aim for high quality. If your
web service looks **average**, most of its users will assume that it
also works average. Many good ideas have simply died because their
UI wasn't as impressive as people were used to, thanks to all those
Pinterests and Instagrams.

A good-looking server has a greater chance for **bigger tips**, right?
If there is no server and we don't see the chef, we judge him or her
only by the **quality** of the food.

Same here. By getting rid of a UI, we allow ourselves to focus on the
quality of the service we're delivering. We don't burn our time and money
on being **nice**. We spend them on being **useful**.

## Much Easier to Scale

{% badge /images/2015/11/bot-6.jpg 250 %}

If we have too many stickies on that board, we just hire more cooks,
or maybe even build another kitchen, and the problem is solved.
We can handle as many customers as necessary.
Well, as long as the board is powerful enough to handle multiple parallel users.

GitHub is a pretty big platform, with hundreds of thousands of users
and projects. If we have too many requests coming in, we can just
add more processing nodes to Rultor. Remember, we're not a server anymore;
we are a **client of GitHub**. We decide when to connect to GitHub and when
to create responses to the requests submitted.

It is much easier to create a scalable client than a scalable server, mostly
because there is nobody really waiting for us to respond quickly. The
load of requests we're getting can be managed much easier, since the
decision of when to process them is made by us.

## Mistakes Are Not So Visible

{% badge /images/2015/11/bot-2.jpg 250 %}

When you're standing in front of a customer, most of your mistakes
are unforgivable, primarily because they are very visible. On the other
hand, when you're cooking something in the kitchen, nobody can see
you and spot your faults. They will only spot them if the spaghetti
has too much salt. In other words, they will **judge** you by your **results**,
not by how you produce them.

It's the same story with the microservice. When it works as a server, we expect
it to be seamless, respond immediately, and present everything in a
structured and organized way. If something goes wrong, it's right here
on the web page. Your best case is a 404, while the worst one is that you
present some wrong information to the user. Even though the bug may not
be critical inside the microservice engine, the user doesn't know that.
The user will judge you by your appearance and won't forget even small
mistakes.

However, when you both are clients of a message board, you don't see
each other. The user communicates with GitHub, and the microservice
interacts with GitHub. Mistakes are less visible. Trust me, we have
had **many of them** over the 18 months that Rultor has been in public use.
We've had downtimes, we've had serious logical mistakes, and we've had data corruption.
But very rarely have these problems become visible online. We merely saw them
in our server logs. Users didn't see them. Well, mostly :)

## Everything Is Traceable

{% badge /images/2015/11/bot-1.jpg 250 %}

Since there is a communication board between us, it's very easy
to see the entire history of our discussion, which is very intuitive.
It's like a Slack chat history. You see what we started from,
who said what, and which conclusions were made.

Basically, you can't have that visibility in a web UI. Well, you can
probably create a special page with the "history of operations," but
who would check it? And how visible and simple would that information be?
And, what's most important, how would that information match up
with the UI?

In the log, you'll state that "the build was started," but
what's the build and how was it started? How can I start it again?
Using which buttons and web controls? It's not clear.

Thus, the traceability of a **chronological** chat is unbeatable.

## Easy to Integrate With Other Services

Yes, think about the future of this approach. If there is a centralized
message board where users talk to a chatbot, why can't other chatbots
talk to each other too?

Forget about RESTful APIs. Just a message board where chatbots post
their requests and collect responses. They are perfectly decoupled, replaceable,
and very scalable. Also, their communication protocol is visible and very
traceable. And they boast many other benefits, as was just explained above. It's much
more convenient for us, both users and programmers, to monitor them and
create them.

Well, maybe it's too extreme to get rid of RESTful APIs entirely, but
to some extent, this approach is feasible, I believe.

I didn't go too far with this idea, but something was done. We have
a messaging platform that allows multiple chatbots to communicate
with users. It's called [Netbout](http://www.netbout.com). It's a very
primitive web system with isolated discussions. Simply put, anyone
can create a new discussion, invite a few friends, and post messages there.
Both users and chatbots can do that.

So, when a new candidate wants to join [Zerocracy](https://www.zerocracy.com),
we ask that person to fill out an [online form](https://www.0crat.com/join). When
the candidate clicks the "Submit" button, a new discussion starts, and the first
chatbot decides who should [interview]({% pst 2016/mar/2016-03-01-how-we-interview-programmers %})
that person. The decision is made
according to the skills listed in the form. The chatbot invites one of our
[best programmers](http://www.teamed.io/#check-out-ourbest-developers)
to conduct the interview. When the interview is done, another chatbot explains to
the candidate what the next steps are, registers him or her in our
database, and starts to show the progress of work.

From a user perspective, it looks like he or she is talking to a few
people who understand just a few simple commands. It is very intuitive
and was easy to design.

I think chatbots are a good approach for interacting with microservices.
Especially when users are more or less professional.

PS. Illustrations by [Kristina Wheat](https://www.behance.net/wheeat).
