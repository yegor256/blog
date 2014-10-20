/*globals $, send_email, window */
$(
  function() {
    'use strict';
    $('#eform').submit(
      function (event) {
        event.preventDefault();
        var $button = $('#unsubscribe'), email = $('#email').val();
        $button.attr('disabled', 'disabled');
        $button.html('Please, wait...');
        send_email(
          email,
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
            $button.attr('disabled', '');
            $button.html('Oops :( Try again...');
          }
        );
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
