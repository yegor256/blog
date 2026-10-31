---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Fear of Decoupling"
date: 2018-09-18
place: Moscow, Russia
tags: oop
description: |
  Most of us are afraid of decoupling objects via interfaces
  since it makes their aggregates less predictable and therefore
  less stable; it's a mistake.
keywords:
  - interfaces in oop
  - loose coupling
  - coupling in oop
  - coupling in object oriented programming
  - coupling vs reliability
image: /images/2018/09/funny-games.jpg
jb_picture:
  caption: Funny Games (2007) by Michael Haneke
---

Objects talk to each other via their methods. In mainstream programming
languages, like Java or C#, an object may have a unique set of methods
together with some methods it is forced to have because it _implements_ certain types,
also known as _interfaces_. My experience of speaking with many programmers
tells me that most of us are pretty scared of objects that implement too
many interface methods. We don't want to deal with them since they
are _polymorphic_ and, because of that, unreliable.
It's a fair fear. Let's try to analyze where it comes from.

<!--more-->

{% jb_picture_body %}

As usual, let's start with a simple Java example. Here is an amount of money
I'm going to send to a user via, say, the PayPal API:

```java
interface Money {
  double cents();
}
```

Now here I am, the method that sends the money:

```java
void send(Money m) {
  double c = m.cents();
  // Send them over via the API...
}
```

These two pieces of code are, as we call it, loosely coupled. The method
`send()` has no idea which class is provided and how exactly the method
`cents()` is implemented. Maybe it's a simple constant object of one dollar:

```java
class OneDollar implements Money {
  @Override
  double cents() {
    return 100.0d;
  }
}
```

Or maybe it's a way more complex entity that makes a network connection first,
in order to fetch the current USD-to-EUR exchange rate, update the database,
and then return the result of some calculation:

```java
class EmployeeHourlyRate implements Money {
  @Override
  double cents() {
    // Fetch the exchange rate;
    // Update the database;
    // Calculate the hourly rate;
    // Return the value.
  }
}
```

The method `send()` doesn't have the knowledge of what exactly is provided
as its first argument. All it can do is hope that the method `cents()` will
do the work right. What if it doesn't?

If I'm a developer of the method `send()` and I'm fully prepared to take the
blame for the mistakes my method causes, I do want to know what my collaborators are.
And I want to be absolutely sure they work. Not just work, but work exactly how I expect
them to. Preferably I would like to write them myself. Ideally
I would like to ensure that nobody touches them after I implement them. You get
the sarcasm, right?

{% quote Polymorphism makes sofware more fragile ... to make it more robust! %}

This may sound like a joke, but I have heard this argument many times. They say
that "it's better to be completely sure two pieces work together, instead of
relying on the damn polymorphism and then spending hours debugging something
I didn't write." And they are right, you know. Polymorphism---when
a seemingly primitive object of type `Money` does whatever it wants, including
HTTP requests and SQL `UPDATE` queries---doesn't add reliability to the entire
application, does it?

No, it doesn't.

Obviously, polymorphism makes the life of the developers of this type `Money` and its
"ancestors" way simpler, since they don't have to think about their users much.
All they worry about is how to return the `double` when `cents()` is called.
They don't need to care about speed, potential exceptions, memory usage,
and many other things, since the interface doesn't require that. It only
tells them to return the `double` and call it a day. Let somebody else
worry about everything else. Easy, huh? But that's a childish and egoistic way
of thinking, you may say!

Yes, it is.

However...

You've most definitely heard of the [Fail Fast]({% pst 2015/aug/2015-08-25-fail-fast %}) idea,
which, in a nutshell, claims that in order to make an application robust
and stable we have to make sure its components are as fragile as possible and
as vulnerable as they can be in response to any potential exceptional situation.
They have to break whenever they can and let their users deal with the failures.
With such a philosophy no object will assume anything good about its counterparts
and will always try to escalate problems to higher levels, which eventually will
hit the end user who will report them back to the team. The team will fix them
all and the entire product will stabilize.

If the philosophy is the opposite and every object is trying to deal with
problems on its individual micro level, the majority of exceptional situations
will never be visible to users, testers, architects and programmers, who are
supposed to be dealing with them and finding solutions for them. Thanks to this
"careful" mindset of individual objects, the stability and robustness of the
entire application will suffer.

We can apply the same logic to the "fear of loose coupling."

When we worry about how `Money.cents()` works and want to control its behavior,
we are doing ourselves and the entire project a big disservice. In the long run
we destabilize the product, instead of making it more stable. Some even
want to prohibit polymorphism by declaring method `send()` this way:

```java
void send(EmployeeHourlyRate m) {
  // Now I know that it's not some abstract Money,
  // but a very specific class EmployeeHourlyRate, which
  // was implemented by Bobby, a good friend of mine.
}
```

Here we limit the amount of mistakes our code may have, since we know Bobby,
we've seen his code, we know how it works and which exceptions to expect.
We are safe. Yes, we are. For now. But strategically speaking, by not
allowing our software to make all possible mistakes and throw all possible
exceptions in all unusual situations, we are seriously limiting its ability
to be properly tested and that's why it's destabilized.

As I [mentioned earlier]({% pst 2017/may/2017-05-23-unlimited-number-of-bugs %}),
the only way to increase the quality of software is to find and fix its bugs.
The more bugs we fix, the fewer are the bugs that remain hidden and not-fixed-yet. A fear
of bugs and our intention to prevent them is only shooting us in the foot.

Instead, we should let everybody, not only Bobby, implement `Money` and pass
those implementations to `send()`. Yes, some of them will cause troubles
and may even lead to UI-visible failures. But if our management understands
the concept of [software quality]({% pst 2017/dec/2017-12-26-software-quality-formula %})
right, they will [not blame]({% pst 2014/apr/2014-04-13-bugs-are-welcome %}) us for mistakes.
Instead, they will encourage us to find as many of them as possible,
reproduce them with automated tests, fix, and re-deploy.

Thus, the fear of decoupling is nothing else but Fail Safe.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">How often do you create interfaces for your classes? <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a> <a href="https://twitter.com/hashtag/oop?src=hash&amp;ref_src=twsrc%5Etfw">#oop</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1046377815799738368?ref_src=twsrc%5Etfw">September 30, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
