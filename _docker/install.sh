#!/bin/bash
set -e
set -o pipefail

# cmake
wget --no-check-certificate https://cmake.org/files/v3.5/cmake-3.5.1.tar.gz
tar xf cmake-3.5.1.tar.gz
rm -rf _cmake-3.5.1
mv cmake-3.5.1 _cmake-3.5.1
cd _cmake-3.5.1
./configure
make
make install
cd ..

# plantuml
wget --retry-connrefused --no-check-certificate http://img.teamed.io/yegor256/plantuml_7707-1_all.deb
dpkg -i plantuml_7707-1_all.deb
rm -rf plantuml_7707-1_all.deb

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
