---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "The Joy of Programming"
date: 2019-07-30
place: Moscow, Russia
tags: mood
description: |
  If I don't understand the logic of my code down to its
  lowest level, I feel depressed and don't get any joy
  out of my work; I do want to know what's inside!
keywords:
  - complexity
  - complexity of code
  - spring framework
  - depression programmer
  - programmer depression
image: /images/2019/07/boardwalk-empire.jpg
jb_picture:
  caption: Boardwalk Empire (2010–2014) by Terence Winter
---

Yesterday I was working with a slide deck for one of my future talks about
Java and object-oriented programming and got stuck at finding convincing
arguments for the _transparency of logic_. I was going to say that it is
important for programmers to be able to understand how everything they do
works, even if they don't see it or never want to see it. But then I realized
that maybe not everybody thinks that way. Maybe some programmers prefer
to stay in the dark about the majority of things,
as long as the code in front of them "just works." Hence this blog post,
to ask you which side you are on.

<!--more-->

{% jb_picture_body %}

Many years ago I was at a job interview as a candidate. They were looking for
a web architect and I was talking to their CTO. He asked me to explain what
happens behind the scenes when we enter a new URL in a web browser and hit "Enter".
I drew him a small diagram with a domain registrar, a few DNS servers,
a load balancer, a few HTTP servers, a few databases, and a few IP relays in the
middle. I believe he was impressed by the answer (even though they didn't hire me back then)
and told me that the majority of web developers didn't understand
most of this picture. According to him, they only knew how HTTP servers worked,
caring very little about the rest. Most of them didn't even know what HTTP was,
as long as the PHP code did what it was intended to.

{% youtube 5FckPa6aOok %}

I remembered that interview, and started asking similar questions to people I was interviewing
later, being a CTO of my own company and an architect on a few other projects.
His conclusions were confirmed. Indeed, most programmers don't understand how, for example,
DNS works nor what it's for. Moreover, they feel just fine without this information.
Does it mean they are bad programmers?

Let me tell you another story, which just happened to me a few days ago. I was
solving a pretty complex technical problem, trying to integrate software
I hadn't had a chance to use before with another piece of software I also hadn't
seen before. It took three full days of work. Now I'm looking back at this
short journey and realizing that I went through a few particular phases, which are always
the same for me when I start working with something new:

  * **Enthusiasm**.
    Here I start quickly, usually from a Quick Start one-pager of the
    new library I'm going to use. I skim through the documentation, ignore
    the majority of it, since it doesn't make any sense, and quickly
    copy-paste what they recommend. It all seems easy and I'm expecting
    the code to work in a few minutes. And usually it does.

  * **Guessing**.
    I start making changes to the simple code I just copy-pasted and I make
    some assumptions about the logic behind it. I don't know how the products
    I'm using are designed, but I need to rely on something. So, I rely
    on what I can _guess_.

  * **Frustration**.
    Obviously, most of my assumptions are wrong. I start googling
    and stackoverflowing. The answers I get (if I get any) are not helping
    much, since the big picture is still missing and the best I can do
    is patch my code to make it work, according to the pieces of advice
    I'm getting from random sources. But I keep staying in the dark
    and the overall design concept is still not clear. And I'm still hoping
    to solve it all without reading the full Developers Manual manuscript.

  * **Depression**.
    Very soon I realize that I'm just a monkey trying to start an aircraft.
    Maybe it will fly and maybe I will even manage to land it. But I'm still
    a monkey and it's very depressing. I have no joy in doing this. I hate
    myself for being stupid. I hate those library creators for making it
    so not obvious to use. And I hate my job.

I believe these four phases are very common for all of us software engineers.
However, what happens afterwards distinguishes good programmers from bad ones. To be
honest, I belong to both categories, depending on the situation. What
do I do when I'm being a bad programmer? I make it all work and call it a day, still
with no idea what is going on inside nor why exactly it works this way
and doesn't work the way I tried before. My depression doesn't go anywhere.
It only escalates. I still hate myself, but my software works. I move
on to the next problem, waiting for the weekend to come.

What do I do when I'm a good programmer? I dive deeper into the problem,
learn the software I use, download its source code, read its documentation,
until I _understand_ what's going on. Then, I get back to my part of the code,
fix it with a full understanding, and call it a day. I sometimes even
write a blog post about it, like
this one for [Nutch]({% pst 2019/apr/2019-04-17-nutch-from-java %}),
this one about [Liquibase]({% pst 2014/jul/2014-07-20-liquibase-in-maven %}),
or this one about [CasperJS]({% pst 2014/jun/2014-06-21-casperjs-with-maven %}).
My depression completely goes away. I don't hate myself anymore, don't hate
my job, and don't hate the developers of those "stupid" libraries. I even
help their projects with my blog posts.

How do I decide which way to choose: to behave like a bad programmer
or like a good one? You may think it depends on the time/budget I have
for the job at hand, but you would be wrong. It totally depends on my
_readiness_ to live in depression.

{% quote I don't want to be a monkey flying an aircraft. I want to be a pilot. %}

Some time ago I told myself that I won't do it anymore. I don't want to be
a _monkey_ flying an aircraft. I want to be a _pilot_. Of course, the learning
curve will be longer, but the result is ... joy. I do enjoy my work when I clearly
and transparently see the logic of every line of code I write. I know exactly
why I write them, what they do, and what will happen if I change them. I don't
know all the details, of course, I know where to click in order to find those
details. This is what makes my work fun for me: the transparency of my
coding logic.

I truly enjoy being in charge of everything my code does. I love to feel that it
does exactly what I want it to do. You may say I'm a control freak---maybe so.
But this is where I've been getting most of the fun, over the last 30 years of coding:
seeing computers do what I want. If some libraries try to take this away from me, putting
me in the passenger's seat, I will do everything I can to get back in the
driving seat. I want to know what's going on and I want this to happen according
to my will. I want to enjoy my work.

Now, back to my conference talk. I'm going to show this piece of code in one of my slides
(this is how [Spring Framework](https://spring.io/) is supposed to be used):

```java
@Controller
public class HelloController {
    @GetMapping("/hello")
    public String handle(Model model) {
        model.addAttribute("message", "Hello World!");
        return "index";
    }
}
```

Then I will ask a question: Do you know who is making an instance of the `HelloController`
class and how that instance is being used? Who is calling its methods, why
and when? Moreover, do you know how to modify that behavior? My point
at the conference will be that a good framework must make it easier for
its users to understand its _internals_. Because good programmers do want
to know what's inside. Bad programmers, on the other hand, are OK with
being aircraft-flying monkeys.

What about you?
