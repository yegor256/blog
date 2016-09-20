#!/bin/bash

mkdir -p _temp
rm -rf _temp/links.txt
for f in $(find . -regex '.*_site/[0-9][0-9][0-9][0-9]/.*\.html' -not -name '*.amp.html'); do
  echo -n "fetching links from $f... "
  tidy -i -asxml $f 2>/dev/null | \
    xmllint -html -xpath '//article//a[starts-with(@href,"/")]/@href' - 2>/dev/null | \
    sed 's|href="\([^"]\+\)"|\1|g' | \
    sed "s| |\n|g" >> _temp/links.txt
  echo "" >> _temp/links.txt
  echo $f | sed 's|.*_site||g' >> _temp/links.txt
  echo "OK"
done

cat _temp/links.txt | sort | uniq -c | sort > _temp/unique_links.txt

links=$(cat _temp/unique_links.txt | wc -l | cut -f1 -d ' ')
if [ "$links" -lt "150" ]; then
  cat _temp/links.txt
  echo "something is wrong with this list... total=${links}"
  exit -1
fi

cat _temp/unique_links.txt | grep ' 1 '
if [ $? -ne 1 ]; then
  echo "some pages are orphans"
  exit -1
fi

echo "no orphans, good!"
