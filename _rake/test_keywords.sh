#!/bin/bash
# Copyright (c) 2014-2025 Yegor Bugayenko
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
