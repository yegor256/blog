---
layout: post
title: "Tacit, a CSS Framework Without Classes"
date: 2015-04-13
tags: pets
description: |
  Tacit is an open source CSS framework without a single
  class, which makes it very easy to use and learn.
keywords:
  - css framework
  - css framework comparison
  - css framework responsive
  - css framework for web apps
  - css framework vs custom
social:
  - hackernews: https://news.ycombinator.com/item?id=9345271
  - reddit: https://www.reddit.com/r/programming/comments/32ianw/tacit_a_css_framework_without_classes/
---

I've been using [Bootstrap](http://getbootstrap.com/)
for more than two years in multiple projects,
and my frustration has been building. First of all, it's too massive for
a small web app. Second, it is not fully self-sufficient; no matter
how much you follow its principles of design, you end up with your
own CSS styles anyway. Third, and most importantly, its internal
design is messy. Having all this in mind, I created
[**tacit**](https://github.com/yegor256/tacit), my own CSS framework,
which immediately received positive feedback on
[Hacker News](https://news.ycombinator.com/item?id=9345271).

<!--more-->

_Tacit_, according to Google, means "understood or implied without being stated."
That's exactly the idea of the [framework](https://github.com/yegor256/tacit).
It doesn't have a single
CSS class and can be applied to any valid HTML5 document. For example, you
have an HTML document:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Subscribe</title>
  </head>
  <body>
    <section>
      <p>Are you interested in learning more?</p>
      <form>
        <label>Email:</label>
        <input name="email"/>
        <button type="submit">Subscribe</button>
      </form>
    </section>
  </body>
</html>
```

This is how it looks in Safari:

{% figure /images/2015/04/html-in-safari-without-tacit.jpg 600 %}

Now, I add `tacit.min.css` to it:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Subscribe</title>
    <link rel="stylesheet" type="text/css"
      href="http://yegor256.github.io/tacit/tacit.min.css"/>
  </head>
  <body>
    <section>
      <p>Are you interested in learning more?</p>
      <form>
        <label>Email:</label>
        <input name="email" type="text"/>
        <button type="submit">Subscribe</button>
      </form>
    </section>
  </body>
</html>
```

This is how it looks in the same Safari browser:

{% figure /images/2015/04/html-in-safari-with-tacit.jpg 600 %}

I hope you got the idea. The HTML itself wasn't changed at all. All CSS
styles are applied to standard HTML elements. Unlike many other CSS frameworks,
in Tacit you don't have to mention CSS classes in the HTML document. The HTML
stays clean and only exposes the data in a pure HTML5 way.

The HTML document is still readable and usable, but it doesn't have the
good-looking-graphics component. Tacit adds that component in a non-intrusive
manner.

{% youtube SCcJcSVBSpU %}

Of course, in many projects, the default layout features of Tacit won't
be enough. In most cases, I still have to add my own CSS classes and inline
styles. But Tacit gives me an adequate foundation to start from. It solves
most of the problems associated with responsiveness of forms, appearance of
form controls, tables, fonts, and colors.

Tacit allows me to focus on functionality from the first day of a project. And
the functionality immediately looks attractive. I have tried many other
frameworks, including [Bootstrap](http://getbootstrap.com/),
[Kube](http://imperavi.com/kube/), and
[Pure](http://purecss.io/). None of them are designed with this concept in mind.
They all put CSS in front of HTML. In all of them, CSS is the most important
element of web design, while HTML is something that assists.

Tacit takes a different approach. In Tacit, HTML is king while CSS is a supportive
element that only makes data look better.

Enjoy!
