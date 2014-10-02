/*globals $:false, window:false, document:false, Ya:false */
function valid_email(email) {
  'use strict';
  var re = /^(([^<>()\[\]\\.,;:\s@\"]+(\.[^<>()\[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(email);
}
function send_email($button, from, text, subject, success, error) {
  'use strict';
  $.ajax(
    {
      type: 'POST',
      url: 'https://mandrillapp.com/api/1.0/messages/send.json',
      data: {
        'key': 'GMfq6HmqFFR4HGCVfIu6Zw',
        'message': {
          'from_email': from,
          'to': [
            {
              'email': 'blog@yegor256.com',
              'name': 'Yegor Bugayenko',
              'type': 'to'
            }
          ],
          'text': 'Hi,\n\n' + text
            + '\n\nEmail: ' + from
            + '\n\nThanks'
            + '\n\n--\nsent through the form',
          'subject': subject,
          'auto_html': true,
          'important': true
        }
      },
      success: success,
      error: error
    }
  );
}

$(
  function() {
    'use strict';
    $.getJSON(
      'http://free.sharedcount.com/?apikey=d730c518430eabcabc46ab79528c744067afa17e&url=' + encodeURIComponent(document.location.href),
      function (data) {
        if (data.Facebook.total_count !== 0) {
          $('.count-facebook').html(data.Facebook.total_count).fadeIn();
        }
        if (data.Twitter !== 0) {
          $('.count-twitter').html(data.Twitter).fadeIn();
        }
        if (data.GooglePlusOne !== 0) {
          $('.count-googleplus').html(data.GooglePlusOne).fadeIn();
        }
        if (data.LinkedIn !== 0) {
          $('.count-linkedin').html(data.LinkedIn).fadeIn();
        }
        if (data.StumbleUpon !== 0) {
          $('.count-stumbleupon').html(data.StumbleUpon).fadeIn();
        }
        if (data.Diggs !== 0) {
          $('.count-digg').html(data.Diggs).fadeIn();
        }
      }
    );
    window.reddit = function(json) {
      var count = json.data.children.length;
      if (count > 0) {
        $('.count-reddit').html(count).fadeIn();
      }
    };
    var js = document.createElement('script');
    js.type = 'text/javascript';
    js.src = 'http://www.reddit.com/api/info.json?jsonp=reddit&url=' + encodeURIComponent(document.location.href);
    $('head').append(js);
    $('#search-query').lunrSearch(
      {
        indexUrl: '/search.json',
        results: '#search-results',
        entries: '.entries',
        template: '#search-results-template'
      }
    );
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
    $('h2').each(
      function (idx, element) {
        var $element = $(element), id = $element.attr('id');
        if (id) {
          $element.append(
            $('<a/>').addClass('link')
              .attr('href', '#' + id)
              .append('<i class="icon icon-link"></i>')
          );
        }
      }
    );
    $('#subscribe').click(
      function (event) {
        var $this = $(this), $error = $('#error'),
          email = $('#email').val(),
          reason = $('#reason').val();
        if (!email) {
          $error.text('No email... What do you mean?');
        } else if (!valid_email(email)) {
          $error.text('Email address doesn\'t look correct');
        } else if (!reason) {
          $error.text('I really want to know who you are');
        } else {
          $error.text('');
          $this.attr('disabled', 'disabled');
          $this.html('Please, wait...');
          event.preventDefault();
          send_email(
            $this, email,
            'I\'d like to receive monthly updates from yegor256.com,'
            + ' please add me to the list of subscribers.\n\n'
            + reason,
            'I would like to receive monthly updates',
            function () {
              $('#form').html(
                '<p class="green"><b>Many thanks!</b>'
                + ' Your request was sent. I\'ll reply by email to'
                + ' <code>' + email + '</code>.</p>'
              );
            },
            function () {
              $this.attr('disabled', '');
              $this.html('Oops :( Try again...');
            }
          );
        }
      }
    );
    $('#unsubscribe').click(
      function (event) {
        var $this = $(this), $error = $('#error'), email = $('#email').val();
        if (!email) {
          $error.text('No email... Please provide your address');
        } else if (!valid_email(email)) {
          $error.text('Email address doesn\'t look correct');
        } else {
          $error.text('');
          $this.attr('disabled', 'disabled');
          $this.html('Please, wait...');
          event.preventDefault();
          send_email(
            $this, email,
            'I\'d like to opt-out from your monthly updates from yegor256.com,'
            + ' please remove me from the list of subscribers.',
            'I would like to OPT-OUT from your monthly updates',
            function () {
              $('#form').html(
                '<p class="green"><b>Thanks</b>, your request was sent.'
                + ' You will <strong>not</strong> receive any more emails from me to this address:'
                + ' <code>' + email + '</code>.</p>'
              );
            },
            function () {
              $this.attr('disabled', '');
              $this.html('Oops :( Try again...');
            }
          );
        }
      }
    );
    $('#email').ready(
      function() {
        var query = window.location.search, matches = query.match(/email=([^&]+)/);
        if (matches !== null) {
          $('#email').val(matches[1]);
        }
      }
    );
  }
);

// Google Analytics
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-1963507-32']);
_gaq.push(['_trackPageview']);
(function() {
  'use strict';
  var ga = document.createElement('script'), s = document.getElementsByTagName('script')[0];
  ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' === document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
  s.parentNode.insertBefore(ga, s);
}());

// Disqus.com
var disqus_shortname = 'yegor256';
(function () {
  'use strict';
  var s = document.createElement('script'); s.async = true;
  s.type = 'text/javascript';
  s.src = '//' + disqus_shortname + '.disqus.com/count.js';
  (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
}());
(function() {
  'use strict';
  var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
  dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
  (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
}());

// yandex metrika
(function (d, w, c) {
  'use strict';
  (w[c] = w[c] || []).push(function() {
    try {
      w.yaCounter26361360 = new Ya.Metrika({id:26361360,
        clickmap:true,
        trackLinks:true,
        accurateTrackBounce:true});
    } catch(e) { }
  });
  var n = d.getElementsByTagName("script")[0],
    s = d.createElement("script"),
    f = function () { n.parentNode.insertBefore(s, n); };
  s.type = "text/javascript";
  s.async = true;
  s.src = (d.location.protocol === "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";
  if (w.opera === "[object Opera]") {
    d.addEventListener("DOMContentLoaded", f, false);
  } else { f(); }
}(document, window, "yandex_metrika_callbacks"));
