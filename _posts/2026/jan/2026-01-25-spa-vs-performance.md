---
# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "SPA vs Web"
date: 2026-01-25
place: Moscow, Russia
tags: mood
description: |
  ...
keywords:
  - ...
  - ...
  - ...
  - ...
  - ...
image: /images/2026/01/bitter-moon.jpg
jb_picture:
  caption: Bitter Moon (1992) by Roman Polanski
---

...

<!--more-->

{% jb_picture_body %}

In 2000, [Roy Fielding][fielding], the author of [REST] and co-author of [HTTP], described the Web in his [dissertation][fielding-dissertation]:

> A network of web pages, where the user progresses through the application
> by selecting links, resulting in the next page being transferred
> to the user and rendered for their use.

Simply put, each action leads to an HTML page reload.

In the early 2000s, this stopped working well:

* Browsers were slow
* Networks were unreliable
* Full page reloads felt wasteful
* Users expected "desktop-like" interactivity

In 1999, Microsoft introduced [XMLHttpRequest] for [Outlook Web Access][owa], enabling background HTTP requests.
In 2005, [Jesse James Garrett][garrett] coined the term [AJAX] in his essay "[Ajax: A New Approach to Web Applications][ajax-essay]."
This paved the way for the [SPA]: instead of HTML, the server sends [JSON], and the browser reconstructs the page locally.
Then came the frameworks: [Angular], [React], [Vue].
Each formalizes the same idea: the browser hosts the application, the server delivers data.

## A Trivial Example

A calculator.
One input field.
One button.
The formula goes to the server, gets evaluated, and the result appears below.
Here is the [Vue] frontend:

```html
<template>
  <input v-model="formula">
  <button @click="calc">Calculate</button>
  <span>{{ result }}</span>
</template>
<script setup>
import { ref } from 'vue'
const formula = ref('')
const result = ref('')
const calc = async () => {
  const res = await fetch('/api/calc', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ formula: formula.value })
  })
  result.value = (await res.json()).result
}
</script>
```

Here is the [Express] backend:

```javascript
const express = require('express')
const app = express()
app.use(express.json())
app.post('/api/calc', (req, res) => {
  res.json({ result: eval(req.body.formula) })
})
app.listen(3000)
```

Simple.
Clean.
Entirely client-driven.
No server-side templates.
No page reload.
The backend is just a REST endpoint.
If you squint, it looks elegant.

## The Performance Lie

Here's the thing.
The primary justification for this architecture is performance.
Not _actual_ performance.
_Perceived_ performance.

The claim goes like this: servers are slow, rendering HTML takes time, users should see something immediately.
Makes sense, right?

But SPAs do not make backends faster.
They hide backend latency by splitting rendering into pieces and deferring work.
The browser gets a shell quickly; everything else arrives later.

A slow backend is no longer a hard failure.
There is no long blank page.
No obvious bottleneck.
Instead, there are spinners.
Placeholders.
Partial content.
The system "feels alive," even if it's slow.

HTTP itself does not forbid long responses.
Browsers will wait.
The real problem is user perception: a blank screen looks broken.
SPAs solve perception, not performance.

## The Architectural Consequence

Once partial loading is acceptable, backend execution time stops being a first-order concern.
Latency is externalized to the user experience instead of being eliminated.

Open Facebook.
Watch the page load in fragments.
Content shifts.
Controls appear late.
Some parts arrive seconds after others.
You wait, adapt, and accept it.

Same with LinkedIn.
Same with Binance.
The user is trained to mentally assemble the interface.

Now open [Stack Overflow].
One request.
One HTML document.
Predictable layout.
No suspense.
Either the page loads, or it doesn't.

See the difference?

In the traditional model, slowness is a bug.
In the SPA model, slowness is a UX problem.
Bugs get fixed.
UX problems get tolerated.

## The Thesis

SPA architecture lowers the cost of backend inefficiency.
It makes suboptimal design acceptable.
It shifts the burden from engineers to users.

And once that shift happens, there is little incentive to go back.
The frontend team handles the spinners.
The backend team ships slow APIs.
Everyone is busy.
Everyone is productive.
The user waits.

## The Alternative

Server-rendered HTML.
Minimal JavaScript.
Full-page navigation.

Not nostalgia.
Discipline.

Not going backwards.
Restoring pressure where it belongs.

If your page takes three seconds to render, you'll know.
You won't hide it behind a skeleton screen.
You'll fix it.

That's the difference.

[JSON]: https://en.wikipedia.org/wiki/JSON
[Angular]: https://angular.io/
[React]: https://react.dev/
[Vue]: https://vuejs.org/
[Node.js]: https://nodejs.org/
[Express]: https://expressjs.com/
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
