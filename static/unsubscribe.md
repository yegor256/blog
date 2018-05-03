---
layout: static
title: "Unsubscribe"
date: 2014-06-11
permalink: unsubscribe.html
description: |
  Opt-out the monthly email update newsletter. I will never
  email you again once you fill this form and send it to me.
keywords:
  - unsubscribe
script: |
  $('#email').ready(
    function() {
      var query = window.location.search,
        matches = query.match(/email=([^&]+)/);
      if (matches !== null) {
        $('#email').val(matches[1]);
      }
    }
  );
---

I'm sorry to see you leaving :(

<form action="https://formspree.io/blog@yegor256.com" method="POST"><fieldset id="form">
  <input type="hidden" name="_next" value="https://www.yegor256.com/unsubscribed.html"/>
  <input type="hidden" name="_subject" value="unsubscribe me"/>
  <input type="hidden" name="_format" value="text"/>
  <label for="email">Your email</label>
  <input id="email" class="field field-text" name="email" size="25" maxlength="255" type="email" required="required"/>
  <label for="unsubscribe">&nbsp;</label>
  <button id="unsubscribe" class="field">Unsubscribe</button>
</fieldset></form>

You can always [subscribe](/about-me.html#form) again.
