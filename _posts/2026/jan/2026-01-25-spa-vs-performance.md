---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "SPAs Kill Web Performance"
date: 2026-01-25
place: Moscow, Russia
tags: mood
description: |
  Single Page Applications, once a solution for slow browsers,
  are now a performance bottleneck due to multiple HTTP round-trips.
keywords:
  - single page application
  - SPA performance
  - web architecture
  - AJAX
  - server-side rendering
image: /images/2026/01/bitter-moon.jpg
jb_picture:
  caption: Bitter Moon (1992) by Roman Polanski
---

It seems to be [popular][adamsilver] to design websites as Single Page Applications (SPA).
Instead of showing a new HTML page on every click, an SPA sends a lightweight skeleton with JavaScript.
The JS makes HTTP requests, receives JSON, and injects data into the DOM.
On each user action, the page doesn't reload---only the DOM changes.
Such an architecture, once a response to slow browsers and unreliable networks, is now a [bottleneck][matuzo].
The page is built of fragments, each requiring its own HTTP request.
No matter how fast each request is, the multiplication diminishes all optimization efforts.

<!--more-->

{% jb_picture_body %}

In 2000, [Roy Fielding][fielding], the author of [REST] and co-author of [HTTP], described the Web in his [dissertation][fielding-dissertation]:

> A network of web pages, where the user progresses through the application
> by selecting links, resulting in the next page being transferred
> to the user and rendered for their use.

Simply put, each action leads to an HTML page reload.

In 1999, Microsoft introduced [XMLHttpRequest] for [Outlook Web Access][owa], enabling background HTTP requests.
In 2005, [Jesse James Garrett][garrett] coined the term [AJAX] in his essay "[Ajax: A New Approach to Web Applications][ajax-essay]."
This came in handy when full page reloads stopped working well:

* Browsers were slow
* Networks were unreliable
* Full page reloads felt wasteful
* Users expected "desktop-like" interactivity

_AJAX_ paved the way for the [SPA]: instead of HTML, the server sends [JSON], and the browser reconstructs the page locally.
Then came the frameworks: [Angular] (2010), [React] (2013), [Vue] (2014).
Each formalizes the same idea: the browser hosts the application, the server delivers data.

Imagine a simple online calculator where a user enters "2+3," clicks "Submit," and sees the result right next to the input field.
No page reload.
The [DOM] remains the same.
The JS inside the browser changes only the result of calculation, in a single `<div/>`.

The primary justification for this architecture is _performance_.
If servers are slow, rendering a full HTML page takes longer than just a JSON with the result of calculation.
If the network is unreliable, re-delivering the entire HTML takes longer than just a small JSON document.
Also, if browsers are slow, making a tiny change in the DOM works faster than a full page reload.

This is true, for a trivial example.
However, when an SPA gets larger, the frontend has to make _dozens of round-trips_ to the backend.
Look at what Facebook and LinkedIn are doing while rendering your home page.
A rather simple UI with just a list of recent posts gets filled up by multiple pieces, each leading to its own HTTP request,
  sometimes taking more than a few seconds to complete rendering a page.
Their UX sucks, if you ask me.

Their architects are stupid?
Nope.

The very idea of SPA is flawed.
The architects of Facebook and LinkedIn are the hostages of it.
They can't make their websites run faster, because they, by design, are built of fragments retrievable from the backend.
They must make _multiple_ HTTP round-trips.

The performance penalty of SPAs is structural, not accidental.
Even if HTTP/2 [multiplexes] requests, the UI still waits for JSON to arrive in order---classic
  [head-of-line blocking][head-of-line blocking] at the application layer.
Worse, one request often reveals permissions, feature flags, or entity identifiers needed for the next, turning parallel calls into a waterfall.
Caching doesn't help either: dozens of endpoints, each with its own TTL, rarely produce a full cache hit,
  and partial hits still force the browser to assemble and reconcile the page at runtime
Meanwhile, the browser must juggle layout stabilization, loading indicators, and partial failures---all before meaningful content becomes visible.

What was once a solution for small DOM updates, in an era of slow browsers and unreliable networks, has turned into a dead-end for web design.

{% quote State belongs on the server while HTML is the primary delivery artifact, not JSON. %}

Most web architects simply can't make their websites as fast as [Stack Overflow], which is not an SPA.
It delivers the entire HTML page, [rendered][by-razor] on the server using [Razor], in one [&lt;50ms][50ms] request.
It does use client-side JS components selectively, but these are isolated and don't negate the central role of server HTML for the initial experience.
Their UX is one of the best on the modern web, if you ask me.

Rendering a full page on the server may still be a slow operation.
It may, and it often will.
However, this problem is _solvable_, for example, with the help of caching.
The server is in charge of the data and the state of navigation, making caching possible.

Literally every large, content-heavy, consumer-facing SPA I can think of is horrible in terms of UX.
Even [Gmail] is not an exception.
Their UX would be noticeably better if they followed the principles of Roy Fielding and reloaded the page every time an email is opened.
I'm not kidding.

[JSON]: https://en.wikipedia.org/wiki/JSON
[Angular]: https://angular.io/
[React]: https://react.dev/
[Vue]: https://vuejs.org/
[Stack Overflow]: https://stackoverflow.com/
[fielding]: https://en.wikipedia.org/wiki/Roy_Fielding
[fielding-dissertation]: https://roy.gbiv.com/pubs/dissertation/fielding_dissertation.pdf
[REST]: https://en.wikipedia.org/wiki/REST
[HTTP]: https://en.wikipedia.org/wiki/HTTP
[SPA]: https://en.wikipedia.org/wiki/Single-page_application
[XMLHttpRequest]: https://en.wikipedia.org/wiki/XMLHttpRequest
[owa]: https://en.wikipedia.org/wiki/Outlook_on_the_web
[garrett]: https://en.wikipedia.org/wiki/Jesse_James_Garrett
[AJAX]: https://en.wikipedia.org/wiki/Ajax_(programming)
[ajax-essay]: https://designftw.mit.edu/lectures/apis/ajax_adaptive_path.pdf
[DOM]: https://en.wikipedia.org/wiki/Document_Object_Model
[adamsilver]: https://adamsilver.io/blog/the-problem-with-single-page-applications/
[matuzo]: https://www.matuzo.at/blog/2023/single-page-applications-criticism/
[Gmail]: https://gmail.com
[50ms]: https://highscalability.com/stackoverflow-update-560m-pageviews-a-month-25-servers-and-i/
[Razor]: https://en.wikipedia.org/wiki/ASP.NET_Razor
[by-razor]: https://scaleyourapp.com/svelte-at-stack-overflow/
[head-of-line blocking]: https://en.wikipedia.org/wiki/Head-of-line_blocking
[multiplexes]: https://stackoverflow.com/questions/36835972/is-the-per-host-connection-limit-raised-with-http-2/36847527#36847527
