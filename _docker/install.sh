#!/bin/bash
set -e
set -o pipefail

# cmake
wget --no-check-certificate --quiet https://cmake.org/files/v3.5/cmake-3.5.1.tar.gz
tar xf cmake-3.5.1.tar.gz
rm -rf _cmake-3.5.1
mv cmake-3.5.1 _cmake-3.5.1
cd _cmake-3.5.1
./configure
make
make install
cd ..

# woff
wget http://img.teamed.io/woff-code-latest.zip
unzip woff-code-latest.zip -d _sfnt2woff
cd _sfnt2woff
make
cp sfnt2woff /usr/local/bin/
cd ..

# tidy
git clone https://github.com/htacg/tidy-html5.git _tidy-html5
cd _tidy-html5/build/cmake
git checkout 5.1.25
cmake ../..
make
make install
cd ../../..
