#!/bin/bash

mkdir -p _temp
rm -rf _temp/words.txt
for f in $(find _site -name '*.html'); do
  tidy -i -asxml $f 2>/dev/null | \
    sed "s|>|>\n|g" | \
    xmllint -html -xpath '(//article//p|//article//h2|//article//h3|//article//h4)/text()' - 2>/dev/null | \
    sed "s/[^a-zA-Z]/ /g" | \
    tr A-Z a-z | \
    sed 's/[ \t\n]/\n/g' | \
    sed "s/^[a-z]\{,3\}$/ /g" >> _temp/words.txt
done

cat _temp/words.txt | sed '/^[ \t]*$/d' | \
  sort | uniq -c | sort -r | cut -c9- > _temp/sorted-words.txt

comm -23 _temp/sorted-words.txt _test/stop-words.txt | head -200 > _temp/top-words.txt

while read k; do
  echo "${k}:"
  grep $k _temp/top-words.txt
  if [[ $? = 1 ]]; then exit -1; fi
done < _test/core-keywords.txt

