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
#find _site -name '*.html' -exec ruby _test/validate_html.rb {} \;
