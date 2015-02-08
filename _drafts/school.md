---
layout: post
title: "It's Not a School!"
date: 2015-01-10
tags: mgmt agile
description:
  A project is not a school and it shouldn't pay for our education, however
  we want and need to learn while working in a project; here is a simple
  advice on how to align our goals and project objectives.
keywords:
  - working and learning
  - working and learning at the same time
  - working and learning together
  - education at work
  - bug tracking
---

In [teamed.io](http://www.teamed.io) we work in distributed teams and
keep all our communications [in tickets]({% pst 2014/oct/2014-10-07-stop-chatting-start-coding %}).
Besides that, we [encourage]({% pst 2014/apr/2014-04-13-bugs-are-welcome %})
every developer in every project to
report bugs whenever he or she finds them. We even
[pay]({% pst 2014/apr/2014-04-17-how-xdsd-is-different %}) for each bug found.
Once in a while I see bugs reported saying something like "_Can someone explain
me how to design this module?_" or even "_I didn't use this library before,
please help me to start_." My usual answer is "_It's not a school, nobody
is going to teach you here!_" I realize that this sounds
rather harsh for most of the developers just starting to work with us.
Here I'll try to show why such an attitude make sense and is beneficial both
for programmers and the project.

Disclaimer: I'm talking about software **projects** here, which, according to PMBOK,
are "_temporary_ endeavors undertaken to create unique
products, services, or results". If your team is doing a continuous
development or maintenance of some software, this concept may not be relevant.

<!--more-->

No matter how unleasant this could be, let's face the reality &mdash;
each software project is a business and we, the developers, are
its **resources**. Just like beton, wood and glass are the resources required
to build a house, which is also a business. No matter how much we think
about ourselves as a family having fun together and writing code because
we enjoy it, each business looks at it completely differently.

The project needs us to produce classes, lines of code, methods, functions,
files and features. Then, the project can convert them into happy customers
which will give us something back. Usually, cash. Then, the project will
share that cash among us, investors and the government.

A properly planned and managed project acquires the best resources its
budget can afford and then relies on their quality. A programmer that doesn't
have enough skills or knowledge is an unreliable resource. Obviously,
no project would acquire such a resource at the beginning. However,
this fact may be revealed in the middle of the project.

Say, you're building a house. You contracted a plumber to install a
draining system. When it's time to mount the equipment he tells you
that he never worked with it and doesn't know how to install.
It was a risk and it occured. A good project manager always has a fallback plan,
or even a few of them. Obviously, the best option would be to contract another
plumber. The worst option would be to train this one, on the spot.

Wait, why it's obvious? The plumber is a great guy. Yes, he doesn't know
how to work with this equipment, but this doesn't mean that we should
fire him immediately. Let's pay for his training, send him to some
courses, buy him some books, let him experiment with the equipment for some
time and then he will be able to install it in our house. Great plan, isn't it?
The plumber will be happy.

But the project won't.

The goal of the project is to build a house, not to train a plumber. The
project doesn't even have funds to train the bloody plumber! If we will train
and teach all our workers, we won't build a house ever. We're not running
a school here. We're building a house!

A good project manager, in a software project, has a staffing management
plan that describes how skills will be recruited, tested, applied and
discharged when necessary. Such a plan may include training, but in
as small amount as possible. Mostly because a plumber trained by us costs much
more comparing to the one trained by someone else, but does exactly the same, or worse.
Thus, a smart project manager acquires project members that are already
capable of performing their duties and falls back to trainings only
in exceptional situations.

Now, a logical question &mdash; should we, programmers, do? We want to
learn and we don't want to spend our own money on it. We don't want to
sit home for a few years learning all possible technologies and then
going to the market as experts, ready to be hired. We want to learn on the stop.
We basically want to use project budgets for our own personal educational needs.
Moreover, a smart programmer exits every project with some new knowledge,
new skills and new technologies in its portfolio.

However, if you make your projects spend their money
for your education &mdash; it's a theft. And a good project manager
should stop you, saying "It's not a school!"

What is a workaround?

I believe, in a software business, there is only one &mdash; blame the
project for your own blanks in education, skills or information.
I'm being absolutely serious.
Let's discuss a few practical situations.

Say, you have a module to work with and it has to be in Python. You have
no experience in Python, you're a Java developer. Who is at fault here? You
can think of it as your problem and ask your project manager to teach you. He should tell
you it's not a school and get rid of you. Bad scenario, for both of you. Instead, blame the
project manager. He hired you. He put you into this situation. He planned
all project activities, so he probably knows what he is doing. This means
that the project documentation should be detailed enough for a Java
developer to create that Python module. However, it is not detailed enough. So, report
this issue and wait for its resolution. Explain in your bug report that you
honestly started to work with the module and realized that its documentation
is not complete enough for a Java developer to understand it. Ask the project
to fix this. The project will invest its money into the documentation and you
will read it and learn. Thus, project money spent on your education will
also contribute to the project. Win-win.

Here is another example. Say, you have to fix a Java module and you're a Java
developer. You understand Java but you don't understand how this algorithm works.
You can blame yourself for not reading
[Knuth](http://www.amazon.com/gp/product/0321751043/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0321751043&linkCode=as2&tag=yegor256com-20&linkId=FVM7INLX6KAHZV66)
in school and ask the project to train you. A good and strong project manager should tell you that it's not a school
and get rid of you. Bad scenario, for both of you. Instead,
blame the project. The code is not self descriptive and is difficult to
understand. The algorithm implementation is not obvious and poorly documented.
Ask for a better documentation. The project will invest its money into
the documentation and you will learn the algorithm from it. The source
code is improved and you improved your skills. Win-win.

One more example. Say, you are tasked to implement a WebSockets back-end in
an existing web app. You know how WebSockets work, but can't understand how
to connect this new back-end to the existing persistence layer. You are rather
new to the project and can't understand what would be the right design. You
can ask the project to give you a training and explain how the code works
and how it can be extended with features like this one. A project manager
should tell you that it's not a school and you're supposed to understand the
software if the project is paying you a software developer salary. And he will
be right. But it's a bad scenario, for both of you. Instead, blame the project
for an incomplete design documentation. A good software should properly document
its architecture and design. Ask the project to provide such a documentation.
The project will invest its time and money into a better documentation and you
will learn from it and find all necessary answers. Win-win.

There are a few other examples in
[How to Cut Corners and Stay Cool]({% pst 2015/jan/2015-01-15-how-to-cut-corners %}) post.

In conclusion, I would recommend to remember that software projects are,
first and foremost, business activities, where we, the developers, are resources.
In order to get something for ourselves, in terms of education and training,
we should align our goals with project objectives. Instead of asking for
help and information we should blame the project for the lack of
documentation. By fixing this flaw the project will improve its artifacts
and at the same time provide valuable knowledge to us, its participants.
