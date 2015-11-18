#!/bin/bash
set -e

find _site -name '*.html' | xargs -P 5 -n 1 ruby _travis/validate_html.rb
