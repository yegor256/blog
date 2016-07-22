/*globals $:false, window:false, document:false, Ya:false, URL:false */
$(
  function() {
    'use strict';
    $('.main p a, .main ul a, .main ol a').each(
      function () {
        var $this = $(this), domain = new URL(this.href).hostname;
        if (domain && domain !== window.location.hostname) {
          $this.append('<i class="icon icon-exit foreign"></i>');
        }
      }
    );
  }
);
