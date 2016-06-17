#!/bin/bash
set -e

find _site/2014/04/06 -name '*.html' -not -name '*.amp.html' | xargs -P 5 -n 1 ruby _travis/validate_html.rb
