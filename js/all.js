/*globals $:false, window:false, document:false, URL:false */
$(
  function() {
    'use strict';
    function number(num) {
      if (num > 1000) {
        return (num / 1000).toFixed(1) + 'k';
      }
      return num;
    }
    if ($('.buttons').css('display') !== 'none') {
      $('.button').click(
        function (event) {
          event.preventDefault();
          var $this = $(this);
          window.open(
            $this.attr('href'),
            $this.attr('title'),
            'width=640,height=300'
          );
        }
      );
      var url = encodeURIComponent(document.location.href.split('?')[0].split('#')[0]);
      $.getJSON(
        'http://free.sharedcount.com/?apikey=d730c518430eabcabc46ab79528c744067afa17e&url=' + url,
        function (data) {
          if (data.GooglePlusOne !== 0) {
            $('.count-googleplus').html(number(data.GooglePlusOne)).fadeIn();
          }
        }
      );
      // @see http://stackoverflow.com/questions/32172969/how-to-get-twitter-url-count
      // $.getJSON(
      //   'http://urls.api.twitter.com/1/urls/count.json?callback=?&url=' + url,
      //   function(json) {
      //     var count = json.count;
      //     if (count > 0) {
      //       $('.count-twitter').html(number(count)).fadeIn();
      //     }
      //   }
      // );
      // $.getJSON(
      //   'https://api.facebook.com/method/links.getStats?format=json&urls=' + url,
      //   function(json) {
      //     var count = json[0].total_count;
      //     if (count > 0) {
      //       $('.count-facebook').html(number(count)).fadeIn();
      //     }
      //   }
      // );
      $.getJSON(
        'https://www.linkedin.com/countserv/count/share?format=jsonp&callback=?&url=' + url,
        function(json) {
          var count = json.count;
          if (count > 0) {
            $('.count-linkedin').html(number(count)).fadeIn();
          }
        }
      );
      $.getJSON(
        'http://www.reddit.com/api/info.json?jsonp=?&url=' + url,
        function(json) {
          var count = json.data.children.length;
          if (count > 0) {
            $('.count-reddit').html(number(count)).fadeIn();
          }
        }
      );
      // $.getJSON(
      //   'http://www.stumbleupon.com/services/1.01/badge.getinfo?url=' + url,
      //   function(json) {
      //     var count = json.result.views;
      //     if (count > 0) {
      //       $('.count-stumbleupon').html(number(count)).fadeIn();
      //     }
      //   }
      // );
    }
  }
);

$(
  function() {
    'use strict';
    $('h2').each(
      function (idx, element) {
        var $element = $(element), id = $element.attr('id');
        if (id) {
          $element.attr('name', id).append(
            $('<a/>').addClass('link')
              .attr('href', '#' + id)
              .append('<i class="icon icon-link notranslate"></i>')
          );
        }
      }
    );
  }
);

$(
  function() {
    'use strict';
    $('.main p a, .main ul a, .main ol a').each(
      function () {
        var $this = $(this);
        if (this.href.hostname && this.href.hostname !== window.location.hostname) {
          $this.append('<i class="icon icon-exit foreign"></i>');
        }
      }
    );
  }
);
