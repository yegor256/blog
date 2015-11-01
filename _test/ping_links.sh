#!/bin/bash
set -e

function ping_uri {
  curl --location --silent --output /dev/null --fail \
    -A 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2194.2 Safari/537.36' \
    -H 'Accept:*/*' \
    -H 'Accept-Encoding:gzip,deflate,sdch' \
    -H 'Cache-Control:max-age=0' \
    --retry 8 \
    --write-out '%{http_code} %{url_effective}\n' $1
}
export -f ping_uri
mkdir -p _temp
find _site -name '*.html' \
  | xargs -P 10 -n 1 ruby _test/fetch_links.rb \
  | sort | uniq \
  | grep -v 'http://www.yegor256.com' \
  | xargs -P 10 -n 1 /bin/bash -c 'ping_uri "$0" >> _temp/pings.txt'

cat _temp/pings.txt | grep -v '^200 ' > _temp/broken.txt
broken=$(cat _temp/broken.txt | wc -l | cut -f1 -d ' ')
if [ "$broken" -gt "20" ]]; then
  cat _temp/broken.txt
  exit -1
fi

