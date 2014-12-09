---
layout: static
title: "Unsubscribe"
date: 2014-06-11
permalink: unsubscribe.html
description:
  Opt-out the monthly email update newsletter. I will never
  email you again once you fill this form and send it to me.
keywords:
  - unsubscribe
---

I'm sorry to see you leaving :(

<form id="eform"><fieldset id="form">
  <label for="email">Your email</label>
  <input id="email" class="field field-text" name="email" size="25" maxlength="255" type="email" required="required"/>
  <label for="unsubscribe"></label>
  <button id="unsubscribe" class="field">Unsubscribe</button>
  <span id="error" style="color:red;"></span>
</fieldset></form>

You can always [subscribe](/about-me.html) again.

<script src="/js/send.js?{{ site.data['hash'] }}" async='async' defer='defer'></script>
<script src="/js/unsubscribe.js?{{ site.data['hash'] }}" async='async' defer='defer'></script>
