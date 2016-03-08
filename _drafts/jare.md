---
layout: post
title: "Jare.io, an Instant and Free CDN"
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

{% figure /images/2016/03/jare-1.png 600 %}

Second, I change my HTML:

{% highlight html %}
<img src="http://cf.jare.io/?u=http://www.teamed.io/image/logo.svg"/>
{% endhighlight %}

That's it.

Try it with your own resource and you will see how
much faster they will be loaded.

It's absolutely free, but I ask you to be reasonable. If your traffic
is huge, you need your own account in CloudFront or somewhere else. My
service is for small projects.

Now, more technical details, if you want to know how technically
this solution works. First, let's discuss what CDN is and how it works.

## URL, DNS, TCP, HTTP

When your browser wants to load an image, it has a [URL](https://en.wikipedia.org/wiki/Uniform_Resource_Locator)
for that. Like in the example above. This is the URL: `http://www.teamed.io/image/logo.svg`.
There are three important parts in this address. First, it's `http`, the
[protocol](https://en.wikipedia.org/wiki/Communications_protocol).
Second, it's `www.teamed.io`, the [host](https://en.wikipedia.org/wiki/Host_%28network%29) name,
and the tail `/image/logo.svg`, the
[path](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier#Syntax).
To load the image the browser has to open a
[socket](https://en.wikipedia.org/wiki/Network_socket),
connecting your computer and the server, which has the image. To open a
socket the browser needs to know the
[IP address](https://en.wikipedia.org/wiki/IP_address) of the server.

There is no such address in that URL. In order to find the IP address
the browser is doing a, so called, lookup. It connects to the
nearest [name server](https://en.wikipedia.org/wiki/Name_server)
and asks "what is the IP address of www.teamed.io?"
The answer usually contains a single IP address:

{% highlight text %}
$ nslookup www.teamed.io
Server:   172.16.0.1
Address:  172.16.0.1#53

Non-authoritative answer:
www.teamed.io canonical name = teamed.github.io.
teamed.github.io  canonical name = github.map.fastly.net.
Name: github.map.fastly.net
Address: 199.27.79.133
{% endhighlight %}

IP address of `www.teamed.io` is `199.27.79.133`, at the time of writing.

When the address is known, the browser opens a new socket and sends
an HTTP request through it:

The server responds with an HTTP response:

That is the SVG image we're looking for. The browser renders it on the web page
and that's it.

## The Network of Delivery Nodes

So far so good, but if the distance between your browser and that IP address
is rather big, loading of the image will take a lot of time. Well, hundreds
of milliseconds. Try to load this image, which is located on the server
that is hosted in Prague, Czech Republic:

I'm trying to do it from Palo Alto, California, which is about half a globe
away from Prague. As you see, it takes over 200ms. That's too much, especially
if a web page contains many images. Overall page loading may take seconds,
just because the server is too far away from me. Well, it will inevitably
too far away from some users, no matter where we host it. If we host it here,
in California, it will be close enough to me and the image will be loaded
instantly (less than 50ms). But then it will be too slow for users in Prague.

This problem has no solutions, if the server generates that images or pages
on-fly in some unique way and if we can't install a number of servers
in different countries and continents. But in most cases, it's not the case.
Like in our example with a logo. This logo doesn't need to be unique for
each user. It is a very _static_ resource, which needs to be created only once
and be delivered to everybody, without any changes.



