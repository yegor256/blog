#!/bin/bash
set -e

if [ -e _sfnt2woff/sfnt2woff ]; then
  cd _sfnt2woff
  echo "sfnt2woff already exists in cache, won't build again"
else
  wget http://img.teamed.io/woff-code-latest.zip
  unzip woff-code-latest.zip -d _sfnt2woff
  cd _sfnt2woff
  make
fi
cp sfnt2woff /usr/local/bin/
