#!/bin/bash
set -e

if [ -e sfnt2woff/sfnt2woff ]; then
  cd sfnt2woff
else
  wget http://img.teamed.io/woff-code-latest.zip
  unzip woff-code-latest.zip -d sfnt2woff
  cd sfnt2woff
  make
fi
cp sfnt2woff /usr/local/bin/
