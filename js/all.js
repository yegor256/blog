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
