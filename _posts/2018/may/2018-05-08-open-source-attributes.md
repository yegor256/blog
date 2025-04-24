---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "An Open Code Base Is Not Yet an Open Source Project"
date: 2018-05-08
place: Dnipro, Ukraine
tags: oss
description: |
  Making your code base visible to everyone doesn't make
  it an open source project yet; there are a number
  of important things you shouldn't forget to do.
keywords:
  - open source
  - open source packaging
  - how to package open source
  - open source maven
  - open source discipline
image: /images/2018/05/her.jpg
jb_picture:
  caption: Her (2013) by Spike Jonze
---

A few weeks ago someone [suggested](https://www.yegor256.com/2018/04/10/learning-by-refactoring.html#comment-3865410512)
I should try to integrate [IntelliJ IDEA](https://www.jetbrains.com/idea/)'s
static analysis rules into
[Qulice]({% pst 2014/aug/2014-08-13-strict-code-quality-control %}),
our aggregator of
[Checkstyle](http://checkstyle.sourceforge.net/),
[PMD](http://pmd.sourceforge.net/),
[FindBugs](http://findbugs.sourceforge.net/),
and some other analyzers. I do love IDEA's rules---some of them are
unique and very useful. I asked whether I could find them somewhere in
Maven Central (they are written in Java) and the answer was "You'll have to figure
out yourself how to use them, but they are open source."
Here comes my opinion about this
situation: I believe that open source doesn't just mean the code is readable
without authorization. It means something much bigger.

<!--more-->

{% jb_picture_body %}

Just making a piece of code publicly accessible is not what it takes to call
it _open source_ software. Actually, it only harms the product, and the
reputation of its author, if it's open but not ready for _reuse_ (which
is what [the open source world]({% pst 2015/dec/2015-12-22-why-dont-you-contribute-to-open-source %})
is all about). As [Eric Raymond](https://en.wikipedia.org/wiki/Eric_S._Raymond) said in his
famous piece [_The Cathedral and the Bazaar_](https://amzn.to/2FKF9tv),
"Good programmers know what to write. Great ones know what to rewrite (and reuse)."

It's the responsibility of the software product's author to help
those "good" programmers to reuse the code. Coding, testing, debugging,
and making sure "it works on my laptop" is one thing. Making it readable and reusable
is a totally different piece of work, which may take
[much more]({% pst 2024/dec/2024-12-15-open-source-beginner-advice %}) time.

As [Karl Fogel](https://en.wikipedia.org/wiki/Karl_Fogel)
said in [_Producing Open Source Software_](https://amzn.to/2jyMrrF):
"Most free software projects fail." They fail (on top of many other factors) because not enough
attention is paid to the following basic things (in no particular
order):

## README

I'm sure you host your product on GitHub. (If not, what's wrong with you?)
There must be a [`README`]({% pst 2019/apr/2019-04-23-elegant-readme %})
file in the root directory that
explains what the product is all about and how we should use it.
A few good examples:
[`leejarvis/slop`](https://github.com/leejarvis/slop/blob/master/README.md),
[`mongobee/mongobee`](https://github.com/mongobee/mongobee/blob/master/README.md)
[`ronmamo/reflections`](https://github.com/ronmamo/reflections/blob/master/README.md),
and
[`yegor256/takes`](https://github.com/yegor256/takes/blob/master/README.md) (this one is mine).
A few bad examples:
[`qos-ch/slf4j`](https://github.com/qos-ch/slf4j/blob/master/README.md),
[`rzwitserloot/lombok`](https://github.com/rzwitserloot/lombok/blob/master/README), and
[`junit4/blob`](https://github.com/junit-team/junit4/blob/master/README.md) (don't be like these guys).

{% quote Only if and when we get interested will we investigate further and deeper. %}

No matter how rich you've made your website, Javadoc, Wiki, mailing
list, and Twitter, the README is the place where we expect
to see everything. Only if and when we get interested will we investigate
further and deeper. Read the README files in other projects and copy
their best ideas.
[README]({% pst 2019/apr/2019-04-23-elegant-readme %}) is your showcase, it must shine.

## License

Most of us don't pay attention to [this bureaucracy](https://en.wikipedia.org/wiki/Software_license).
I didn't either, until recently.
I thought that the moment my code is open I can forget about any
rights and royalties. They will just use my code and I won't
see any profit, ever. The license I attach to it won't matter---nobody
reads it anyway. This is exactly what happens in most cases.
But only while those users are small potatoes.

A few years ago I was an architect on a software project and we had to create
an analyzer of hardware components, like CPU, memory, hard disc, etc. We had
to make sure all of them worked as expected after running pretty complex
and customized tests. My obvious suggestion was to use open source tools,
which would do the hard work for us. We would only have to integrate them.
It was an awesome idea, until some of us decided to check the licenses of
those tools.

{% quote I'm suggesting you think about the license before publishing the product. %}

That was the moment I realized that I was so wrong for not paying attention
to what licenses say. [GPL](https://en.wikipedia.org/wiki/GNU_General_Public_License),
for example, which we found in a few tools,
didn't allow us to reuse the code if our product wasn't open source too.
Since we were creating proprietary software, we understood that we weren't able to
use [copyleft](https://en.wikipedia.org/wiki/Copyleft) modules,
only
[MIT](https://en.wikipedia.org/wiki/MIT_License),
[BSD](https://en.wikipedia.org/wiki/BSD_licenses) or similar.

I'm suggesting you think about the license before publishing the
product. I've used [MIT](https://en.wikipedia.org/wiki/MIT_License)
in all my products since 2016.

## Distribution

A mere collection of `.rb` files is not reusable Ruby code. Well, maybe for
those [hackers]({% pst 2014/oct/2014-10-26-hacker-vs-programmer-mentality %})
I despise so much, it is. But for professional
[developers]({% pst 2018/jan/2018-01-23-sociotech-skills %}),
who are too [lazy]({% pst 2018/apr/2018-04-17-how-to-be-lazy %})
to read their own code, let alone someone else's,
it definitely isn't.

"Take it from GitHub" is not a polite way to treat us---your fellow programmers---anymore.
It was, twenty years ago, but now we have repositories.
You have to distribute your product as an "artifact" through one of those public
repositories, and make it possible for us to fetch it
from there, skipping the testing and packaging, and just using it as a product
(a Ruby gem or Java JAR, for example).

I'm talking about repositories like
[Maven Central](https://search.maven.org/),
[npmjs](https://www.npmjs.com/),
or [RubyGems](https://rubygems.org/).
You have to find a way to deploy your product there.
It's not an easy task, even though those repositories
do their best to simplify the process. We use
[Rultor]({% pst 2014/sep/2014-09-11-deployment-script-vs-rultor %}) in all our projects,
which helps us streamline the deployment:

  * [yegor256/takes](https://github.com/yegor256/takes) to Maven Central
    ([details]({% pst 2014/aug/2014-08-19-how-to-release-to-maven-central %}));
  * [yegor256/xcop](https://github.com/yegor256/xcop) to RubyGems
    ([details]({% pst 2014/aug/2014-08-26-publish-to-rubygems %}));
  * [yegor256/tacit](https://github.com/yegor256/tacit) to npmjs.

[Package managers](https://en.wikipedia.org/wiki/Package_manager)
like Maven, NPM, Rake, Grunt, Gradle and
[others](https://en.wikipedia.org/wiki/List_of_software_package_management_systems),
are the standard and traditional way of reusing open source software (proprietary too).
If your product is not available in a public repository, it's not a product;
it's just a code base.

## Javadoc

We all hate writing documentation. And we hate libraries that are not
documented. I usually find it boring to write Javadoc blocks for my classes,
but I understand that without them the code I'm writing inside
those classes will not interest anyone.

The best format for those Javadoc blocks is "by example." Instead of prose
I'd recommend you demonstrate how to use the class, especially in combination
with it neighbors. Moreover, I'd suggest you _don't_ write documentation
anywhere else apart from those Javadoc blocks. (They exist in other
languages too, but have different names.)

The problem with Javadoc is that it's not so easy to format the text
so that it looks visually attractive. Maybe that's why many programmers
still rely on Wikis or project websites. I'd recommend you stay inside
Javadoc blocks and learn their formatting syntax.

## Badges

As [you can see](https://github.com/yegor256/takes), I like badges. First and foremost
they make a repository look as if it's being "actively maintained," especially
if those badges are green. They don't really deliver any valuable information.
They mostly say: "Our author has very good taste, see how perfectly
our colors match!"

{% quote I add Travis badges to all projects of mine, right after I create a new repository. %}

Jokes aside, it's not so easy to add all those badges. Each badge will take you
some time, to integrate a third party system, to make sure the numbers
are good enough to be proud of, and to keep it under control. If the
repository is not being watched over, the badges will eventually start failing.

## Continuous Integration

In order to use your code we have to trust it, meaning that we have to
be sure that it works, or at least passes automated tests. (Do I have to say that
you [must have tests]({% pst 2022/jul/2022-07-05-safety-net %})?)
How can we be sure it works? [CI]({% pst 2014/oct/2014-10-05-ten-hosted-continuous-integration-services %})
is the answer. We must be able
to see the logs of the recent CI build and make sure it is clean.

It's a matter of trust. You may never use those <del>Travis</del> GitHub Actions builds and simply
ignore their red and green signals, but they are important for us---your
clients. I add <del>Travis</del> GitHub Actions badges to all projects of mine, right after I create
a new repository.

## Contribution Guidelines

For a regular GitHub addict it's not a problem to figure out how to
send you a pull request. However, the majority of us, at least
initially, will consist of active users, not contributors. We will try
to use your product and will attempt to customize it for our needs.
If we get lost, we will leave, frustrated.

To prevent this, you have to explain what a disciplined contributor
has to do in order to make changes to your code base. Here are
the questions I'd recommend you answer in your
[`CONTRIBUTING.md`](https://help.github.com/articles/setting-guidelines-for-repository-contributors/):

  * How do I run an automated build?
  * How big/small does a pull request have to be in order to be accepted?
  * What are your style guidelines?
  * How do bugs have to be reported, tagged, explained?
  * What makes a [good bug report]({% pst 2018/apr/2018-04-24-right-way-to-report-bugs %})?

Here is the text I
[use](https://blog.github.com/2016-02-17-issue-and-pull-request-templates/) in all my projects:
[`ISSUE_TEMPLATE.md`](https://github.com/yegor256/takes/blob/14d1d4f6c398a5f8ff08d958fc86f4413dcc7778/.github/ISSUE_TEMPLATE.md)
and
[`PULL_REQUEST_TEMPLATE.md`](https://github.com/yegor256/takes/blob/14d1d4f6c398a5f8ff08d958fc86f4413dcc7778/.github/PULL_REQUEST_TEMPLATE.md).

## Quality Wall

Finally, if you are lucky, we will use your product and will be interested
in contributing. You will start getting our pull requests. The question is how
fast we will ruin your code base. We will, if you don't protect yourself.

If you strictly review each pull request and reject anything that doesn't
look like "great" code, you will lose us, your contributors. We don't want
to write great code, we want to make changes to your product so that it
becomes more suitable for _our_ needs. The greatness of the code is _your_
concern, not ours.

On the other hand, if you accept whatever comes in, the architecture will lose its robustness
(if it ever had any) and you again will lose us, your contributors. This time
you will lose us because the product will become bad and difficult to
maintain and contribute to.

The best way to keep the balance is to "hire" a tool to help you:
build automation, static analysis, automated tests, and coverage control.
You have to configure the product to fail when the changes someone
introduces violate its internal quality expectations.
I [use Rultor]({% pst 2014/jul/2014-07-24-rultor-automated-merging %}) for that too.

Did I forget anything?
