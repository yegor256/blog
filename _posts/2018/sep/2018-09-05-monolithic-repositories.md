---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Monolithic Repos Are Evil"
date: 2018-09-05
place: Moscow, Russia
tags: devops
description: |
  While many, including Google, advocate for larger monolithic
  repositories, I strongly believe that the biggest repo should
  include fewer than 50K lines of code.
keywords:
  - mono stack repo
  - monolithic repository
  - mono repo
  - monorepo
  - git monorepo
image: /images/2018/09/funny-games.jpg
jb_picture:
  caption: Funny Games (2007) by Michael Haneke
---

We all keep our code in ~~Git~~
[version control](https://en.wikipedia.org/wiki/Version_control) repositories.
The question is whether we should create a new repository for each
new module or try to keep as much as possible in a single so called "monolithic" repo
(or simply [monorepo](https://en.wikipedia.org/wiki/Monorepo)).
Market leaders, like [Facebook](https://code.fb.com/core-data/scaling-mercurial-at-facebook/)
and [Google](https://www.infoq.com/presentations/Development-at-Google),
advocate the second approach. I believe they are wrong.

<!--more-->

{% jb_picture_body %}

Let's use the following JavaScript function as an example.
It downloads a JSON document from a [Zold](https://www.zold.io)
node (using [jQuery](https://jquery.com/))
and places part of its content on the HTML page.
Then it colors the data according to its value.

```javascript
// main.js
function main() {
  $.getJSON('http://b1.zold.io/', function(json) {
    var $body = $('body');
    $body.text(json.nscore);
    var color = 'red';
    if (json.nscore > 500) {
      color = 'green';
    }
    $body.css('color', color);
  });
}
```

Pretty obvious, isn't it? Just a single `main.js` file which does everything we need.
We simply add it to the HTML and it works:

```html
<html>
  <head>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"/>
    <script src="main.js"/>
  </head>
  <body onload="main();">loading...</body>
</html>
```

Now, let me refactor it. Let me break it into two pieces. The first
piece will load the data and the second one will be a jQuery plugin to colorize
HTML content according to the data it contains. This is how the
plugin will look:

```javascript
// colorize.js
$.fn.colorize = function() {
  var data = parseFloat(this.text());
  var keys = Object.keys(colors)
    .map(function (k) { return parseInt(k); })
    .sort(function (a,b) { return a - b; })
    .reverse();
  for (i = 0; i < keys.length; ++i) {
    var max = keys[i];
    if (data >= max) {
      this.addClass(colors[max]);
      return;
    }
    this.removeClass(colors[max]);
  }
  return this;
}
```

The `main.js` will look like this:

```javascript
// main.js
function main() {
  $.getJSON('http://b1.zold.io/', function(json) {
    $('body')
      .text(json.nscore)
      .colorize({ 500: 'green', 0: 'red' });
  });
}
```

Now, instead of a single monolithic piece of code, we have two smaller pieces
which have to be loaded together into the target HTML:

```html
<html>
  <head>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"/>
    <script src="colorize.js"/>
    <script src="main.js"/>
  </head>
  <body onload="main();">loading...</body>
</html>
```

Two pieces are better than one? It seems that
[Google](https://research.google/pubs/why-google-stores-billions-of-lines-of-code-in-a-single-repository/),
[Digital Ocean](https://blog.digitalocean.com/taming-your-go-dependencies/)
and [Mozilla](https://gregoryszorc.com/blog/2014/09/09/on-monolithic-repositories/)
don't think so.

I disagree.

To illustrate my point I extracted the JavaScript function into a
new standalone [jQuery plugin](https://github.com/yegor256/colorizejs).
Here is what I did:

  * Created a new GitHub repo [yegor256/colorizejs](https://github.com/yegor256/colorizejs);
  * Read the [instructions](https://learn.jquery.com/plugins/basic-plugin-creation/);
  * Did some research of jQuery plugins, studied a few examples;
  * Found out that most of them used [Gulp](https://gulpjs.com/), which I've never heard of;
  * Decided to use [npm](https://www.npmjs.com/) for JavaScript packaging (what else, right?);
  * Created [`package.json`](https://github.com/yegor256/colorizejs/blob/master/package.json) for npm;
  * Renamed GitHub repo to `colorizejs` when I found out that npm package
    [`colorize`](https://www.npmjs.com/package/colorize) already exists;
  * Configured [`.travis.yml`](https://github.com/yegor256/colorizejs/blob/master/.travis.yml) for [Travis](https://travis-ci.org/);
  * Created a [README.md](https://github.com/yegor256/colorizejs/blob/master/README.md) and explained how to use it and install it;
  * Decided to use the MIT license and created [LICENSE.txt](https://github.com/yegor256/colorizejs/blob/master/LICENSE.txt);
  * Configured [PDD](https://github.com/yegor256/colorizejs/blob/master/.pdd) for
    [puzzles]({% pst 2017/apr/2017-04-05-pdd-in-action %}) automated collection;
  * Configured [`.rultor.yml`](https://github.com/yegor256/colorizejs/blob/master/.rultor.yml) for
    [Rultor]({% pst 2014/jul/2014-07-24-rultor-automated-merging %});
  * Tried to create a unit test and failed miserably (after a full hour of research),
    since I've had almost no experience in JS unit testing;
  * Posted a [question](https://stackoverflow.com/questions/51809750/) to Stack Overflow;
  * The question was answered by a few people only after the bounty I offered;
  * @brian-lives-outdoors's answer
    was the best and he even submitted a [pull request](https://github.com/yegor256/colorizejs/pull/2)
    with a unit test, which I merged;
  * Released the first version [0.0.1](https://github.com/yegor256/colorizejs/tree/0.0.1)
    to [npmjs.com](https://www.npmjs.com/package/colorizejs);
  * Modified the code to make it work both with classes and colors;
  * [Implemented](https://github.com/yegor256/colorizejs/issues/3) and released
    the next version [0.1.0](https://github.com/yegor256/colorizejs/tree/0.1.0);
  * [Added it](https://github.com/zold-io/zold.github.io/issues/81) to Zold front-end,
    tested it, and released it---check it out [here](https://www.zold.io/health.html).

It took almost three weeks of waiting and four hours of work, just
to move a small piece of JavaScript code to a new repository and release
it separately. Was it worth it? Well, I think it was. But ~~many~~ most
other blog post authors, who I managed to find, think that it would be better to keep
everything in a single monolithic repo, mostly because it's better for _productivity_.
For example,
[Advantages of monorepos](https://danluu.com/monorepo/) by [Dan Luu](https://twitter.com/danluu),
[Advantages and Disadvantages of a Monolithic Repository](https://dl.acm.org/doi/abs/10.1145/3183519.3183550)
(a case study at Google) by Ciera Jaspan et al.,
and
[How Monolithic Repository in Open Source saved my Laziness](https://www.tomasvotruba.cz/blog/2017/01/31/how-monolithic-repository-in-open-source-saved-my-laziness/)
by Tomas Votruba.

There are also a few good analyses of both approaches, for example
[Monolithic repositories vs. Many repositories](https://www.dotconferences.com/2016/05/fabien-potencier-monolithic-repositories-vs-many-repositories)
speech by Fabien Potencier at dotScale 2016
and
[Repo Style Wars: Mono vs Multi](https://www.gigamonkeys.com/mono-vs-multi/)
by Peter Seibel.

In a nutshell, they
[all claim](https://gomonorepo.org/) that productivity is higher with a monolithic repo because
the amount of operations one has to do in order to make a change is smaller.
Indeed, in a monorepo there will be a single branch, a single set of commits, a single pull request,
a single merge, deploy and release. Also it will be easier to test, both
manually and via unit testing. Continuous integration is easier to configure,
and so on and so forth.

{% quote A set of smaller components is better than a larger solid piece. %}

All these "reasonable" arguments remind me of what I hear when preaching object decomposition and suggesting that multiple objects are [better]({% pst 2017/feb/2017-02-28-too-many-classes %}) than a single large one.
Imagine a large class of 3,000 lines of code, which does many things and they are all tightly [coupled][coupling].
It's "easy" to test it, to make changes, to deploy, to review, etc.
Because everything stays in one file, right?
We don't need to jump from class to class in order to understand the design.
We just look at one screen, scroll it up and down, and that's it.
Right?
Totally wrong!

I guess I don't need to explain why it's wrong.
We don't design our software that way anymore.
We know that tight [coupling] is a bad idea.
We know that a set of smaller components is better than a larger solid piece.

{% youtube zljJpADEf_E %}

Why can't we apply the same logic to repositories?
I believe we can.
Of course, just like in object-oriented programming, a fine-grained design requires more skills and time.
Look at what I had to do with this small [jQuery] plugin.
I've spent hours of coding and thinking.
I even had to learn [Gulp] and [Jasmine], which I most probably will not use anymore.
But the benefits we are getting from it are enormous.
This is my short list of them:

  * **Encapsulation**.
    Each repo encapsulates a single problem, hiding its details from everybody else.
    Thanks to that, the scope each repo has to deal with gets smaller.
    The smaller the scope, just like in OOP, the easier it is to maintain and modify.
    The easier to maintain, the cheaper the development.
    I guess Google guys don't really worry about costs.
    On the contrary, they want their [salaries]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %}) to grow.
    A large unmaintainable monolithic repo is a perfect tool to make it happen.

  * **Fast Builds**.
    When a repo is small, the time its automated build takes is small.
    Look at the time Travis [spends](https://travis-ci.org/yegor256/colorizejs/builds/420726284) for my jQuery plugin.
    It's 51 seconds.
    It's fast.
    We [all know](https://mortoray.com/2015/05/06/fast-build-turnaround-time-is-essential/) that the faster the build, the better it is for productivity, since it's easier to use the build as a tool for development.

  * **Accurate Metrics**.
    I don't know whether you rely on metrics in your projects, but we at
    [Zerocracy](https://www.zerocracy.com) do pay attention to numbers, like
    lines of code, [hits of code]({% pst 2014/nov/2014-11-14-hits-of-code %}),
    number of commits, classes, methods, cohesion, [coupling], etc.
    It's always a question whether the metrics are accurate.
    Calculating lines of code for a large repository doesn't make any sense, since
    the number will include a lot of files from completely different parts of
    the application. Moreover there will be different languages and file formats.
    Say a repo has 200K lines of Java, 150K lines of XML, 50K lines of JavaScript,
    and 40K lines of Ruby. Can you say something specific about this repo? Is it
    large? Is it a Java repo? And, more importantly, can it be compared with other
    repositories? Not really. It's just a big messy storage of files.

{% quote The preferred situation is one language or technology per repository. %}

  * **Homogeneous Tasks**.
    Smaller repositories tend to have smaller tech stacks, meaning that each of
    them uses just a few languages and frameworks, or (and this is the preferred
    situation)---one language or technology per repository. Thanks to this,
    the management of programmers becomes easier, since any ticket/problem can
    be assigned to anybody. It's easier to make tasks similar in size and complexity.
    This obviously means better manageability of the project.

  * **Single Coding Standard**.
    It's easier to standardize the coding style if the repo is small. When it's
    large, various parts of the code base will have different styles and
    it will be almost impossible to put everybody on the same page. In other
    words, smaller repositories look more beautiful than larger ones.

  * **Short Names**.
    Each repository, inevitably, will have its own namespace. For example, in the
    JS repository I just created, I only have two files: `colorizejs.js` and `test-colorizejs.js`.
    I don't really care about the naming inside them, since the namespace
    is small. ~~I can even use global variables.~~
    Shorter names and smaller namespaces mean better maintainability.

  * **Simple Tests**.
    The larger the code base, the more dependencies it has, which are difficult
    to mock and test. Large code bases become fundamentally untestable since
    they require a lot of integration tests which are difficult to maintain.
    Smaller libraries, frameworks and modules are easier to keep at the level
    of simple and fast unit testing.

Thus, I believe that the smaller the repositories and modules, the better.
Ideally, I would say, the largest acceptable size for a code base is 50,000 lines of code.
Everything that goes above this line is a perfect candidate for decomposition.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">What do you think is better, a bigger code repository with everything inside, or many smaller ones with their own builds, dependencies, issues, and pull requests?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1053922638517731329?ref_src=twsrc%5Etfw">October 21, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

[coupling]: https://en.wikipedia.org/wiki/Coupling_(computer_programming)
[Gulp]: https://gulpjs.com/
[Jasmine]: https://jasmine.github.io/
[jQuery]: https://jquery.com/
