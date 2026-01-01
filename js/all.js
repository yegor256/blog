/**
 * SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */

/*globals $:false, window:false, document:false */

// This is Disqus configuration, to make it identify the website correctly.
var disqus_domain = 'yegor256.com';
var disqus_shortname = 'yegor256';

var VK = {};
if (typeof($) != 'undefined') {
  $(function() {
    'use strict';
    function number(num) {
      if (num > 1000) {
        return (num / 1000).toFixed(1) + 'k';
      }
      return num;
    }
    $(document).on('keydown', function(e) {
      if ($(e.target).is('input, textarea')) {
        return;
      }
      if ((e.key === 'f' || e.key === 'F') && !e.altKey && !e.ctrlKey && !e.metaKey) {
        e.preventDefault();
        const $f = $('#search-query');
        $f.focus();
        $f.attr('placeholder', '');
      }
    });
    $('article a[href]').each(function () {
      const href = $(this).attr('href');
      if (!href.startsWith('http') || href.includes(location.hostname)) {
        return;
      }
      if ($(this).find('img').length > 0) {
        return;
      }
      $(this).addClass('external');
      $(this).append('<img src="/images/icons/link.svg" class="link" alt="external"/>');
    });
    if ($('.buttons').css('display') !== 'none') {
      $(".button[href!='#']").click(
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
      var url = document.location.href.split('?')[0].split('#')[0],
        eurl = encodeURIComponent(url),
        border = '1px solid #ffa094',
        timeout = 5000;
      if ($('.count-facebook').length) {
        $.ajax({
          dataType: 'jsonp',
          async: true,
          timeout: timeout,
          url: 'https://graph.facebook.com/?callback=?&ids=' + eurl,
          success: function(json) {
            if (json[url]) {
              var count = json[url].share.share_count;
              if (count > 0) {
                $('.count-facebook').html(number(count)).fadeIn();
              }
            }
          },
          error: function() {
            $('.share .icon-facebook').css('border', border);
          }
        });
      }
      if ($('.count-linkedin').length) {
        $.ajax({
          dataType: 'json',
          async: true,
          timeout: timeout,
          url: 'https://www.linkedin.com/countserv/count/share?format=jsonp&callback=?&url=' + eurl,
          success: function(json) {
            var count = json.count;
            if (count > 0) {
              $('.count-linkedin').html(number(count)).fadeIn();
            }
          },
          error: function() {
            $('.share .icon-linkedin').css('border', border);
          }
        });
      }
      if ($('.count-reddit').length) {
        $.ajax({
          dataType: 'json',
          async: true,
          timeout: timeout,
          url: 'https://www.reddit.com/api/info.json?jsonp=?&url=' + eurl,
          success: function(json) {
            var count = json.data.children.length;
            if (count > 0) {
              $('.count-reddit').html(number(count)).fadeIn();
            }
          },
          error: function() {
            $('.share .icon-reddit').css('border', border);
          }
        });
      }
      if ($('.count-vk').length) {
        VK.Share = {};
        VK.Share.count = function (index, count) {
          if (count > 0) {
            $('.count-vk').html(number(count)).fadeIn();
          }
        };
        $.ajax({
          dataType: 'jsonp',
          async: true,
          timeout: timeout,
          url: 'https://vk.com/share.php?act=count&url=' + eurl
        });
      }
      /*
      if ($('.count-hackernews').length) {
        $.ajax({
          dataType: 'json',
          async: true,
          timeout: timeout,
          url: ' "'
            + encodeURIComponent(url.replace('https://www.yegor256.com', ''))
            + '"',
          success: function(json) {
            var count = json.nbHits;
            if (count > 0) {
              $('.count-hackernews').html(number(count)).fadeIn();
            }
          },
          error: function() {
            $('.share .icon-hackernews').css('border', border);
          }
        });
      }
      */
    }
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
    $('.main p a, .main ul a, .main ol a').each(
      function (idx, a) {
        if (a.hostname && a.hostname !== window.location.hostname) {
          var $a = $(this);
          if ($a.find('img').length == 0) {
            $a.addClass('foreign');
          }
        }
      }
    );
  });
}
