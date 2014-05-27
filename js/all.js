$(
  function() {
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
        var $element = $(element),
          icon = '<i class="fa fa-link"></i>',
          id = $element.attr('id');
        if (id) {
          $element.prepend(
            $('<a/>').addClass('header-link').attr('href', '#' + id).html(icon)
          );
        }
      }
    );
    $('#subscribe').click(
      function (event) {
        $this = $(this);
        $error = $('#error');
        var email = $('#email').val();
        var reason = $('#reason').val();
        var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (!email) {
          $error.text('No email... What do you mean?');
        } else if (!re.test(email)) {
          $error.text('Email address doesn\'t look correct');
        } else if (!reason) {
          $error.text('I really want to know who you are');
        } else {
          $error.text('');
          $this.attr('disabled', 'disabled');
          $this.html('Please, wait...');
          event.preventDefault();
          $.ajax(
            {
              type: 'POST',
              url: 'https://mandrillapp.com/api/1.0/messages/send.json',
              data: {
                'key': 'GMfq6HmqFFR4HGCVfIu6Zw',
                'message': {
                  'from_email': email,
                  'to': [
                    {
                      'email': 'blog@yegor256.com',
                      'name': 'Yegor Bugayenko',
                      'type': 'to'
                    }
                  ],
                  'text': 'Hi,\n\n'
                    + 'I\'d like to receive monthly updates from yegor256.com,'
                    + ' please add me to the list of subscribers.\n\n'
                    + reason
                    + '\n\nEmail: ' + email
                    + '\n\nThanks'
                    + '\n\n--\nsent through the form',
                  'subject': 'I would like to receive monthly updates',
                  'auto_html': true,
                  'important': true
                }
              },
              success: function () {
                $('#form').html(
                  '<p style="color:green;"><b>Many thanks!</b>'
                  + ' Your request was sent. I\'ll reply by email.</p>'
                );
              },
              error: function () {
                $this.attr('disabled', '');
                $this.html('Oops :( Try again...');
              }
            }
          );
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
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();

// Disqus.com
var disqus_shortname = 'yegor256';
(function () {
    var s = document.createElement('script'); s.async = true;
    s.type = 'text/javascript';
    s.src = '//' + disqus_shortname + '.disqus.com/count.js';
    (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
}());
(function() {
  var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
  dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
  (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
})();

// Google Custom Search Engine
(function() {
  var cx = '012237142075217162703:vly1vck9bom';
  var gcse = document.createElement('script');
  gcse.type = 'text/javascript';
  gcse.async = true;
  gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
    '//www.google.com/cse/cse.js?cx=' + cx;
  var s = document.getElementsByTagName('script')[0];
  s.parentNode.insertBefore(gcse, s);
})();
