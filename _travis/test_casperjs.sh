#!/bin/bash
set -e

DIR=$(dirname $0)
cd "${DIR}/.."
PORT=4000
jekyll serve --port=$PORT --host=localhost --trace &
PID=$!
trap 'kill -9 $PID; rm -rf _site' EXIT

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
  if [ $COUNT -eq 120 ]; then
    echo "Jekyll takes too long"
    break
  fi
done

casperjs test $DIR/casperjs/*
