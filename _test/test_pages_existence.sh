#!/bin/bash
set -e

pages="CNAME
404.html
contents.html
best.html
favicon.ico
robots.txt
rss.xml
unsubscribe.html
2014/04/06/introduction.html
tag/aop.html
p/2/index.html
js/post.js
images/yegor-bugayenko.png
gnuplot/2014/11/hoc-vs-loc.svg
css/fontcustom.woff
css/layout.css
fonts/2AACA7_0_0.ttf
about-me.html
sitemap.xml
index.html"

for p in $pages; do
  p="_site/$p"
  if [ ! -f $p ]; then
    echo "page $p doesn't exist!"
    exit -1
  fi
done
