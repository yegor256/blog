---
layout: post
title: "Monolithic Repos"
date: 2018-07-20
place: Moscow, Russia
tags: devops
description: |
  ...
keywords:
  - mono stack repo
  - monolithic repository
  - mono repo
  - monorepo
  - git monorepo
image: /images/2018/07/
jb_picture:
  caption:
---

We all keep our code in <del>Git</del>
[version control](https://en.wikipedia.org/wiki/Version_control) repositories.
The question is whether we should create a new repository for each
new module or try to keep as much as possible in a single so called "monothilic" repo.
Market makers, like [Facebook](https://code.fb.com/core-data/scaling-mercurial-at-facebook/)
and [Google](https://www.infoq.com/presentations/Development-at-Google),
advocate the second approach. I believe, it is a mistake.

<!--more-->

{% jb_picture_body %}

There are many arguments in favor of a single monolithic repo.
I want to try to apply them all to a piece of code, and see whether
they will make sense. It seems that the logic behind pro-monolithic
thinking is very similar when we deal with repositories and,
say, a JavaScript function.

Let's use the following function, as an example.
It downloads a JSON document (using [jQuery](https://jquery.com/))
and places part of its content to the HTML page.
Then, it colors the data, according to its value.

{% highlight javascript %}
// main.js
function main() {
  $.getJSON('http://b1.zold.io/', function(json) {
    $('body').text(json.nscore);
    if (json.nscore > 500) {
      $('body').css('color', 'green');
    } else {
      $('body').css('color', 'red');
    }
  });
}
{% endhighlight %}

Pretty obvious, isn't it? Just a single `main.js` file, which does everything we need.
We simply add it to the HTML and it works:

{% highlight html %}
<html>
  <head>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"/>
    <script src="main.js"/>
  </head>
  <body onload="main();">loading...</body>
</html>
{% endhighlight %}

Now, let me refactor it. Let me break it into two pieces. The first
piece will load the data and the second one will be a jQuery plugin to colorize
HTML content according to the data it contains. This is how the
plugin will look:

{% highlight javascript %}
// colorize.js
$.fn.colorize = function() {
  this.css('color', 'inherit');
  for (var max in colors) {
    if ($element.text() > max) {
      this.css('color', colors[max]);
      break;
    }
  }
  return this;
}
{% endhighlight %}

The `main.js` will look like this:

{% highlight javascript %}
// main.js
function main() {
  $.getJSON('http://b1.zold.io/', function(json) {
    $('body')
      .text(json.nscore)
      .colorize({ 500: 'green', 0: 'red' });
  });
}
{% endhighlight %}

Now, instead of a single monolithic piece of code we have two smaller pieces,
which have to be loaded together into the target HTML:

{% highlight html %}
<html>
  <head>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"/>
    <script src="colorize.js"/>
    <script src="main.js"/>
  </head>
  <body onload="main();">loading...</body>
</html>
{% endhighlight %}

Two pieces are better than one? It seems that
[Digital Ocean](https://blog.digitalocean.com/taming-your-go-dependencies/)
and [Mozilla](https://gregoryszorc.com/blog/2014/09/09/on-monolithic-repositories/)
think so. Here are the most popular arguments in favor of a single file:

  * Deployment is faster;
  * Testing is easier, since the entire code is right here;
  *

This is all true. However, just l

**Faster Deployment**.

Obviously, it's easier and faster to deploy one file instead of a file
and a plugin.

However, do we really need faster deployments



The problem is very

Monolithic repositories

fine-grained modularity


Encapsulation.

Faster deployment.

Faster builds/CI.

Metrics accuracy.

Homogeneous tasks.

Less environment dependencies. More intensive testing, since devs are coming from different envs.

Single coding standard.

Shorter names.

Microservices.

Problems:

Dependencies.

Search between repos.

