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

## What Is an SPA?

In 2000, [Roy Fielding][fielding], the author of [REST] and co-author of [HTTP], described the Web in his [dissertation][fielding-dissertation]:

> A network of web pages, where the user progresses through the application
> by selecting links, resulting in the next page being transferred
> to the user and rendered for their use.

Simply put, each action leads to an HTML page reload.

In the late 2000s, this stopped working well:

* Browsers were slow
* Networks were unreliable
* Full page reloads felt wasteful
* Users expected "desktop-like" interactivity

The [SPA] was introduced.
Instead of HTML, the server sends [JSON].
The browser reconstructs the HTML page locally.
Then came the frameworks: [Angular], [React], [Vue].
Each formalizes the same idea: the browser hosts the application, the server delivers data.

## A Trivial Example

One HTML page.
One textarea.
A Save button.
Clicking Save sends JSON to an [Express] backend, which writes the content to a file.
Here is the [Vue] frontend:

```html
<template>
  <textarea v-model="text"></textarea>
  <button @click="save">Save</button>
</template>
<script setup>
import { ref, onMounted } from 'vue'
const text = ref('')
onMounted(async () => {
  const res = await fetch('/api/text')
  text.value = (await res.json()).text
})
const save = async () => {
  await fetch('/api/text', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ text: text.value })
  })
}
</script>
```

Here is the backend:

```javascript
const express = require('express')
const fs = require('fs')
const app = express()
app.use(express.json())
app.get('/api/text', (req, res) => {
  res.json({ text: fs.readFileSync('data.txt', 'utf8') })
})
app.post('/api/text', (req, res) => {
  fs.writeFileSync('data.txt', req.body.text)
  res.json({ ok: true })
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
