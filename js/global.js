/*globals $:false, window:false, document:false, URL:false */
$(
  function() {
    'use strict';
    $('#search-query').lunrSearch(
      {
        indexUrl: '/search.json',
        results: '#search-results',
        entries: '.entries',
        template: '#search-results-template'
      }
    );
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

// yandex metrika
window.yandex_metrika_callbacks = [];
window.yandex_metrika_callbacks.push(
  function() {
    'use strict';
    window.yaCounter26361360 = new Ya.Metrika(
      {
        id:26361360,
        webvisor:true,
        clickmap:true,
        trackLinks:true,
        accurateTrackBounce:true
      }
    );
  }
);

// Google Analytics
var _gaq = [];
_gaq.push(['_setAccount', 'UA-1963507-32']);
_gaq.push(['_trackPageview']);
