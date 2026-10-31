---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "It's Not a School!"
date: 2015-02-16
tags: management agile
description: |
  A project is not a school, and it shouldn't pay for our education; however,
  we want to learn while working on a project. Here is some simple
  advice on how to align our goals and project objectives.
keywords:
  - working and learning
  - working and learning at the same time
  - working and learning together
  - education at work
  - bug tracking
image: /images/2015/02/gi-jane.png
jb_picture:
  caption: G.I. Jane (1997) by Ridley Scott
---

At [Zerocracy](https://www.zerocracy.com), we work in distributed teams and
keep all our communications [in tickets]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %}).
Besides that, we [encourage]({% pst 2014/apr/2014-04-13-bugs-are-welcome %})
every developer on every project to
report bugs whenever he or she finds them. We even
[pay]({% pst 2014/apr/2014-04-17-how-xdsd-is-different %}) for each bug found.
Once in a while, I see bugs reported along these lines: "_Can someone explain
to me how to design this module?_" or even "_I haven't used this library before;
please help me get started_." My usual answer is, "_This is not a school; nobody
is going to teach you here!_" I realize this sounds
rather harsh to most developers who are just starting to work with us, so
here I'll try to illustrate why such an attitude makes sense and is beneficial to both
the programmers and the project.

Disclaimer: I'm talking about software _projects_ here, which PMBOK defines
as "_temporary_ endeavors undertaken to create unique
products, services, or results." If your team is engaged in
[continuous development]({% pst 2016/feb/2016-02-18-holacracy-autocracy %})
or maintenance of software, this concept may not be relevant.

<!--more-->

{% jb_picture_body %}

No matter how unpleasant this could be, let's face the reality:
each software project is a business, and we, the developers, are
its _resources_. Just like concrete, wood, and glass are the resources required
to build a house, which is also a business activity. No matter how much we think
about ourselves as a family having fun together and writing code because
we enjoy it, each business looks at it completely differently.

The project needs us to _produce_ classes, lines of code, methods, functions,
files, and features. Then, the project can convert them into happy customers,
which will give us something back---usually cash. Finally, the project will
share that cash among us,
[investors]({% pst 2015/dec/2015-12-16-investors-are-too-scared %}),
and the government.

{% youtube YBQoTZ-1X-o %}

A properly planned and managed project acquires the best resources its
budget can afford and then relies on their quality. A programmer who doesn't
have adequate skills or knowledge is an _unreliable resource_. Obviously,
no project would acquire such a resource from the start. However,
this weakness may be revealed in the middle of the project.

Say you're building a house and you contracted a plumber to install a
drainage system. When it's time to mount the equipment, he tells you
that he's never worked with it and doesn't know how to install it.
It was a risk, and it occurred. A good
[project manager]({% pst 2015/sep/2015-09-22-micromanagement %})
always has a fallback plan
or even a few of them. Obviously, the best option would be to contract _another_
plumber. The worst option would be to train the original one on the spot.

{% quote The goal of the project is to build a house, not to train a plumber %}

Wait, why is that so obvious? The plumber is a great guy. Yes, he doesn't know
how to work with this equipment, but that doesn't mean we should
[fire]({% pst 2015/sep/2015-09-16-how-to-fire-someone-right %})
him immediately. Let's pay for his training, send him to some
courses, buy him some books, let him experiment with the equipment for some
time, and then he will be able to install it in our house. Great plan, isn't it?
The plumber will be happy.

But the project won't.

The goal of the project is to build a house, not to train a plumber. The
project doesn't even have funds to train the bloody plumber! If we train
and teach all our workers, we won't ever build a house. We're not running
a school here. We're building a house!

While working on a software project, a good project manager has a staffing management
plan that describes how skills will be recruited, tested, applied, and
discharged when necessary. Such a plan may include training, but it would be
as small an amount as possible---mostly because a plumber trained by us
[costs]({% pst 2015/jun/2015-06-02-how-to-estimate-software-cost %}) much
more than one trained by someone else but does exactly the same, or worse, work.
Thus, a smart project manager acquires project members who are already
capable of performing their duties and falls back on training only
in exceptional situations.

{% quote If you make your projects spend their money on your education, that's theft %}

Now, a logical question: What should we, as programmers, do? We want to
learn, and we don't want to spend our own money on it. We don't want to
sit home for a few years learning all possible technologies before entering
the job market as experts, ready to be hired. We want to learn on the job.
We basically want to use project budgets for our own personal educational needs.
Moreover, a smart programmer exits every project with some new knowledge,
new skills, and new technologies in his or her portfolio.

However, if you make your projects spend their money
on your education, that's theft. And a good project manager
should stop you, saying "This is not a school!"

What is the solution?

I believe that in the software business, there is only one workaround---blame the
project for your own deficiencies in education, skills, or information.
I'm being absolutely serious.
Let's discuss a few practical situations.

Say you have a module to work with, and it has to be written in Python. You have
no experience in Python; you're a Java developer. Who is at fault here? You
could think of it as your problem and ask your project manager to teach you, but he should tell
you he's not running a school and get rid of you. That's a bad scenario for both of you. Instead, blame the
project manager. He [hired]({% pst 2016/jun/2016-06-21-how-to-hire-programmer %})
you. He put you into this situation. He planned
all project activities, so he probably knows what he is doing. This means
that the project _documentation_ should be detailed enough for a Java
developer to create that Python module. However, it is not detailed enough. So report
this _issue_ and wait for its _resolution_. Explain in your
[bug report]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %}) that you
honestly started to work with the module and realized that its documentation
is not complete enough for a Java developer to understand. Ask the project manager
to fix this. If the project decides to invest its money into the documentation, you
have the chance to read it and learn. Thus, the project's money spent on your education will
also contribute to the project. It's a win-win.

Here is another example: Say you have to fix a Java module and you're a Java
developer. You understand Java, but you don't understand how this algorithm works.
You could blame yourself for not reading
[Knuth](https://amzn.to/2c5o1n2)
in school and ask the project to train you on it. A good and strong project manager should tell you that it's not a school
and get rid of you. Again, a bad scenario for both of you. Instead,
blame the project. The code is _not self-descriptive_ and is difficult to
understand. The algorithm implementation is _not obvious_ and is poorly documented.
Ask for better documentation. If the project invests its money into
the documentation, you will learn the algorithm from it. The source
code will be improved, and you will have improved your skills. Win-win.

One more example: Say you are tasked to implement a WebSockets back-end in
an existing web app. You know how WebSockets work but can't understand how
to connect this new back-end to the existing persistence layer. You are rather
new to the project and don't understand what would be the right design. You
could ask for the project to provide training to explain how the code works
and how it can be extended with features like this one. A project manager
should tell you that you're not in school and are supposed to understand the
software if the project is paying you a software developer
[salary]({% pst 2016/dec/2016-12-06-how-to-pay-programmers-less %}). And he will
be right. But it's a bad scenario for both of you. Instead, blame the project
for _incomplete_ design documentation. Good software should properly document
its architecture and design. Ask for the project to provide such documentation.
If it invests its time and money into better documentation, you
will learn from it and find all the necessary answers. Another win-win.

There are a few other examples in my
[How to Cut Corners and Stay Cool]({% pst 2015/jan/2015-01-15-how-to-cut-corners %}) post.

In conclusion, I would recommend you remember that software projects are,
first and foremost, business activities where we, the developers, are _resources_.
In order to obtain something for ourselves in terms of education and training,
we should align our goals with project objectives. Instead of asking for
help and information, we should blame the project for its lack of
documentation. By fixing this flaw, the project will improve its artifacts
and, at the same time, provide valuable knowledge to us, its participants.
