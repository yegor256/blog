---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "SRP is a Hoax"
date: 2017-12-19
place: Moscow, Russia
tags: oop
description: |
  The single responsibility principle is very popular among
  object-oriented programmers, but how practical and
  valid is it really?
keywords:
  - srp
  - single responsibility principle
  - srp is fake
  - srp java
  - srp oop
image: /images/2017/12/the-thomas-crown-affair.jpg
jb_picture:
  caption: The Thomas Crown Affair (1999) by John McTiernan
---

The [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle),
according to [Robert Martin](https://en.wikipedia.org/wiki/Robert_Cecil_Martin)'s
[Clean Code](https://amzn.to/2m7LmaA),
means that "a class should have only one reason to change."
Let's try to decrypt this rather vague statement and see how it
helps us design better object-oriented software. If it does.

<!--more-->

{% jb_picture_body %}

I mentioned SRP once in [my post about SOLID]({% pst 2017/mar/2017-03-28-solid %}),
saying that it doesn't really help programmers understand the good old
"[high cohesion](https://en.wikipedia.org/wiki/Cohesion_%28computer_science%29)"
concept, which was introduced by
[Larry Constantine](https://en.wikipedia.org/wiki/Larry_Constantine)
back in 1974. Now let's see it by example and analyze how we can
improve a class, with the SRP in mind, and whether it will become
[more object-oriented]({% pst 2014/nov/2014-11-20-seven-virtues-of-good-object %}).

Let's try the class [`AwsOcket`](https://github.com/jcabi/jcabi-s3/blob/0.18/src/main/java/com/jcabi/s3/AwsOcket.java)
from [jcabi-s3](http://s3.jcabi.com) (I've simplified the code):

```java
class AwsOcket {
  boolean exists() { /* ... */ }
  void read(final OutputStream output) { /* ... */ }
  void write(final InputStream input) { /* ... */ }
}
```

Correct me if I'm wrong, but according to SRP this class is responsible for
too many things:
1) checking the existence of an object in AWS S3,
2) reading its content, and
3) modifying its content.
Right? It's not a good design and it must be changed.

In order to change it and make it responsible for just one thing we must introduce
a getter, which will return an AWS client and then create three new classes:
`ExistenceChecker`, `ContentReader`, and `ContentWriter`. They will check,
read, and write. Now, in order to read the content and print it to the
console I'm currently doing this:

```java
if (ocket.exists()) {
  ocket.read(System.out);
}
```

Tomorrow, if I refactor the class, I will be doing this:

```java
if (new ExistenceChecker(ocket.aws()).exists()) {
  new ContentReader(ocket.aws()).read(System.out);
}
```

Aside from the fact that these checkers, readers, and writers are not really
classes, but pure holders of procedures, the usage of this `ocket` turns
into a nightmare. We can't really know anymore what will happen with it
when we pass it somewhere. We can't, for example, guarantee that the content
that is coming from it is decrypted or decoded on the fly. We simply can't
decorate it. It is not an object anymore, but a holder of an AWS client,
which is used by some other classes somewhere.

Yes, now it is responsible for only one thing: encapsulating the reference
to the AWS client. It is a perfect class as far as SRP is concerned. But it
is not an object anymore.

The same will happen with any class if you apply the SRP principle to its
full extent: it will become a holder of data or of other objects, with a
collection of setters and getters on top of them. Maybe with one extra
method in addition to those.

{% quote “One thing” is a misleading simplification of a “high cohesion” concept. %}

My point is that SRP is a wrong idea.

Making classes small and cohesive is a good
idea, but making them responsible "for one thing" is a misleading simplification
of a "high cohesion" concept. It only turns them into dumb carriers of something
else, instead of being encapsulators and decorators of smaller entities, to
construct bigger ones.

In our fight for this fake SRP idea we lose a much more important principle,
which really is about true object-oriented programming and thinking:
encapsulation. It is much less important how many things an object is
responsible for than how tightly it protects the entities it encapsulates.
A monster object with a hundred methods is much less of a problem than a DTO with five pairs of
getters and setters! This is because a DTO spreads the problem all over the code,
where we can't even find it, while the monster object is always right in front
of us and we can always refactor it into smaller pieces.

Encapsulation comes first, size goes next, if ever.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">What do you think about the Single Responsibility Principle (SRP)? <a href="https://twitter.com/hashtag/oop?src=hash&amp;ref_src=twsrc%5Etfw">#oop</a> <a href="https://twitter.com/hashtag/elegantobjects?src=hash&amp;ref_src=twsrc%5Etfw">#elegantobjects</a></p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1036247379140399104?ref_src=twsrc%5Etfw">September 2, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
