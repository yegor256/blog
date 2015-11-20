#!/bin/bash
set -e

wget http://people.mozilla.com/~jkew/woff/woff-code-latest.zip
unzip woff-code-latest.zip -d sfnt2woff
cd sfnt2woff
make
sudo mv sfnt2woff /usr/local/bin/
cd ..
rm -rf sfnt2woff
