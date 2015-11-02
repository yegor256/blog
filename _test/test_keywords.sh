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
    sed "s/^[a-z]\{,4\}$/ /g" >> _temp/words.txt
done

cat _temp/words.txt | \
  sort | \
  uniq -c | \
  sort -r | \
  head -200 > _temp/top-words.txt

grep 'java' _temp/top-words.txt
