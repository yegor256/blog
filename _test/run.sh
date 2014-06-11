#!/bin/bash

DIR=$(dirname $0)
PORT=4000
jekyll serve --port=$PORT --host=localhost "--source=$DIR/.." &
PID=$!
echo "Jekyll started, PID: ${PID}"
while true; do
    curl --silent --head http://localhost:$PORT > /dev/null
    ERROR=$?
    if [ $ERROR -eq 0 ]; then
        break
    fi
    sleep 1
done
casperjs test $DIR/casperjs/*
kill -9 $PID
rm -rf $DIR/../_site
