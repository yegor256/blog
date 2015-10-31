---
layout: post
title: "Chatbot is Better Than UI, for a Microservice"
date: 2015-10-27
place: Seattle, WA
tags: java architecture
description:
  Chatbot is a perfect alternative to a traditional
  user interface, when dealing with a microservice
  and professional users.
keywords:
  - chatbot
  - chatbot in Github
  - chatbot java
  - chatbot architecture
  - chatbot user interface
---

Chatbot (or [chatterbot](https://en.wikipedia.org/wiki/Chatterbot), as Wikipedia says)
is a piece of software that talks to you, in some chat.
[We](http://www.teamed.io) are using chatbots in a few (micro-)services and they
fully replace user interfaces. I don't think there is any innovation
in this approach, but it proved to be very effective, over the last year or so.
That's why this post.
Here is how [Rultor](http://www.rultor.com) chatbot works for
us and what are the benefits.

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

Let's see what's going on here and then we'll discuss
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

Now, what is so special about it?

One thing &mdash; there is no user interface. Well, there is
no **traditional** web-based HTML/CSS user interface. There is no
login, logout, profile, menu, or anything like this. Rultor is
a web service that has **no web UI**. The only way to
communicate with it is by talking with its chatbot.

What's so good about it? A few things.

## Service Is Not a Server

This how a traditional architecture of a web system would look:

{% plantuml %}
skinparam componentStyle uml2
User -> [Service]
[Service] -> [Database]
{% endplantuml %}

A user is giving instructions to a service and receives responses.
This communication is happening through a user interface &mdash; a bunch
of HTTP entry points receiving requests from a browser and returning
HTML+CSS responses. Or, if a user is another service, requests may
contain some data and responses will be in XML or JSON. You got the idea,
a user is a client and the service is a server.

Like in a restaurant &mdash; you say what you want and a server goes
to the kitchen, waits there, and, in a few minutes, comes back with
spaghetti carbonara. You're a client and that cute lady is a server.

In case of a chatbot it's not the case any more. Look at the
architecture:

{% plantuml %}
skinparam componentStyle uml2
[GitHub] -left-> User
[GitHub] -right-> [Service]
[Service] -right-> [Database]
{% endplantuml %}

First, a user posts a requests to GitHub, though a web user interface
provided by GitHub. It is a communication hub for us. Then, the service
connects to GitHub through their RESTful API and checks whether there
are any new requests there. If something new is found, the service
does the job, prepares a response and posts it there. The client receives
an email notification about a new response just posted into the ticket. The
client checks GitHub and finds the response.

Here is how this would look in a restaurant. There would be a board with stickers.
First, you write a sticker note "I'd like spaghetti carbonara,
with parmesan and fresh pepper on top" (damn, I'm just too hungry now) and
pin it to the board at number 15. Then, you return to your table. A chef from
the kitchen checks that board and finds your sticker note. He makes that
spaghetti, tops it with parmesan, fresh pepper, some basil leafs and
virgin olive oil... yeah, he makes it right... and puts it next to the board.
You hear an announcement that the order number 15 is ready. You go there,
collect the food, return to your table and enjoy.

The point is that there is no cute lady involved any more. There is no
server. There are two parties communicating with the board &mdash; you and
the kitchen. The kitchen is our microservice, but it's not a server any more.

These two parties are perfectly decoupled now. They never talk to each other. And
they both are **clients** of the communication hub, which is GitHub or
a board in the restaurant.

Again, the microservice is **not a server** any more.
Instead, it is a client of a communication hub. And this flip of its position
gives a lot of benefits to us, its developers.

## No Need To Be Fast

First of all, we don't need to care much about the performance of our
UI. Well, we don't care at all, since we don't have a UI. Do we care
about the **speed** of responses on GitHub? Not really. When a user posts
a message to GitHub, he or she doesn't expect our chatbot to give an
immediate answer in less than 100 milliseconds (that's what any properly
designed web system must guarantee, I believe).

We put a sticker on the board and we understand that the kitchen is probably
doing something else at the moment. We'll wait for a few seconds or even minutes.
While, if I give an order to the waitress, and she waits five seconds
before replying back &mdash; I will be very surprised. If she keeps doing
it on every question, I will question myself whether everything is OK with her.

I expect a user interface to be instant, while in a chat I have no problem
with giving some time to the bot to answer. This happens **naturally**. We're
used to delays in chats, when we're talking with real people. They need some
time to process our information, to think, to type something back.

But a user interface doesn't have that luxury. It has to be bullet fast,
otherwise I immediately get frustrated. Same happens to you, right?

## No Need To Look Cute

Another advantage of this no-server design is that there is no need
to look pretty. There is no web interface, no HTML, no CSS,
**no graphic design**. Maybe, not everybody really like that.
Most non-professional users may still prefer to talk to a cute server,
instead of sticking some paper notes to the board.
But if we're dealing with professional
computer engineers, they are not that demanding.

Rultor doesn't have any web UI and its users simply don't know how
it "looks". It just **talks** to you. The only thing you see is its
avatar in GitHub.

This saves a lot of money and time on design efforts, which, usually,
are very expensive if you really aim for high quality. If your
web service looks **average**, most of its users will assume that it
also works average. Many good ideas simply died because their
UI was not as impressive as people are used to, thanks to all that
"pinterests and instagrams".

A good looking server has a higher chance for **bigger tips**, right?
If there is no server and don't see the chef &mdash; we judge him or her
only by the **quality** of the food.

Same here. By getting rid of a UI we allow ourselves to focus on
quality of the service we're delivering. We don't burn our time and money
on being **nice**. We spend them on being **useful**.

## Much Easier To Be Scalable

If we have too many stickers on that board, we just hire more cooks,
or maybe even build yet another kitchen and the problem is solved.
We can handle as many customers as necessary.
Well, as long as the board is powerful enough to handle multiple parallel users.

GitHub is a pretty big platform, with hundreds of thousands of users
and projects. If we have too many requests coming in, we can just
add more processing nodes to Rultor. Remember, we're not a server any more,
we are a client of GitHub. We decide when to connect to GitHub and when
to create responses to the requests submitted.

It is much easier to create a scalable client than a scalable server. Mostly
because there is nobody really waiting for us to be fast in response. The
load of requests we're getting can be managed much easier, since the
decision of when to process them is made by us.

## Mistakes Are Not So Visible

When you're standing in front of a customer, most of your mistakes
are unforgivable, mostly because they are very visible. On the other
hand, when you're cooking something in the kitchen, nobody can see
you and spot your faults. They will only spot them if the spaghetti
have too much salt. In other words, they will judge you by your results,
not by how you produce them.

The same story with the microservice. When it works as a server, we expect
it to be seamless, respond immediately, and present everything in a
structured and organized way. If something goes wrong, it's right here
on the web page. In the best case it's 404, in the worst one &mdash; you
present some wrong information to the user. Even though the bug may not
be critical inside the microservice engine, the user doesn't know that.
The user will judge you by your appearance, and won't forget even small
mistakes.

However, when you both are clients of a message board, you don't see
each other. The user communicates with GitHub and the microservice
interacts with GitHub. Mistakes are less visible. Trust me, we have
had many of them over the last 18 months of Rultor being in public use.
We had downtimes, we had serious logical mistakes, we had data corruption.
But very rarely these problems became visible online. We just saw them
in our server logs. Users didn't see them. Well, mostly.

## Everything Is Traceable

Since there is a communication board between us, it's very easy
to see the entire history of discussion, which is very intuitive.
It's like a Slack chat history. You see what did we start from,
who said what and what conclusions were made.

You basically can't have that visibility in a web UI. Well, you can
probably create a special page with "history of operations", but
who will check it? And how visible and simple that information will be?
And, what is the most important, how that information will match
with the UI?

In the log you will say that "the build was started", but
what is the build and how was is started? How can I start it again?
Using which buttons and web controls? It's not clear.

Thus, traceability of a chronological chat is unbeatable.

## Easy To Integrate With Other Services

Yes, think about the future of this approach. If there is a centralized
messaging board, where users talk to a chatbot, why other chatbots
can't talk to each other too?

Forget about RESTful APIs. Just a messaging board, where chatbots post
their requests and collect responses. They are perfectly decoupled, replaceable
and very scalable. Also, their communication protocol is visible and very
traceable. And many other benefits, just explained above. It's much
more convenient for us, users and programmers, to monitor them and
to create them.

Well, maybe it's too extreme to get rid of RESTful APIs entirely, but
to some extend this approach is feasible, I believe.

I didn't go too far in this idea, but something was done. We have
a messaging platform, which allows multiple chatbots to communicate
with users. It's called [Netbout](http://www.netbout.com). It's a very
primitive web system, with isolated discussions. Simply put, anyone
can create a new discussion, invite a few friends and post messages there.
Both users and chatbots can do that.

So, when a new candidate wants to join [Teamed.io](http://www.teamed.io),
we ask that person to fill an [online form](http://www.teamed.io/join.html). When
the candidate clicks "Submit" button, a new discussion starts and the first
chatbot decides who should interview that person. The decision is made
by the skills listed in the form. The chatbot invites one of our
[best programmers](http://www.teamed.io/#check-out-ourbest-developers)
to do the interview. When interview is done, another chatbot explains
the candidate what are the next steps, registers him or her in our
database and starts to show the progress of work.

From a user perspective it looks like he or she is talking to a few
people that understand just a few simple commands. It is very intuitive
and was easy to design.

I think, chatbots is a good approach for interacting with microservices.
Especially when users are more or less professional.
