---
layout: post
title: "Jare.io, an Instant CDN"
date: 2016-03-09
place: Palo Alto, CA
tags: cdn
description:
  If you want your images, script, or CSS files
  be available via a CDN, use jare.io, an instant
  and free service.
keywords:
  - CDN
  - simple CDN
  - quick CDN
  - fast CDN
  - free CDN
---

{% badge http://www.jare.io/images/logo.svg 92 http://www.jare.io %}

CDN stands for a Content Delivery Network. Technically, it is a bunch
of servers located in different countries and continents. You give them
your `logo.gif` and they give you a URL, which resolves to a different
server, depending on who is trying to resolve it. As a result, the
file is always close to the end-user and your website loads way faster
than without a CDN. Sounds good, but all CDN providers want money
for their service and usually a rather complex setup and registration
procedure. My pet project [jare.io](http://www.jare.io) is a free
CDN that is simple to configure. It utilizes AWS CloudFront resources.

<!--more-->

First, let me show how it works and then, if you're interested in
the details, will explain how it's done internally. Say, you have
this HTML:

{% highlight html %}
<img src="http://www.teamed.io/image/logo.svg"/>
{% endhighlight %}

I want this `logo.svg` to be delivered via a CDN. There are two steps.
First, I register my domain at [jare.io](http://www.jare.io):

xxx

Second, I change my HTML:

{% highlight html %}
<img src="http://cf.jare.io/?u=http://www.teamed.io/image/logo.svg"/>
{% endhighlight %}

That's it. Try it with your own resource and you will see how
much faster they will be loaded.

It's absolutely free, but I ask you to be reasonable. If your traffic
is huge, you need your own account in CloudFront or somewhere else. My
service is for small projects.

Now, more technical details, if you want to know how technically
this solution works. First, how CDN works.
