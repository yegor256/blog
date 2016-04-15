#!/bin/bash

total=0
errors=0
for f in $(find _site -name '*.html'); do
  tidy -i -asxml $f 2>/dev/null | \
    xmllint -html -xpath '//article//figure[@class="highlight"]/pre/code[not(contains(@class,"text"))]' - 2>/dev/null | \
    sed -E 's|<code [^>]+>||g' | \
    sed -E 's|<span class="[A-Za-z0-9-]+">||g' | \
    sed 's|<\/code>|\n|g' | \
    sed 's|<\/span>||g' | \
    sed 's|&lt;|<|g' | \
    sed 's|&gt;|>|g' | \
    grep -E '.{81,}'
  if [ $? -ne 1 ]; then
    ((errors++))
    echo -e "$f has too long lines\n\n"
  fi
  ((total++))
done
if [ $errors -ne 0 ]; then
  echo "there are ${errors} problems above (lines are too long)"
  exit -1
fi

echo "all ${total} HTML files are clean!"
