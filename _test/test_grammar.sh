#!/bin/bash

for f in $(find _site -name '*.html'); do
  echo -n "checking grammar in $f... "
  tidy -i -asxml $f 2>/dev/null | \
    sed "s|>|>\n|g" | \
    xmllint -html -xpath '(//article//p|//article//h2|//article//h3|//article//h4)/text()' - 2>/dev/null | \
    sed "s/[^a-zA-Z'@\"\-]/ /g" | \
    sed 's/[ \t\n]/\n/g' | \
    LC_ALL='C' sort | \
    uniq | \
    aspell --lang=en_US --ignore=3 -p ./_test/aspell.en.pws pipe | \
    grep ^\&
  if [[ $? != 1 ]]; then exit -1; fi
  echo "OK"
done

for f in $(find . -regex '\./_site/[0-9]\{4\}/.*\.html'); do
  echo -n "checking name of $f... "
  echo $f | sed "s|[^a-zA-Z]| |g" | \
    LC_ALL='C' sort | \
    aspell --lang=en_US --ignore=2 --ignore-case -p ./_test/aspell.en.pws pipe | \
    grep ^\&
  if [[ $? != 1 ]]; then exit -1; fi
  echo "OK"
done

echo "grammar is clean!"
