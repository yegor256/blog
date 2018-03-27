#!/bin/bash
set -e
set -o pipefail

wget http://img.teamed.io/woff-code-latest.zip
unzip woff-code-latest.zip -d _sfnt2woff
cd _sfnt2woff
make
cp sfnt2woff /usr/local/bin/
