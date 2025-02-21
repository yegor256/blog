#!/bin/bash
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

mkdir -p _temp
rm -rf _temp/words.txt
echo -n "fetching all words... "
find _site -name '*.html' | while IFS= read -r f; do
  tidy -i -asxml "${f}" 2>/dev/null | \
    sed "s|>|>\n|g" | \
    xmllint -html -xpath '(//article//p|//article//h2|//article//h3|//article//h4)/text()' - 2>/dev/null | \
    sed "s/[^a-zA-Z]/ /g" | \
    tr '[:upper:]' '[:lower:]' | \
    sed 's/[ \t\n]/\n/g' | \
    sed '/^[ \t]*$/d' >> _temp/words.txt
done
echo -e "done, $(wc -l _temp/words.txt | cut -f1 -d ' ') words found"

rm -rf _temp/good-words.txt
echo -n "removing stop words... "
sort < _temp/words.txt | uniq -c | sort -r | cut -c9- | \
while read -r k; do
  if ! grep -q "${k}" _travis/stop-words.txt; then
    echo "${k}" >> _temp/good-words.txt
  fi
done
echo "done, $(wc -l _temp/good-words.txt | cut -f1 -d ' ') good words left"

head -200 < _temp/good-words.txt > _temp/top-words.txt

errors=0
while read -r k; do
  echo -n "${k}: "
  grep -q "${k}" _temp/top-words.txt
  if [ $? -eq 1 ]; then
    echo "is absent!"
    ((errors++))
  else
    echo "OK"
  fi
done < _travis/core-keywords.txt
if [ "$errors" -ne "0" ]; then
  echo "there are ${errors} missed keywords, see above"
  cat _temp/top-words.txt
  exit 1
fi
