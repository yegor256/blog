#!/bin/bash
# Copyright (c) 2014-2024 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so. The Software doesn't include files with .md extension.
# That files you are not allowed to copy, distribute, modify, publish, or sell.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -e
set -x

links=$1
report=$2

function ping_uri {
  curl --location \
    --silent \
    --output /dev/null \
    --max-time 15 \
    --fail \
    --user-agent 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' \
    -H 'Accept: text/html,*/*' \
    -H 'Accept-Encoding: gzip, deflate' \
    -H 'Cache-Control: max-age=0' \
    --retry 4 \
    --write-out '%{http_code} %{url_effective}\n' "$1"
}
export -f ping_uri

cmd="ping_uri \"\$0\" >> \"${report}\"; echo \"\$0\";"
cat "${links}" | xargs -P 10 -n 1 /bin/bash -c "${cmd}"
