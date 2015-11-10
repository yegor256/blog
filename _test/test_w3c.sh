#!/bin/bash
set -e

find _site -name '*.html' | xargs -P 5 -n 1 ruby _test/validate_html.rb
