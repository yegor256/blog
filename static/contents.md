---
layout: static
title: "Contents"
date: 2014-06-24
permalink: contents.html
description: |
  Contents of the entire blog, in chronological order; the page
  is generated automatically and contains a complete list
  of all articles published in this blog
image: /images/yegor-is-presenting.png
keywords:
  - blog
  - contents
  - software development blog
  - yegor bugayenko blog
  - yegor256 blog contents
  - articles about software development
  - articles about programming
style: |
  .sorter {
    cursor: pointer;
  }
  .active {
    font-weight: bold;
  }
script: |
  function count_comments() {
    var total = 0;
    $('.comment_count').each(
      function() {
        var m = /(\d+) .*/.exec($(this).html());
        if (m) {
          total += parseInt(m[1]);
        }
      }
    );
    var before = $('#total_comments').html();
    var after = ' (' + total + ' comments total)';
    $('#total_comments').css('color', 'gray');
    $('#total_comments').html(after);
    if (total == 0 || before != after) {
      setTimeout(count_comments, 1000);
    } else {
      $('#total_comments').css('color', 'inherit');
    }
  }
  count_comments();
  function sort_by_comments() {
    sort_by(
      function(x) {
        var re = /[^\d]/g;
        return ~~$(x).find('.comment_count').html().replace(re, '');
      }
    );
    $('#by_comments').addClass('active');
  }
  function sort_by_date() {
    sort_by(
      function(x) {
        return Date.parse($(x).find('time').attr('datetime'));
      }
    );
    $('#by_date').addClass('active');
  }
  function sort_by_length() {
    sort_by(
      function(x) {
        return ~~$(x).attr('data-length');
      }
    );
    $('#by_length').addClass('active');
  }
  function sort_by(f) {
    $('#all div.tagged').sort(
      function(a, b) {
        fa = f(a);
        fb = f(b);
        if (fa > fb) {
          return -1;
        }
        if (fb > fa) {
          return 1;
        }
        return 0;
      }
    ).detach().appendTo('#all');
    $('#sorters .sorter').removeClass('active');
  }
---

All tags in alphabetic order (see their [presence stats](/tags.txt)):

{{ site.tags | tag_cloud }}

Intensity of writing:
{% wordcount %},
written in {% placescount %}.

{% figure /stats.svg 600 %}

This is a full list of {{ site.posts.size }} blog posts published<span id="total_comments"></span>:

<div id='sorters'>
Sort by:
<span id="by_date" onclick="sort_by_date();" class="sorter active">date</span>
|
<span id="by_comments" onclick="sort_by_comments();" class="sorter">comments</span>
|
<span id="by_length" onclick="sort_by_length();" class="sorter">length</span>
</div>

<div id="all">
{{ site.posts | yb_tagged_list }}
</div>

{% if jekyll.environment == "production" %}
  <script>var disqus_shortname = 'yegor256';</script>
  <script id="dsq-count-scr" src="//yegor256.disqus.com/count.js" async="async"></script>
{% endif %}
