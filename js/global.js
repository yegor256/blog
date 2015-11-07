/*globals $:false, window:false, document:false, Ya:false, URL:false */
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
  }
);

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

// disqus.com
var disqus_shortname = 'yegor256';
var disqus_url = document.location.href.split('?')[0].split('#')[0];
$(
  function() {
    'use strict';
    $('<script>')
      .attr('src', '//a.disquscdn.com/count.js')
      .attr('async', 'async')
      .attr('defer', 'defer')
      .appendTo('head');
  }
);
