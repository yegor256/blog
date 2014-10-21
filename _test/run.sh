#!/bin/bash
set -e

DIR=$(dirname $0)
PORT=4000
jekyll serve --port=$PORT --host=localhost "--source=$DIR/.." &
PID=$!
trap 'kill -9 $PID; rm -rf $DIR/../_site' EXIT

COUNT=1
echo "Jekyll started, PID: ${PID}"
while true; do
  STATUS=$(curl --silent --write-out "%{http_code}" http://localhost:$PORT --output /dev/stderr 2>/dev/null | cat)
  if [ $STATUS -eq 200 ]; then
    echo "Jekyll is ready!"
    break
  fi
  echo "waiting for Jekyll to get ready (${COUNT})..."
  sleep 15
  (( COUNT++ ))
  if [ $COUNT -eq 30 ]; then
    echo "Jekyll takes too long"
    break
  fi
done

casperjs test $DIR/casperjs/*

find _site -name '*.html' | xargs -P 5 -n 1 ruby _test/validate_html.rb

function ping_uri {
  curl --location --silent --output /dev/null --fail \
    -A 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2194.2 Safari/537.36' \
    -H 'Accept:*/*' \
    -H 'Accept-Encoding:gzip,deflate,sdch' \
    -H 'Cache-Control:max-age=0' \
    --write-out '%{url_effective}: %{http_code}\n' $1 || exit 255
}
export -f ping_uri
mkdir -p _temp
find _site -name '*.html' \
  | xargs -P 10 -n 1 ruby _test/fetch_links.rb \
  | sort | uniq \
  | grep -v 'http://www.yegor256.com' \
  | xargs -P 10 -n 1 /bin/bash -c 'ping_uri "$0"'
