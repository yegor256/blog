#!/bin/bash
set -e
set -x

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

cmd="ping_uri \"\$0\" >> ${2}; echo \"\$0\";"
cat $1 | xargs -P 10 -n 1 /bin/bash -c "${cmd}"
