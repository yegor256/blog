#!/bin/bash

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
rm _temp/links.txt
for f in $(find . -regex '.*_site/.*\.html'); do
  tidy -i -asxml $f 2>/dev/null | \
    xmllint -html -xpath '//article//a[starts-with(@href,"http")]/@href' - 2>/dev/null | \
    sed 's|href="\([^"]\+\)"|\1|g' | \
    sed "s| |\n|g" >> _temp/links.txt
  echo "" >> _temp/links.txt
done

cat _temp/links.txt | \
  uniq | \
  sed '/^[ \t]*$/d' | \
  grep -v 'http://www.yegor256.com' | \
  grep -v 'linkedin.com' | \
  grep -v '^000 ' > _temp/unique-links.txt

total=$(wc -l _temp/unique-links.txt | cut -f1 -d ' ')
echo "${total} unique foreign links found"

cat _temp/unique-links.txt | xargs -P 10 -n 1 /bin/bash -c 'ping_uri "$0" >> _temp/pings.txt; echo "$0"'

cat _temp/pings.txt | grep -v '^200 ' > _temp/broken.txt
broken=$(cat _temp/broken.txt | wc -l | cut -f1 -d ' ')
if [ "$broken" -gt "40" ]; then
  echo "${broken} link(s) broken (out of ${total}):"
  cat _temp/broken.txt
  exit -1
else
  echo "just ${broken} broken link(s)(out of ${total}), it's acceptable:"
  cat _temp/broken.txt
fi

