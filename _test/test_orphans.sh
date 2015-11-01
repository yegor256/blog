#!/bin/bash
set -e

mkdir -p _temp
rm -rf _temp/links.txt
for f in $(find . -regex '.*_site/[0-9]\{4\}/.*\.html'); do
  echo -n "fetching links from $f... "
  tidy -i -asxml $f 2>/dev/null | \
    xmllint -html -xpath '//article//a[starts-with(@href,"/")]/@href' - 2>/dev/null | \
    sed "s/href=\"\([^\"]*\)\"/\1/g" | \
    sed "s/ /\n/g" >> _temp/links.txt
  echo "" >> _temp/links.txt
  echo $f | sed 's/.*_site//g' >> _temp/links.txt
  echo "OK"
done

cat _temp/links.txt | \
  sort | \
  uniq -c | \
  sort | \
  grep ' 1 '
if [[ $? != 1 ]]; then exit -1; fi

echo "no orphans, good!"
