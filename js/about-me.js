/*globals $:false, window:false, document:false, Ya:false, URL:false */
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
