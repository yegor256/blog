/*globals $, send_email */
$(
  function() {
    'use strict';
    $('#eform').submit(
      function (event) {
        event.preventDefault();
        var $button = $('#subscribe'),
          email = $('#email').val(),
          reason = $('#reason').val();
        $button.attr('disabled', 'disabled');
        $button.html('Please, wait...');
        send_email(
          email,
          'I\'d like to receive monthly updates from yegor256.com,'
          + ' please add me to the list of subscribers.\n\n'
          + reason,
          'I would like to receive monthly updates',
          function () {
            $('#eform').html(
              '<p class="green"><b>Many thanks!</b>'
              + ' Your request was sent. I\'ll reply by email to'
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
  }
);
