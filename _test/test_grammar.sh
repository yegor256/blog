#!/bin/bash

for f in $(find _site -name '*.html'); do
  echo "checking grammar in $f..."
  tidy -i -asxml $f 2>/dev/null | \
    xmllint -html -xpath '//article//p/text()' - 2>/dev/null | \
    sed "s/[^a-zA-Z'@\"-]/ /g" | \
    sed 's/[ \t\n]/\n/g' | \
    LC_ALL='C' sort | \
    uniq | \
    aspell --lang=en_US --ignore=3 -p ./_test/aspell.en.pws pipe | \
    grep ^\&
  # if [[ $? != 1 ]]; then exit -1; fi
done

