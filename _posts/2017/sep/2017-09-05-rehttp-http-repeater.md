---
layout: post
title: "ReHTTP.net&mdash;HTTP Repeater"
date: 2017-09-05
place: Odessa, Ukraine
tags: pets
description: |
  Some HTTP requests that arrive at my web apps
  can't be processed for technical reasons and I need
  them to be re-submitted; rehttp.net does exactly that.
keywords:
  - http repeater
  - http service mesh
  - http webhook reliability
  - webhook repeater
  - repeat webhook
---

{% badge https://www.rehttp.net/images/logo.svg 92 https://www.rehttp.net %}

I faced a problem a few weeks ago with
[0pdd.com](https://www.0pdd.com), one of my web apps that is
supposed to receive HTTP requests (known as
[webhooks](https://developer.github.com/webhooks/)) from GitHub:
sometimes the app is down, GitHub gets an HTTP error, and never
sends the request again. The request simply gets lost. There is absolutely
no way to receive it again once the app is back up. I realized that I needed
a [service mesh](https://buoyant.io/2017/04/25/whats-a-service-mesh-and-why-do-i-need-one/)
between GitHub and my web app, to accept HTTP
requests and repeat them later if they can't be delivered immediately.

<!--more-->

I created [rehttp.net](https://www.rehttp.net) to do exactly that.

See, the URL I've been giving to GitHub is this one:

```text
https://www.0pdd.com/hook/github
```

From now on a new URL has to be used:

```text
https://www.rehttp.net/p/https://www.0pdd.com/hook/github
```

It looks very similar, but starts with `https://www.rehttp.net/p/`. GitHub sends
all webhook PUT/POST requests to the ReHTTP server, which stores
them in a temporary database (I'm using AWS DynamoDB).

ReHTTP attempts to deliver them immediately. If something goes wrong and
the server HTTP response code is not in the 200-299 range, the next attempt is made
in about an hour. Then it retries every hour for about a day. If all
attempts fail, it abandons the request and that's it.

What is interesting is that now I can see a summary of my API
[here](https://www.rehttp.net/i?u=http%3A%2F%2Fwww.0pdd.com%2Fhook%2Fgithub).
I see how many requests were processed successfully over the last 24 hours
and how many of them failed. Also, I have this cute button:

<img src="https://www.rehttp.net/b?u=http%3A%2F%2Fwww.0pdd.com%2Fhook%2Fgithub" alt='badge'/>

And I have a URL for checking the status of the entire API:

```text
https://www.rehttp.net/s?u=http%3A%2F%2Fwww.0pdd.com%2Fhook%2Fgithub
```

I gave this URL to [StatusCake](https://www.statuscake.com/) to
ping it every five minutes. If and when
something goes wrong, StatusCake will email me and drop me a message
on the phone.

ReHTTP is absolutely free. It is written in Java and the code is open.
See its [GitHub repository](https://github.com/yegor256/rehttp)
and contribute if you find any bugs or just want to add a feature.
