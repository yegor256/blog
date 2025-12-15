/**
 * SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */

/*globals $:false, document:false, window:false */

window.disqus_config = function () {
  this.page.url = document.location.href.split('?')[0].split('#')[0];
  this.page.identifier = this.page.url;
};
$(function() {
  const s = document.createElement('script');
  s.src = 'https://yegor256.disqus.com/embed.js';
  s.setAttribute('data-timestamp', +new Date());
  document.head.appendChild(s);
});
