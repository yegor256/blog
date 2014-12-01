#!/bin/bash
set -e

function ping_uri {
  curl --location --silent --output /dev/null --fail \
    -A 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2194.2 Safari/537.36' \
    -H 'Accept:*/*' \
    -H 'Accept-Encoding:gzip,deflate,sdch' \
    -H 'Cache-Control:max-age=0' \
    --retry 8 \
    --write-out '%{url_effective}: %{http_code}\n' $1 || exit 255
}
export -f ping_uri
mkdir -p _temp
find _site -name '*.html' \
  | xargs -P 10 -n 1 ruby _test/fetch_links.rb \
  | sort | uniq \
  | grep -v 'http://www.yegor256.com' \
  | xargs -P 10 -n 1 /bin/bash -c 'ping_uri "$0"'
