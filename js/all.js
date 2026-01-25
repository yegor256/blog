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
    $('#search-query').focus(function() {
      $('.google').css('visibility', 'visible');
    }).blur(function() {
      $('.google').css('visibility', 'hidden');
    });
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
      // no need to add an image:
      // $(this).append('<img src="/images/icons/link.svg" class="link" alt="external"/>');
    });
    if ($('.buttons').css('display') !== 'none') {
      $(".button[href!='#']").click(
        function (event) {
          event.preventDefault();
          const $btn = $(this);
          window.open(
            $btn.attr('href'),
            $btn.attr('title'),
            'width=640,height=300'
          );
        }
      );
      const url = document.location.href.split('?')[0].split('#')[0];
      const eurl = encodeURIComponent(url);
      const border = '1px solid #ffa094';
      const timeout = 5000;
      function fetchCount(name, endpoint, extractor) {
        const $counter = $('.count-' + name);
        if (!$counter.length) {
          return;
        }
        $.ajax({
          dataType: 'jsonp',
          async: true,
          timeout: timeout,
          url: endpoint,
          success: function(json) {
            const count = extractor(json);
            if (count > 0) {
              $counter.html(number(count)).fadeIn();
            }
          },
          error: function() {
            $('.share .icon-' + name).css('border', border);
          }
        });
      }
      fetchCount(
        'facebook',
        'https://graph.facebook.com/?callback=?&ids=' + eurl,
        function(json) { return json[url] ? json[url].share.share_count : 0; }
      );
      fetchCount(
        'linkedin',
        'https://www.linkedin.com/countserv/count/share?format=jsonp&callback=?&url=' + eurl,
        function(json) { return json.count; }
      );
      fetchCount(
        'reddit',
        'https://www.reddit.com/api/info.json?jsonp=?&url=' + eurl,
        function(json) { return json.data.children.length; }
      );
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
  });
}
