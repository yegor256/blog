#!/bin/bash
set -e

DIR=$(dirname $0)
PORT=4000
jekyll serve --port=$PORT --host=localhost "--source=$DIR/.." &
PID=$!
COUNT=1
echo "Jekyll started, PID: ${PID}"
while true; do
  status=$(curl --silent --write-out "%{http_code}" http://localhost:$PORT --output /dev/stderr 2>/dev/null | cat)
  if [ $status -eq 200 ]; then
    echo "Jekyll is ready!"
    break
  fi
  echo "waiting for Jekyll to get ready..."
  sleep 15
  (( COUNT++ ))
  if [ $count == 5 ]; then
    echo "Jekyll takes too long"
    break
  fi
done
casperjs test $DIR/casperjs/*
kill -9 $PID
echo "Jekyll stopped"
rm -rf $DIR/../_site
