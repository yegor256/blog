---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Jare.io, an Instant and Free CDN"
date: 2016-03-30
place: Palo Alto, CA
tags: pets
description: |
  If you want your images, script, or CSS files
  be available via a CDN, use jare.io, an instant
  and free service.
keywords:
  - CDN
  - simple CDN
  - quick CDN
  - fast CDN
  - free CDN
social:
  - hackernews: https://news.ycombinator.com/item?id=11394981
---

{% badge https://www.jare.io/images/logo.svg 92 https://www.jare.io %}

CDN stands for a Content Delivery Network. Technically, it is a bunch
of servers located in different countries and continents. You give them
your `logo.gif` and they give you a URL, which resolves to a different
server depending on who is trying to resolve it. As a result, the
file is always close to the end-user and your website loads much faster
than without a CDN. Sounds good, but all CDN providers want money
for their service and usually a rather complex setup and registration
procedure. My pet project [jare.io](https://www.jare.io) is a free
CDN that is simple to configure. It utilizes AWS CloudFront resources.

<!--more-->

First, let me show how it works and then, if you're interested in
the details, I will explain how it's done internally. Say you have
this HTML:

```html
<img src="//www.teamed.io/image/logo.svg"/>
```

I want this `logo.svg` to be delivered via a CDN. There are two steps.
First, I register my domain at [jare.io](https://www.jare.io):

{% figure /images/2016/03/jare-1.png 600 %}

Second, I change my HTML:

```html
<img src="//cf.jare.io/?u=https://www.teamed.io/images/logo.svg"/>
```

That's it.

Try it with your own resources and you will see how
much faster they will be loaded.

It's absolutely free, but I ask you to be reasonable. If your traffic
is huge, you need your own account in CloudFront or somewhere else. My
service is for small projects.

Now for more technical details, if you want to know how technically
this solution works. First, let's discuss what CDN is and how it works.

## URL, DNS, TCP, HTTP

When your browser wants to load an image, it has a [URL](https://en.wikipedia.org/wiki/Uniform_Resource_Locator)
for that, like in the example above. This is the URL: `https://www.teamed.io/image/logo.svg`.
There are three important parts in this address. First is `http`, the
[protocol](https://en.wikipedia.org/wiki/Communications_protocol).
Second is `www.teamed.io`, the [host](https://en.wikipedia.org/wiki/Host_%28network%29) name,
and the tail `/images/logo.svg`, which is the
[path](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier#Syntax).
To load the image, the browser has to open a
[socket](https://en.wikipedia.org/wiki/Network_socket),
connecting your computer and the server, which has the image. To open a
socket, the browser needs to know the
[IP address](https://en.wikipedia.org/wiki/IP_address) of the server.

There is no such address in that URL. In order to find the IP address,
the browser is doing what is called a lookup. It connects to the
nearest [name server](https://en.wikipedia.org/wiki/Name_server)
and asks "what is the IP address of www.teamed.io?"
The answer usually contains a single IP address:

```text
$ nslookup www.teamed.io
Server:   172.16.0.1
Address:  172.16.0.1#53

Non-authoritative answer:
www.teamed.io canonical name = teamed.github.io.
teamed.github.io  canonical name = github.map.fastly.net.
Name: github.map.fastly.net
Address: 199.27.79.133
```

IP address of `www.teamed.io` is `199.27.79.133`, at the time of writing.

When the address is known, the browser opens a new socket and sends
an [HTTP request](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_message)
through it:

```text
GET /images/logo.svg HTTP/1.1
Host: www.teamed.io
Accept: image/*
```

The server responds with an
[HTTP response](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Response_message):

```text
HTTP/1.1 200 OK
Content-Type: image/svg+xml

[SVG image content goes here, over 1000 bytes]
```

That is the [SVG](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics)
image we're looking for. The browser renders it on the web page
and that's it.

## The Network of Edge Servers

So far so good, but if the distance between your browser and that IP address
is rather large, loading the image will take a lot of time. Well, hundreds
of milliseconds. Try to load this image, which is located on a server
that is hosted in Prague, Czech Republic (I'm using `curl` as suggested
[here](https://josephscott.org/archives/2011/10/timing-details-with-curl/)):

```text
$ curl -w "@f.txt" -o /dev/null -s \
  https://www.vlada.cz/images/vlada/vlada-ceske-republiky_en.gif
    time_namelookup:  0.005
       time_connect:  0.376
   time_pretransfer:  0.377
 time_starttransfer:  0.566
                    ----------
         time_total:  0.567
```

I'm trying to do it from Palo Alto, California, which is about half a globe
away from Prague. As you can see, it takes over 500ms. That's too much, especially
if a web page contains many images. Overall, page loading may take seconds,
just because the server is too far away from me. Well, it will inevitably be
too far away from some users, no matter where we host it. If we host it here
in California, it will be close enough to me and the image will be loaded
instantly (less than 50ms). But then it will be too slow for users in Prague.

This problem has no solutions if the server generates images or pages
on the fly in some unique way and if we can't install a number of servers
in different countries and continents. But in most cases, such as our logo example, this is not a problem.
This logo doesn't need to be unique for
each user. It is a very _static_ resource, which needs to be created only once
and be delivered to everybody, without any changes.

So, how about we install a server somewhere here in California and let
Californian users connect to it. When a request for `logo.gif` comes
to one of the _edge_ servers, it will connect to the central server
in Prague and load the file. This will happen only once. After that, the
edge server will not request the file
from the central server. It will return it immediately, from its internal cache.

We need to have many edge servers, preferably in all countries where
our users may be located. The first request will take longer, but all others
will be much faster because they will be served from the closest edge server.

Now, the question is how the browser will know which edge server is the closest, right?
We simply trick the domain name resolution process. Depending on who is asking,
the DNS will give different answers. Let's take `cf.jare.io`, for example (it
is the name of all edge servers responsible for delivering our content
in AWS CloudFront, a CNAME for `djk1be5eatcae.cloudfront.net`).
If I'm looking it up from California, I'm getting the following answer:

```text
$ nslookup cf.jare.io
Server:   192.168.1.1
Address:  192.168.1.1#53

Non-authoritative answer:
cf.jare.io  canonical name = djk1be5eatcae.cloudfront.net.
Name: djk1be5eatcae.cloudfront.net
Address: 54.230.141.211
```

An edge server with IP address `54.230.141.211` is located in
[San Francisco](https://db-ip.com/54.230.141.211). This
is rather close to me, less than fifty miles. If I do the same operation
from a server in Virginia, I get a different response:

```text
$ nslookup cf.jare.io
Server:   172.16.0.23
Address:  172.16.0.23#53

Non-authoritative answer:
cf.jare.io  canonical name = djk1be5eatcae.cloudfront.net.
Name: djk1be5eatcae.cloudfront.net
Address: 52.85.131.217
```

An edge server with IP address `52.85.131.217` is located in
[Washington](https://db-ip.com/52.85.131.217), which is far away from
me, but very close to the server I was making the lookup from.

There are thousands of name servers around the world and all of them
have different information about where that edge server `cf.jare.io`
is physically located. Depending on who is asking, the answer will be different.

## AWS CloudFront

[CloudFront](https://aws.amazon.com/cloudfront/) is one of the simplest
CDN solutions. All you have to do to start delivering your content
through their edge nodes is to create a "distribution" and configure it.
A distribution is basically a connector between content origin and
edge servers:

{% plantuml style="width:75%" %}
skinparam componentStyle uml2
Browser -right-> [Edge]
[Edge] -right-> [Central]
[Central] -right-> [Origin]
{% endplantuml %}

One of edge servers receives an HTTP request. If it already has that
`logo.svg` in its cache, it immediately returns an HTTP response with its
content inside. If its cache is empty, the edge server makes an HTTP
request to the central server. This server knows about the "distribution"
and its configuration. It makes an HTTP connection to the origin server,
which is `www.teamed.io` and asks it to return `logo.svg`. When done,
the image is returned to the edge server, where it is cached.

This looks rather simple, but it's not free and it's not that quick to configure.
You have to create an account with CloudFront, register your credit card
there, and get an approval. Then you have to create a distribution and configure it.
You should then create that CNAME in your name server. If you're doing it
for a single website, it's not a big deal. If you have a dozen websites,
it's a time consuming operation.

## Jare.io, a Middle Man

Jare.io is an extra component in that diagram, which makes your
life easier:

{% plantuml style="width:75%" %}
skinparam componentStyle uml2
Browser -right-> [Edge]
[Edge] -right-> [Central]
[Central] -down-> [Relay]
[Relay] -right-> [Origin]
{% endplantuml %}

Jare.io has a "relay," which acts as an origin server for CloudFront. All
requests that arrive to `cf.jare.io` are dispatched to the relay. The relay
decides what to do with them. The decision is based on the information
from the HTTP request URI. For example, the request from the browser
has this URI path:

```text
/?u=https://www.teamed.io/images/logo.svg
```

Remember, the request is made to `cf.jare.io`, which is the address of
the edge server. This exact URI arrives at `relay.jare.io`. The URI contains
enough information to make a decision about which file has to be returned.
The relay makes a new HTTP request to `www.teamed.io` and retrieves the image.

The beauty of this solution is that it's easy. For small websites,
it is a free and quick CDN.

By the way, when we query the same image through jare.io (and CloudFront),
it comes back much faster:

```text
$ curl -w "@f.txt" -o /dev/null -s \
  http://cf.jare.io/?u=www.vlada.cz/images/vlada/vlada-ceske-republiky_en.gif
    time_namelookup:  0.005
       time_connect:  0.021
   time_pretransfer:  0.021
 time_starttransfer:  0.041
                    ----------
         time_total:  0.041
```

Most of the work is done by AWS CloudFront, while jare.io is just a
relay that makes its configuration more convenient. Besides, it makes
it free, because jare.io is sponsored by
[Zerocracy](https://www.zerocracy.com). In other words, my company will
pay for your usage of CloudFront. I would appreciate if you kept that in
mind and didn't use jare.io for traffic-intensive resources.
