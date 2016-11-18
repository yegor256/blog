#!/bin/bash
set -e
set -x

function ping_uri {
  curl --location \
    --silent \
    --output /dev/null \
    --max-time 20 \
    --fail \
    -H 'User-Agent: Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)' \
    -H 'Accept: text/html,*/*' \
    -H 'Accept-Encoding: gzip, deflate' \
    -H 'Cache-Control: max-age=0' \
    --retry 8 \
    --write-out '%{http_code} %{url_effective}\n' $1
}
export -f ping_uri

cmd="ping_uri \"\$0\" >> ${2}; echo \"\$0\";"
cat $1 | xargs -P 10 -n 1 /bin/bash -c "${cmd}"
